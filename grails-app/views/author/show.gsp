<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Show Author</title>
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
            <span class="menuButton"><g:link class="create" action="create">New Author</g:link></span>
        </div>
        <div class="body">
            <h1>Show Author</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table class="full">
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">Name:</td>

                            <td valign="top" class="value">
                                <g:link controller="userName" action="show" id="${authorInstance?.name?.id}">
                                    ${authorInstance?.name?.encodeAsHTML()}</g:link>
                            </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Username:</td>

                            <td valign="top" class="value">${fieldValue(bean: authorInstance, field: 'username')}</td>

                        </tr>

                        <!--<tr class="prop">
                            <td valign="top" class="name">Comments:</td>

                            <td valign="top" style="text-align:left;" class="value">
                                <ul>
                                    <g:each var="c" in="${authorInstance.comments}">
                                        <li><g:link controller="postedComment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                </ul>
                            </td>

                        </tr>-->

                        <tr class="prop">
                            <td valign="top" class="name">Email:</td>

                            <td valign="top" class="value">${fieldValue(bean: authorInstance, field: 'email')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">About:</td>

                            <td valign="top" class="value">${fieldValue(bean: authorInstance, field: 'about')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Posts:</td>

                            <td valign="top" style="text-align:left;" class="value">
                                <ul>
                                    <g:each var="p" in="${authorInstance.posts}">
                                        <li><g:link controller="post" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                </ul>
                            </td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${authorInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
