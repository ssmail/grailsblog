<!-- start header -->
<div id="header">
	<div id="menu">
		<ul>
			<li class="current_page_item"><a href="#">Homepage</a></li>
			<li><a href="#">Blogs</a></li>
			<li><a href="#">Photos</a></li>
			<li><a href="#">About</a></li>
			<li class="last"><a href="#">Contact</a></li>
		</ul>
	</div>
</div>
<div id="logo-wrap">
<div id="logo">
	<h1><a href="#">lotus flower </a></h1>
	<h2> Design by Free Css Templates</h2>
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
			<li id="search">
				<h2>Search</h2>
				<g:render template="/shared/searchBoxTemplate"/>
                <jsec:isLoggedIn>
                    Logged in as: <jsec:principal/> (<g:link controller="auth" action="signOut">sign out</g:link>)
                </jsec:isLoggedIn>
			</li>
			<li>
			    <g:render template="/shared/recentPostsTemplate" model="[postInstance : postInstance]"/>
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
	    &nbsp;<g:link url="http://code.google.com/p/grailsblog/"> ${site.title} v<g:meta name="app.version"/></g:link>. 
	    &nbsp;Template from <a href="http://www.freecsstemplates.org/">Free CSS Templates</a>.
    </p>
	</div>
</div>
<!-- end footer -->