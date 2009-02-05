class ArchiveController {

    def recaptchaService
    def postService

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
        else {
            return [postInstance: postInstance, recentPosts: postService.getRecentPosts()]
        }
    }

    def saveComment = {
        def post = Post.get(params.id)
        params.remove("id")
        params.dateCreated = new Date()
        params.lastUpdated = new Date()
        def postedComment = new PostedComment(params)

        def recaptchaOK = true
        if (!recaptchaService.verifyAnswer(session, request.getRemoteAddr(), params)) {
            recaptchaOK = false
        }

        post.addToComments(postedComment)
        if (recaptchaOK && !postedComment.hasErrors() && !post.hasErrors() && post.save()) {
            flash.message = null
            recaptchaService.cleanUp(session)
            render(template: '/shared/postedCommentsTemplate', model: [postInstance: post])
        }
        else {
            post.removeFromComments(postedComment)
            if (recaptchaOK) {
                flash.message = message(code: "comment.form.error", args: [])
            }
            else if (!recaptchaOK) {
                flash.message = message(code: "recaptcha.error", args: [])
            }
            render(template: '/shared/postedCommentsTemplate', model: [postInstance: post, postedComment: postedComment])
        }
    }
}