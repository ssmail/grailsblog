<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title><g:message code="blog.title"/> - <g:message code="admin"/></title>
        <g:javascript>
            Rico.onLoad(function() {
                $("mainBody").addClassName("hideboth");
            });
        </g:javascript>
    </head>
    <body>
        <jsec:hasAnyRole in="['SUPER_ADMIN', 'ADMIN']">
            <div>
                <g:link controller="registeredUser" action="list"><g:message code="user.admin"/></g:link>
            </div>
            <div>
                <g:link controller="author" action="list"><g:message code="author.admin"/></g:link>
            </div>
        </jsec:hasAnyRole>
        <div>
            <g:link controller="post" action="list"><g:message code="post.admin"/></g:link>
        </div>
    </body>
</html>