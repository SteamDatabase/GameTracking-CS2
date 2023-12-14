"use strict";

var MainMenuTournamentPassStatus = ( function()
{
	var _m_schTimer = null;

	var _m_bRegisteredForAllEvents = false;
	var _m_InventoryUpdatedHandler = null;
	var _m_cp = $.GetContextPanel();
	var _Init = function()
	{
		_RegisterForInventoryUpdate();

		if ( !MyPersonaAPI.IsConnectedToGC() )
		{
			return;
		}
		
		                                                     
		_UpdatePanel();
	};

	var _RegisterForInventoryUpdate = function()
	{
		if ( _m_bRegisteredForAllEvents )
			return;

		_m_bRegisteredForAllEvents = true;

		_m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', _Init );

		_m_cp.RegisterForReadyEvents( true );

		$.RegisterEventHandler( 'ReadyForDisplay', _m_cp, function()
		{
			if ( !_m_InventoryUpdatedHandler )
			{
				_m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', _Init );
			}
		} );

		$.RegisterEventHandler( 'UnreadyForDisplay', _m_cp, function()
		{
			if ( _m_InventoryUpdatedHandler )
			{
				$.UnregisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', _m_InventoryUpdatedHandler );
				_m_InventoryUpdatedHandler = null;
			}
		} );
	};
	
	var _UpdatePanel = function()
	{
		var elCountdownLabel = $.GetContextPanel().FindChildInLayoutFile( 'id-tournament-pass-status-game-countdown' );

		                                                                                                
		var id = InventoryAPI.GetActiveTournamentCoinItemId( g_ActiveTournamentInfo.eventid );

		if( !id || id === '0' )
		{
			                                                              
			elCountdownLabel.SetHasClass( 'hidden', true );
		}
		else
		{
			                  
			elCountdownLabel.SetHasClass( 'hidden', false );
			EnableCountdownTimer( elCountdownLabel, "#pickem_timer" );
		}

		$.GetContextPanel().FindChildInLayoutFile( 'id-tournament-pass-status' ).SetPanelEvent(
			'onactivate', _ShowTournamentJournalPanel.bind( undefined, id ) );
		
		_AddItemImages();
		_ItemsOnSale();
			
		$.GetContextPanel().style.backgroundImage = 'url("file://{images}/store/tournament_items_' + g_ActiveTournamentInfo.eventid + '.png")';
		$.GetContextPanel().style.backgroundRepeat = 'no-repeat';
		$.GetContextPanel().style.backgroundSize = 'cover' ;
		$.GetContextPanel().style.backgroundPosition = '50% 50%';
	};


	var _AddItemImages = function()
	{
		var aImages = $.GetContextPanel().FindChildInLayoutFile( 'id-tournament-pass-status-images-row' ).Children();
		aImages[ 0 ].itemid = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( g_ActiveTournamentStoreLayout[ 0 ][ 1 ], 0 );
		aImages[ 1 ].itemid = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( g_ActiveTournamentStoreLayout[ 1 ][ 0 ], 0 );
		aImages[ 2 ].itemid = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( g_ActiveTournamentStoreLayout[ 2 ][ 0 ], 0 );
	};

	var EnableCountdownTimer = function( elDescLabel, displayString )
	{
		var elPanel = $.GetContextPanel().FindChildInLayoutFile( 'id-tournament-pass-status' );

		elDescLabel.text = displayString;
		if ( !_m_schTimer )
		{
			_m_schTimer = $.Schedule( 0.1, _Timer.bind( undefined, elPanel ) );
		}
	};

	var _ItemsOnSale = function()
	{
		var elPrecent = $.GetContextPanel().FindChildInLayoutFile( 'id-tournament-pass-saletag' );
		elPrecent.SetHasClass( 'hidden', true );

			                 
			var reduction = ItemInfo.GetStoreSalePercentReduction( g_ActiveTournamentInfo.itemid_pass, 1 );
			elPrecent.SetHasClass( 'hidden', ( reduction === '' || reduction === undefined ) ? true : false );
	}

	var _ShowInpsectPopup = function( id )
	{
		                                                                         
		$.DispatchEvent( 'ShowTournamentStore' );
		$.DispatchEvent( 'ShowTournamentStorePassPopup' );

		                                                                                   
		                                                
		   	   
		   	                                                               
		   	              
		   	       
		   	                   
		   	       
		   	                         
		   	       
		   	                    
		   	      
		     
	};

	var _ShowTournamentJournalPanel = function ( id )
	{
		UiToolkitAPI.ShowCustomLayoutPopupParameters(
			'',
			'file://{resources}/layout/popups/popup_tournament_journal.xml',
			'journalid=' + id
		);
	};

	var _ActivatePass = function ( id )
	{
		UiToolkitAPI.ShowCustomLayoutPopupParameters(
			'',
			'file://{resources}/layout/popups/popup_capability_decodable.xml',
			'key-and-case=,' + id +
			'&' + 'asyncworktype=decodeable'
		);
	};

	var _Timer = function( elPanelParam )
	{
		_m_schTimer = null;

		                                    
		if ( !elPanelParam || !elPanelParam.IsValid() )
			return;

		var elCountdown = elPanelParam.FindChildInLayoutFile( 'id-tournament-pass-status-game-countdown' );
		var secRemaining = PredictionsAPI.GetGroupRemainingPredictionSeconds( "global" );
		if ( !secRemaining )
		{
			_ShowStatus( elPanelParam );
			return;
		}

		elCountdown.SetDialogVariable( 'time', FormatText.SecondsToSignificantTimeString( secRemaining ) );
		elCountdown.SetHasClass( 'hidden', ( secRemaining > 0 ) ? false : true );
		_m_schTimer = $.Schedule( 30, _Timer.bind( null, elPanelParam ) );
	};

	var _ShowStatus = function( elPanel )
	{
		var id = InventoryAPI.GetActiveTournamentCoinItemId( g_ActiveTournamentInfo.eventid );
		var nCampaignID = parseInt( InventoryAPI.GetItemAttributeValue( id, "campaign id" ) );
		var numTotalChallenges = InventoryAPI.GetCampaignNodeCount( nCampaignID );

		var completedChallengesList = [];
		for ( var jj = 0; jj < numTotalChallenges; ++jj )
		{
			var nMissionNodeID = InventoryAPI.GetCampaignNodeIDbyIndex( nCampaignID, jj );
			var strNodeState = InventoryAPI.GetCampaignNodeState( nCampaignID, nMissionNodeID, id );

			if ( strNodeState === "complete" )
			{
				completedChallengesList.push(nMissionNodeID);
			}
		}

		var completedChallenges = completedChallengesList.length;
		var elLabel = elPanel.FindChildInLayoutFile( 'id-tournament-pass-status-game-countdown' );

		elLabel.SetHasClass( 'hidden', ( !completedChallenges || completedChallenges < 1 ) );
		
		if ( !completedChallenges || completedChallenges < 1 )
		{
			return;
		}
	
		elLabel.SetDialogVariableInt( 'challenges', completedChallenges );
		elLabel.text = $.Localize( '#tournament_coin_completed_challenges_int', elLabel );
	};

	var _PurchaseComplete = function( id )
	{
		if ( ItemInfo.ItemDefinitionNameSubstrMatch(id, 'tournament_pass_') )
		{
			_Init();
		}
	};

	return{
		Init: _Init,
		PurchaseComplete: _PurchaseComplete
	};

})();

(function ()
{
	MainMenuTournamentPassStatus.Init();
	$.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_UpdateConnectionToGC', MainMenuTournamentPassStatus.Init );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_Store_PurchaseCompleted', MainMenuTournamentPassStatus.PurchaseComplete );
})();
