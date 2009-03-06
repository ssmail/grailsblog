import PostService
import RegisteredUser
import SecurityService
import UserName

class SetUp {

    def securityService
    def postService

    def init() {
        initServices()
        initData()
    }

    def initServices() {

        // Mock out securityService
        securityService = [getCurrentUser: {
            def name = UserName.findByFirstName("Grails")
            def user = RegisteredUser.findByName(name)
            //user.posts = []
            user
        }] as SecurityService

        postService = new PostService()
    }

    def initData() {
        new BootStrap().init()
    }

}