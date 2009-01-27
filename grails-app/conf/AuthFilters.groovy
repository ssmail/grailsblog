public class AuthFilters {

    static filters = {

        admin(uri: "/admin/*") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN") | role("AUTHOR")
                }
            }
        }

        adminHome(uri: "/admin") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN") | role("AUTHOR")
                }
            }
        }

        authorAdmin(controller: "author") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

        postAdmin(controller: "post") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN") | role("AUTHOR")
                }
            }
        }

        postAdmin(controller: "post", action: "create") {
            before = {
                accessControl {
                    role("AUTHOR")
                }
            }
        }

        postCategoryAdmin(controller: "postCategory") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

        postedCommentAdmin(controller: "postComment") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

        searchableAdmin(controller: "searchable") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

        userAdmin(controller: "jsecUser") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

        userNameAdmin(controller: "userName") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

    }

}