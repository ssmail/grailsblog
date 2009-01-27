class Permission implements org.jsecurity.authz.Permission, Serializable {

    static belongsTo = [user: RegisteredUser]

    boolean implies(org.jsecurity.authz.Permission p) {
        false
    }

}
