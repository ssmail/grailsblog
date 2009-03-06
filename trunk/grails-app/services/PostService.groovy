import Post

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

    /**
     * Return all posts for user with pagination support
     * @param user
     * @param params http request parameters passed into controller
     * @return PagedResultList containing all posts for user
     */
    def getUserPosts(user, params) {
        params.max = Math.min(params?.max?.toInteger() ?: 10, 100)
        params.offset = params?.offset?.toInteger() ?: 0
        params.sort = params?.sort ?: "displayDate"
        params.order = params?.order ?: "desc"

        def posts = Post.createCriteria().list(
                max: params.max,
                offset: params.offset,
                sort: params.sort, 
                order: params.order) {
            eq "author", user
        }

        posts
    }

    def getTotalDisplayable() {
        Post.countByDisplayDateLessThanEquals(new Date())
    }

}
