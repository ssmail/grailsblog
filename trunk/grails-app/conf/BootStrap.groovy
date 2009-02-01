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
            createDefaultSite()
        }
    }

    def createDefaultUsers() {

        // Super Admin user and role.
        def superAdminName = new UserName(firstName: "Super", middleName: "", lastName: "Admin").save()
        def superAdminUser = new RegisteredUser(username: "admin", passwordHash: new Sha1Hash("admin").toHex(),
                name: superAdminName, email: "test@test.com")
        superAdminUser.addToRoles(name: RoleName.SUPER_ADMIN)
        superAdminUser.save()

        // Create an author
        def authorName = new UserName(firstName: "Grails", middleName: "", lastName: "Blog").save()
        def author = new Author(username: "author", passwordHash: new Sha1Hash("author").toHex(), name: authorName).save()
        author.addToRoles(name: RoleName.AUTHOR)

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

    def createDefaultSite() {
        Site site = new Site(title: "Grails Blog",
                subtitle: "Subtitle",
                tagLine: "Insert witty tagline here",
                description: "Site description",
                siteUrl: "http://www.grailsblog.com",
                feedDescription: "GrailsBlog keeps you up to date with Grails, its supporting technologies and opinions",
                keyWords: "key, words, separated, by, commas")
        site.save()
    }
} 