'use strict';

var TeamSelectMenu = ( function ()
{
	var m_nHighlightedTeamNum = 0;
	var m_errorTimerHandle = false;
	var m_playerCounts = [ 0, 0 ];
	var m_botCounts = [ 0, 0 ];
	                                                
	var _m_UiSceneFrameBoundaryEventHandler = null;
	var m_scheduledHideWash = null;

	function _Init()
	{
		var elBtnTeamT = $( "#BtnSelectTeam-TERRORIST" );
		elBtnTeamT.SetPanelEvent( "onmouseover", _HighlightTTeam );
		elBtnTeamT.SetPanelEvent( "onmouseout", _UnhighlightTTeam );
		elBtnTeamT.SetPanelEvent( "onactivate", _SelectTeam.bind( undefined, 2 ) );

		var elBtnTeamCT = $( "#BtnSelectTeam-CT" );
		elBtnTeamCT.SetPanelEvent( "onmouseover", _HighlightCTTeam );
		elBtnTeamCT.SetPanelEvent( "onmouseout", _UnhighlightCTTeam );
		elBtnTeamCT.SetPanelEvent( "onactivate", _SelectTeam.bind( undefined, 3 ) );

		var elBtnSpectate = $( "#TeamSelectSpectate" );
		elBtnSpectate.SetPanelEvent( "onactivate", _SelectTeam.bind( undefined, 1 ) );

		var elBtnAuto = $( "#TeamSelectAuto" );
		elBtnAuto.SetPanelEvent( "onactivate", _SelectTeam.bind( undefined, 0 ) );

		_UnhighlightTTeam();
		_UnhighlightCTTeam();
	}

	function _ShowPanelTest( mockdata )
	{
		MockAdapter.SetMockData( mockdata );

		_ShowPanel();
	}

	function _ShowPanel()
	{
		if ( GameStateAPI.IsDemoOrHltv() )
			return;

		if ( m_scheduledHideWash != null )
		{
			$.CancelScheduled( m_scheduledHideWash );
			m_scheduledHideWash = null;
		}

		const elFade = $( "#TeamSelectFade" );
		elFade.style.transitionDuration = "0.0s";
		elFade.RemoveClass( "hidden" );

		m_scheduledHideWash = $.Schedule( 0.5, () =>
		{
			if ( elFade.IsValid() )
			{
				elFade.style.transitionDuration = "0.5s";
				elFade.AddClass( "hidden" );
			}
			
			m_scheduledHideWash = null;
		} );

		var elBackgroundImage = $.GetContextPanel().FindChildInLayoutFile( 'BackgroundMapImage' );
		var mapName = MockAdapter.GetMapBSPName();

		elBackgroundImage.SetImage( 'file://{images}/map_icons/screenshots/1080p/' + mapName +'.png' );

		_OnServerForcingTeamJoin( 0 );

		m_nHighlightedTeamNum = 0;

		$( "#TeamJoinError" ).AddClass( "hidden" );
		if ( m_errorTimerHandle !== false )
		{
			$.CancelScheduled( m_errorTimerHandle );
			m_errorTimerHandle = false;
		}
	}

	function _OnReadyForDisplay()
	{
		if ( !_m_UiSceneFrameBoundaryEventHandler )
		{
			_m_UiSceneFrameBoundaryEventHandler = $.RegisterForUnhandledEvent( "UISceneFrameBoundary", _OnUISceneFrameBoundary );
		}
	};

	function _OnUnreadyForDisplay()
	{
		if ( _m_UiSceneFrameBoundaryEventHandler )
		{
			$.UnregisterForUnhandledEvent( "UISceneFrameBoundary", _m_UiSceneFrameBoundaryEventHandler );
			_m_UiSceneFrameBoundaryEventHandler = null;
		}
	};

	function _OnUISceneFrameBoundary()
	{
		var bInFallbackMode = $.GetContextPanel().IsInFallbackMode();
		$( "#TeamSelectMenu" ).FindChildrenWithClassTraverse( "team-select-fallback" ).forEach( el =>
		{
			if ( bInFallbackMode )
				el.RemoveClass( "team-select-fallback-hidden" );
			else
				el.AddClass( "team-select-fallback-hidden" );
		} );
	}

	var _UpdateBotPlayerCount = function ( countBots, countPlayers, team )
	{
		var elLabel = $( "#BtnSelectTeam-" + team ).FindChildInLayoutFile( "PlayerBotCount" );

		if ( countBots === 1 )
			elLabel.SetDialogVariable( "botlabel", $.Localize( "#team_select_bot" ) );
		else
			elLabel.SetDialogVariable( "botlabel", $.Localize( "#team_select_bots" ) );

		if ( countPlayers === 1 )
			elLabel.SetDialogVariable( "playerlabel", $.Localize( "#team_select_player" ) );
		else
			elLabel.SetDialogVariable( "playerlabel", $.Localize( "#team_select_players" ) );

		elLabel.SetDialogVariableInt( "bots", countBots );
		elLabel.SetDialogVariableInt( "players", countPlayers );
		elLabel.text = $.Localize( "#team_select_bot_player_count", elLabel );
	}

	var _OnServerForcingTeamJoin = function ( nTimeout )
	{
		var bUnassigned = $.GetContextPanel().GetTeamNumber() == 0;
		$( "#TeamSelectCancel" ).visible = !bUnassigned;

		if ( bUnassigned && nTimeout > 0 )
		{
			                            
			var elTimer = $( "#AutojoinTimer" );
			var elTimerBar = elTimer.FindChildInLayoutFile( "AutojoinTimerBar" );
			if ( elTimerBar )
			{
				elTimerBar.DeleteAsync( 0 );
			}

			                          
			elTimerBar = $.CreatePanel( "Panel", elTimer, "AutojoinTimerBar" );
			elTimerBar.style.animationDuration = nTimeout + "s";
			elTimerBar.AddClass( "team-select__timer__bar" );

			                  
			elTimer.endTime = Date.now() * 0.001 + nTimeout;
			elTimer.visible = true;
		}
		else
		{
			                  
			$( "#AutojoinTimer" ).visible = false;
		}
	}

	function _SelectTeam( nTeamNum )
	{
		if ( nTeamNum != 0 && nTeamNum == MockAdapter.GetPlayerTeamNumber( MyPersonaAPI.GetXuid() ) )
		{
			                                                        
			_HidePanel();
			return;
		}

		_SetTeam( nTeamNum );
	}

	function _SelectHighlightedTeam()
	{
		_SelectTeam( m_nHighlightedTeamNum );
	}

	function _HighlightTTeam()
	{
		_UnhighlightTeam( m_nHighlightedTeamNum );
		m_nHighlightedTeamNum = 2;
		$.GetContextPanel().HighlightTeam( 2, true );
	}

	function _HighlightCTTeam()
	{
		_UnhighlightTeam( m_nHighlightedTeamNum );
		m_nHighlightedTeamNum = 3;
		$.GetContextPanel().HighlightTeam( 3, true );
	}

	function _UnhighlightTTeam()
	{
		_UnhighlightTeam( 2 );
	}

	function _UnhighlightCTTeam()
	{
		_UnhighlightTeam( 3 );
	}

	function _UnhighlightTeam( nTeamNum )
	{
		if ( m_nHighlightedTeamNum == nTeamNum )
		{
			m_nHighlightedTeamNum = 0;
			$.GetContextPanel().HighlightTeam( nTeamNum, false );
		}
	}

	var _SetTeam = function ( team )
	{
		  
		                   
		           
		            
		  
		GameInterfaceAPI.ConsoleCommand( "jointeam " + team + " 1" );
	}

	var _SetTeamT = function ()
	{
		_SetTeam( 2 );
	}

	var _SetTeamCT = function ()
	{
		_SetTeam( 3 );
	}

	var _ShowError = function ( locString )
	{
		var elLabel = $( "#TeamJoinErrorLabel" );
		var elWarningPanel = $( "#TeamJoinError" );

		elLabel.text = $.Localize( locString );
		elWarningPanel.RemoveClass( "hidden" );

		m_errorTimerHandle = $.Schedule( 5.0, function ()
		{
			if ( elWarningPanel.IsValid() )
				elWarningPanel.AddClass( "hidden" );

			m_errorTimerHandle = false;
		} );
	}

	var _Escape = function ()
	{
		                                                                          
		if ( $.GetContextPanel().GetTeamNumber() == 0 )
			GameInterfaceAPI.ConsoleCommand( "gameui_activate" );
		else
			_HidePanel();
	}

	var _HidePanel = function ()
	{
		$.DispatchEvent( "CSGOShowTeamSelectMenu", false, true );
	}

	var _ClearPlayerLists = function ()
	{
		$( "#List-0" ).RemoveAndDeleteChildren();
		$( "#List-1" ).RemoveAndDeleteChildren();

		m_playerCounts[ 0 ] = 0;
		m_playerCounts[ 1 ] = 0;

		m_botCounts[ 0 ] = 0;
		m_botCounts[ 1 ] = 0;

		_UpdateBotPlayerCount( 0, 0, "TERRORIST" );
		_UpdateBotPlayerCount( 0, 0, "CT" );
	}

	var _AddToPlayerList = function ( nTeamIdx, xuid )
	{
		var elList = $( "#List-" + nTeamIdx );

		var elTeammate = $.CreatePanel( "Panel", elList, "Teammate" );
		elTeammate.BLoadLayoutSnippet( "Teammate" );

		var elAvatar = $.CreatePanel( "Panel", elTeammate, "Avatar" );
		elAvatar.BLoadLayout( "file://{resources}/layout/avatar.xml", false, false );
		elAvatar.BLoadLayoutSnippet( "AvatarParty" );
		Avatar.Init( elAvatar, xuid.toString(), "PlayerCard" );

		if ( MockAdapter.IsFakePlayer( xuid ) )
		{
			var elAvatarImage = elAvatar.FindChildInLayoutFile( "JsAvatarImage" );
			elAvatarImage.PopulateFromPlayerSlot( MockAdapter.GetPlayerSlot( xuid ) );

			m_botCounts[ nTeamIdx ]++;
		}
		else
		{
			m_playerCounts[ nTeamIdx ]++;
		}

		elTeammate.SetHasClass( 'bot', MockAdapter.IsFakePlayer( xuid ) );

		var elName = elTeammate.FindChildInLayoutFile( "TeamSelectTeammateName" );
		elName.text = MockAdapter.GetPlayerName( xuid );

		elTeammate.MoveChildAfter( elName, elAvatar );

		_UpdateBotPlayerCount( m_botCounts[ nTeamIdx ], m_playerCounts[ nTeamIdx ], nTeamIdx == 0 ? "TERRORIST" : "CT" );
	}

	return {
		Init: _Init,
		OnServerForcingTeamJoin: _OnServerForcingTeamJoin,
		SetTeamCT: _SetTeamCT,
		SetTeamT: _SetTeamT,
		ShowPanel: _ShowPanel,
		ShowPanel_Test: _ShowPanelTest,
		Escape: _Escape,
		HidePanel: _HidePanel,
		ShowError: _ShowError,
		HighlightTTeam: _HighlightTTeam,
		HighlightCTTeam: _HighlightCTTeam,
		SelectHighlightedTeam: _SelectHighlightedTeam,
		ClearPlayerLists: _ClearPlayerLists,
		AddToPlayerList: _AddToPlayerList,
		OnReadyForDisplay: _OnReadyForDisplay,
		OnUnreadyForDisplay: _OnUnreadyForDisplay,
	}
} )();

                                                                                                    
                                           
                                                                                                    
( function ()
{
	TeamSelectMenu.Init();
	                             
	$.RegisterForUnhandledEvent( "CSGOShowTeamSelectMenu", TeamSelectMenu.ShowPanel );
	$.RegisterForUnhandledEvent( "CSGOShowTeamSelectMenu_Test", TeamSelectMenu.ShowPanel_Test );

	$.RegisterForUnhandledEvent( "ServerForcingTeamJoin", TeamSelectMenu.OnServerForcingTeamJoin );
	$.RegisterForUnhandledEvent( "TeamJoinFailed", TeamSelectMenu.ShowError );

	$.RegisterForUnhandledEvent( "ClearTeamSelectPlayerLists", TeamSelectMenu.ClearPlayerLists );
	$.RegisterForUnhandledEvent( "AddToTeamSelectPlayerList", TeamSelectMenu.AddToPlayerList );

	$.GetContextPanel().RegisterForReadyEvents( true );
	$.RegisterEventHandler( "ReadyForDisplay", $.GetContextPanel(), TeamSelectMenu.OnReadyForDisplay );
	$.RegisterEventHandler( "UnreadyForDisplay", $.GetContextPanel(), TeamSelectMenu.OnUnreadyForDisplay );

	var _m_cP = $( "#TeamSelectMenu" );

	                                                                        
	if ( !_m_cP )
		_m_cP = $( "#PanelToTest" );

	$.RegisterKeyBind( _m_cP, "key_escape", TeamSelectMenu.Escape );
	$.RegisterKeyBind( _m_cP, "key_1", TeamSelectMenu.SetTeamT );
	$.RegisterKeyBind( _m_cP, "key_2", TeamSelectMenu.SetTeamCT );
} )();
