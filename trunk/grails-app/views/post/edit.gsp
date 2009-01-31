<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Edit Post</title>
        <g:javascript>
            Rico.onLoad(function() {
                $("mainBody").addClassName("hidecol1");
                $("postEdit").show();
            });
        </g:javascript>
    </head>
    <body>
        <div id="postEdit" style="display: none">
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
                <h1>Edit Post</h1>
                <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${postInstance}">
                    <div class="errors">
                        <g:renderErrors bean="${postInstance}" as="list"/>
                    </div>
                </g:hasErrors>
                <g:form method="post">
                    <input type="hidden" name="id" value="${postInstance?.id}"/>
                    <div class="dialog">
                        <table class="full">
                            <tbody>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="author">Author:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'author', 'errors')}">
                                        ${postInstance?.author.encodeAsHTML()}
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="dateCreated">Date Created:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'dateCreated', 'errors')}">
                                        <g:datePicker name="dateCreated" value="${postInstance?.dateCreated}"></g:datePicker>
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="lastUpdated">Last Updated:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'lastUpdated', 'errors')}">
                                        <g:datePicker name="lastUpdated" value="${postInstance?.lastUpdated}"></g:datePicker>
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="displayDate">Display Date:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'displayDate', 'errors')}">
                                        <g:datePicker name="displayDate" value="${postInstance?.displayDate}"></g:datePicker>
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="title">Title:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'title', 'errors')}">
                                        <input type="text" id="title" name="title" value="${fieldValue(bean: postInstance, field: 'title')}"/>
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="content">Content:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'content', 'errors')}">
                                        <fckeditor:editor
                                                name="content"
                                                width="100%"
                                                height="400"
                                                toolbar="Standard"
                                                fileBrowser="default">
                                            ${postInstance.content}
                                        </fckeditor:editor>
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="comments">Comments:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'comments', 'errors')}">

                                        <ul>
                                            <g:each var="c" in="${postInstance?.comments}">
                                                <li><g:link controller="postedComment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                                            </g:each>
                                        </ul>
                                        <g:link controller="postedComment" params="['post.id':postInstance?.id]" action="create">Add PostedComment</g:link>

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
        </div>
    </body>
</html>
