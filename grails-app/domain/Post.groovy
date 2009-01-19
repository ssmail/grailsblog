class Post implements Comparable {

    String title
    String content = ""
    String teaser = ""
    Date dateCreated
    Date lastUpdated
    Date displayDate
    SortedSet comments
    PostCategory category

    static hasMany = [comments : PostedComment]
    static belongsTo = [author: Author]

    static mapping = {
        content type: "text"
        teaser type: "text"
    }

    /**
     * Sort by date created descending
     */
    public int compareTo(Object obj) {
        return (obj.displayDate <=> displayDate)
    }

    String toString() {
        return "${title}"
    }

}
