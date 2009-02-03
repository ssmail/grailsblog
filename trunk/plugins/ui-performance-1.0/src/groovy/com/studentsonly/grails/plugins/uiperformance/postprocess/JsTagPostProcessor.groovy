package com.studentsonly.grails.plugins.uiperformance.postprocess

/**
 * JavaScript tag post-processor.
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
class JsTagPostProcessor extends AbstractTagPostProcessor {

	def extensions = ['js']
	boolean gzip = true

	@Override
	String process(String html, request) {

		boolean process = getConfigBoolean('processJS', true)
		if (!process || isDevelopment()) {
			return expandBundle(html)
		}

		return super.process(html, request)
	}
}
