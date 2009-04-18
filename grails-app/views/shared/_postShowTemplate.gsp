<div class="post">
    <h1 class="title">
        ${postInstance.title.encodeAsHTML()}
    </h1>
    <div class="entry">
        ${postInstance?.content}
    </div>
	<div class="meta">
		<g:render template="/shared/byLineTemplate" model="[postInstance: postInstance]"/>
		<p class="links">
            <b>|</b> <a href="#" class="comments">Comments (${postInstance?.comments?.size()})</a>
        </p>
	</div>
    <h3 class="title">Comments:</h3><a name="comments"></a>
    <g:render template="/shared/postedCommentsTemplate" model="[comment : comment]"/>
</div>