public class AuthFilters {

    static filters = {

        admin(uri: "/admin/*") {
            before = {
                accessControl {
                    role("SuperAdmin") | role("Admin") | role("Author")
                }
            }
        }

        adminHome(uri: "/admin") {
            before = {
                accessControl {
                    role("SuperAdmin") | role("Admin") | role("Author")
                }
            }
        }

        authorAdmin(controller: "author") {
            before = {
                accessControl {
                    role("SuperAdmin") | role("Admin")
                }
            }
        }

        postAdmin(controller: "post") {
            before = {
                accessControl {
                    role("SuperAdmin") | role("Admin") | role("Author")
                }
            }
        }

        postCategoryAdmin(controller: "postCategory") {
            before = {
                accessControl {
                    role("SuperAdmin") | role("Admin")
                }
            }
        }

        postedCommentAdmin(controller: "postComment") {
            before = {
                accessControl {
                    role("SuperAdmin") | role("Admin")
                }
            }
        }

        userAdmin(controller: "jsecUser") {
            before = {
                accessControl {
                    role("SuperAdmin") | role("Admin")
                }
            }
        }

        userNameAdmin(controller: "userName") {
            before = {
                accessControl {
                    role("SuperAdmin") | role("Admin")
                }
            }
        }

    }

}