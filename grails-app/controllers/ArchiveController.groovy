class ArchiveController {

    def recaptchaService
    def postService

    def index = { redirect(action: list, params: params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    def list = {
        postService.getDisplayablePosts(100, params.offset)
    }

    def show = {
        def postInstance = Post.get(params.id)

        if (!postInstance || postInstance.displayDate > new Date()) {
            flash.message = "Post not found"
            redirect(controller: "home", action: "index")
        }
        else {
            return [postInstance: postInstance, totalPosts: postService.getTotalDisplayable(), recentPosts: postService.getRecentPosts()]
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
            // recaptchaService is not cleaned up here because that invalidates it during an ajax response
            //recaptchaService.cleanUp(session)
            render(template: '/shared/commentTemplate', model: [postInstance: post])
        }
        else {
            post.removeFromComments(postedComment)
            if (recaptchaOK) {
                flash.message = message(code: "comment.form.error", args: [])
            }
            else if (!recaptchaOK) {
                flash.message = message(code: "recaptcha.error", args: [])
            }
            render(template: '/shared/commentTemplate', model: [postInstance: post])
        }
    }
}