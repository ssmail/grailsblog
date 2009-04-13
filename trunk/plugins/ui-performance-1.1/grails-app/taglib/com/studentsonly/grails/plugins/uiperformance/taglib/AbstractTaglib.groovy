package com.studentsonly.grails.plugins.uiperformance.taglib

/**
 * Abstract base class for taglibs.
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
abstract class AbstractTaglib {

	/**
	 * Generates html for attributes not explicitly handled.
	 * <p/>
	 * Remove all handled attributes before calling this, e.g.
	 * <code>attrs.remove 'border'</code>
	 *
	 * @param attrs  the attribute map
	 * @return  html for extra attributes
	 */
	protected String generateExtraAttributes(attrs) {

		String extra = ''

		attrs.each { key, value ->
			extra += " ${key}=\"${value}\""
		}

		extra
	}

	protected String generateRelativePath(dir, name, plugin) {

		String baseUri = grailsAttributes.getApplicationUri(request)
		String path = baseUri
		path += (baseUri.endsWith('/') ? '' : '/')
		String requestPluginContext = plugin ? pluginContextPath : ''
		if (requestPluginContext) {
			path += (requestPluginContext.startsWith('/') ? requestPluginContext.substring(1) : requestPluginContext)
			path += '/'
		}
		path += dir + '/' + name
		return path
	}
}
