public class SiteFilters {

    static filters = {
        siteInResponse(controller: "*", action: "*") {
            after = {model ->
                def sites = Site.list()
                Site site = sites.getAt(0)
                model?.site = site
            }
        }
    }

}