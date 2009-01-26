<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Edit Author</title>
        <g:javascript>
            Rico.onLoad(function() {
                $("mainBody").addClassName("hideboth");
            });
        </g:javascript>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home"/></a></span>
            <span class="menuButton">
                <a class="home" href="<g:createLink controller='admin' action='index'/>">
                    Admin Home
                </a>
            </span>
            <span class="menuButton"><g:link class="list" action="list">Author List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Author</g:link></span>
        </div>
        <div class="body">
            <h1>Edit Author</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${authorInstance}">
                <div class="errors">
                    <g:renderErrors bean="${authorInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form method="post">
                <input type="hidden" name="id" value="${authorInstance?.id}"/>
                <div class="dialog">
                    <table class="full">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: authorInstance, field: 'name', 'errors')}">
                                    <g:select optionKey="id" from="${UserName.list()}" name="name.id" value="${authorInstance?.name?.id}"></g:select>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username">Username:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: authorInstance, field: 'username', 'errors')}">
                                    <input type="text" id="username" name="username" value="${fieldValue(bean: authorInstance, field: 'username')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">Email:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: authorInstance, field: 'email', 'errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean: authorInstance, field: 'email')}"/>
                                </td>
                            </tr>

                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments">Comments:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: authorInstance, field: 'comments', 'errors')}">

                                    <ul>
                                        <g:each var="c" in="${authorInstance?.comments?}">
                                            <li><g:link controller="postedComment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                                        </g:each>
                                    </ul>
                                    <g:link controller="postedComment" params="['author.id':authorInstance?.id]" action="create">Add PostedComment</g:link>

                                </td>
                            </tr>-->

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="about">About:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: authorInstance, field: 'about', 'errors')}">
                                    <input type="text" id="about" name="about" value="${fieldValue(bean: authorInstance, field: 'about')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="posts">Posts:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: authorInstance, field: 'posts', 'errors')}">

                                    <ul>
                                        <g:each var="p" in="${authorInstance?.posts?}">
                                            <li><g:link controller="post" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                        </g:each>
                                    </ul>
                                    <g:link controller="post" params="['author.id':authorInstance?.id]" action="create">Add Post</g:link>

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
