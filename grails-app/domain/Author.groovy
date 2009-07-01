class Author extends Commenter {

    String about = ""
    String aboutMargin = ""
    Boolean contactMe = false
    SortedSet posts = new TreeSet()

    static hasMany = [posts: Post]

    static mapping = {
        about type: "text"
        aboutMargin type: "text"
        cache true
        posts cache: 'nonstrict-read-write'
    }

    String toString() {
        return "${name}"
    }

}