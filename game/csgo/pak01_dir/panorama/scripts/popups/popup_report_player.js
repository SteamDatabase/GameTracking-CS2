'use strict';

var PopupReportPlayer = ( function(){

	var _Init = function ()
	{

		var xuid = $.GetContextPanel().GetAttributeString( "xuid", "" );

		$.GetContextPanel().SetDialogVariable( "target_player", GameStateAPI.GetPlayerName( xuid ));

		                                                               
		$.GetContextPanel().FindChildInLayoutFile( "id-report" ).Children().forEach( el => 
		{
			var category = el.GetAttributeString( "data-category", "" );

			el.enabled = GameStateAPI.IsReportCategoryEnabledForSelectedPlayer( xuid, category );
		});

	}

	var _Submit = function ()
	{
		var categories = "";

		                                                    
		$.GetContextPanel().FindChildInLayoutFile( "id-report" ).Children().forEach( el => 
		{
			if ( el.checked )
				categories += el.GetAttributeString( "data-category", "" ) + ",";
		});

		var xuid = $.GetContextPanel().GetAttributeString( "xuid", "" );

		GameStateAPI.SubmitPlayerReport( xuid, categories );

		$.DispatchEvent( 'UIPopupButtonClicked', '' );
	}

	return {
				Init	:	_Init,
				Submit	:	_Submit,
	};
})();
