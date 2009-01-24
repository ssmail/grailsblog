class PostedComment implements Comparable{

    String title
    String content
    String anonymousName
    Date dateCreated
    Date lastUpdated

    static belongsTo = [commenter : Commenter, post : Post]

    static constraints = {
        title(blank: false, size: 1..100)
        content(blank: false, size: 1..250)
        commenter(nullable:true)
        anonymousName(blank: false, size: 1..100)
    }

    static mapping = {
        content type: "text"
    }

    public int compareTo(Object o) {
        return o.dateCreated <=> dateCreated
    }

}
