class HomeController {

    def postService

    def index = {
        postService.getDisplayablePosts(params.max, params.offset)
    }
}
