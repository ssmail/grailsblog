<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Site List</title>
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
            <h1>Site List</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="full">
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="Id"/>

                            <g:sortableColumn property="title" title="Title"/>

                            <g:sortableColumn property="subtitle" title="Subtitle"/>

                            <g:sortableColumn property="tagLine" title="Tag Line"/>

                            <g:sortableColumn property="description" title="Description"/>

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${siteInstanceList}" status="i" var="siteInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${siteInstance.id}">${fieldValue(bean: siteInstance, field: 'id')}</g:link></td>

                                <td>${fieldValue(bean: siteInstance, field: 'title')}</td>

                                <td>${fieldValue(bean: siteInstance, field: 'subtitle')}</td>

                                <td>${fieldValue(bean: siteInstance, field: 'tagLine')}</td>

                                <td>${fieldValue(bean: siteInstance, field: 'description')}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${Site.count()}"/>
            </div>
        </div>
    </body>
</html>
