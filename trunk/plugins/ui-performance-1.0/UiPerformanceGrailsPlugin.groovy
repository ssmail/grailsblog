import org.codehaus.groovy.grails.commons.GrailsApplication

import grails.util.GrailsUtil

import com.studentsonly.grails.plugins.uiperformance.CacheFilter

import com.studentsonly.grails.plugins.uiperformance.postprocess.CssTagPostProcessor
import com.studentsonly.grails.plugins.uiperformance.postprocess.ImageTagPostProcessor
import com.studentsonly.grails.plugins.uiperformance.postprocess.JsTagPostProcessor

class UiPerformanceGrailsPlugin {

	def version = 1.0
	def dependsOn = [:]

	def author = 'Burt Beckwith'
	def authorEmail = 'beckwithb@studentsonly.com'
	def title = 'Grails UI Performance Plugin'
	def description = "Taglibs and Filter to implement some of the Yahoo performance team's 14 rules"
	def documentation = 'http://grails.org/UiPerformance+Plugin'

	private static final String COMPRESSING_FILTER_CLASS =
		'com.planetj.servlet.filter.compression.CompressingFilter'

	def doWithSpring = {
		// register the three post-processors
		imageTagPostProcessor(ImageTagPostProcessor)
		cssTagPostProcessor(CssTagPostProcessor)
		jsTagPostProcessor(JsTagPostProcessor)
	}

	def doWithApplicationContext = { applicationContext ->
		// nothing to do
	}

	def doWithWebDescriptor = { xml ->

		if (!application.config.uiperformance.enabled) {
			return
		}

		boolean prod = GrailsApplication.ENV_PRODUCTION == GrailsUtil.environment

		def contextParam = xml.'context-param'
		contextParam[contextParam.size() - 1] + {
			'filter' {
				'filter-name'('cacheFilter')
				'filter-class'(CacheFilter.name)
			}
		}

		def htmlConfig = application.config.uiperformance.html

		if (prod && htmlConfig.compress) {

			if (!htmlConfig.containsKey('includeContentTypes') &&
					!htmlConfig.containsKey('excludeContentTypes')) {
				// set default to text types only if there's no config set
				htmlConfig.includeContentTypes = ['text/html', 'text/xml', 'text/plain']
			}

			contextParam[contextParam.size() - 1] + {
				'filter' {
					'filter-name'(COMPRESSING_FILTER_CLASS)
					'filter-class'(COMPRESSING_FILTER_CLASS)

					['debug', 'statsEnabled'].each { name ->
						def value = htmlConfig[name]
						if (value) {
							'init-param' {
								'param-name'(name)
								'param-value'('true')
							}
						}
					}

					['includePathPatterns', 'excludePathPatterns',
					 'includeContentTypes', 'excludeContentTypes',
					 'includeUserAgentPatterns', 'excludeUserAgentPatterns'].each { name ->
						def value = htmlConfig[name]
						if (value) {
							'init-param' {
								'param-name'(name)
								'param-value'(value.join(','))
							}
						}
					}

					['compressionThreshold', 'javaUtilLogger', 'jakartaCommonsLogger'].each { name ->
						def value = htmlConfig[name]
						if (value) {
							'init-param' {
								'param-name'(name)
								'param-value'(value.toString())
							}
						}
					}
				}
			}
		}

		def filter = xml.'filter'
		filter[filter.size() - 1] + {
			'filter-mapping' {
				'filter-name'('cacheFilter')
				'url-pattern'('/*')
			}
		}

		if (prod && htmlConfig.compress) {
			filter[filter.size() - 1] + {
				if (!htmlConfig.urlPatterns) {
					htmlConfig.urlPatterns = ['/*']
				}

				htmlConfig.urlPatterns.each { pattern ->
					'filter-mapping' {
						'filter-name'(COMPRESSING_FILTER_CLASS)
						'url-pattern'(pattern)
					}
				}
			}
		}
	}

	def doWithDynamicMethods = { ctx ->
		// nothing to do
	}

	def onChange = { event ->
		// nothing to do
	}

	def onConfigChange = { event ->
		// nothing to do
	}
}
