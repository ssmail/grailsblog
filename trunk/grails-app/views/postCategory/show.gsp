<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Show PostCategory</title>
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
            <h1>Show PostCategory</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table class="full">
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">Name:</td>

                            <td valign="top" class="value">${fieldValue(bean: postCategoryInstance, field: 'name')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Description:</td>

                            <td valign="top" class="value">${fieldValue(bean: postCategoryInstance, field: 'description')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Sub Categories:</td>

                            <td valign="top" style="text-align:left;" class="value">
                                <ul>
                                    <g:each var="s" in="${postCategoryInstance.subCategories}">
                                        <li><g:link controller="postCategory" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                </ul>
                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Parent:</td>

                            <td valign="top" class="value"><g:link controller="postCategory" action="show" id="${postCategoryInstance?.parent?.id}">${postCategoryInstance?.parent?.encodeAsHTML()}</g:link></td>

                        </tr>

                        <!--<tr class="prop">
                            <td valign="top" class="name">Posts:</td>

                            <td valign="top" style="text-align:left;" class="value">
                                <ul>
                                    <g:each var="p" in="${postCategoryInstance.posts}">
                                        <li><g:link controller="post" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                </ul>
                            </td>

                        </tr>-->

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${postCategoryInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
