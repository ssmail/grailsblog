package com.studentsonly.grails.plugins.uiperformance.postprocess

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

		boolean process = getConfigBoolean('processCSS', true)
		if (!process || isDevelopment()) {
			return expandBundle(html)
		}

		return super.process(html, request)
	}
}
