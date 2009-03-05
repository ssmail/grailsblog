class UrlMappings {

    static mappings = {
        // archive/show/1
        //  home/index
        //  search/index

        // User access
        // None yet, this will be used later for registered users

        // Anonymous browsing
        "/"(controller: "home", action: "index")
        "/archive/show"(controller: "archive", action: "show")
        "/archive/saveComment"(controller: "archive", action: "saveComment")
        "/archive/list"(controller: "archive", action: "list")
        "/feed/rss"(controller: "feed", action: "rss")
        "/feed/atom"(controller: "feed", action: "atom")

        "/home/index"(controller: "home", action: "index")

        "/search/index"(controller: "search", action: "index")

        "/author/about"(controller: "author", action: "about")

        // Admin access
        "/admin"(controller: "admin", action: "index")
        "/admin/$controller/$action?/$id?"()

        // Error handling
        "500"(view: '/error')
    }
}
