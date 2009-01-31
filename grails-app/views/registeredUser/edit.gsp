<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Edit RegisteredUser</title>
        <modalbox:modalIncludes/>
        <g:javascript>
            Rico.onLoad(function() {
                $("mainBody").addClassName("hideboth");
            });
        </g:javascript>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">RegisteredUser List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New RegisteredUser</g:link></span>
        </div>
        <div class="body">
            <h1>Edit RegisteredUser</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${registeredUserInstance}">
                <div class="errors">
                    <g:renderErrors bean="${registeredUserInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form method="post">
                <input type="hidden" name="id" value="${registeredUserInstance?.id}"/>
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
                                    <g:link controller="userName" action="edit" id="${registeredUserInstance?.id}">
                                        ${registeredUserInstance?.name?.encodeAsHTML()}
                                    </g:link>
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
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <modalbox:createLink
                                            action="changePasswordModal"
                                            id="${registeredUserInstance.id}"
                                            title="Change Password"
                                            width="375">
                                        <g:message code="change.password"/>
                                    </modalbox:createLink>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update"/></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
