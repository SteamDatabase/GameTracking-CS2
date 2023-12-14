'use strict';

var PopupCommendPlayer = ( function(){

	var m_loadingJob = 0;
	var m_elStatus;
	var m_elCommend;

	var _Init =  function()
	{
		m_elStatus = $( "#id-commend-status" );
		m_elCommend = $( "#id-commend" );

		var xuid = $.GetContextPanel().GetAttributeString( "xuid", "" );
		$.GetContextPanel().SetDialogVariable( "target_player", $.HTMLEscape( GameStateAPI.GetPlayerName( xuid ) ) );

		_Update();
	}

	function _CancelLoading()
	{
		m_loadingJob = 0;

		if ( m_elStatus && m_elStatus.IsValid() )
		{
			m_elStatus.text = $.Localize( '#SFUI_PlayerDetails_Loading_Failed' );
		}
		
		m_elCommend.visible = false;
	}

	function _ReceivedCommendationFromServer()
	{
		if ( m_loadingJob )
		{
			$.CancelScheduled( m_loadingJob );
			m_loadingJob = 0;
		}

		_Update();
	}
	
	var _Update = function()
	{
		var xuid = $.GetContextPanel().GetAttributeString( "xuid", "" );
		var bAskedServersForCommendation = GameStateAPI.QueryServersForCommendation( xuid );

		if ( bAskedServersForCommendation )
		{
			var numTokens = GameStateAPI.GetCommendationTokensAvailable();

			if ( numTokens == 0 )
			{
				if ( m_elStatus && m_elStatus.IsValid() )
				{
					m_elStatus.text = $.Localize( "#SFUI_PlayerDetails_NoCommendations_Left" );
				}

				m_elCommend.visible = false;
				
			}
			else
			{
				if ( m_elStatus && m_elStatus.IsValid() )
				{
					m_elStatus.SetDialogVariableInt( "num_token", numTokens );
					m_elStatus.text = $.Localize( "#Panorama_PlayerDetails_Commendations_Left", numTokens, m_elStatus );
				}

				m_elCommend.visible = true;
			}
			
			if ( m_elCommend.visible )
			{
				                                                                                                              
				var oCommends = GameStateAPI.GetMyCommendationsJSOForUser( xuid );
				if ( oCommends[ 'valid' ] )
				{
					var bHasPrevCommendations = false;

					$.GetContextPanel().FindChildInLayoutFile( "id-commend" ).Children().forEach( el => 
					{
						var category = el.GetAttributeString( "data-category", "" );
						
						if ( oCommends[ category ] )
						{
							el.checked = true;
							bHasPrevCommendations = true;
						}
					} );
					
					if ( bHasPrevCommendations )
					{
						m_elStatus.text = $.Localize( "#SFUI_PlayerDetails_Previously_Submitted" );
					}	
				}
			}
		}
		else
		{
			                                      
			m_loadingJob = $.Schedule( 10, _CancelLoading );

			if ( m_elStatus && m_elStatus.IsValid() )
			{
				m_elStatus.text = $.Localize( "#SFUI_PlayerDetails_Loading" );
			}
			
			m_elCommend.visible = false;
		}

		                       
		$( "#id-commend-submit" ).visible = m_elCommend.visible;
	}

	var _Submit = function()
	{
		var xuid = $.GetContextPanel().GetAttributeString( "xuid", "" );

		var commendString = "";

		$.GetContextPanel().FindChildInLayoutFile( "id-commend" ).Children().forEach( el => 
		{
			var category = el.GetAttributeString( "data-category", "" );
			
			if ( el.checked )
			{
				commendString += category + ",";
			}
		});

		GameStateAPI.SubmitCommendation( xuid, commendString );
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
	}

	return {
		Init : _Init,
		Submit : _Submit,
		ReceivedCommendationFromServer : _ReceivedCommendationFromServer,
	};
})();


                                                                                                    
                                           
                                                                                                    
( function()
{
	$.RegisterForUnhandledEvent( "GameState_CommendPlayerQueryResponse", PopupCommendPlayer.ReceivedCommendationFromServer );
} )();
