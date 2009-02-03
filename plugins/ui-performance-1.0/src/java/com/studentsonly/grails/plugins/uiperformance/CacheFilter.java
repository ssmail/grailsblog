package com.studentsonly.grails.plugins.uiperformance;

import grails.util.GrailsUtil;
import groovy.util.ConfigObject;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.groovy.grails.commons.ApplicationHolder;
import org.codehaus.groovy.grails.commons.ConfigurationHolder;
import org.codehaus.groovy.grails.commons.GrailsApplication;
import org.springframework.util.AntPathMatcher;

/**
 * Adds 'Expires' and 'Cache-Control' headers plus handles necessary headers when
 * the resource is gzipped. Only applied when in prod mode and deployed in war.
 *
 * @author <a href='mailto:beckwithb@studentsonly.com'>Burt Beckwith</a>
 */
public class CacheFilter implements Filter {

	private static final long SECONDS_IN_DAY = 60 * 60 * 24;
	private static final long TEN_YEARS_SECONDS = SECONDS_IN_DAY * 365 * 10;
	private static final long TEN_YEARS_MILLIS = TEN_YEARS_SECONDS * 1000;
	private static final String MAX_AGE = "max-age=" + TEN_YEARS_SECONDS;
	private static final Set<String> EXTENSIONS = new HashSet<String>(
			Arrays.asList(new String[] { "js", "css", "gif", "jpg", "png" }));

	private boolean _production;
	private boolean _war;
	private boolean _processImages;
	private boolean _processCSS;
	private boolean _processJS;
	private final AntPathMatcher _pathMatcher = new AntPathMatcher();
	private List<String> _exclusions;

	/**
	 * {@inheritDoc}
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse,
	 * 	javax.servlet.FilterChain)
	 */
	public void doFilter(final ServletRequest req, final ServletResponse res, final FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;

		String uri = request.getRequestURI();

		if (_production && _war && isCacheable(uri)) {

			response.setDateHeader("Expires", System.currentTimeMillis() + TEN_YEARS_MILLIS);
			response.setHeader("Cache-Control", MAX_AGE);
			if (uri.endsWith(".gz.css") || uri.endsWith(".gz.js")) {
				response.addHeader("Content-Encoding", "gzip");
			}
		}

		chain.doFilter(request, response);
	}

	private boolean isCacheable(final String uri) {

		if (!uri.contains("__v")) {
			return false;
		}

		if (isExcluded(uri)) {
			return false;
		}

		int index = uri.lastIndexOf('.');
		if (index == -1) {
			return false;
		}

		String extension = uri.substring(index + 1).toLowerCase();
		if (!EXTENSIONS.contains(extension)) {
			return false;
		}

		if (extension.equals("css")) {
			if (!_processCSS) {
				return false;
			}
		}
		else if (extension.equals("js")) {
			if (!_processJS) {
				return false;
			}
		}
		else if (!_processImages) {
			return false;
		}

		return true;
	}

	private boolean isExcluded(final String uri) {
		for (String pattern : _exclusions) {
			if (_pathMatcher.match(pattern, uri)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * {@inheritDoc}
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	public void init(final FilterConfig filterConfig) {
		_production = GrailsApplication.ENV_PRODUCTION.equals(GrailsUtil.getEnvironment());
		_war = ApplicationHolder.getApplication().isWarDeployed();
		
		_processImages = getConfigBoolean("processImages");
		_processCSS = getConfigBoolean("processCSS");
		_processJS = getConfigBoolean("processJS");

		findExclusions();
	}

	private boolean getConfigBoolean(final String name) {
		Boolean value = (Boolean)getConfigProperty(name);
		return value == null ? true : value;
	}

	@SuppressWarnings("unchecked")
	private void findExclusions() {
		_exclusions = (List<String>)getConfigProperty("exclusions");
		if (_exclusions == null) {
			_exclusions = Collections.emptyList();
		}
	}

	private Object getConfigProperty(final String name) {

		ConfigObject current = ConfigurationHolder.getConfig();
		String[] parts = ("uiperformance." + name).split("\\.");

		// navigate down to the last element, returning null if any level isn't
		// a ConfigObject or doesn't exist (don't auto-create like ConfigObject does).
		for (int i = 0; i < parts.length - 1; i++) {
			Object thing = current.get(parts[i]);
			if (thing instanceof ConfigObject) {
				current = (ConfigObject)thing;
			}
			else {
				return null;
			}
		}

		return current.get(parts[parts.length - 1]);
	}
	
	/**
	 * {@inheritDoc}
	 * @see javax.servlet.Filter#destroy()
	 */
	public void destroy() {
		// nothing to do
	}
}
