import org.jsecurity.SecurityUtils

class SecurityService {

    boolean transactional = true

    def getCurrentUser() {

        def subject = SecurityUtils.getSubject()
        def currentUser

        if (subject.authenticated) {
            currentUser = Author.findByUsername(SecurityUtils.getSubject()?.getPrincipal())
        }

        currentUser

    }
}
