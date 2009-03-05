<div id="postShow">

    <div class="postTitle">
        <h2>${postInstance.title.encodeAsHTML()}</h2>
    </div>
    <g:render template="/shared/byLineTemplate" model="[postInstance:postInstance]"/>
    <div class="postContent">
        ${postInstance.content}
    </div>
    <div id="postedCommentsAll">
        <h3>Comments:</h3>
        <g:render template="/shared/postedCommentsTemplate" model="[comment : comment]"/>
    </div>
</div>