class Post implements Comparable {

    static searchable = {
        only: ['content', 'title']
        content spellCheck: "include"
        title spellCheck: "include"
    }

    String title
    String content = ""
    String teaser = ""
    Date dateCreated
    Date lastUpdated
    Date displayDate
    SortedSet comments
    PostCategory category

    static hasMany = [comments: PostedComment]
    static belongsTo = [author: Author]

    static mapping = {
        content type: "text"
        teaser type: "text"
        cache true
        comments cache: 'nonstrict-read-write'
        author cache: 'nonstrict-read-write'
        category cache: 'nonstrict-read-write'
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
