<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <g:render template="/shared/layout/headTemplate"/>
        <g:render template="/shared/layout/javascriptTemplate"/>
        <g:layoutHead/>
    </head>
    <body id="mainBody" class="${site.googleAdSense?.size() == 0 ? '' : 'hidecol1'}">
        <g:render template="/shared/layout/mainBodyTemplate"/>
        ${site?.googleAnalytics}
    </body>
</html>