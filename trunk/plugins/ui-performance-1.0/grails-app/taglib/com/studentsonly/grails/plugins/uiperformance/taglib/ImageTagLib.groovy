package com.studentsonly.grails.plugins.uiperformance.taglib

/**
 * Generates an &lt;img&gt; tag.
 * <p/>
 * The only required attribute is 'src', which is the relative path of the image
 * file ('/images/foo.gif' would specify src='foo.gif', '/images/foo/bar/z.jpg'
 * would specify src='foo/bar/z.jpg').
 * <p/>
 * 'name' is an optional attribute and defines both the name and id attributes if specified.
 * <p/>
 * 'border' is an optional attribute, defaulting to '0' if not provided. 
 * <p/>
 * All other attributes are included at the end in the specified order.
 * <p/>
 * &lt;p:image src='foo.gif' alt='Foo' style='width: 200px'/&gt;
 * would generate this output:
 * &lt;img src='/yourapp/images/foo.gif' border='0' alt="Foo" style="width: 200px"/&gt;
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
class ImageTagLib extends AbstractTaglib {

	static namespace = 'p'

	// dependency injection
	def imageTagPostProcessor

	/**
	 * Generates the image tag.
	 */
	def image = { attrs ->

		if (!attrs.src) {
			throwTagError("Tag [image] is missing required attribute [src]")
		}

		String src = attrs.remove('src')
		String link = src
		boolean absolute = 'true' == attrs.remove('absolute')
		if (!absolute) {
			link = generateRelativePath('images', src, attrs.plugin)
		}

		String borderAttr = attrs.remove('border')
		int border = borderAttr ? Integer.parseInt(borderAttr) : 0

		String name = attrs.remove('name')
		String nameAndId = name ? "name='${name}' id='${name}' " : ''

		String html = "<img src='${link}' ${nameAndId}border='${border}'${generateExtraAttributes(attrs)}/>"
		if (imageTagPostProcessor) {
			html = imageTagPostProcessor.process(html, request)
		}
		out << html
	}
}
