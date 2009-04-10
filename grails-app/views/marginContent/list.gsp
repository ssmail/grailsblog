

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>MarginContent List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New MarginContent</g:link></span>
        </div>
        <div class="body">
            <h1>MarginContent List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="full">
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="title" title="Title" />
                        
                   	        <g:sortableColumn property="content" title="Content" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${marginContentInstanceList}" status="i" var="marginContentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${marginContentInstance.id}">${fieldValue(bean:marginContentInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:marginContentInstance, field:'title')}</td>
                        
                            <td>${fieldValue(bean:marginContentInstance, field:'content')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${MarginContent.count()}" />
            </div>
        </div>
    </body>
</html>
