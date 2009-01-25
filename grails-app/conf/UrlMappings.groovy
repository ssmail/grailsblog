class UrlMappings {

    static mappings = {
        // archive/show/1
        //  home/index
        //  search/index

        // User access
        // None yet, this will be used later for registered users

        // Anonymous browsing
        "/"(controller: "home", action: "index")
        "/arhive/show"(controller: "archive", action: "show")
        "/arhive/saveComment"(controller: "archive", action: "saveComment")

        "/home/index"(controller: "home", action: "index")

        "/search/index"(controller: "search", action: "index")

        // Admin access
        "/admin"(controller: "admin", action: "index")
        "/admin/$controller/$action?/$id?"()

        // Error handling
        "500"(view: '/error')
    }
}
