class PostedCommentController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        if(!params.max) params.max = 10
        [ postedCommentInstanceList: PostedComment.list( params ) ]
    }

    def show = {
        def postedCommentInstance = PostedComment.get( params.id )

        if(!postedCommentInstance) {
            flash.message = "PostedComment not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ postedCommentInstance : postedCommentInstance ] }
    }

    def delete = {
        def postedCommentInstance = PostedComment.get( params.id )
        if(postedCommentInstance) {
            postedCommentInstance.delete()
            flash.message = "PostedComment ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "PostedComment not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def postedCommentInstance = PostedComment.get( params.id )

        if(!postedCommentInstance) {
            flash.message = "PostedComment not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ postedCommentInstance : postedCommentInstance ]
        }
    }

    def update = {
        def postedCommentInstance = PostedComment.get( params.id )
        if(postedCommentInstance) {
            postedCommentInstance.properties = params
            if(!postedCommentInstance.hasErrors() && postedCommentInstance.save()) {
                flash.message = "PostedComment ${params.id} updated"
                redirect(action:show,id:postedCommentInstance.id)
            }
            else {
                render(view:'edit',model:[postedCommentInstance:postedCommentInstance])
            }
        }
        else {
            flash.message = "PostedComment not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def postedCommentInstance = new PostedComment()
        postedCommentInstance.properties = params
        return ['postedCommentInstance':postedCommentInstance]
    }

    def save = {
        def postedCommentInstance = new PostedComment(params)
        if(!postedCommentInstance.hasErrors() && postedCommentInstance.save()) {
            flash.message = "PostedComment ${postedCommentInstance.id} created"
            redirect(action:show,id:postedCommentInstance.id)
        }
        else {
            render(view:'create',model:[postedCommentInstance:postedCommentInstance])
        }
    }
}
