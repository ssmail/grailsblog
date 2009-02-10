<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="admin"/>
        <title>Show Post</title>
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
            <span class="menuButton"><g:link class="list" action="list">Post List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Post</g:link></span>
        </div>
        <div class="body">
            <h1>Show Post</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table class="full">
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">Author:</td>

                            <td valign="top" class="value"><g:link controller="author" action="show" id="${postInstance?.author?.id}">${postInstance?.author?.encodeAsHTML()}</g:link></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Title:</td>

                            <td valign="top" class="value">${fieldValue(bean: postInstance, field: 'title')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Date Created:</td>

                            <td valign="top" class="value">${fieldValue(bean: postInstance, field: 'dateCreated')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Display Date:</td>

                            <td valign="top" class="value">${fieldValue(bean: postInstance, field: 'displayDate')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Last Updated:</td>

                            <td valign="top" class="value">${fieldValue(bean: postInstance, field: 'lastUpdated')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Teaser:</td>

                            <td valign="top" class="value">${postInstance.teaser}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Content:</td>

                            <td valign="top" class="value">${postInstance.content}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Comments:</td>

                            <td valign="top" style="text-align:left;" class="value">
                                <ul>
                                    <g:each var="c" in="${postInstance.comments}">
                                        <li><g:link controller="postedComment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                </ul>
                            </td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${postInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
