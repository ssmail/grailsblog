<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="admin"/>
        <title>Edit Site</title>
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
                    <table class="full">
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
                                    <label for="siteUrl">Site URL:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'siteUrl', 'errors')}">
                                    <input type="text" maxlength="150" id="siteUrl" name="siteUrl" value="${fieldValue(bean: siteInstance, field: 'siteUrl')}"/>
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
                                    <label for="welcomeMessageTitle">Welcome Message Title:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'welcomeMessageTitle', 'errors')}">
                                    <input type="text" id="welcomeMessageTitle" name="welcomeMessageTitle" value="${fieldValue(bean: siteInstance, field: 'welcomeMessageTitle')}"/>
                                </td>
                            </tr>    

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content">Welcome Message:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'welcomeMessage', 'errors')}">
                                    <fckeditor:editor
                                            name="welcomeMessage"
                                            width="100%"
                                            height="400"
                                            toolbar="Standard"
                                            fileBrowser="default">
                                        ${siteInstance.welcomeMessage}
                                    </fckeditor:editor>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="feedDescription">Feed Description:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'feedDescription', 'errors')}">
                                    <textarea class="full" rows="5" name="feedDescription">${fieldValue(bean: siteInstance, field: 'feedDescription')}</textarea>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="keyWords">Keywords:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'keyWords', 'errors')}">
                                    <textarea class="full" rows="5" name="keyWords">${fieldValue(bean: siteInstance, field: 'keyWords')}</textarea>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="googleAdSenseTop">Google Ad Sense Top:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'googleAdSenseTop', 'errors')}">
                                    <textarea class="full" rows="5" name="googleAdSenseTop">${fieldValue(bean: siteInstance, field: 'googleAdSenseTop')}</textarea>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="googleAdSenseSide">Google Ad Sense Side:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteInstance, field: 'googleAdSenseSide', 'errors')}">
                                    <textarea class="full" rows="5" name="googleAdSenseSide">${fieldValue(bean: siteInstance, field: 'googleAdSenseSide')}</textarea>
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
