public class SiteFilters {

    static filters = {
        siteInResponse(controller: "*", action: "*") {
            before = {
                def sites = Site.list()
                request.site = sites.getAt(0)
                // Clear flash before each response is handled
                flash.message = null
            }
            after = {model ->
                def sites = Site.list()
                model?.site = sites.getAt(0)
            }
        }
    }

}