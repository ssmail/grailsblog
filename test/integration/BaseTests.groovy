import PostService
import SecurityService
import SetUp

class BaseTests extends GroovyTestCase {

    SetUp setUp
    SecurityService securityService
    PostService postService

    void setUp() {
        super.setUp();
        setUp = new SetUp()
        setUp.init()

        setupServices()
        setupControllers()
    }

    void tearDown() {
        super.tearDown();
    }

    /**
     * Dummy test to avoid a failure due to "No tests found in BaseTests"
     */
    void testDataConfig() {
    }

    def setupServices() {
        securityService = setUp.securityService
        postService = setUp.postService
    }

    def setupControllers() {

    }

}