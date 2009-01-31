<div id="changePasswordForm">
    <g:form action="changePassword" id="${registeredUserId}">
        <table class="full">
            <tbody>
                <tr>
                    <td>
                        <label><g:message code="new.password"/>:</label>
                    </td>
                    <td>
                        <g:passwordField name="newPassword"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label><g:message code="confirm.password"/>:</label>
                    </td>
                    <td>
                        <g:passwordField name="confirmPassword"/>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" value="Update" action="changePassword"/></span>
        </div>
    </g:form>
</div>