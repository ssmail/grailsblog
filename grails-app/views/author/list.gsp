<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Author List</title>
        <g:javascript>
            Rico.onLoad(function() {
                $("mainBody").addClassName("hideboth");
            });
        </g:javascript>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home"/></a></span> 
            <span class="menuButton">
                <a class="home" href="<g:createLink controller='admin' action='index'/>">
                    Admin Home
                </a>
            </span>
            <span class="menuButton"><g:link class="create" action="create">New Author</g:link></span>
        </div>
        <div class="body">
            <h1>Author List</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="full">
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="Id"/>

                            <g:sortableColumn property="username" title="Username"/>

                            <th>Name</th>

                            <g:sortableColumn property="email" title="Email"/>

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${authorInstanceList}" status="i" var="authorInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${authorInstance.id}">${fieldValue(bean: authorInstance, field: 'id')}</g:link></td>

                                <td>${fieldValue(bean: authorInstance, field: 'username')}</td>

                                <td>${fieldValue(bean: authorInstance, field: 'name')}</td>

                                <td>${fieldValue(bean: authorInstance, field: 'email')}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${Author.count()}"/>
            </div>
        </div>
    </body>
</html>
