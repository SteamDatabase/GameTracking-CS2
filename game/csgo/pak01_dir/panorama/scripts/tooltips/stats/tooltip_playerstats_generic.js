'use strict';

var PlayerStatsGenericTooltip = ( function()
{

	function _Init ()
	{
		var title = $.GetContextPanel().GetAttributeString( "title", "" );
		var text = $.GetContextPanel().GetAttributeString( "text", "" );
		var loc = $.GetContextPanel().GetAttributeString( "loc", "" );
		var addClass = $.GetContextPanel().GetAttributeString( "class", "" );

		var elTitle = $.GetContextPanel().FindChildTraverse( 'title' );
		$.GetContextPanel().SetDialogVariable( 'title', title );
		elTitle.visible = title != undefined && title != '';

		var elText = $.GetContextPanel().FindChildTraverse( 'text' );
		if ( loc != "" )
			text = $.Localize( '#' + loc );
		
		$.GetContextPanel().SetDialogVariable( 'text', text );
		elText.visible = text != undefined && text != '';

		if (addClass != "" )
			$.GetContextPanel().AddClass(addClass);
	}

	return {
		Init: _Init,
	}


})();

(function()
{
})();