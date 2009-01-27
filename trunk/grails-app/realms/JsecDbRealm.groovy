import org.jsecurity.authc.AccountException
import org.jsecurity.authc.IncorrectCredentialsException
import org.jsecurity.authc.SimpleAccount
import org.jsecurity.authc.UnknownAccountException

class JsecDbRealm {
    static authTokenClass = org.jsecurity.authc.UsernamePasswordToken

    def credentialMatcher

    def authenticate(authToken) {
        log.info "Attempting to authenticate ${authToken.username} in DB realm..."
        def username = authToken.username

        // Null username is invalid
        if (username == null) {
            throw new AccountException('Null usernames are not allowed by this realm.')
        }

        // Get the user with the given username. If the user is not
        // found, then they don't have an account and we throw an
        // exception.
        def user = JsecUser.findByUsername(username)
        if (!user) {
            throw new UnknownAccountException("No account found for user [${username}]")
        }

        log.info "Found user '${user.username}' in DB"

        // Now check the user's password against the hashed value stored
        // in the database.
        def account = new SimpleAccount(username, user.passwordHash, "JsecDbRealm")
        if (!credentialMatcher.doCredentialsMatch(authToken, account)) {
            log.info 'Invalid password (DB realm)'
            throw new IncorrectCredentialsException("Invalid password for user '${username}'")
        }

        return account
    }

    def hasRole(principal, roleName) {
        def user = RegisteredUser.findByUsername(principal, [fetch: [roles: 'join']])

        return user.roles.any {
            it.name == RoleName.valueOf(roleName)
        }
    }

    def hasAllRoles(principal, userRoles) {
        def foundRoles = RegisteredUser.withCriteria {
            projections {
                property "roles"
            }
            roles {
                'in'('name', roles.collect { RoleName.valueOf(it) })
            }
            eq('username', principal)
        }

        return foundRoles.size() == roles.size()
    }

    def isPermitted(principal, requiredPermission) {

        if (requiredPermission instanceof org.jsecurity.authz.Permission) {
            def permissions = org.jsecurity.authz.Permission.withCriteria {
                registeredUser {
                    eq('username', principal)
                }
            }
            return permissions.any {permission ->
                permission.implies(requiredPermission)
            }
        }
        else {
            return true
        }

    }
}
