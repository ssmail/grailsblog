<title><g:layoutTitle default="Grails"/></title>
<link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'layout_shiny_buttons.css')}"/>
<link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'main.css')}"/>
<% if (request.getHeader("user-agent").contains("MSIE 6.0")) { %>
<link rel="stylesheet" href="${createLinkTo(dir: 'css/patches', file: 'patch_shiny_buttons.css')}"/>
<% } %>
<link rel="shortcut icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>