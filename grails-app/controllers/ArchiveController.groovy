import Post
import PostedComment

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
            return [
                    postInstance: postInstance,
                    totalPosts: postService.getTotalDisplayable(),
                    recentPosts: postService.getRecentPosts()]
        }
    }

    def saveComment = {
        def post = Post.get(params.id)
        params.remove("id")
        params.dateCreated = new Date()
        params.lastUpdated = new Date()
        // Prototype doesn't like an id of name 'content' so this is the workaround
        params.content = params?.newCommentContent
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
            flash.message = generateCommentErrorMessage(postedComment, recaptchaOK)
            response.sendError(404)
        }
    }

    def generateCommentErrorMessage(postedComment, recaptchaOK) {
        def msg
        postedComment.validate()
        def contentError = postedComment?.errors?.getFieldError("content")
          
        if (recaptchaOK) {
            def commentTooLarge = contentError != null && postedComment.content?.size() > 0
            
            if (commentTooLarge) {
                msg = message(code: "comment.form.content.too.big.error", args: [postedComment.content.size()])
            }
            else {
                msg = message(code: "comment.form.error", args: [])
            }
        }
        else if (!recaptchaOK) {
            msg = message(code: "recaptcha.error", args: [])
        }
        
        return msg
    }
}