<div id="searchResults" class="searchResults">
    <g:if test="${results}">
        <div id="postResults" class="resultsPane">
            <h2>Search Results</h2>
            <g:each in="${results}" var="post">
                ${post.title.encodeAsHTML()}
                ${post?.teaser}
            </g:each>
        </div>
    </g:if>
    <g:elseif test="${suggestedQuery}">
        <p>Did you mean <em>${suggestedQuery.encodeAsHTML()}?</em></p>
    </g:elseif>
</div>