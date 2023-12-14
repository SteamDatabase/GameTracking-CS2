'use strict';

var LastMatch = ( function()
{
	var _m_cp = $.GetContextPanel();
    var _m_InventoryUpdatedHandler = null;
    var _m_DeepStatsEvtHandle = null;
	var _m_oLastMatch = null;

    var _Init = function()
	{
		_RegisterForInventoryUpdate();

		_m_cp.FindChildInLayoutFile( 'id-mainmenu-lastmatch' ).SetPanelEvent( 
			'onactivate', 
			function(){
				$.DispatchEvent( 'OpenStatsMenu' );
		});

		_OnStatsReceived();
	};

	var _RegisterForInventoryUpdate = function()
	{
		if ( !_m_InventoryUpdatedHandler )
		{
			_m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent(
				'PanoramaComponent_MyPersona_InventoryUpdated', LastMatch.OnStatsReceived );
		}

		if ( _m_DeepStatsEvtHandle === null ) 
		{
			_m_DeepStatsEvtHandle = $.RegisterForUnhandledEvent( 'DeepStatsReceived', LastMatch.OnStatsReceived );
		}

		_m_cp.RegisterForReadyEvents( true );
		_m_cp.SetReadyForDisplay( false );

		$.RegisterEventHandler( 'ReadyForDisplay', _m_cp, function()
		{
			if ( !_m_InventoryUpdatedHandler )
			{
				_m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent(
					'PanoramaComponent_MyPersona_InventoryUpdated', LastMatch.OnStatsReceived );
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

	var _HasSubscription = function()
	{
		var rtRecurringSubscriptionNextBillingCycle = InventoryAPI.GetCacheTypeElementFieldByIndex( 'RecurringSubscription', 0, 'time_next_cycle' );
		if ( rtRecurringSubscriptionNextBillingCycle )
		{
			var numSecondsTillNextBillingCycle = NewsAPI.GetNumSecondsTillGcTimestamp( rtRecurringSubscriptionNextBillingCycle );
			if ( numSecondsTillNextBillingCycle >= 60 )
			{
				return true;
			}
			
		}
		return false;
	}


	var _OnStatsReceived = function()
	{
		var oMatch = DeepStatsAPI.GetLastCachedMatchJS();

		if( !oMatch )
		{
			$.GetContextPanel().SetHasClass( 'hidden' , true );
			return;
		}
		
		if ( oMatch.matches.length > 0 &&
			_HasSubscription())
		{

				$.GetContextPanel().SetHasClass( 'hidden' , false );
				_UpdateStatsPanel( oMatch );
		}
		else
		{
			$.GetContextPanel().SetHasClass( 'hidden' , true );
		}
	}

	var _UpdateStatsPanel = function ( oMatchFromDeepStats )
	{
		                  
		if( _m_oLastMatch && ( _m_oLastMatch.matches[ 0 ].player.match_id === oMatchFromDeepStats.matches[ 0 ].player.match_id ))
		{
			return;
		}

		_m_oLastMatch = oMatchFromDeepStats;

		var oMatch = _m_oLastMatch.matches[ 0 ].player;
		var elResult = _m_cp.FindChildTraverse( 'id-mainmenu-lastmatch-match-result' ); 
		
		elResult.SetHasClass( 'mainmenu__lastmatch__match__win-loss--green',( oMatch.match_outcome & 0x3 ) == 1 );
		elResult.SetHasClass( 'mainmenu__lastmatch__match__win-loss--red',( oMatch.match_outcome & 0x3 ) == 2 );
		elResult.SetHasClass( 'mainmenu__lastmatch__match__win-loss--yellow',( oMatch.match_outcome & 0x3 ) == 0 );
		elResult.SetHasClass( 'mainmenu__lastmatch__match__win-loss--dnf', ( oMatch.match_outcome & 0x4 ) );
		
		                
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

		        
		var elStatPanel = _m_cp.FindChildInLayoutFile( 'id-mainmenu-lastmatch' );
		elStatPanel.SetDialogVariable( 'myscore', String( oMatch.rounds_won) );
		elStatPanel.SetDialogVariable( 'enemyscore', String( oMatch.rounds_lost) );
	};

	function _UpdateStats ( oMatch, mode )
	{
		var elStatsContainer = _m_cp.FindChildTraverse( 'id-mainmenu-lastmatch-match-stats' );

		elStatsContainer.SetDialogVariable( 'kills', MatchStats.GetTotalKills( oMatch ) );
		elStatsContainer.SetDialogVariable( 'kdr', MatchStats.GetKillsPerDeath( oMatch ) );
		elStatsContainer.SetDialogVariable( 'adr', MatchStats.GetDamagePerRound( oMatch ) );
		elStatsContainer.SetDialogVariable( 'dmg', MatchStats.GetTotalDamage( oMatch ) );
		
		elStatsContainer.SetDialogVariable( 'hsp',  MatchStats.GetHeadShotKillRate( oMatch ) + '%'  );
		elStatsContainer.SetDialogVariable( 'mk', MatchStats.GetTotalMultiKills( oMatch )  );
	}

	var _MapInfo = function( mapName )
	{
		var elMapIcon = _m_cp.FindChildInLayoutFile( "id-mainmenu-lastmatch-match-map-icon" );
		elMapIcon.SetImage ( "file://{images}/map_icons/map_icon_" + mapName + ".svg" );
		_m_cp.FindChildInLayoutFile( "id-mainmenu-lastmatch-match-map-name" ).text = $.Localize( '#SFUI_Map_' + mapName );

		var elBackground = _m_cp.FindChildInLayoutFile( "id-mainmenu-lastmatch-background" );
		elBackground.style.backgroundImage = 'url("file://{images}/map_icons/screenshots/360p/' + mapName + '.png")';
		elBackground.style.backgroundPosition = '50% 50%';
		elBackground.style.backgroundSize = "cover";
		elBackground.style.brightness = "0.25";
		elBackground.style.backgroundImgOpacity = ".8";
		elBackground.style.blur = "gaussian( 3, 3, 2)";
	};

	var _MatchTimeAndMode = function( time, mode )
	{
		var elMapTime = _m_cp.FindChildInLayoutFile( "id-mainmenu-lastmatch-match-map-time" );

		elMapTime.SetDialogVariable( 'time',  time );
		elMapTime.SetDialogVariable( 'mode', mode );
	};

	var _UpdateTeammates = function( arrMates )
	{
		var elMates = _m_cp.FindChildInLayoutFile( "id-mainmenu-lastmatch-match-teammates" );
		elMates.RemoveAndDeleteChildren();

		arrMates.forEach( function( accountId, index )
		{
			var xuid = DeepStatsAPI.GetXUIDByAccountID( accountId );
			var elAvatar = $.CreatePanel( 'CSGOAvatarImage', elMates, index );
			elAvatar.PopulateFromSteamID( xuid );
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
        OnStatsReceived: _OnStatsReceived
	};

} )();

                             
( function()
{
	LastMatch.Init();
} )();