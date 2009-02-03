class PostCategory {

    String name
    String description = ""

    static belongsTo = [parent: PostCategory]
    static hasMany = [subCategories: PostCategory, posts: Post]

    static constraints = {
        name(maxSize: 100)
        description(maxSize: 1000)
        parent(nullable: true)
        subCategories(nullable: true)
    }

    String toString() {
        return "${name}"
    }

}
