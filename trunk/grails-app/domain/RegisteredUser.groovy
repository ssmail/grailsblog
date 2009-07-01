class RegisteredUser extends JsecUser {

    UserName name
    String email

    static hasMany = [roles: Role,
            permissions: Permission]
            
    static constraints = {
        email(email: true, nullable: true)
    }
}
