

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit MarginContent</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">MarginContent List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New MarginContent</g:link></span>
        </div>
        <div class="body">
            <h1>Edit MarginContent</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${marginContentInstance}">
            <div class="errors">
                <g:renderErrors bean="${marginContentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${marginContentInstance?.id}" />
                <div class="dialog">
                    <table class="full">
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title">Title:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:marginContentInstance,field:'title','errors')}">
                                    <input class="full" type="text" maxlength="100" id="title" name="title" value="${fieldValue(bean:marginContentInstance,field:'title')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content">Content:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:marginContentInstance,field:'content','errors')}">
                                    <textarea class="full" rows="5" cols="40" name="content">${fieldValue(bean:marginContentInstance, field:'content')}</textarea>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
