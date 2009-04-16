<h2>
    <g:message code="recent.posts" default="Recent Posts"/>
    <g:link controller="feed" action="rss">
        <img id="feed-icon" src="${createLinkTo(dir: 'images', file: 'feed-icon.png')}" alt="Feed Icon"/>
    </g:link>
</h2>
<ul>
    <g:each in="${recentPosts}" var="post" status="i">
        <li>
            <a href="<g:createLink controller="archive" action="show" id="${post.id}"/>">${post.title}</a>
        </li>
    </g:each>
</ul>
<div class="recentPostsMore">
    <g:if test="${totalPosts > recentPosts?.size()}">
        <p class="links">
            <a class="showMore" href="<g:createLink controller="archive" action="list"/>"><g:message code="recent.posts.more" default="More"/></a>
        </p>
    </g:if>
</div>