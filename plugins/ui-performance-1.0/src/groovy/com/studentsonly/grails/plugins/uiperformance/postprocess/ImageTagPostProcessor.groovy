package com.studentsonly.grails.plugins.uiperformance.postprocess

/**
 * Image tag post-processor.
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
class ImageTagPostProcessor extends AbstractTagPostProcessor {
	def extensions = ['gif', 'png', 'jpg']
	boolean gzip = false

	@Override
	String process(String html, request) {

		boolean process = getConfigBoolean('processImages', true)
		if (!process) {
			return html
		}

		return super.process(html, request)
	}
}
