<g:formRemote url='[controller: "search", action: "index"]'
        id="searchableForm"
        name="searchableForm"
        update="col3_content"
        method="post">
    <g:textField name="q" value="${params.q}"/>
</g:formRemote>