class MarginContent {
	
	String title = ""
	String content = ""
	Boolean active = false
	Integer displayPriority = 1
	
	static mapping = {
		cache: true
		content type: "text"
	}
	
	static constraints = {
		title(maxSize: 100)
		content(maxSize: 500)
	}

}