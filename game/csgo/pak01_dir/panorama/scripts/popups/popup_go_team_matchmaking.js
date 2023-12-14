'use strict';

var PopupGoTeamMatchmaking = ( function(){

	var m_xuidToInvite = '';

	var _Init = function() 
	{
		                               
		    
		   	                                                                  
		    
		                              
		    
		   	                               
		    
		                                                     
		                                                             
		                                                           

		_SetUpEnterTextButton();
	};

	var _SetUpEnterTextButton = function()
	{
		let elTextEntry = $( '#CodeTextEntry' );
		elTextEntry.text = CompetitiveMatchAPI.GetDirectChallengeCode();
	};

	var _RandomCode = function()
	{
		let elTextEntry = $( '#CodeTextEntry' );
		elTextEntry.text = CompetitiveMatchAPI.GenerateDirectChallengeCode();
		SteamOverlayAPI.CopyTextToClipboard( elTextEntry.text.toUpperCase() );
		UiToolkitAPI.ShowTextTooltip( 'RandomCode', '#PopupGoTeamMatchmaking_DirectChallenge_Random2' );
	}

	var _CodeRegenerated = function()
	{
		_SetUpEnterTextButton();
		UiToolkitAPI.ShowTextTooltip( 'RandomCode', '#PopupGoTeamMatchmaking_DirectChallenge_Random2' );
		$.Schedule( 2, function() { UiToolkitAPI.HideTextTooltip(); } );
	}

	var _CopyCode = function()
	{
		let elTextEntry = $( '#CodeTextEntry' );
		SteamOverlayAPI.CopyTextToClipboard( elTextEntry.text.toUpperCase() );
		UiToolkitAPI.ShowTextTooltip( 'CopyCode', '#PopupGoTeamMatchmaking_DirectChallenge_Copied' );
	}

	var _GO = function( how )
	{
		switch ( how )
		{
			case 'regular': LobbyAPI.StartMatchmaking( '', '', '', '' ); break;
			case 'team': LobbyAPI.StartMatchmaking( '', '', '', '1' ); break;
			case 'direct':
				let code0 = '', code1 = '';
				let elTextEntry = $( '#CodeTextEntry' );
				if ( elTextEntry.text )
				{
					code0 = CompetitiveMatchAPI.ValidateDirectChallengeCode( elTextEntry.text.toUpperCase(), 'set' );
					let pos = ( code0 && typeof code0 === 'string' ) ? code0.indexOf( ',' ) : -1;
					if ( pos > 0 )
					{
						code1 = code0.substring( pos + 1 );
						code0 = code0.substring( 0, pos );
					}
				}
				if ( !code0 || !code1 )
				{
					$.DispatchEvent( 'CSGOPlaySoundEffect', 'mainmenu_press_GO', 'MOUSE' );
					UiToolkitAPI.ShowGenericPopupYesNo( '#PopupGoTeamMatchmaking_DirectChallenge_Explain_Title', '#PopupGoTeamMatchmaking_DirectChallenge_Explain', "",
						function()
						{
							CompetitiveMatchAPI.GenerateDirectChallengeCode();
							SteamOverlayAPI.CopyTextToClipboard( CompetitiveMatchAPI.GetDirectChallengeCode().toUpperCase() );
							$.DispatchEvent( 'PlayMenu_GoTeamMatchmaking_CodeGenerated' );
						}, function(){} );
					return;
				}
				LobbyAPI.StartMatchmaking( '', code0, code1, '1' );
				break;
		}
		                   
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'mainmenu_press_GO', 'MOUSE' );
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
	}

	return {
		Init:	_Init,
		GO:	_GO,
		CodeRegenerated: _CodeRegenerated,
		RandomCode : _RandomCode,
		CopyCode : _CopyCode,
	};

} )();

                                                                                                    
                                            
                                                                                                    
(function()
{
	$.RegisterForUnhandledEvent( 'PlayMenu_GoTeamMatchmaking_CodeGenerated', PopupGoTeamMatchmaking.CodeRegenerated );
})();