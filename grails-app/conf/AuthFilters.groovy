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

        authorAdminCreate(controller: "author", action: "create") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

        authorAdminEdit(controller: "author", action: "edit") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

        authorAdminList(controller: "author", action: "list") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

        authorAdminShow(controller: "author", action: "show") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN")
                }
            }
        }

        marginContentAdmin(controller: "marginContent") {
            before = {
                accessControl {
                    role("SUPER_ADMIN") | role("ADMIN") | role("AUTHOR")
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

        postAdminAuthor(controller: "post", action: "create") {
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

        postedCommentAdmin(controller: "postedComment") {
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

        userAdminRegisteredUser(controller: "registeredUser") {
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

        siteAdmin(controller: "site") {
            before = {
                accessControl {
                    role("SUPER_ADMIN")
                }
            }
        }

    }

}