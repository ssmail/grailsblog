<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Edit Site</title>
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
            <h1>Edit Site</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${siteInstance}">
                <div class="errors">
                    <g:renderErrors bean="${siteInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form method="post">
                <input type="hidden" name="id" value="${siteInstance?.id}"/>
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title">Title:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'title', 'errors')}">
                                    <input type="text" maxlength="100" id="title" name="title" value="${fieldValue(bean: siteInstance, field: 'title')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subtitle">Subtitle:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'subtitle', 'errors')}">
                                    <input type="text" maxlength="100" id="subtitle" name="subtitle" value="${fieldValue(bean: siteInstance, field: 'subtitle')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tagLine">Tag Line:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'tagLine', 'errors')}">
                                    <input type="text" maxlength="100" id="tagLine" name="tagLine" value="${fieldValue(bean: siteInstance, field: 'tagLine')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">Description:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'description', 'errors')}">
                                    <textarea class="full" rows="5" name="description">${fieldValue(bean: siteInstance, field: 'description')}</textarea>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="googleAdSense">Google Ad Sense:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'googleAdSense', 'errors')}">
                                    <textarea class="full" rows="5" name="googleAdSense">${fieldValue(bean: siteInstance, field: 'googleAdSense')}</textarea>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="googleAnalytics">Google Analytics:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'googleAnalytics', 'errors')}">
                                    <textarea class="full" rows="5" name="googleAnalytics">${fieldValue(bean: siteInstance, field: 'googleAnalytics')}</textarea>
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
