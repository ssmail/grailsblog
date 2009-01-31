<g:each in="${postInstance.comments.sort{it?.dateCreated}}" status="i" var="comment">
    <g:render template="/shared/commentTemplate" model="[comment : comment]"/>
</g:each>

<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>
<g:formRemote name="newComment"
        id="${postInstance.id}"
        url="[ controller: 'archive', action: 'saveComment']"
        update="[success: 'postedComments', failure: 'postedComments']">
    <div><g:message code="comment.form.title" default="Title"/>*</div>
    <g:textField class="commentFormInput" name="title" value="${postedComment?.title}" />

    <div><g:message code="comment.form.name" default="Name"/>*</div>
    <g:textField class="commentFormInput" name="anonymousName" value="${postedComment?.anonymousName}" />

    <div><g:message code="comment.form.content" default="Comment"/>*</div>
    <g:textArea class="commentFormTextArea" name="content" value="${postedComment?.content}"/>

    <recaptcha:ifEnabled>
        <recaptcha:recaptcha theme="clean"/>
    </recaptcha:ifEnabled>

    <input type="hidden" name="id" value="${postInstance.id}"/>
    <div><input type="submit" value="Submit"/></div>
</g:formRemote>