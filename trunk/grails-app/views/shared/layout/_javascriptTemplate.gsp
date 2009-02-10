<p:javascript src="prototype/prototype"/>
<p:javascript src="prototype/scriptaculous"/>
<p:javascript src="prototype/builder"/>
<p:javascript src="prototype/effects"/>
<p:javascript src="prototype/controls"/>
%{--<p:javascript src="prototype/slider"/>--}%
%{--<p:javascript src="prototype/dragdrop"/>--}%
<p:javascript src="application"/>
<g:javascript src="rico/rico.js"/>
<g:javascript>
    Rico.loadModule('Corner');

    document.observe("dom:loaded", function() {
        var roundCorners = Rico.Corner.round.bind(Rico.Corner);
        roundCorners('page_margins');
        roundCorners('footer');
    });

</g:javascript>