<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>PostCategory List</title>
        <g:javascript>
            Rico.onLoad(function() {
                $("mainBody").addClassName("hidecol1");
                $("postCreate").show();
            });
        </g:javascript>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New PostCategory</g:link></span>
        </div>
        <div class="body">
            <h1>PostCategory List</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table class="full">
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="Id"/>

                            <th>Parent</th>

                            <g:sortableColumn property="description" title="Description"/>

                            <g:sortableColumn property="name" title="Name"/>

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${postCategoryInstanceList}" status="i" var="postCategoryInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${postCategoryInstance.id}">${fieldValue(bean: postCategoryInstance, field: 'id')}</g:link></td>

                                <td>${fieldValue(bean: postCategoryInstance, field: 'parent')}</td>

                                <td>${fieldValue(bean: postCategoryInstance, field: 'description')}</td>

                                <td>${fieldValue(bean: postCategoryInstance, field: 'name')}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${PostCategory.count()}"/>
            </div>
        </div>
    </body>
</html>
