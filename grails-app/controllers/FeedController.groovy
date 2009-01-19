class FeedController {
    def postService

    def rss = {
        def posts = postService.getRecentPosts()

        render(feedType: "rss", feedVersion: "2.0") {
            title = g.message(code: "blog.title", args: [])
            link = "http://${InetAddress.localHost.canonicalHostName}/feed/rss"
            description = g.message(code: "blog.rss.feed.description", args: [])

            posts.each {post ->
                entry(post.title.encodeAsHTML()) {
                    link = "http://${InetAddress.localHost.canonicalHostName}/archive/show/${post.id}"//"http://your.test.server/article/1"
                    retrieveContent(post) // return the content
                }
            }

        }
    }

    // TODO Refactor this to get rid of duplicate code
    def atom = {
        render(feedType: "atom", feedVersion: "1.0") {
            title = g.message(code: "blog.title", args: [])
            link = "http://${InetAddress.localHost.canonicalHostName}/feed/rss"
            description = g.message(code: "blog.rss.feed.description", args: [])

            posts.each {post ->
                entry(post.title.encodeAsHTML()) {
                    link = "http://${InetAddress.localHost.canonicalHostName}/archive/show/${post.id}"//"http://your.test.server/article/1"
                    retrieveContent(post) // return the content
                }
            }

        }
    }

    def retrieveContent(post) {
        def content

        if (post.teaser.size() > 0) {
            content = post.teaser
        } else {
            content = post.content
        }

        content
    }
}