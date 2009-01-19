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
    <div><g:message code="comment.form.title"/>*</div>
    <input class="commentFormInput" type="text" name="title" value="${postedComment?.title}"/>

    <div><g:message code="comment.form.name"/>*</div>
    <input class="commentFormInput" type="text" name="anonymousName" value="${postedComment?.anonymousName}"/>

    <div><g:message code="comment.form.content"/>*</div>
    <textarea class="commentFormTextArea" name="content">${postedComment?.content}</textarea>

    <recaptcha:ifEnabled>
        <recaptcha:recaptcha theme="clean"/>
    </recaptcha:ifEnabled>

    <input type="hidden" name="id" value="${postInstance.id}"/>
    <div><input type="submit" value="Submit"/></div>
</g:formRemote>