class Author extends Commenter {

    String about = ""
    SortedSet posts = new TreeSet()

    static hasMany = [posts: Post]

    static constraints = {
        email(nullable: true)
    }

    static mapping = {
        about type: "text"
    }

    String toString() {
        return "${name}"
    }

}