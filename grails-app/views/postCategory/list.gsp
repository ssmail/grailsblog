<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="admin"/>
        <title>PostCategory List</title>
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
            <span class="menuButton"><g:link class="create" action="create">New PostCategory</g:link></span>
        </div>
        <div class="body">
            <h1>PostCategory List</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="full">
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="Id"/>

                            <g:sortableColumn property="name" title="Name"/>

                            <g:sortableColumn property="description" title="Description"/>

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${postCategoryInstanceList}" status="i" var="postCategoryInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${postCategoryInstance.id}">${fieldValue(bean: postCategoryInstance, field: 'id')}</g:link></td>

                                <td>${fieldValue(bean: postCategoryInstance, field: 'name')}</td>

                                <td>${fieldValue(bean: postCategoryInstance, field: 'description')}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${PostCategory.count()}"/>
            </div>
        </div>
    </body>
</html>
