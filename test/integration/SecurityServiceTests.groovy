import BaseTests

public class SecurityServiceTests extends BaseTests {

    void testGetCurrentUser() {
        def name = securityService.getCurrentUser().name
        assertEquals("Verify current user is returned", "Grails Blog", name.toString())
    }

}