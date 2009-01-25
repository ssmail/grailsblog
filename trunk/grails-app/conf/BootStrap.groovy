import org.jsecurity.crypto.hash.Sha1Hash

class BootStrap {

    def init = {servletContext ->
        initData()
    }

    def destroy = {
    }

    def initData = {
        if (!JsecUser.findByUsername("admin")) {
            createDefaultUsers()
            createDefaultCategory()
            createDefaultPost()
        }
    }

    def createDefaultUsers() {
        // Roles
        def superAdminRole = new JsecRole(name: "SuperAdmin").save()
        def adminRole = new JsecRole(name: "Admin").save()
        def authorRole = new JsecRole(name: "Author").save()
        def registeredUserRole = new JsecRole(name: "RegisteredUser").save()

        // Super Admin user and role.
        def superAdminUser = new JsecUser(username: "admin", passwordHash: new Sha1Hash("admin").toHex()).save()
        new JsecUserRoleRel(user: superAdminUser, role: superAdminRole).save()

        // Create an author
        def authorName = new UserName(firstName: "Grails", middleName: "", lastName: "Blog").save()
        def author = new Author(username: "author", passwordHash: new Sha1Hash("author").toHex(), name: authorName).save()
        new JsecUserRoleRel(user: author, role: authorRole).save()

    }

    def createDefaultCategory() {
        new PostCategory(name: "General").save()
    }

    def createDefaultPost() {
        PostCategory category = PostCategory.get(1)
        Author author = Author.list().getAt(0)
        Post post = new Post(
                title: "Welcome to GrailsBlog!",
                content: "Content goes here",
                displayDate: new Date(),
                category: category)
        author.addToPosts(post)
        author.save()
    }
} 