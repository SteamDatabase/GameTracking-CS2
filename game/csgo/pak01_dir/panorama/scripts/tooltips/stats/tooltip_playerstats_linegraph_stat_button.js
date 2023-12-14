'use strict';

var PlayerStatsLineGraphStatButtonTooltip = ( function()
{

	function _Init ()
	{
		var title = $.GetContextPanel().GetAttributeString( "title", "" );
		var text = $.GetContextPanel().GetAttributeString( "text", "" );
		var addClass = $.GetContextPanel().GetAttributeString( "class", "" );

		var elTitle = $.GetContextPanel().FindChildTraverse( 'title' );
		$.GetContextPanel().SetDialogVariable( 'title', title );
		elTitle.visible = title != undefined && title != '';

		var elText = $.GetContextPanel().FindChildTraverse( 'text' );
		$.GetContextPanel().SetDialogVariable( 'text', text );
		elText.visible = text != undefined && text != '';

		$.GetContextPanel().AddClass( addClass );
	}

	return {
		Init: _Init,
	}


})();

(function()
{
})();