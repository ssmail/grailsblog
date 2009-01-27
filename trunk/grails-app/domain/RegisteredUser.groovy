class RegisteredUser extends JsecUser {

    UserName name
    String email

    static hasMany = [roles: Role,
            permissions: Permission]

}
