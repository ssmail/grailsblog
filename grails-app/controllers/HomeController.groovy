class HomeController {

    def postService

    def index = {
        params.max = 10
        params.sort = "displayDate"
        params.order = "desc"
        def posts = Post.list(params)
        // TODO This is repeated in archivecontroller show... move to service
        [posts: posts, recentPosts: postService.getRecentPosts()]
    }
}
