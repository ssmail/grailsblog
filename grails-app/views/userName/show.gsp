<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Show UserName</title>
        <g:javascript>
            document.observe("dom:loaded", function() {
                $("mainBody").className = "hideboth";
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
            <span class="menuButton"><g:link class="list" action="list">UserName List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New UserName</g:link></span>
        </div>
        <div class="body">
            <h1>Show UserName</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table class="full">
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">First Name:</td>

                            <td valign="top" class="value">${fieldValue(bean: userNameInstance, field: 'firstName')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Middle Name:</td>

                            <td valign="top" class="value">${fieldValue(bean: userNameInstance, field: 'middleName')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Last Name:</td>

                            <td valign="top" class="value">${fieldValue(bean: userNameInstance, field: 'lastName')}</td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${userNameInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
