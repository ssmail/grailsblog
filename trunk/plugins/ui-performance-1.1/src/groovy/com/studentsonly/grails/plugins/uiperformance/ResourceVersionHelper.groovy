package com.studentsonly.grails.plugins.uiperformance

import java.util.zip.GZIPOutputStream

import com.studentsonly.grails.plugins.uiperformance.JsErrorReporter

import com.yahoo.platform.yui.compressor.CssCompressor
import com.yahoo.platform.yui.compressor.JavaScriptCompressor

import org.carrot2.labs.smartsprites.SmartSpritesParameters
import org.carrot2.labs.smartsprites.SpriteBuilder
import org.carrot2.labs.smartsprites.message.MemoryMessageSink
import org.carrot2.labs.smartsprites.message.Message
import org.carrot2.labs.smartsprites.message.MessageLog

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.mozilla.javascript.EvaluatorException

import org.springframework.core.io.FileSystemResource
import org.springframework.core.io.support.PathMatchingResourcePatternResolver
import org.springframework.util.FileCopyUtils

/**
 * Does the work of versioning files, creating bundles, gzipping, etc. Called from _Events.groovy
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
class ResourceVersionHelper {

	void version(String stagingDir, String basedir) {

		try {
			String version = determineVersion(basedir)
			println "applying version $version"
			versionResources new File(stagingDir), version, basedir
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

	private void versionResources(File stagingDir, String version, String basedir) {

		Map<String, String> spritePaths = createSprites(stagingDir)

		createPropertiesFile stagingDir, version, spritePaths

		createBundles stagingDir

		String charset = /*System.getProperty('file.encoding') ?:*/ 'UTF-8'
		def jsErrorReporter = new JsErrorReporter()
		boolean processJS = Utils.getConfigBoolean('processJS', true)
		boolean processCSS = Utils.getConfigBoolean('processCSS', true)
		boolean processImages = Utils.getConfigBoolean('processImages', true)

		stagingDir.eachFileRecurse { file ->
			if (file.directory) {
				return
			}

			String relativePath = (file.path - (basedir + File.separatorChar)).replaceAll('\\\\', '/')
			if (Utils.isExcluded(relativePath)) {
				return
			}

			applyVersion file, version, charset, jsErrorReporter,
				processJS, processCSS, processImages
		}
	}

	private Map<String, String> createSprites(File stagingDir) {
		boolean processImages = Utils.getConfigBoolean('processImages', true)
		if (!processImages) {
			return [:]
		}

		Map<String, String> spritePaths = [:]

		CH.config.uiperformance.bundles.findAll {it.type == 'sprite'}.each { bundle ->
			processSprite bundle.files, bundle.name, bundle.ext, stagingDir, spritePaths
		}

		buildSprites stagingDir

		return spritePaths
	}

	private void createBundles(File stagingDir) {
		boolean processCSS = Utils.getConfigBoolean('processCSS', true)
		boolean processJS = Utils.getConfigBoolean('processJS', true)
		CH.config.uiperformance.bundles.findAll { it.type != 'sprite'}.each { bundle ->
			if (!(bundle.type == 'css' && !processCSS) && !(bundle.type == 'js' && !processJS)) {
				concatenate bundle.files, bundle.name, bundle.type, bundle.type, stagingDir
			}
		}
	}

	/**
	 * Write out a properties file for use by taglibs, etc.
	 * @param stagingDir  the root dir
	 * @param version  the app version
	 * @param spritePaths  optional map of sprite paths
	 */
	private void createPropertiesFile(File stagingDir, String version, Map<String, String> spritePaths) {

		def props = spritePaths as Properties
		props.version = version

		props.store new FileOutputStream(new File(stagingDir, 'WEB-INF/classes/uiperformance.properties')),
			'UI Performance plugin properties'
	}

	private void applyVersion(file, String version, String charset, jsErrorReporter,
			boolean processJS, boolean processCSS, boolean processImages) {

		if (processCSS && file.name.toLowerCase().endsWith('.css')) {
			versionAndRewriteCss file, version, charset
			return
		}

		if (processJS && file.name.toLowerCase().endsWith('.js')) {
			versionAndMinifyJs file, version, charset, jsErrorReporter
			return
		}

		if (processImages) {
			['.gif', '.jpg', '.png'].each { ext ->
				if (file.name.toLowerCase().endsWith(ext)) {
					renameWithVersion file, version
				}
			}
		}
	}

	private void renameWithVersion(file, String version) {
		String versionedPath = addVersion(file, version)
		if (!file.renameTo(new File(versionedPath))) {
			throw new RuntimeException("unable to rename $file.path to $versionedPath")
		}
	}

	private void versionAndRewriteCss(file, String version, String charset) {
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
				if (Utils.isExcluded(url)) {
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

		writeMinifiedCss css.toString(), addVersion(file, version), charset, originalDate, file
	}

	private void versionAndMinifyJs(file, version, charset, jsErrorReporter) {

		Date originalDate = new Date(file.lastModified())

		Writer out = null
		String versionedName = addVersion(file, version)

		boolean minifyJs = Utils.getConfigBoolean('minifyJs', true)
		if (minifyJs) {
			boolean minifyJsAsErrorCheck = Utils.getConfigBoolean('minifyJsAsErrorCheck', false)
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

				if (minifyJsAsErrorCheck) {
					out = new StringWriter()
				}
				else {
					out = new OutputStreamWriter(new FileOutputStream(versionedName), charset)
				}

				// TODO  lookup in config
				boolean munge = true
				boolean preserveAllSemiColons = false
				boolean disableOptimizations = false
				boolean verbose = false

				compressor.compress out, -1, munge, verbose, preserveAllSemiColons, disableOptimizations

				if (minifyJsAsErrorCheck) {
					writeUnminifiedJs file, version, originalDate
				}
			}
			catch (e) {
				error "problem minifying $file: $e.message"
				boolean continueJs = Utils.getConfigBoolean('continueAfterMinifyJsError', false)
				if (minifyJsAsErrorCheck || continueJs) {
					writeUnminifiedJs file, version, originalDate
					if (!file.delete()) {
						error "unable to delete $file.path"
					}
				}
				else {
					throw e
				}
			}
			finally {
				close out
			}
		}
		else {
			writeUnminifiedJs file, version, originalDate
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
	}

	private void writeMinifiedCss(String css, String outputFilename, String charset,
			Date originalDate, file) {

		boolean minifyCss = Utils.getConfigBoolean('minifyCss', true)
		if (minifyCss) {

			boolean minifyCssAsErrorCheck = Utils.getConfigBoolean('minifyCssAsErrorCheck', false)
			Writer out = null
			try {
				def compressor = new CssCompressor(new StringReader(css))

				if (minifyCssAsErrorCheck) {
					out = new StringWriter()
				}
				else {
					out = new OutputStreamWriter(new FileOutputStream(outputFilename), charset)
				}

				compressor.compress out, -1

				if (minifyCssAsErrorCheck) {
					writeUnminifiedCss css, outputFilename, originalDate, file
				}
			}
			catch (e) {
				error "problem minifying $file: $e.message"
				boolean continueCss = Utils.getConfigBoolean('continueAfterMinifyCssError', false)
				if (minifyCssAsErrorCheck || continueCss) {
					writeUnminifiedCss css, outputFilename, originalDate, file
					if (!file.delete()) {
						error "unable to delete $file.path"
					}
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
		}
		else {
			writeUnminifiedCss css, outputFilename, originalDate, file
		}

		gzip outputFilename, originalDate

		if (!file.delete()) {
			error "unable to delete $file.path"
		}
	}

	private void writeUnminifiedCss(String css, String outputFilename, Date originalDate, file) {
		FileCopyUtils.copy new StringReader(css), new FileWriter(outputFilename)
		gzip outputFilename, originalDate
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

	private void processSprite(List fileNames, String name, String ext,
			File stagingDir, Map<String, String> spritePaths) {

		println "\ncreating sprite file ${name}-sprite.css"
		Set files = expandAndResolveFileList(fileNames, new File(stagingDir, 'images'))
		def spriteCss = new StringBuilder()
		spriteCss.append "/** sprite: ${name}-sprite; sprite-image: url(../images/${name}-sprite.${ext}); */\n"
		for (file in files) {
			if (file.directory) {
				continue
			}
			def dimensions = Utils.calculateImageDimension(file)
			if (!dimensions) {
				// ???
			}
			String fileName = file.name.substring(0, file.name.lastIndexOf('.'))
			String relativePath = getRelativePath(file, stagingDir)
			spriteCss.append ".${fileName}_sprite {\n"
			spriteCss.append "	width: ${(int)dimensions.width}px;\n"
			spriteCss.append "	height: ${(int)dimensions.height}px;\n"
			spriteCss.append "	background-color: transparent;\n"
			spriteCss.append "	background-image: url(../$relativePath);  /** sprite-ref: ${name}-sprite; */\n"
			spriteCss.append "}\n\n"
		}

		new File(stagingDir, "css/${name}.css") << spriteCss.toString()

		spritePaths["sprite-$name"] = buildSpritePaths(files, stagingDir, name)
	}

	/**
	 * Expands names/patterns into Files.
	 * @param fileNames  names and/or patterns
	 * @param baseDir  the root dir to search in
	 * @return  matching files
	 */
	private Set<File> expandAndResolveFileList(List fileNames, File baseDir) {
		def pathResolver = new PathMatchingResourcePatternResolver()
		def resources = new HashSet<FileSystemResource>()
		for (fileName in fileNames) {
			resources.addAll pathResolver.doFindMatchingFileSystemResources(baseDir, fileName)
		}
		return resources*.file
	}

	private String buildSpritePaths(Collection files, File stagingDir, String name) {
		def paths = new StringBuilder()
		for (file in files) {
			paths.append getRelativePath(file, stagingDir)
			paths.append ','
		}
		return paths.toString()
	}

	/**
	 * return a path string of the given file relative to the provided
	 * parent directory
	 */
	private String getRelativePath(File file, File dir) {
		return (file.canonicalPath - dir.canonicalPath).substring(1).replace(File.separator, '/')
	}

	private void buildSprites(File rootDir) {
		def parameters = new SmartSpritesParameters(new File(rootDir, 'css'))
		def messageSink = new MemoryMessageSink()
		def messageLog = new MessageLog(messageSink)

		new SpriteBuilder(parameters, messageLog).buildSprites()

		if (true) {
			def comparator = Message.MessageLevel.COMPARATOR
			def minLevel = Message.MessageLevel.IE6NOTICE
			StringBuilder spriteMessages = new StringBuilder()
			for (message in messageSink.messages) {
				if (comparator.compare(message.level, minLevel) >= 0) {
					spriteMessages.append '\t'
					spriteMessages.append message.toString()
					spriteMessages.append '\n'
				}
			}
			println "\nSmartSprite log:\n$spriteMessages"
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

	private void error(String message) {
		println "\nERROR: $message\n"
	}
}
