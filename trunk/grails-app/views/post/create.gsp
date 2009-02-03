<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Create Post</title>
        <g:javascript>
            document.observe("dom:loaded", function() {
                $("mainBody").className = "hidecol1";
                $("postCreate").show();
            });
        </g:javascript>
    </head>
    <body>
        <div id="postCreate" style="display: none">
            <div id="pop" class="nav">
                <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home"/></a></span>
                <span class="menuButton">
                    <a class="home" href="<g:createLink controller='admin' action='index'/>">
                        Admin Home
                    </a>
                </span>
                <span class="menuButton"><g:link class="list" action="list">Post List</g:link></span>
            </div>
            <div class="body">
                <h2>Create Post</h2>
                <g:if test="${flash.message}">
                    <div class="message">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${postInstance}">
                    <div class="errors">
                        <g:renderErrors bean="${postInstance}" as="list"/>
                    </div>
                </g:hasErrors>
                <g:form action="save" method="post">
                    <div class="dialog">
                        <table class="full">
                            <tbody>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label>Author:</label>
                                    </td>
                                    <td>
                                        ${author}
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
                                        <label for="category">Category:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'category', 'errors')}">
                                        <g:select optionKey="id" from="${PostCategory.list()}" name="category.id" value="${postInstance?.category?.id}"></g:select>
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="title">Title:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'title', 'errors')}">
                                        <input class="almostFull" type="text" id="title" name="title" value="${fieldValue(bean: postInstance, field: 'title')}"/>
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

                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <span class="button"><input class="save" type="submit" value="Create"/></span>
                    </div>
                </g:form>
            </div>
        </div>
    </body>
</html>
