class HomeController {
    
    def postService

    def index = {
        def posts = Post.list(max: 10, sort: "displayDate", order: "desc")
        // TODO This is repeated in archivecontroller show... move to service
        [posts: posts, recentPosts: postService.getRecentPosts()]
    }
}
