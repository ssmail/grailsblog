<h2><g:message code="recent.posts"/></h2>
<div id="recentPosts">
    <g:each in="${recentPosts}" var="post" status="i">
        <div class="recentPosts">
            <a href="<g:createLink controller="archive" action="show" id="${post.id}"/>">${post.title}</a>
        </div>
    </g:each>
    <div class="recentPostsMore">
        <g:if test="${recentPosts?.size > 10}">
            <a href="<g:createLink controller="archive" action="list"/>"><g:message code="recent.posts.more"/></a>
        </g:if>
    </div>
</div>