import org.apache.commons.lang.StringUtils

class StringService {

    boolean transactional = true

    def capitalizeFirst(stringToModify) {
        
        def modifiedString = ""

        if (stringToModify) {
            modifiedString = Character.toString(stringToModify.charAt(0))
            modifiedString = " " + StringUtils.capitalize(modifiedString) + "."
        }

        return modifiedString
    }
}
