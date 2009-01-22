import org.apache.commons.lang.StringUtils

class PostController {

    def securityService

    def readMore = "<!--READMORE-->"

    def scaffold = true

    def index = { redirect(action: list, params: params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    def list = {
        if (!params.max) params.max = 10
        if (!params.sort) params.sort = "displayDate"
        if (!params.order) params.order = "desc"
        [postInstanceList: Post.list(params)]
    }

    def show = {
        def postInstance = Post.get(params.id)

        if (!postInstance) {
            flash.message = "Post not found with id ${params.id}"
            redirect(action: list)
        }
        else { return [postInstance: postInstance] }
    }

    def delete = {
        def postInstance = Post.get(params.id)
        if (postInstance) {
            postInstance.delete()
            flash.message = "Post ${params.id} deleted"
            redirect(action: list)
        }
        else {
            flash.message = "Post not found with id ${params.id}"
            redirect(action: list)
        }
    }

    def edit = {
        def postInstance = Post.get(params.id)

        if (!postInstance) {
            flash.message = "Post not found with id ${params.id}"
            redirect(action: list)
        }
        else {
            return [postInstance: postInstance]
        }
    }

    def update = {
        def postInstance = Post.get(params.id)
        if (postInstance) {
            postInstance.properties = params
            updateTeaser(postInstance)

            if (!postInstance.hasErrors() && postInstance.save()) {
                flash.message = "Post ${params.id} updated"
                redirect(action: show, id: postInstance.id)
            }
            else {
                render(view: 'edit', model: [postInstance: postInstance])
            }
        }
        else {
            flash.message = "Post not found with id ${params.id}"
            redirect(action: edit, id: params.id)
        }
    }

    // Called when create button is clicked.  Takes user to the create page
    def create = {

        def currentUser = securityService.getCurrentUser()
        def postInstance = new Post()

        postInstance.properties = params
        return ['postInstance': postInstance, author: currentUser]
    }

    // Called from create page.  Saves the new post
    def save = {
        def postInstance = new Post(params)
        postInstance.author = securityService.getCurrentUser()
        updateTeaser(postInstance)

        if (!postInstance.hasErrors() && postInstance.save()) {
            flash.message = "Post ${postInstance.id} created"
            redirect(action: show, id: postInstance.id)
        }
        else {
            render(view: 'create', model: [postInstance: postInstance])
        }
    }
    // TODO Move to Service
    def updateTeaser(postInstance) {

        if (StringUtils.contains(params.content, readMore)) {
            postInstance.teaser = StringUtils.substringBefore(params.content, readMore)
        } else {
            postInstance.teaser = ""
        }

    }
}
