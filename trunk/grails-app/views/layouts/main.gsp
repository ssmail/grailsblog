<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title><g:layoutTitle default="Grails"/></title>
<link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'layout_shiny_buttons.css')}"/>
<link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'main.css')}"/>
<link rel="shortcut icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
<g:javascript library="prototype"/>
<g:javascript library="scriptaculous"/>
<g:javascript library="application"/>
<g:javascript src="rico/rico.js"/>
<% if (request.getHeader("user-agent").contains("MSIE 6.0")) { %>
<link rel="stylesheet" href="${createLinkTo(dir: 'css/patches', file: 'patch_shiny_buttons.css')}"/>
<% } %>
<g:javascript>
    Rico.loadModule('Corner');
    Rico.onLoad(function() {
        var roundCorners = Rico.Corner.round.bind(Rico.Corner);
        roundCorners('page_margins');
        roundCorners('footer');
    });

</g:javascript>
<g:layoutHead/>
</head>
<body id="mainBody">
    <div id="page_margins">
        <div id="page">
            <div id="header">

                <div id="topnav">
                    <!-- start: skip link navigation -->
                    <a class="skip" href="#navigation" title="skip link">Skip to the navigation</a><span class="hideme">.</span>
                    <a class="skip" href="#content" title="skip link">Skip to the content</a><span class="hideme">.</span>
                    <!-- end: skip link navigation -->
                    <span>
                        <g:render template="/shared/searchBoxTemplate"/>
                        <jsec:isNotLoggedIn>
                            <g:message code="search"/>
                        </jsec:isNotLoggedIn>
                        <jsec:isLoggedIn>
                            Logged in as: <jsec:principal/> (<g:link controller="auth" action="signOut">sign out</g:link>)
                        </jsec:isLoggedIn>
                    </span>
                </div>

                <% homeText = message(code: "home", args: []) %>
                <h1 class="siteTitle"><g:link controller="home" action="index" title="${homeText}">${site}</g:link></h1>
                <span>${site.tagLine}</span>
            </div>
            <!-- begin: main navigation #nav -->
            <!--<<div id="nav"><a id="navigation" name="navigation"></a>-->
            <!-- skiplink anchor: navigation -->
            <!--<div id="nav_main">-->

            <!--<ul>-->
            <!--<li id="current"><a href="#">Button 1</a></li>-->
            <!--<li><a href="#">Button 2</a></li>-->
            <!--<li><a href="#">Button 3</a></li>-->
            <!--<li><a href="#">Button 4</a></li>-->
            <!--<li><a href="#">Button 5</a></li>-->

            <!--</ul>-->
            <!--</div>-->
            <!--</div>-->
            <!-- end: main navigation -->
            <!-- begin: main content area #main -->
            <div id="main">
                <!-- begin: #col1 - first float column -->
                <div id="col1">
                    <div id="col1_content" class="clearfix">

                    </div>
                </div>
                <!-- end: #col1 -->

                <!-- begin: #col2 second float column -->
                <div id="col2">
                    <div id="col2_content" class="clearfix">
                        <g:render template="/shared/recentPostsTemplate" model="[postInstance : postInstance]"/>
                        <div id="spinner" class="spinner" style="display:none;">
                            <img src="${createLinkTo(dir: 'images', file: 'spinner.gif')}" alt="Spinner"/>
                        </div>
                    </div>

                </div>
                <!-- end: #col2 -->
                <!-- begin: #col3 static column -->
                <div id="col3">
                    <div id="col3_content" class="clearfix"><a id="content" name="content"></a>
                        <!-- skiplink anchor: Content -->
                        <g:layoutBody/>
                    </div>
                    <div id="ie_clearing">&nbsp;</div>
                    <!-- End: IE Column Clearing -->
                </div>

                <!-- end: #col3 -->
            </div>
            <!-- end: #main -->
            <!-- begin: #footer -->
            <div id="footer">Footer with copyright notice and status information<br/>
                Layout based on <a href="http://www.yaml.de/">YAML</a></div>
            <!-- end: #footer -->
        </div>

    </div>
</body>

</body>
</html>