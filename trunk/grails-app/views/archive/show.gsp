<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>${site.title} - ${postInstance.title}</title>
    </head>
    <body>
        <g:render template="/shared/postShowTemplate" model="[postInstance: postInstance]"/>
    </body>
</html>