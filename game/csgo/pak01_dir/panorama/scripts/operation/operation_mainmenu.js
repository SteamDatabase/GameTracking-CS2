'use strict';

var OperationMainMenu = ( function()
{

	var _m_nSeasonIndex = null;
	var _m_InventoryUpdatedHandler = null;
	var _m_cp = $.GetContextPanel();
	var _m_DeepStatsEvtHandle = null;

	var _m_oLastMatch = null;

	                        
	                        
	                        
	var _Init = function()
	{
		_RegisterForInventoryUpdate();
		_OnInventoryUpdated();
	};

	var _RegisterForInventoryUpdate = function()
	{
		if ( !_m_InventoryUpdatedHandler )
		{
			_m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent(
				'PanoramaComponent_MyPersona_InventoryUpdated', _OnInventoryUpdated );
		}

		_m_cp.RegisterForReadyEvents( true );

		$.RegisterEventHandler( 'ReadyForDisplay', _m_cp, function()
		{
			if ( !_m_InventoryUpdatedHandler )
			{
				_m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent(
					'PanoramaComponent_MyPersona_InventoryUpdated', _OnInventoryUpdated );
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
	
	var _OnInventoryUpdated = function()
	{
		if ( !MyPersonaAPI.IsInventoryValid() )
		{
			                                                      
			return;
		}

		if ( !_m_nSeasonIndex )
		{
			_m_nSeasonIndex = GameTypesAPI.GetActiveSeasionIndexValue();
			                                                                                              
		}

		_CheckUsersOperationStatus();
	};
	
	var _CheckUsersOperationStatus = function()
	{
		OperationUtil.ValidateOperationInfo( _m_nSeasonIndex );
		var oStatus = OperationUtil.GetOperationInfo();

		if ( _m_nSeasonIndex === -1 ||
			!_m_nSeasonIndex ||
			oStatus.nCoinRank === -1 ||
			oStatus.nCoinRank === undefined ||
			oStatus.nCoinRank === null )
		{
			return;
		}

		_ShowUpdatePanelBasedOnStatus( oStatus );

		_m_cp.RemoveClass( 'hidden' );
		$.DispatchEvent( 'HideMainMenuNewsPanel' );
	};

	var _ShowUpdatePanelBasedOnStatus = function( oStatus )
	{	
		_ShowUpSell();

		if ( !oStatus.bPremiumUser )
		{
			                                               
			if ( oStatus.nActiveCardIndex > -1 )
			{
				_ShowOperationPanel( oStatus );
				_HideUpSell();
				return;
			}
			
			                                            
			_ShowUpSell();
		}
		else
		{
			_ShowOperationPanel( oStatus );
			_HideUpSell();
		}
	};

	var _ShowUpSell = function()
	{
		var onMissionSelect = function()
		{
			var LocalPlayerHasPrime = PartyListAPI.GetFriendPrimeEligible( MyPersonaAPI.GetXuid() );
			if ( !LocalPlayerHasPrime )
			{
				UiToolkitAPI.ShowGenericPopupTwoOptions(
					'#op_select_mission_card',
					'#op_play_mission_popup_desc_noprime',
					'',
					'#op_stars_shop_open',
					function() { OperationUtil.OpenPopupCustomLayoutOperationStore(); },
					'#Cancel',
					function() { }
				);
				return;
			}

			UiToolkitAPI.ShowGenericPopupTwoOptions(
				'#op_select_mission_card',
				'#op_play_mission_popup_desc',
				'',
				'#op_select_mission_card',
				function() { _OnMissionSelectPopupBtnPress() },
				'#Cancel',
				function() { }
			);
		};
		
		var elUpsell = $.GetContextPanel().FindChildInLayoutFile( 'id-op-mainmenu-upsell' );
		elUpsell.AddClass( 'show' );

		var btnPremium = elUpsell.FindChildInLayoutFile( 'id-op-mainmenu-upsell-store' );
		btnPremium.SetPanelEvent( 'onactivate',
			OperationUtil.OpenUpSell.bind( undefined )
		);

		var sUserOwnedOperationPassItemID = InventoryAPI.GetActiveSeasonPassItemId();
		var sFauxPassItemID = OperationUtil.GetPassFauxId();
		
		btnPremium.text = sUserOwnedOperationPassItemID ? '#SFUI_ConfirmBtn_ActivatePassNow' : '#op_get_premium';
		
		elUpsell.FindChildInLayoutFile( 'id-op-mainmenu-upsell-store-image' ).itemid = sFauxPassItemID;

		var elMissions = $.GetContextPanel().FindChildInLayoutFile( 'id-op-mainmenu-mission_select' );
		elMissions.SetPanelEvent( 'onactivate', onMissionSelect );

		  
		                               
		  
		var elPassSaleDiscount = elUpsell.FindChildInLayoutFile( 'id-op-mainmenu-upsell-store-passsalediscount' );
		elPassSaleDiscount.visible = sUserOwnedOperationPassItemID ? false : true;
		var sPctReduction = StoreAPI.GetStoreItemPercentReduction( sFauxPassItemID );
		if ( sPctReduction && sPctReduction !== '-0%' )
			elPassSaleDiscount.text = sPctReduction;
		else
			elPassSaleDiscount.visible = false;
	};

	var _HideUpSell = function()
	{
		var elUpsell = $.GetContextPanel().FindChildInLayoutFile( 'id-op-mainmenu-upsell' );
		elUpsell.RemoveClass( 'show' );
	};

	var _ShowOperationPanel = function( oStatus )
	{
		                                                                       
		                             
		_UpdateMissionsPanel( oStatus );
	};

	var _ShouldShowStorePanel = function()
	{
		return _m_nSeasonIndex !== null && _m_nSeasonIndex >= 9;
	};

	var _OnMissionSelectPopupBtnPress = function()
	{
		                                           
		                                                                                      
		                                                    
		
		                  
		var jsoCardDetails = MissionsAPI.GetSeasonalOperationMissionCardDetails( _m_nSeasonIndex, 0 );
		var missionCardId = jsoCardDetails.id;

		                             
		var missionId = jsoCardDetails.quests[ 0 ];
		var MissionItemID = InventoryAPI.GetQuestItemIDFromQuestID( Number( missionId ) );

		UiToolkitAPI.ShowCustomLayoutPopupParameters(
			'',
			'file://{resources}/layout/popups/popup_activate_mission.xml',
			'message=' + $.Localize( '#op_mission_activate' ) +
			'&' + 'requestedMissonCardId=' + missionCardId +
			'&' + 'seasonAccess=' + _m_nSeasonIndex +
			'&' + 'questItemID=' + MissionItemID +
			'&' + 'spinner=1' +
			'&' + 'activateonly=true'
		);
	};

	var _ShowMainMenu = function()
	{
		var moviePanel = _m_cp.FindChildInLayoutFile( 'id-op-mainmenu-upsell-movie' );
		moviePanel.SetMovie( "file://{resources}/videos/riptide_logo_loop.webm" );

		_CheckUsersOperationStatus();
	};

	var _HideMainMenu = function()
	{
		if ( OperationMissionCard )
		{
			OperationMissionCard.CancelUnlockTimer();
		}

		var moviePanel = _m_cp.FindChildInLayoutFile( 'id-op-mainmenu-upsell-movie' );
		moviePanel.SetMovie( "" );
	};

	                    
	                    
	                    
	var _UpdateMissionsPanel = function( oStatus )
	{
		                                                      
		                                                              
		                                  
		
		_m_cp.FindChildInLayoutFile( 'id-op-mainmenu-missions' ).RemoveClass( 'hide' );
		_m_cp.SetDialogVariableInt( 'total_missions', oStatus.nMissionsCompleted );

		_UpdateXpDisplay( oStatus );

		var cardIndex = oStatus.nActiveCardIndex ? oStatus.nActiveCardIndex : 0;
		_UpdateSelectedMissionCard( cardIndex );
		_SetUpCardUnlockDisplay( oStatus );
	};

	var _UpdateSelectedMissionCard = function( cardIndex )
	{
		var jsoCardDetails = MissionsAPI.GetSeasonalOperationMissionCardDetails( _m_nSeasonIndex, Number( cardIndex ));
		var elLabel = $.GetContextPanel().FindChildInLayoutFile( 'id-missions-selected-card-name' );

		var nWeek = cardIndex + 1;
		elLabel.text = $.Localize( "#op_mainmenu_mission_week_prefix") + " " + nWeek + ": " + $.Localize( jsoCardDetails.name );

		_UpdateMissionCard( cardIndex );
	};

	var jsContextMenuMissionCardCallbackHandle;
	var _OpenMissionCardSelectContextMenu = function()
	{
		var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParameters( 
		'id-missions-selected-card-btn',
		'', 
		'file://{resources}/layout/context_menus/context_menu_select_mission_card.xml', 
		'test=123456&callback=' +
		jsContextMenuMissionCardCallbackHandle );

		contextMenuPanel.AddClass( "ContextMenu_NoArrow" );
	}

	jsContextMenuMissionCardCallbackHandle = UiToolkitAPI.RegisterJSCallback( _UpdateSelectedMissionCard );

	var _UpdateMissionCard = function( idx )
	{
		var elMissionCard = $.GetContextPanel().FindChildInLayoutFile( 'id-missions-mission-card' );

		OperationMissionCard.UpdateMissionCard(
			parseInt(idx),
			elMissionCard
		);
	}

	var _UpdateXpDisplay = function( oStatus )
	{
		                                                        
		                                                                                  
		                                               
		                                                       

		var elXpLabel = _m_cp.FindChildInLayoutFile( 'id-mission-card-xp-progress' );
		                                                        
		elXpLabel.text = "";                                                                      

		if ( !oStatus.bPremiumUser )
		{
			return;
		}
	
		var numPreviousMissionsCompletedForReward = 0;
		var numNextMissionsCompletedNeededForReward = null;
		var allThresholds = oStatus.nMissionsRewardThresholds.split( ',' );
		for ( var j = 0; j < allThresholds.length; ++j )
		{
			var numericThreshold = parseInt( allThresholds[ j ] );
			if ( oStatus.nMissionsCompleted < numericThreshold )
			{
				numNextMissionsCompletedNeededForReward = numericThreshold;
				break;                  
			} else
			{
				numPreviousMissionsCompletedForReward = numericThreshold;
				                    
			}
		}
		if ( numNextMissionsCompletedNeededForReward )
		{
			_m_cp.SetDialogVariableInt( 'xp_missions_completed', oStatus.nMissionsCompleted - numPreviousMissionsCompletedForReward );
			_m_cp.SetDialogVariableInt( 'xp_missions_needed', numNextMissionsCompletedNeededForReward - numPreviousMissionsCompletedForReward );
			elXpLabel.text = $.Localize( '#op_mission_card_xp_reward', _m_cp );
		}
	};

	var _SetUpCardUnlockDisplay = function( oStatus )
	{
		var elPanel = _m_cp.FindChildInLayoutFile( 'id-op-mainmenu-mission-unlock' );
		var numMissionBacklog = InventoryAPI.GetMissionBacklog();
		var bShouldShow = oStatus.nActiveCardIndex < numMissionBacklog - 1;

		elPanel.SetHasClass( 'hide', !bShouldShow );
		
		if ( !bShouldShow )
		{
			return;
		}
		
		elPanel.SetDialogVariableInt( 'unlocked_week', numMissionBacklog );
		elPanel.SetPanelEvent( 'onactivate', function()
		{
			_UpdateSelectedMissionCard( numMissionBacklog - 1 );
		});
	};

	var _OpenOperationHub = function( rewardIndexToOpenTo = -1 )
	{
		OperationUtil.OpenPopupCustomLayoutOperationHub( rewardIndexToOpenTo );
	};

	var _OpenOperationStore = function( )
	{
		OperationUtil.OpenPopupCustomLayoutOperationStore( );
	};

	                    
	                   
	                    
	                                                                              

	function _OnStatsReceived ()
	{
		var oMatch = DeepStatsAPI.GetLastCachedMatchJS();

		if ( !oMatch )
			return;

		var oStatus = OperationUtil.GetOperationInfo();
		
		if ( _m_oLastMatch !== null && _m_oLastMatch.matches[ 0 ].player.match_id != oMatch.matches[ 0 ].player.match_id )
		{
			_ShowStatsPanel( oStatus );
		}
	}

	var _ShowStatsPanel = function ( oStatus )
	{
		var elStatPanel = _m_cp.FindChildInLayoutFile( 'id-op-mainmenu-stats' );
		var elBtn = _m_cp.FindChildInLayoutFile( 'id-op-mainmenu-open-stats-btn' );
		
		if( !_ShouldShowStorePanel() )
		{
			elStatPanel.SetHasClass( 'hide', true );
			return;
		}

		elStatPanel.SetHasClass( 'hide', false );

		if( !oStatus.bPremiumUser )
		{
			_m_cp.FindChildInLayoutFile( 'id-op-mainmenu-stats-section' ).SetHasClass( 'hide', true );
			_m_cp.FindChildInLayoutFile( 'id-op-mainmenu-stats-upsell' ).SetHasClass( 'hide', false );
			_m_cp.FindChildInLayoutFile( 'id-op-mainmenu-stats-store-image' ).itemid = OperationUtil.GetPassFauxId();

			elBtn.text = $.Localize(
				InventoryAPI.GetActiveSeasonPassItemId() ? 
				'#SFUI_ConfirmBtn_ActivatePassNow' : 
				'#op_get_premium'
				).toUpperCase();

			elBtn.SetPanelEvent( 'onactivate', function()
			{
				OperationUtil.OpenUpSell();
			} );

			_m_cp.FindChildInLayoutFile( 'id-op-mainmenu-stats' ).SetPanelEvent( 'onactivate', function()
			{
				OperationUtil.OpenUpSell();
			} );

			return;
		}
		else
		{
			_m_cp.FindChildInLayoutFile( 'id-op-mainmenu-stats-upsell' ).SetHasClass( 'hide', true );
			_m_cp.FindChildInLayoutFile( 'id-op-mainmenu-stats-section' ).SetHasClass( 'hide', false );

			elBtn.text = $.Localize( '#op_mainmenu_stats_btn_text' );
			elBtn.SetPanelEvent( 
				'onactivate', 
				function(){
					$.DispatchEvent( 'OpenStatsMenu' );
			});

			_m_cp.FindChildInLayoutFile( 'id-op-mainmenu-stats' ).SetPanelEvent( 
				'onactivate', 
				function(){
					$.DispatchEvent( 'OpenStatsMenu' );
			});
		}

		_m_oLastMatch = DeepStatsAPI.GetLastCachedMatchJS();

		var bHasMatchData = _m_oLastMatch != null && _m_oLastMatch.matches.length > 0;
		elStatPanel.SetHasClass( 'no-match-data', !bHasMatchData );

		if( !bHasMatchData )
			return;
		
		                   
		                                      
		var oMatch = _m_oLastMatch.matches[ 0 ].player;

		var elResult = _m_cp.FindChildTraverse( 'id-op-mainmenu-stats-match-result' ); 
		
		elResult.SetHasClass( 'op-mainmenu__stats__match__win-loss--green',( oMatch.match_outcome & 0x3 ) == 1 );
		elResult.SetHasClass( 'op-mainmenu__stats__match__win-loss--red',( oMatch.match_outcome & 0x3 ) == 2 );
		elResult.SetHasClass( 'op-mainmenu__stats__match__win-loss--yellow',( oMatch.match_outcome & 0x3 ) == 0 );

		elResult.SetHasClass( 'op-mainmenu__stats__match__win-loss--dnf', ( oMatch.match_outcome & 0x4 ) );
		
		                
		_MapInfo( DeepStatsAPI.MapIDToString( oMatch.mapid ) );

		var mode = DeepStatsAPI.GetMatchTypeString( oMatch.mm_game_mode );
		var strMode = '';

		switch ( mode )
		{
			case "Competitive":
				strMode = '#SFUI_GameModeCompetitive';
				break;
			
			case "Wingman":
				strMode = '#SFUI_GameModeScrimComp2v2';
				break;
			
			case "CompetitiveCaptains":
				strMode = '#SFUI_GameModeCompetitiveTeams';
				break;
			
			case "CompetitiveScrimmage":
				strMode = '#playerstats_mode_comp_scrim';
				break;				
			
			default:
				strMode = '';
		}
		
		var timestamp = DeepStatsAPI.MatchIDToLocalTime( oMatch.match_id );
		var strTime = DeepStatsAPI.GetRelativeTimeStringForTimestamp( timestamp );

		_MatchTimeAndMode( strTime, $.Localize( strMode ) );
		_UpdateTeammates( oMatch.mates );
		_UpdateStats( oMatch, mode );

		        
		elStatPanel.SetDialogVariable( 'myscore', String( oMatch.rounds_won) );
		elStatPanel.SetDialogVariable( 'enemyscore', String( oMatch.rounds_lost) );
	};

	function _UpdateStats ( oMatch, mode )
	{
		var elStatsContainer = _m_cp.FindChildTraverse( 'id-op-mainmenu-stats-match-stats' );

		elStatsContainer.SetDialogVariable( 'kills', MatchStats.GetTotalKills( oMatch ) );
		elStatsContainer.SetDialogVariable( 'kdr', MatchStats.GetKillsPerDeath( oMatch ) );
		elStatsContainer.SetDialogVariable( 'adr', MatchStats.GetDamagePerRound( oMatch ) );
		elStatsContainer.SetDialogVariable( 'dmg', MatchStats.GetTotalDamage( oMatch ) );
		
		elStatsContainer.SetDialogVariable( 'hsp',  MatchStats.GetHeadShotKillRate( oMatch ) + '%'  );
		elStatsContainer.SetDialogVariable( 'mk', MatchStats.GetTotalMultiKills( oMatch )  );
	}

	var _MapInfo = function( mapName )
	{
		var elMapIcon = _m_cp.FindChildInLayoutFile( "id-op-mainmenu-stats-match-map-icon" );
		elMapIcon.SetImage ( "file://{images}/map_icons/map_icon_" + mapName + ".svg" );
		_m_cp.FindChildInLayoutFile( "id-op-mainmenu-stats-match-map-name" ).text = $.Localize( '#SFUI_Map_' + mapName );

		var elBackground = _m_cp.FindChildInLayoutFile( "id-op-mainmenu-stats-background" );
		elBackground.style.backgroundImage = 'url("file://{images}/map_icons/screenshots/360p/' + mapName + '.png")';
		elBackground.style.backgroundPosition = '50% 50%';
		elBackground.style.backgroundSize = "clip_then_cover";
		elBackground.style.brightness = "0.25";
		elBackground.style.backgroundImgOpacity = ".8";
		elBackground.style.blur = "gaussian( 3, 3, 2)";

	};

	var _MatchTimeAndMode = function( time, mode )
	{
		var elMapTime = _m_cp.FindChildInLayoutFile( "id-op-mainmenu-stats-match-map-time" );

		elMapTime.SetDialogVariable( 'time',  time );
		elMapTime.SetDialogVariable( 'mode', mode );
	};

	var _UpdateTeammates = function( arrMates )
	{
		var elMates = _m_cp.FindChildInLayoutFile( "id-op-mainmenu-stats-match-teammates" );
		elMates.RemoveAndDeleteChildren();

		arrMates.forEach( function( accountId, index )
		{
			var xuid = DeepStatsAPI.GetXUIDByAccountID( accountId );
			var elAvatar = $.CreatePanel( 'CSGOAvatarImage', elMates, index );
			elAvatar.PopulateFromSteamID(xuid);
			elAvatar.AddClass( 'avatar-image__icon' );
			
			elAvatar.SetPanelEvent( 'onactivate', function( xuid )
			{
				var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent(
					'',
					'',
					'file://{resources}/layout/context_menus/context_menu_playercard.xml',
					'xuid=' + xuid,
					function() {}
				)
				contextMenuPanel.AddClass( "ContextMenu_NoArrow" );

			}.bind( this, xuid ) );
		} );
	};

	return {
		Init: _Init,
		OnInventoryUpdated: _OnInventoryUpdated, 
		CheckUsersOperationStatus: _CheckUsersOperationStatus,
		OpenOperationHub: _OpenOperationHub,
		OpenOperationStore: _OpenOperationStore,
		ShowMainMenu: _ShowMainMenu,
		HideMainMenu: _HideMainMenu,
		OnStatsReceived: _OnStatsReceived,
		OpenMissionCardSelectContextMenu: _OpenMissionCardSelectContextMenu,
		UpdateSelectedMissionCard: _UpdateSelectedMissionCard
	};
} )();



                             
( function()
{
	$.RegisterForUnhandledEvent( 'CSGOShowMainMenu', OperationMainMenu.ShowMainMenu );
	$.RegisterForUnhandledEvent( 'CSGOHideMainMenu', OperationMainMenu.HideMainMenu );

	OperationMainMenu.Init();
} )();

