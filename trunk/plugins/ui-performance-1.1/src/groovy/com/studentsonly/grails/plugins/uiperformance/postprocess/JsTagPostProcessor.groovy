package com.studentsonly.grails.plugins.uiperformance.postprocess

import com.studentsonly.grails.plugins.uiperformance.Utils

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

		boolean process = Utils.getConfigBoolean('processJS', true)
		if (!process || Utils.isDevelopment() || !Utils.isEnabled()) {
			return expandBundle(html)
		}

		return super.process(html, request)
	}
}
