<p:javascript src='application.all'/>
<g:javascript src="rico/rico.js"/>
<g:javascript>
    Rico.loadModule('Corner');

    document.observe("dom:loaded", function() {
        var roundCorners = Rico.Corner.round.bind(Rico.Corner);
        roundCorners('page_margins');
        roundCorners('footer');
    });

</g:javascript>