<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Post List</title>
        <g:javascript>
            Rico.onLoad(function() {
                $("mainBody").addClassName("hideboth");
            });
        </g:javascript>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home"/></a></span>
            <span class="menuButton">
                <a class="home" href="<g:createLink controller='admin' action='index'/>">
                    Admin Home
                </a>
            </span>
            <span class="menuButton"><g:link class="create" action="create">New Post</g:link></span>
        </div>
        <div class="body">
            <h1>Post List</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="full">
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="Id"/>

                            <th>Author</th>
                            <g:sortableColumn property="title" title="Title"/>

                            <g:sortableColumn property="dateCreated" title="Date Created"/>

                            <g:sortableColumn property="displayDate" title="Display Date"/>

                            <g:sortableColumn property="lastUpdated" title="Last Updated"/>

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${postInstanceList}" status="i" var="postInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${postInstance.id}">${fieldValue(bean: postInstance, field: 'id')}</g:link></td>

                                <td>${fieldValue(bean: postInstance, field: 'author')}</td>

                                <td>${fieldValue(bean: postInstance, field: 'title')}</td>

                                <td>${fieldValue(bean: postInstance, field: 'dateCreated')}</td>

                                <td>${fieldValue(bean: postInstance, field: 'displayDate')}</td>

                                <td>${fieldValue(bean: postInstance, field: 'lastUpdated')}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${Post.count()}"/>
            </div>
        </div>
    </body>
</html>
