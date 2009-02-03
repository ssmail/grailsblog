<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Edit PostCategory</title>
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
            <span class="menuButton"><g:link class="list" action="list">PostCategory List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New PostCategory</g:link></span>
        </div>
        <div class="body">
            <h1>Edit PostCategory</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${postCategoryInstance}">
                <div class="errors">
                    <g:renderErrors bean="${postCategoryInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form method="post">
                <input type="hidden" name="id" value="${postCategoryInstance?.id}"/>
                <div class="dialog">
                    <table class="full">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postCategoryInstance, field: 'name', 'errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean: postCategoryInstance, field: 'name')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">Description:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postCategoryInstance, field: 'description', 'errors')}">
                                    <input type="text" id="description" name="description" value="${fieldValue(bean: postCategoryInstance, field: 'description')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subCategories">Sub Categories:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postCategoryInstance, field: 'subCategories', 'errors')}">

                                    <ul>
                                        <g:each var="s" in="${postCategoryInstance?.subCategories?}">
                                            <li><g:link controller="postCategory" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                                        </g:each>
                                    </ul>
                                    <g:link controller="postCategory" params="['postCategory.id':postCategoryInstance?.id]" action="create">Add PostCategory</g:link>

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="parent">Parent:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postCategoryInstance, field: 'parent', 'errors')}">
                                    <g:select optionKey="id" from="${PostCategory.list()}" name="parent.id" value="${postCategoryInstance?.parent?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>

                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="posts">Posts:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: postCategoryInstance, field: 'posts', 'errors')}">

                                    <ul>
                                        <g:each var="p" in="${postCategoryInstance?.posts?}">
                                            <li><g:link controller="post" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                        </g:each>
                                    </ul>
                                    <g:link controller="post" params="['postCategory.id':postCategoryInstance?.id]" action="create">Add Post</g:link>

                                </td>
                            </tr>-->

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
