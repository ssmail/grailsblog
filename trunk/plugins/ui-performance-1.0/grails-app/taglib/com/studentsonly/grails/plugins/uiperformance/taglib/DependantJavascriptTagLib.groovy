package com.studentsonly.grails.plugins.uiperformance.taglib

/**
 * Allows deferred declaration of JavaScript files and rendering of the tags at the end of the body
 * for faster page loads.
 *
 * Borrowed from <a href='http://www.nabble.com/Javascript-at-the-end-of-a-page-to18948092.html#a18962552'>here</a>
 * and modified a bit.
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
class DependantJavascriptTagLib extends AbstractTaglib {

	static namespace = 'p'

	def dependantJavascript = { attrs, body ->
		String js = body()
		def jsBlocks = request.jsBlocks
		if (!jsBlocks) {
			jsBlocks = []
			request.jsBlocks = jsBlocks
		}
		jsBlocks << js
	}

	def renderDependantJavascript = {
		request.jsBlocks.each { js ->
			out << js
			out << '\n'
		}
	}
}
