class SiteController {

    def scaffold = Site

    def create = {
        redirect(action: "list")
    }
}
