<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>PostedComment List</title>
        <g:javascript>
            document.observe("dom:loaded", function() {
                $("mainBody").className = "hideboth";
            });
        </g:javascript>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
            <span class="menuButton">
                <a class="home" href="<g:createLink controller='admin' action='index'/>">
                    Admin Home
                </a>
            </span>
        </div>
        <div class="body">
            <h1>PostedComment List</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="full">
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="Id"/>

                            <g:sortableColumn property="title" title="Title"/>

                            <g:sortableColumn property="dateCreated" title="Date Created"/>

                            <g:sortableColumn property="anonymousName" title="Anonymous Name"/>

                            <th>Commenter</th>

                            <g:sortableColumn property="content" title="Content"/>

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${postedCommentInstanceList}" status="i" var="postedCommentInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${postedCommentInstance.id}">${fieldValue(bean: postedCommentInstance, field: 'id')}</g:link></td>

                                <td>${fieldValue(bean: postedCommentInstance, field: 'title')}</td>

                                <td>${fieldValue(bean: postedCommentInstance, field: 'dateCreated')}</td>

                                <td>${fieldValue(bean: postedCommentInstance, field: 'anonymousName')}</td>

                                <td>${fieldValue(bean: postedCommentInstance, field: 'commenter')}</td>

                                <td>${fieldValue(bean: postedCommentInstance, field: 'content')}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${PostedComment.count()}"/>
            </div>
        </div>
    </body>
</html>
