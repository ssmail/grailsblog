class PostService {

    boolean transactional = true

    def getRecentPosts() {

        def posts = Post.withCriteria {
            le 'displayDate', new Date()
            maxResults 10
            order 'displayDate', 'desc'
        }

        posts
    }

    def getDisplayablePosts(max, offset) {
        max = Math.min(max?.toInteger() ?: 10, 100)
        offset = offset?.toInteger() ?: 0
        def total = Post.countByDisplayDateLessThanEquals(new Date())

        def posts = Post.withCriteria {
            le 'displayDate', new Date()
            maxResults max
            firstResult offset
            order 'displayDate', 'desc'
        }

        [posts: posts, totalPosts: total, recentPosts: getRecentPosts()]
    }
}
