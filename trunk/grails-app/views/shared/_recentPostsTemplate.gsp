<h2>
    <g:message code="recent.posts" default="Recent Posts"/>
    <g:link controller="feed" action="rss">
        <img id="feed-icon" src="${createLinkTo(dir: 'images', file: 'feed-icon.png')}" alt="Feed Icon"/>
    </g:link>
</h2>
<div id="recentPosts">
    <g:each in="${recentPosts}" var="post" status="i">
        <div class="recentPosts">
            <a href="<g:createLink controller="archive" action="show" id="${post.id}"/>">${post.title}</a>
        </div>
    </g:each>
    <div class="recentPostsMore">
        <g:if test="${totalPosts > recentPosts?.size()}">
            <a href="<g:createLink controller="archive" action="list"/>"><g:message code="recent.posts.more" default="More"/></a>
        </g:if>
    </div>
</div>