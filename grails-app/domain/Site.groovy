class Site {

    String title
    String subtitle
    String tagLine
    String description
    String keyWords
    String siteUrl
    String feedDescription
    String googleAdSense
    String googleAnalytics

    static constraints = {
        title(maxSize: 100)
        subtitle(nullable: true, maxSize: 100)
        tagLine(maxSize: 100)
        description(nullable: true, maxSize: 1000)
        keyWords(nullable: true, maxSize: 1000)
        siteUrl(maxSize: 150)
        feedDescription(maxSize: 1000)
        googleAdSense(nullable: true, maxSize: 1000)
        googleAnalytics(nullable: true, maxSize: 1000)
    }

    static mapping = {
        cache true
    }

    String toString() {
        return "${title} | ${subtitle}"
    }

}
