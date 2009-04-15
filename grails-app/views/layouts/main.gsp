<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--

Design by Free CSS Templates
http://www.freecsstemplates.org
Released for free under a Creative Commons Attribution 2.5 License

Title      : Lotus Flower
Version    : 1.0
Released   : 20080501
Description: A two-column, fixed-width and lightweight template ideal for 1024x768 resolutions. Suitable for blogs and small websites.

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <g:render template="/shared/layout/headTemplate"/>
    <g:layoutHead/>
</head>
<body id="mainBody" class="${site.googleAdSense?.size() > 0 ? '' : 'hidecol1'}">
    <g:render template="/shared/layout/mainBodyTemplate"/>
    <g:render template="/shared/layout/javascriptTemplate"/>
    ${site?.googleAnalytics}
</body>
</html>