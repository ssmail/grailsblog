import SecurityService

class PostControllerTests extends BaseTests {

    void testList() {

        def pc = new PostController()
        pc.postService = setUp.postService
        pc.securityService = setUp.securityService

        pc.list()
    }
}
