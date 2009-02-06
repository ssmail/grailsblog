<div id="postShow">

    <div class="postTitle">
        <h2>${postInstance.title.encodeAsHTML()}</h2>
    </div>
    <div class="byLine">
        by ${postInstance.author.encodeAsHTML()} on <g:formatDate format="MMMM d, yyyy" date="${postInstance.dateCreated}"/>
    </div>
    <div class="postContent">
        ${postInstance.content}
    </div>
    <div id="postedCommentsAll">
        <h3>Comments:</h3>
        <g:render template="/shared/postedCommentsTemplate" model="[comment : comment]"/>
    </div>
</div>