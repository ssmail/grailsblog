<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>${site}</title>
        <feed:meta kind="rss" version="2.0" controller="feed" action="rss"/>
        <meta name="description" content="${site?.description}"/>
        <meta name="keywords" content="${site?.keyWords}"/>
    </head>
    <body>
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <g:if test="${site?.welcomeMessageTitle && site?.welcomeMessage}">
            <div class="post">
                <h1 class="title">${site?.welcomeMessageTitle}</h1>
                <div class="entry">
                    <p>${site?.welcomeMessage}</p>
                </div>
            </div>
        </g:if>
        <g:each in="${posts}" status="i" var="postInstance">
            <div class="post">
                <h2 class="title">
				    <a href="<g:createLink
                        controller="archive"
                        action="show"
                        id="${postInstance.id}"/>"
                        title="<g:message code="blog.permalink" default="Permalink"/>">
                            ${postInstance.title.encodeAsHTML()}</a>
                    </a>
                </h2>
                <div class="entry">
                    <g:if test="${postInstance.teaser.size() > 0}">
                        ${postInstance.teaser}
                    </g:if>
                    <g:else>
                        ${postInstance.content}
                    </g:else>
                </div>
    			<div class="meta">
    				<g:render template="/shared/byLineTemplate" model="[postInstance:postInstance]"/>
    				<p class="links">
    				    <a class="more" href="<g:createLink
                            controller="archive"
                            action="show"
                            id="${postInstance.id}"/>"
                            title="<g:message code="blog.permalink" default="Permalink"/>">
                            Read full article
                        </a> 
                        <b>|</b> <g:link class="comments" controller="archive" action="show" id="${postInstance.id}">Comments (${postInstance?.comments?.size()})</g:link>
                    </p>
    			</div>
            </div>
        </g:each>
        <g:if test="${totalPosts > posts.size()}">
            <div class="paginateButtons">
                <g:paginate controller="home"
                        action="index"
                        total="${totalPosts}"/>
            </div>
        </g:if>
    </body>
</html>
