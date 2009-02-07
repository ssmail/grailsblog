<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>${site.title} - <g:message code="archive" default="Archive"/></title>
    </head>
    <body>
        <g:each in="${posts}" var="post">
            <div>
                <g:link controller="archive" action="show" id="${post?.id}">
                    ${post?.title.encodeAsHTML()}
                </g:link>
            </div>
        </g:each>

    </body>
    <div class="paginateButtons">
        <g:paginate controller="archive"
                action="list"
                total="${Post.count()}"/>
    </div>
</html>