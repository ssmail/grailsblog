<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Create RegisteredUser</title>
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
            <span class="menuButton"><g:link class="list" action="list">RegisteredUser List</g:link></span>
        </div>
        <div class="body">
            <h1>Create RegisteredUser</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${registeredUserInstance}">
                <div class="errors">
                    <g:renderErrors bean="${registeredUserInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form action="save" method="post">
                <div class="dialog">
                    <table class="full">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username">Username:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: registeredUserInstance, field: 'username', 'errors')}">
                                    <input type="text" id="username" name="username" value="${fieldValue(bean: registeredUserInstance, field: 'username')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: registeredUserInstance, field: 'name', 'errors')}">
                                    <g:select optionKey="id" from="${UserName.list()}" name="name.id" value="${registeredUserInstance?.name?.id}"></g:select>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">Email:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: registeredUserInstance, field: 'email', 'errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean: registeredUserInstance, field: 'email')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="passwordHash">Password Hash:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: registeredUserInstance, field: 'passwordHash', 'errors')}">
                                    <input type="text" id="passwordHash" name="passwordHash" value="${fieldValue(bean: registeredUserInstance, field: 'passwordHash')}"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create"/></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
