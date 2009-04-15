<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>${site.title} - <g:message code="archive" default="Archive"/></title>
    </head>
    <body>
        <ul id="archive">
            <g:each in="${posts}" var="post">
                <li>
                    <g:link controller="archive" action="show" id="${post?.id}">
                        ${post?.title.encodeAsHTML()}
                    </g:link>
                </li>
            </g:each>
        </ul>
    </body>
    <g:if test="${totalPosts > posts.size()}">
        <div class="paginateButtons">
            <g:paginate controller="archive"
                    action="list"
                    total="${totalPosts}"/>
        </div>
    </g:if>
</html>