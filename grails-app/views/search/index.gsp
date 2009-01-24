<%@ page import="org.codehaus.groovy.grails.plugins.searchable.util.StringQueryUtils" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title><g:message code="blog.title"/> - <g:message code="search.results"/></title>
    </head>
    <body>
        <div id="searchResults" class="searchResults">
            <h2>
                <g:message code="search.results.for"/>
                <span class="searchTerm">
                    <g:if test="${params?.q}">
                        ${params?.q.encodeAsHTML()}
                    </g:if>
                    <g:else>
                        <g:message code="blank"/>
                    </g:else>
                </span>
            </h2>
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
                            <g:message code="blank"/>
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
    </body>
</html>