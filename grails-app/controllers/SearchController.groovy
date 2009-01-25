import org.compass.core.engine.SearchEngineQueryParseException

class SearchController {
    def searchableService

    /**
     * Index page with search form and results
     */
    def index = {
        if (!params.q?.trim()) {
            render(view: "index", model: [results: null])
        }
        try {
            params.max = 20
            if (!params.q) {
                params.q = ""
            }
            def searchResults = searchableService.search(params.q, params)

            if (!searchResults.results || searchResults.results.size() == 0) {
                params.suggestQuery = true
                searchResults = searchableService.search(params.q, params)
            }

            render(view: "index", model: searchResults)
        } catch (SearchEngineQueryParseException ex) {
            return [parseException: true]
        }
    }
}