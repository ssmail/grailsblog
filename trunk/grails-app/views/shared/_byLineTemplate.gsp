<p class="byline">
    by
    <% modalTitle = message(code: "about", args: []) + " " + postInstance.author.encodeAsHTML() %>
    <modalbox:createLink
            controller="author"
            action="about"
            id="${postInstance?.author?.id?.encodeAsHTML()}"
            title="${modalTitle}"
            width="400">
        ${postInstance.author.encodeAsHTML()}
    </modalbox:createLink>

    on <g:formatDate format="MMMM d, yyyy" date="${postInstance.displayDate}"/>
</p>