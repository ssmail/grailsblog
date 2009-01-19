<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title><g:message code="blog.title"/></title>
        <feed:meta kind="rss" version="2.0" controller="feed" action="rss"/>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:each in="${posts}" status="i" var="postInstance">
                <div>
                    <div class="postTitle">
                        <h2><a href="<g:createLink controller="archive" action="show" id="${postInstance.id}"/>">
                            ${postInstance.title.encodeAsHTML()}</a>
                        </h2>
                    </div>
                    <div class="byLine">
                        by ${postInstance.author.encodeAsHTML()} on <g:formatDate format="MMMM d, yyyy" date="${postInstance.displayDate}"/>
                    </div>
                    <div class="postContent">
                        <g:if test="${postInstance.teaser.size() > 0}">
                            ${postInstance.teaser}
                        </g:if>
                        <g:else>
                            ${postInstance.content}
                        </g:else>
                    </div>
                </div>
                <div class="dots"></div>
            </g:each>
        </div>
    </body>
</html>
