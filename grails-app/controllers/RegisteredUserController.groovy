import org.jsecurity.crypto.hash.Sha1Hash

class RegisteredUserController {

    def index = { redirect(action: list, params: params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    def list = {
        if (!params.max) params.max = 10
        [registeredUserInstanceList: RegisteredUser.list(params)]
    }

    def show = {
        def registeredUserInstance = RegisteredUser.get(params.id)

        if (!registeredUserInstance) {
            flash.message = "RegisteredUser not found with id ${params.id}"
            redirect(action: list)
        }
        else { return [registeredUserInstance: registeredUserInstance] }
    }

    def delete = {
        def registeredUserInstance = RegisteredUser.get(params.id)
        if (registeredUserInstance) {
            registeredUserInstance.delete()
            flash.message = "RegisteredUser ${params.id} deleted"
            redirect(action: list)
        }
        else {
            flash.message = "RegisteredUser not found with id ${params.id}"
            redirect(action: list)
        }
    }

    def edit = {
        def registeredUserInstance = RegisteredUser.get(params.id)

        if (!registeredUserInstance) {
            flash.message = "RegisteredUser not found with id ${params.id}"
            redirect(action: list)
        }
        else {
            return [registeredUserInstance: registeredUserInstance]
        }
    }

    def update = {
        def registeredUserInstance = RegisteredUser.get(params.id)
        if (registeredUserInstance) {
            registeredUserInstance.properties = params
            if (!registeredUserInstance.hasErrors() && registeredUserInstance.save()) {
                flash.message = "RegisteredUser ${params.id} updated"
                redirect(action: show, id: registeredUserInstance.id)
            }
            else {
                render(view: 'edit', model: [registeredUserInstance: registeredUserInstance])
            }
        }
        else {
            flash.message = "RegisteredUser not found with id ${params.id}"
            redirect(action: edit, id: params.id)
        }
    }

    def create = {
        def registeredUserInstance = new RegisteredUser()
        registeredUserInstance.properties = params
        return ['registeredUserInstance': registeredUserInstance]
    }

    def save = {
        def registeredUserInstance = new RegisteredUser(params)
        if (!registeredUserInstance.hasErrors() && registeredUserInstance.save()) {
            flash.message = "RegisteredUser ${registeredUserInstance.id} created"
            redirect(action: show, id: registeredUserInstance.id)
        }
        else {
            render(view: 'create', model: [registeredUserInstance: registeredUserInstance])
        }
    }

    def changePasswordModal = {
        [registeredUserId: params.id]
    }

    def changePassword = {
        def changed = false
        def registeredUserInstance = RegisteredUser.get(params.id)
        if (params.newPassword.equals(params.confirmPassword)) {
            changed = true
            registeredUserInstance.passwordHash = new Sha1Hash(params.newPassword).toHex()
        }

        if (changed && !registeredUserInstance.hasErrors() && registeredUserInstance.save()) {
            flash.message = "RegisteredUser ${registeredUserInstance.id} password changed"
            redirect(action: show, id: registeredUserInstance.id)
        }
        else {
            flash.message = "Unable to change password"
            render(view: 'edit', model: [registeredUserInstance: registeredUserInstance])
        }
    }
}
