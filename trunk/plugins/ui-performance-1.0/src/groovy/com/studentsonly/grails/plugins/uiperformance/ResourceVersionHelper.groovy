package com.studentsonly.grails.plugins.uiperformance

import java.util.zip.GZIPOutputStream

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.mozilla.javascript.EvaluatorException
import org.springframework.util.AntPathMatcher
import org.springframework.util.FileCopyUtils

import com.yahoo.platform.yui.compressor.CssCompressor
import com.yahoo.platform.yui.compressor.JavaScriptCompressor

import com.studentsonly.grails.plugins.uiperformance.JsErrorReporter

/**
 * Does the work of versioning files, creating bundles, gzipping, etc. Called from _Events.groovy
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
class ResourceVersionHelper {

	private final _exclusionMatcher = new AntPathMatcher()

	void version(String stagingDir, String basedir) {

		boolean processImages = getConfigBoolean('processImages', true)
		boolean processCSS = getConfigBoolean('processCSS', true)
		boolean processJS = getConfigBoolean('processJS', true)
		boolean continueCss = getConfigBoolean('continueAfterMinifyCssError', false)
		boolean continueJs = getConfigBoolean('continueAfterMinifyJsError', false)

		List exclusions = configureExclusions()

		try {
			String version = determineVersion(basedir)
			println "applying version $version"
			versionResources new File(stagingDir), version, exclusions, basedir,
				processImages, processCSS, processJS, continueCss, continueJs
		}
		catch (EvaluatorException e) {
			throw e
		}
		catch (IOException e) {
			throw e
		}
		catch (e) {
			e.printStackTrace()
			throw e
		}
	}

	private List configureExclusions() {
		def exclusions = CH.config.uiperformance.exclusions
		if (!exclusions) {
			exclusions = []
		}
		exclusions << '**/CVS'
		exclusions << '**/.svn'

		return exclusions
	}

	private String determineVersion(String basedir) {

		def determineVersionClosure = CH.config.uiperformance.determineVersion
		if (determineVersionClosure instanceof Closure) {
			return determineVersionClosure()
		}

		File entries = new File(basedir, '.svn/entries')
		if (entries.exists()) {
			return entries.text.split('\n')[3].trim()
		}

		// TODO  need something better than this
		return System.currentTimeMillis().toString()
	}

	private void versionResources(File stagingDir, String version, List exclusions, String basedir,
			boolean processImages, boolean processCSS, boolean processJS,
			boolean continueCss, boolean continueJs) {

		createBundles stagingDir, processCSS, processJS
		createPropertiesFile stagingDir, version

		String charset = /*System.getProperty('file.encoding') ?:*/ 'UTF-8'
		versionResources stagingDir, version, charset,
				new JsErrorReporter(), exclusions, basedir,
				processImages, processCSS, processJS, continueCss, continueJs
	}

	private void createBundles(File stagingDir, boolean processCSS, boolean processJS) {
		CH.config.uiperformance.bundles.each { bundle ->
			if (!(bundle.type == 'css' && !processCSS) && !(bundle.type == 'js' && !processJS)) {
				concatenate bundle.files, bundle.name, bundle.type, bundle.type, stagingDir
			}
		}
	}

	private void createPropertiesFile(File stagingDir, String version) {
		// write out a properties file for use by taglibs, etc.
		new File(stagingDir, 'WEB-INF/classes/version.properties').write("version=$version\n")
	}

	private void versionResources(File dir, String version, String charset,
			JsErrorReporter jsErrorReporter, List exclusions, String basedir,
			boolean processImages, boolean processCSS, boolean processJS,
			boolean continueCss, boolean continueJs) {

		dir.eachFile { file ->
			String relativePath = (file.path - (basedir + File.separatorChar)).replaceAll('\\\\', '/')
			if (isExcluded(relativePath, exclusions)) {
				return
			}

			if (file.directory) {
				versionResources file, version, charset, jsErrorReporter, exclusions, basedir,
					processImages, processCSS, processJS, continueCss, continueJs
				return
			}

			applyVersion file, version, charset, jsErrorReporter, exclusions,
				processImages, processCSS, processJS, continueCss, continueJs
		}
	}

	private boolean isExcluded(String relativePath, List exclusions) {
		boolean excluded = false
		exclusions.each { pattern ->
			if (!excluded && _exclusionMatcher.match(pattern, relativePath)) {
				excluded = true
				return
			}
		}

		return excluded
	}

	private void applyVersion(file, String version, String charset, jsErrorReporter, List exclusions,
			boolean processImages, boolean processCSS, boolean processJS,
			boolean continueCss, boolean continueJs) {

		if (processCSS && file.name.toLowerCase().endsWith('.css')) {
			versionAndRewriteCss file, version, charset, exclusions, continueCss
			return
		}

		if (processJS && file.name.toLowerCase().endsWith('.js')) {
			versionAndMinifyJs file, version, charset, jsErrorReporter, continueJs
			return
		}

		['.gif', '.jpg', '.png'].each { ext ->
			if (processImages && file.name.toLowerCase().endsWith(ext)) {
				renameWithVersion file, version
			}
		}
	}

	private void renameWithVersion(file, String version) {
		String versionedPath = addVersion(file, version)
		if (!file.renameTo(new File(versionedPath))) {
			throw new RuntimeException("unable to rename $file.path to $versionedPath")
		}
	}

	private void versionAndRewriteCss(file, String version, String charset, List exclusions, boolean continueCss) {
		Date originalDate = new Date(file.lastModified())

		def css = new StringBuilder()
		file.eachLine { line ->
			int index = line.indexOf('url(')
			if (index == -1 || line.contains('http')) {
				css.append line
			}
			else {
				int index2 = line.indexOf(')', index)
				String url = line.substring(index + 4, index2)
				if (isExcluded(url, exclusions)) {
					css.append line
				}
				else {
					css.append line.substring(0, index + 4)
					addVersion css, url, version
					css.append line.substring(index2)
				}
			}
			css.append '\n'
		}

		writeMinifiedCss css.toString(), addVersion(file, version), charset, originalDate, file, continueCss
	}

	private void versionAndMinifyJs(file, version, charset, jsErrorReporter, boolean continueJs) {

		Date originalDate = new Date(file.lastModified())

		Writer out = null
		String versionedName

		try {
			Reader jsIn = null
			def compressor
			try {
				jsIn = new InputStreamReader(new FileInputStream(file), charset)
				compressor = new JavaScriptCompressor(jsIn, jsErrorReporter)
			}
			finally {
				close jsIn
			}

			versionedName = addVersion(file, version)
			out = new OutputStreamWriter(new FileOutputStream(versionedName), charset)

			// TODO  lookup in config
			boolean munge = true
			boolean preserveAllSemiColons = false
			boolean disableOptimizations = false
			boolean verbose = false

			compressor.compress out, -1, munge, verbose, preserveAllSemiColons, disableOptimizations
		}
		catch (e) {
			error "problem minifying $file: $e.message"
			if (continueJs) {
				writeUnminifiedJs file, version, originalDate
				return
			}
			else {
				throw e
			}
		}
		finally {
			close out
		}

		gzip versionedName, originalDate

		if (!file.delete()) {
			error "unable to delete $file.path"
		}
	}

	private void writeUnminifiedJs(file, version, originalDate) {
		String versionedName = addVersion(file, version)
		FileCopyUtils.copy file, new File(versionedName)
		gzip versionedName, originalDate
		if (!file.delete()) {
			error "unable to delete $file.path"
		}
	}

	private void writeMinifiedCss(String css, String outputFilename, String charset,
			Date originalDate, file, boolean continueCss) {

		def out = null
		try {
			def compressor = new CssCompressor(new StringReader(css))
			out = new OutputStreamWriter(new FileOutputStream(outputFilename), charset)
			compressor.compress out, -1
		}
		catch (e) {
			error "problem minifying $file: $e.message"
			if (continueCss) {
				writeUnminifiedCss css, outputFilename, originalDate, file
				return
			}
			else {
				throw e
			}
		}
		finally {
			if (out) {
				out.close()
			}
		}

		gzip outputFilename, originalDate

		if (!file.delete()) {
			error "unable to delete $file.path"
		}
	}

	private void writeUnminifiedCss(String css, String outputFilename, Date originalDate, file) {
		FileCopyUtils.copy new StringReader(css), new FileWriter(outputFilename)
		gzip outputFilename, originalDate
		if (!file.delete()) {
			error "unable to delete $file.path"
		}
	}

	private String addVersion(file, String version) {
		def sb = new StringBuilder()
		addVersion sb, file.path, version
		return sb.toString()
	}

	private void addVersion(StringBuilder sb, String name, String version) {
		int index = name.lastIndexOf('.')
		sb.append name.substring(0, index)
		sb.append '__v'
		sb.append version
		sb.append name.substring(index)
	}

	private void gzip(filename, originalDate) {
		File gzipped = createGzipFile(filename)

		FileCopyUtils.copy(
				new BufferedInputStream(new FileInputStream(filename)),
				new GZIPOutputStream(new FileOutputStream(gzipped)))

		// currently Grails copies to staging w/out preserving last modified, so this isn't helpful yet ...
		gzipped.lastModified = originalDate.time
	}

	private File createGzipFile(filename) {
		int index = filename.lastIndexOf('.')
		String ext = filename.substring(index + 1)
		filename = (filename - ".$ext") + ".gz.$ext"
		return new File(filename)
	}

	private void concatenate(List files, String name, String subdir, String ext, File stagingDir) {
		new File(stagingDir, "$subdir/${name}.$ext").withWriter { writer ->
			files.each { file ->
				writer.write new File(stagingDir, "$subdir/${file}.$ext").text
				writer.write '\n'
			}
		}
	}

	private void close(Closeable closeable) {
		try {
			if (closeable) {
				closeable.close()
			}
		}
		catch (e) {
			// ignored
		}
	}

	private boolean getConfigBoolean(name, boolean defaultIfMissing) {
		def value = CH.config.uiperformance[name]
		return value instanceof Boolean ? value : defaultIfMissing
	}

	private void error(String message) {
		println "\nERROR: $message\n"
	}
}
