<div id="postedComments">
    <g:render template="/shared/commentTemplate" model="[postInstance : postInstance]"/>
</div>


<div id="commentSpinner" class="spinner" style="display:none;">
    <img src="${createLinkTo(dir: 'images', file: 'spinner.gif')}" alt="Spinner"/>
</div>

<g:formRemote name="newComment"
        id="${postInstance.id}"
        url="[ controller: 'archive', action: 'saveComment']"
        update="[success: 'postedComments', failure: 'postedComments']"
        onComplete="Recaptcha.reload();"
        onLoaded="Effect.Fade('commentSpinner', {duration:0.5,queue:'end'}); Effect.Fade('spinner', {duration:0.5,queue:'end'});">
    <div><g:message code="comment.form.title" default="Title"/>*</div>
    <g:textField class="commentFormInput" name="title" value="${postedComment?.title}"/>

    <div><g:message code="comment.form.name" default="Name"/>*</div>
    <g:textField class="commentFormInput" name="anonymousName" value="${postedComment?.anonymousName}"/>

    <div><g:message code="comment.form.content" default="Comment"/>*</div>
    <g:textArea class="commentFormTextArea" name="content" value="${postedComment?.content}"/>

    <recaptcha:ifEnabled>
        <recaptcha:recaptcha theme="clean"/>
    </recaptcha:ifEnabled>

    <input type="hidden" name="id" value="${postInstance.id}"/>
    <div><input type="submit" value="Submit"/></div>
</g:formRemote>