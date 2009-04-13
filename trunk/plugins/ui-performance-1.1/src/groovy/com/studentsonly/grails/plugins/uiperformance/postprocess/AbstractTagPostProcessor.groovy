package com.studentsonly.grails.plugins.uiperformance.postprocess

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.codehaus.groovy.grails.commons.GrailsApplication

import grails.util.GrailsUtil

import com.studentsonly.grails.plugins.uiperformance.Utils

/**
 * Abstract base class for tag post-processors.
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
abstract class AbstractTagPostProcessor {

	String process(String html, request) {

		if (!Utils.isProduction() || !Utils.isEnabled()) {
			return html
		}

		String processed = html
		boolean foundIt = false
		extensions.each { ext ->
			if (foundIt) {
				return
			}

			int indexExt = html.indexOf(".$ext")
			if (indexExt == -1) {
				return
			}

			String quote = "'"
			int indexQuoteEnd = html.indexOf(quote, indexExt)
			if (indexQuoteEnd == -1) {
				quote = '"'
				indexQuoteEnd = html.indexOf('"', indexExt)
				if (indexQuoteEnd == -1) {
					return
				}
			}

			int indexQuoteStart = html.length() - html.reverse().indexOf(quote, html.length() - indexQuoteEnd + 1)
			String path = html.substring(indexQuoteStart, indexQuoteEnd)

			String name = Utils.addVersion(path)
			if (gzip) {
				String ae = request.getHeader('accept-encoding')
				if (ae && ae.contains('gzip')) {
					name = (name - ".$ext") + ".gz.$ext"
				}
			}

			processed = html.substring(0, indexQuoteStart) + name + html.substring(indexQuoteEnd)
			foundIt = true
		}

		return processed
	}

	protected String expandBundle(String html) {
		String expanded = null
		CH.config.uiperformance.bundles.each { bundle ->
			if (expanded == null) {
				String ext = extensions[0]
				if (html.contains("/" + ext + "/" + bundle.name)) {
					expanded = expandBundle(html, bundle, ext)
				}
			}
		}

		return expanded ?: html
	}

	protected String expandBundle(String html, bundle, String ext) {

		String path = "/$ext/${bundle.name}.$ext"
		int index = html.indexOf(path)
		String start = html.substring(0, index)
		String end = html.substring(index + path.length())

		def sb = new StringBuilder()
		bundle.files.each { file ->
			sb.append(start)
			sb.append("/").append(ext).append("/")
			sb.append(file).append(".").append(ext)
			sb.append(end).append('\n')
		}
		return sb.toString()
	}
}
