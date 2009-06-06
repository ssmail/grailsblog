class Site {

    String title
    String subtitle
    String tagLine
    String description
    String welcomeMessageTitle
    String welcomeMessage
    String keyWords
    String siteUrl
    String feedDescription
    String googleAdSenseTop
    String googleAdSenseSide
    String googleAnalytics
    
    static constraints = {
        title(maxSize: 100)
        subtitle(nullable: true, maxSize: 100)
        tagLine(maxSize: 100)
        description(nullable: true, maxSize: 1000)
        welcomeMessageTitle(nullable: true, maxSize: 100)
        welcomeMessage(nullable: true)
        keyWords(nullable: true, maxSize: 1000)
        siteUrl(maxSize: 150)
        feedDescription(maxSize: 1000)
        googleAdSenseTop(nullable: true, maxSize: 1000)
        googleAdSenseSide(nullable: true, maxSize: 1000)
        googleAnalytics(nullable: true, maxSize: 1000)
    }

    static mapping = {
        cache true
        welcomeMessage type: "text"
    }

    String toString() {
        return "${title} | ${subtitle}"
    }

}
