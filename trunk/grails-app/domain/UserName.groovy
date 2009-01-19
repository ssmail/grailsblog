class UserName {

    def stringService
    static transients =  ['stringService']

    String firstName
    String middleName
    String lastName

    static constraints = {
        middleName(nullable : true)
    }

    String toString() {
        return "${firstName}" + stringService.capitalizeFirst(middleName) +  " ${lastName}"
    }

}
