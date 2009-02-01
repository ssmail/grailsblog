<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Show Site</title>
        <g:javascript>
            Rico.onLoad(function() {
                $("mainBody").addClassName("hideboth");
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
            <span class="menuButton"><g:link class="list" action="list">Site List</g:link></span>
        </div>
        <div class="body">
            <h1>Show Site</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table class="full">
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">Title:</td>

                            <td valign="top" class="value">${fieldValue(bean: siteInstance, field: 'title')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Subtitle:</td>

                            <td valign="top" class="value">${fieldValue(bean: siteInstance, field: 'subtitle')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Tag Line:</td>

                            <td valign="top" class="value">${fieldValue(bean: siteInstance, field: 'tagLine')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Description:</td>

                            <td valign="top" class="value">${fieldValue(bean: siteInstance, field: 'description')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Feed Description:</td>

                            <td valign="top" class="value">${fieldValue(bean: siteInstance, field: 'feedDescription')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Keywords:</td>

                            <td valign="top" class="value">${fieldValue(bean: siteInstance, field: 'keyWords')}</td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${siteInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="edit" value="Edit"/></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
