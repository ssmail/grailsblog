<!-- start header -->
<div id="header">
	<div id="menu">
		<ul>
		    <li class="current_page_item">
			    <g:link controller="home" action="index">Homepage</g:link>
            </li>
		    <li>
			    <g:link controller="archive" action="list">Articles</g:link>
            </li>
		</ul>
	</div>
	<div id="search">
		<g:render template="/shared/searchBoxTemplate"/>
        <jsec:isLoggedIn>
            Logged in as: <jsec:principal/> (<g:link controller="auth" action="signOut">sign out</g:link>)
        </jsec:isLoggedIn>
    </div>
</div>
<div id="logo-wrap">
    <div id="logo">
        <% homeText = message(code: "home", args: []) %>
            <h1><g:link controller="home" action="index" title="${homeText}">${site?.title}</g:link></h1>
            <h2> ${site?.tagLine}</h2>
    </div>
    <div class="${site?.googleAdSenseTop?.size() == null || site?.googleAdSenseTop == null  ? '' : 'googleAdSenseTop'}">
      ${site?.googleAdSenseTop}
    </div>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
	<!-- start content -->
	<div id="content">
	    <g:layoutBody/>
	</div>
	<!-- end content -->
	<!-- start sidebar -->
	<div id="sidebar">
		<ul>
                        <g:if test="${postInstance?.author?.aboutMargin}">
                              <li>
                                  <g:render template="/author/aboutAuthorMarginContentTemplate"/>
                              </li>
                        </g:if>
			<li>
			    ${site?.googleAdSenseSide}
			</li>
			<li>
			    <g:render template="/shared/recentPostsTemplate"/>
			</li>
		</ul>
	</div>
	<!-- end sidebar -->
	<div style="clear: both;">&nbsp;</div>
</div>
<!-- end page -->
<!-- start footer -->
<div id="footer">
	<div id="footer-wrap">
	<p id="legal">&copy;<g:formatDate format="yyyy" date="${new Date()}"/> 
	    &nbsp;<g:link url="http://code.google.com/p/grailsblog/"> ${site?.title} v<g:meta name="app.version"/></g:link>.
	    &nbsp;Template from <a href="http://www.freecsstemplates.org/">Free CSS Templates</a>.
    </p>
	</div>
</div>
<!-- end footer -->