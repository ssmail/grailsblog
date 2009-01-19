import org.jsecurity.crypto.hash.Sha1Hash

class BootStrap {

    def init = {servletContext ->
        createDefaultUsers()
        createDefaultCategory()
        createDefaultPost()
    }

    def destroy = {
    }

    def createDefaultUsers() {

        // Administrator user and role.
        def adminRole = new JsecRole(name: "Administrator").save()
        def adminUser = new JsecUser(username: "admin", passwordHash: new Sha1Hash("admin").toHex()).save()
        new JsecUserRoleRel(user: adminUser, role: adminRole).save()

        // A normal user.
        def userRole = new JsecRole(name: "User").save()
        def normalUser = new JsecUser(username: "phil", passwordHash: new Sha1Hash("password").toHex()).save()
        new JsecUserRoleRel(user: normalUser, role: userRole).save()

        // Give another user the "User" role.
        normalUser = new JsecUser(username: "alice", passwordHash: new Sha1Hash("changeit").toHex()).save()
        new JsecUserRoleRel(user: normalUser, role: userRole).save()

        // Create an author
        def authorName = new UserName(firstName: "Dean", middleName: "Charles", lastName: "Del Ponte").save()
        def author = new Author(username: "author", passwordHash: new Sha1Hash("author").toHex(), name: authorName).save()
        new JsecUserRoleRel(user: author, role: adminRole).save()

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