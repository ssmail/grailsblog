<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="admin"/>
        <title>${site.title} - <g:message code="admin" default="Admin"/></title>
        <g:javascript>
            Rico.onLoad(function() {
                $("mainBody").addClassName("hideboth");
            });
        </g:javascript>
    </head>
    <body>
        <jsec:hasAnyRole in="['SUPER_ADMIN']">
            <div>
                <g:link controller="site" action="list"><g:message code="site.admin" default="Site Admin"/></g:link>
            </div>
        </jsec:hasAnyRole>
        <jsec:hasAnyRole in="['SUPER_ADMIN', 'ADMIN']">
            <div>
                <g:link controller="registeredUser" action="list"><g:message code="user.admin" default="User Admin"/></g:link>
            </div>
            <div>
                <g:link controller="author" action="list"><g:message code="author.admin" default="Author Admin"/></g:link>
            </div>
            <div>
                <g:link controller="postCategory" action="list"><g:message code="post.category.admin" default="Post Category Admin"/></g:link>
            </div>
        </jsec:hasAnyRole>
        <jsec:hasAnyRole in="['AUTHOR', 'SUPER_ADMIN', 'ADMIN']">
            <div>
                <g:link controller="post" action="list"><g:message code="post.admin" default="Post Admin"/></g:link>
            </div>
        </jsec:hasAnyRole>
    </body>
</html>