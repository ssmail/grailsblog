<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="admin"/>
        <title>Show PostedComment</title>
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
            <h1>Show PostedComment</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table class="full">
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">Title:</td>

                            <td valign="top" class="value">${fieldValue(bean: postedCommentInstance, field: 'title')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Date Created:</td>

                            <td valign="top" class="value">${fieldValue(bean: postedCommentInstance, field: 'dateCreated')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Last Updated:</td>

                            <td valign="top" class="value">${fieldValue(bean: postedCommentInstance, field: 'lastUpdated')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Anonymous Name:</td>

                            <td valign="top" class="value">${fieldValue(bean: postedCommentInstance, field: 'anonymousName')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Commenter:</td>

                            <td valign="top" class="value"><g:link controller="commenter" action="show" id="${postedCommentInstance?.commenter?.id}">${postedCommentInstance?.commenter?.encodeAsHTML()}</g:link></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Content:</td>

                            <td valign="top" class="value">${fieldValue(bean: postedCommentInstance, field: 'content')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Post:</td>

                            <td valign="top" class="value"><g:link controller="post" action="show" id="${postedCommentInstance?.post?.id}">${postedCommentInstance?.post?.encodeAsHTML()}</g:link></td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${postedCommentInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
