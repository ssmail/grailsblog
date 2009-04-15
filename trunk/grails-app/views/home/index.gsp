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
        <!-- <div class="post">
                <h1 class="title">Welcome to our website </h1>
                <div class="entry">
                    <p><img src="../images/img06.jpg" alt="" width="140" height="125" class="left" />This is Lotus Flower, is a free template from <a href="http://freecsstemplates.org/">Free CSS Templates</a> released under a <a href="http://creativecommons.org/licenses/by/2.5/">Creative Commons Attribution 2.5 License</a>. The flower photo is fromt <a href="http://www.pdphoto.org/">PDPhoto.org</a>. You're free to use this template for both commercial or personal use. I only ask that you link back to <a href="http://freecsstemplates.org/">my site</a> in some way. Enjoy :)</p>
                    <p>&nbsp;</p>
                </div>
                <div class="meta">
                    <p class="byline">Posted on July 21, 2007 byFreeCssTemplates</p>
                    <p class="links"><a href="#" class="more">Read full article</a> <b>|</b> <a href="#" class="comments">Comments (32)</a></p>
                </div>
            </div> -->
        <g:each in="${posts}" status="i" var="postInstance">
            <div class="post">
                <h2 class="title">
                    ${postInstance.title.encodeAsHTML()}</a>
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
                        <b>|</b> <a href="#" class="comments">Comments (32)</a>
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
