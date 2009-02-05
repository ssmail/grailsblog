<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Edit PostedComment</title>
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
            <span class="menuButton"><g:link class="list" action="list">PostedComment List</g:link></span>
        </div>
        <div class="body">
            <h1>Edit PostedComment</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${postedCommentInstance}">
                <div class="errors">
                    <g:renderErrors bean="${postedCommentInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form method="post">
                <input type="hidden" name="id" value="${postedCommentInstance?.id}"/>
                <div class="dialog">
                    <table class="full">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title">Title:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postedCommentInstance, field: 'title', 'errors')}">
                                    <input type="text" maxlength="100" id="title" name="title" value="${fieldValue(bean: postedCommentInstance, field: 'title')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated">Date Created:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postedCommentInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${postedCommentInstance?.dateCreated}"></g:datePicker>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated">Last Updated:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postedCommentInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${postedCommentInstance?.lastUpdated}"></g:datePicker>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="anonymousName">Anonymous Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postedCommentInstance, field: 'anonymousName', 'errors')}">
                                    <input type="text" maxlength="100" id="anonymousName" name="anonymousName" value="${fieldValue(bean: postedCommentInstance, field: 'anonymousName')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="commenter">Commenter:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postedCommentInstance, field: 'commenter', 'errors')}">
                                    <g:select optionKey="id" from="${Commenter.list()}" name="commenter.id" value="${postedCommentInstance?.commenter?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content">Content:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postedCommentInstance, field: 'content', 'errors')}">
                                    <g:textArea class="full" name="content" value="${fieldValue(bean: postedCommentInstance, field: 'content')}" rows="5" maxlength="250"/>
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
