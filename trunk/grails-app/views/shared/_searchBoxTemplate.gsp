<g:form url='[controller: "searchable", action: "index"]'
        id="searchableForm"
        name="searchableForm"
        method="get">
    <g:hiddenField name="suggestQuery" value="true"/>
    <g:textField name="q" value="${params.q}"/>
</g:form>