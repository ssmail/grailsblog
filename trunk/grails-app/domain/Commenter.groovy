class Commenter extends RegisteredUser {

    static hasMany = [ comments : PostedComment ]

    static constraints = {

        comments(nullable : true)
        
    }

}
