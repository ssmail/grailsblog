class PostCategory {

    String name
    String description = ""

    static belongsTo = [parent: PostCategory]
    static hasMany = [subCategories: PostCategory, posts: Post]

    static constraints = {
        parent(nullable: true)
        subCategories(nullable: true)
    }

    String toString() {
        return "${name}"
    }

}
