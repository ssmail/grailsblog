class PostService {

    boolean transactional = true

    def getRecentPosts() {
        Post.listOrderByDisplayDate(max: 10, order: "desc")
    }
}
