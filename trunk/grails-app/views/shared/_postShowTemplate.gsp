<div class="post">
    <h1 class="title">
        ${postInstance.title.encodeAsHTML()}
    </h1>
    <div class="entry">
        <g:if test="${postInstance.teaser.size() > 0}">
            ${postInstance.teaser}
        </g:if>
        <g:else>
            ${postInstance.content}
        </g:else>
    </div>
	<div class="meta">
		<g:render template="/shared/byLineTemplate" model="[postInstance:postInstance]"/>
		<p class="links">
            <b>|</b> <a href="#" class="comments">Comments (32)</a>
        </p>
	</div>
    <h3 class="title">Comments:</h3>
    <g:render template="/shared/postedCommentsTemplate" model="[comment : comment]"/>
</div>