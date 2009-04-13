class MarginContent {
	
	String title = ""
	String content = ""
	
	static mapping = {
		cache: true
		content type: "text"
	}
	
	static constraints = {
		title(maxSize: 100)
		content(maxSize: 500)
	}

}
