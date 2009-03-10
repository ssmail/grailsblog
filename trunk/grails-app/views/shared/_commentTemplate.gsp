<g:each in="${postInstance?.comments?.sort{it?.dateCreated}}" status="i" var="comment">
    <div id="comment${comment.id}" class="commentBg">
        <h4 class="commentTitle">
            ${comment?.title.encodeAsHTML()}
        </h4>
        <div class="commentByLine">
            by ${comment?.anonymousName.encodeAsHTML()} on
            <g:formatDate format="MMMM d, yyyy" date="${comment.dateCreated}"/>
            <g:message code="at" default="at"/> <g:formatDate format="h:mm aaa z" date="${comment.dateCreated}"/>
        </div>
        <div class="commentContent">
            ${comment?.content.encodeAsHTML()}
        </div>
    </div>
    <div class="dots"></div>
</g:each>