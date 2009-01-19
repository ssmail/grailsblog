import net.tanesha.recaptcha.ReCaptchaFactory
import net.tanesha.recaptcha.*
import grails.util.GrailsUtil

class RecaptchaService {
	boolean transactional = false
	private def recaptchaConfig = null
	
	/**
	 * Gets the ReCaptcha config as defined in grails-app/conf/RecaptchaConfig.grovy
	 */
	def getRecaptchaConfig() {
		if(this.recaptchaConfig==null){
			ClassLoader parent = getClass().getClassLoader()
			GroovyClassLoader loader = new GroovyClassLoader(parent)
			def rc = loader.loadClass("RecaptchaConfig")
			this.recaptchaConfig = new ConfigSlurper(GrailsUtil.environment).parse(rc)
			if (!this.recaptchaConfig.recaptcha.publicKey || this.recaptchaConfig.recaptcha.publicKey.length() == 0) {
				throw new IllegalArgumentException("Recaptcha Public Key must be specified in RecaptchaConfig")
			}
			if (!this.recaptchaConfig.recaptcha.privateKey || this.recaptchaConfig.recaptcha.privateKey.length() == 0) {
				throw new IllegalArgumentException("Recaptcha Private Key must be specified in RecaptchaConfig")
			}
		}
		return this.recaptchaConfig
	}
	
	/**
	 * Creates HTML containing all necessary markup for displaying a ReCaptcha object. This method is most
	 * commonly called by the ReCaptcha tag library and not by other users.
	 * 
	 * @param session The current session. Used for short term storage of the recaptcha object and any error messages.
	 * @param props Properties used to construct the HTML. See http://recaptcha.net/apidocs/captcha/client.html for valid
	 * properties.
	 * 
	 * @return HTML code, suitable for embedding into a webpage.
	 */
	def createCaptcha(session, props) {
		// Public key, private key, include noscript
		def config = getRecaptchaConfig()
		ReCaptcha recap
		if (config.recaptcha.useSecureAPI) {
			recap = ReCaptchaFactory.newSecureReCaptcha(config.recaptcha.publicKey, config.recaptcha.privateKey, config.recaptcha.includeNoScript)
		} else {
			recap = ReCaptchaFactory.newReCaptcha(config.recaptcha.publicKey, config.recaptcha.privateKey, config.recaptcha.includeNoScript)
		}
		session["recaptcha"] = recap
		return recap.createRecaptchaHtml(session["recaptcha_error"], props)
	}
	
	/**
	 * Verify a ReCaptcha answer.
	 * 
	 * @param session The current session.
	 * @param remoteAddress The address of the browser submitting the answer.
	 * @param params Parameters supplied by the browser.
	 * 
	 * @return True if the supplied answer is correct, false otherwise. Returns true if ReCaptcha support is disabled.
	 */
	def verifyAnswer(session, remoteAddress, params) {
		if (!isEnabled()) {
			return true
		}
		ReCaptcha recaptcha = session["recaptcha"]
        if (!recaptcha) {
            return false
        } else { 
            def response = recaptcha.checkAnswer(remoteAddress, params.recaptcha_challenge_field?.trim(), params.recaptcha_response_field?.trim())
            if (!response.valid) {
            	session["recaptcha_error"] = response.errorMessage
            }
            return response.valid
        }
	}
	
	/**
	 * Get a value indicating if the ReCaptcha plugin should be enabled.
	 */
	def isEnabled() {
		return getRecaptchaConfig().recaptcha.enabled
	}

    /**
     * Get a value indicating if the previous verification attempt failed.
     *
     * @param session The current session
     */
    def validationFailed(session) {
        return (session["recaptcha_error"] != null)
    }
	
	/**
	 * Cleanup resources associated with the session. This does have to be called, but not calling it will leave the recaptcha
	 * object in memory until the session expires.
	 * 
	 * @param session The current session.
	 */
	def cleanUp(session) {
        session["recaptcha"] = null
        session["recaptcha_error"] = null
	}
}