class AdminController {

    def postService

    def index = {
        [recentPosts: postService.getRecentPosts()]
    }
}
