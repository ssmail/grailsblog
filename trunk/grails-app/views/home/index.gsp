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
        <div class="body">
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:each in="${posts}" status="i" var="postInstance">
                <div>
                    <div class="postTitle">
                        <h2>
                            <a href="<g:createLink
                                    controller="archive"
                                    action="show"
                                    id="${postInstance.id}"/>"
                                    title="<g:message code="blog.permalink" default="Permalink"/>">
                                ${postInstance.title.encodeAsHTML()}</a>
                        </h2>
                    </div>
                    <div class="byLine">
                        by ${postInstance.author.encodeAsHTML()} on <g:formatDate format="MMMM d, yyyy" date="${postInstance.displayDate}"/>
                    </div>
                    <div class="postContent">
                        <g:if test="${postInstance.teaser.size() > 0}">
                            ${postInstance.teaser}
                            <div class="readMore">
                                <g:link controller="archive" action="show" id="${postInstance.id}">
                                    <g:message code="post.read.more" default="Read More"/>
                                </g:link>
                            </div>
                        </g:if>
                        <g:else>
                            ${postInstance.content}
                        </g:else>
                    </div>
                </div>
                <g:if test="${i < posts.size() - 1}">
                    <div class="dots"></div>
                </g:if>
            </g:each>
            <div class="paginateButtons">
                <g:paginate controller="home"
                        action="index"
                        total="${totalPosts}"/>
            </div>
        </div>
    </body>
</html>
