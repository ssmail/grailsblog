<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Create Author</title>
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
            <span class="menuButton"><g:link class="list" action="list">Author List</g:link></span>
        </div>
        <div class="body">
            <h1>Create Author</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${authorInstance}">
                <div class="errors">
                    <g:renderErrors bean="${authorInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form action="save" method="post">
                <div class="dialog">
                    <table class="full">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: authorInstance, field: 'name', 'errors')}">
                                    <g:select optionKey="id" from="${UserName.list()}" name="name.id" value="${authorInstance?.name?.id}"></g:select>
                                     or
                                    <g:link controller="userName" action="create">
                                        <g:message code="create.new.author.name" default="Create new author name"/>
                                    </g:link>
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
                    <span class="button"><input class="save" type="submit" value="Create"/></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
