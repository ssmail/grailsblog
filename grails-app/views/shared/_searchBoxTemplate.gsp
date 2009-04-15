<% search = message(code:"search", args:[]) ?: "Search" %>
<g:form url='[controller: "search", action: "index"]'
        id="searchableForm"
        name="searchableForm"
        method="get">
    <g:textField class="inputStyle" name="q" value="${params.q}"/>
    <g:actionSubmit class="buttonStyle" value="${search}" controller="search" action="index" />
</g:form>