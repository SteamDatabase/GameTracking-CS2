'use strict';

var PopupReportServer = ( function ()
{
	var _Init = function ()
	{
		$.GetContextPanel().SetDialogVariable( "server_name", GameStateAPI.GetServerName() );
		_UpdateSubmitButton();
	}

	var _Submit = function ()
	{
		var categories = "";

		                                                    
		$.GetContextPanel().FindChildInLayoutFile( "id-report" ).Children().forEach( el => 
		{
			if ( el.checked )
				categories += el.GetAttributeString( "data-category", "" ) + ",";
		});

		GameStateAPI.SubmitServerReport( categories );

		$.DispatchEvent( 'UIPopupButtonClicked', '' );
	}

	var _UpdateSubmitButton = function ()
	{
		var bCanSubmit = $.GetContextPanel().FindChildInLayoutFile( "id-report" ).Children().some( function ( el )
		{
			return el.checked;
		} );

		$.GetContextPanel().FindChildInLayoutFile( "SubmitButton" ).enabled = bCanSubmit;
	}

	return {
		Init				:	_Init,
		Submit				: _Submit,
		UpdateSubmitButton	: _UpdateSubmitButton,
	};
})();
