class Site {

    String name
    String tagLine
    String description
    String googleAdSense
    String googleAnalytics

    static constraints = {
        name(maxSize: 100)
        tagLine(maxSize: 100)
        description(maxSize: 1000)
        googleAdsense(maxSize: 1000)
        googleAnalytics(maxSize: 1000)
    }
}
