<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>${site.title} - ${postInstance.title}</title>
        <!--<g:javascript>
            Rico.loadModule('Corner');
            Rico.onLoad(function() {
                roundCorners('postedCommentsAll');
            });
        </g:javascript>-->
    </head>
    <body>
        <div class="body">
            <div class="body">
                <g:render template="/shared/postShowTemplate" model="[postInstance : postInstance]"/>
            </div>
        </div>
    </body>
</html>