import org.apache.commons.lang.StringUtils

class PostController {

    def securityService

    def postService

    def readMore = "<!--READMORE-->"

    def scaffold = true

    def index = { redirect(action: list, params: params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    /**
     * Returns a list of the logged-in user's posts
     */
    def list = {

        def user = securityService.getCurrentUser()
        def posts = postService.getUserPosts(user, params)
        params.totalPosts = posts.totalCount
        [postInstanceList: posts, params: params]
    }

    def show = {
        def postInstance = Post.get(params.id)

        if (!postInstance) {
            flash.message = "Post not found with id ${params.id}"
            redirect(action: list)
        }
        else { return [postInstance: postInstance, recentPosts: postService.getRecentPosts()] }
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
            return [postInstance: postInstance, recentPosts: postService.getRecentPosts()]
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
                render(view: 'edit', model: [postInstance: postInstance, recentPosts: postService.getRecentPosts()])
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
        return ['postInstance': postInstance, author: currentUser, recentPosts: postService.getRecentPosts()]
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
            render(view: 'create', model: [postInstance: postInstance, recentPosts: postService.getRecentPosts()])
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
