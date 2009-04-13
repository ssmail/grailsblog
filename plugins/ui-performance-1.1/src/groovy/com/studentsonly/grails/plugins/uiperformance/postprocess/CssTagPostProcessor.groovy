package com.studentsonly.grails.plugins.uiperformance.postprocess

import com.studentsonly.grails.plugins.uiperformance.Utils

/**
 * CSS tag post-processor.
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
class CssTagPostProcessor extends AbstractTagPostProcessor {

	def extensions = ['css']
	boolean gzip = true

	@Override
	String process(String html, request) {

		boolean process = Utils.getConfigBoolean('processCSS', true)
		if (!process || Utils.isDevelopment() || !Utils.isEnabled()) {
			return expandBundle(html)
		}

		return super.process(html, request)
	}
}
