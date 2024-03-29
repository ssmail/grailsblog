<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="admin" />
        <title>UserName List</title>
        <g:javascript>
            document.observe("dom:loaded", function() {
                $("mainBody").className = "hideboth";
            });
        </g:javascript>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}"><g:message code="home" default="Home"/></a></span>
            <span class="menuButton">
                <a class="home" href="<g:createLink controller='admin' action='index'/>">
                    Admin Home
                </a>
            </span>
            <span class="menuButton"><g:link class="create" action="create">New UserName</g:link></span>
        </div>
        <div class="body">
            <h1>UserName List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="full">
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />

                   	        <g:sortableColumn property="firstName" title="First Name" />
                        
                   	        <g:sortableColumn property="middleName" title="Middle Name" />
                        
                   	        <g:sortableColumn property="lastName" title="Last Name" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userNameInstanceList}" status="i" var="userNameInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${userNameInstance.id}">${fieldValue(bean:userNameInstance, field:'id')}</g:link></td>

                            <td>${fieldValue(bean:userNameInstance, field:'firstName')}</td>
                        
                            <td>${fieldValue(bean:userNameInstance, field:'middleName')}</td>
                        
                            <td>${fieldValue(bean:userNameInstance, field:'lastName')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${UserName.count()}" />
            </div>
        </div>
    </body>
</html>
