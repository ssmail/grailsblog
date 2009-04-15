<%@ page import="org.codehaus.groovy.grails.plugins.searchable.util.StringQueryUtils" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>${site.title} - <g:message code="search.results" default="Search Results"/></title>
    </head>
    <body>
        <div class="post">
            <h1 class="title">
                <g:message code="search.results.for" default="Search results for"/>
                '<span class="searchTerm">
                    <g:if test="${params?.q}">
                        ${params?.q.encodeAsHTML()}
                    </g:if>
                    <g:else>
                        <g:message code="blank" default="blank"/>
                    </g:else>
                </span>'
            </h1>
            <div class="entry">
                <g:if test="${results}">
                    <div id="postResults" class="resultsPane">
                        <g:each in="${results}" var="post">
                            <h3>
                                <g:link controller="archive" action="show" id="${post.id}">
                                    ${post.title.encodeAsHTML()}
                                </g:link>
                            </h3>
                            ${post?.teaser}
                        </g:each>
                    </div>
                </g:if>
                <g:if test="${!results || results.size() == 0}">
                    <p>Nothing matched your query -
                        <strong>
                            <g:if test="${params?.q}">
                                ${params?.q}
                            </g:if>
                            <g:else>
                                <g:message code="blank" default="blank"/>
                            </g:else>
                        </strong>
                    </p>
                </g:if>
                <g:if test="${suggestedQuery}">
                    <p>Did you mean <g:link
                            controller="search"
                            action="index"
                            params="[q: suggestedQuery]">
                        ${StringQueryUtils.highlightTermDiffs(params.q.trim(), suggestedQuery)}
                    </g:link>?</p>
                </g:if>
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
    </body>
</html>