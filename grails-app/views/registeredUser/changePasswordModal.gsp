<g:form action="changePassword" id="${registeredUserId}">
    <div>
        New password:  <g:passwordField name="newPassword"/>
    </div>
    <div>
        Confirm password:  <g:passwordField name="confirmPassword"/>
    </div>
    <div class="buttons">
        <span class="button"><g:actionSubmit class="save" value="Update" action="changePassword"/></span>
    </div>
</g:form>