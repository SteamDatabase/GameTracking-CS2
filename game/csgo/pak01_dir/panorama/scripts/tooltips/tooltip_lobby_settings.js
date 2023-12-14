"use strict";

var TooltipLobby = ( function ()
{
	var m_GameSettings = {};
	var m_GameOptions = {};
	var m_RefreshStatsScheduleHandle = false;

	
	
	var _Init = function ()
	{
		if ( LobbyAPI.IsSessionActive() ) {
			_CancelStatsRefresh();
			_GetLobbySettings();
			_Permissions();
			_SetPrimeStatus();
			_SetMode();
			_SetMaps();
			_GetLobbyStatistics();
			_SetGameModeFlags();
			_SetDirectChallengeSettings();
		}
		else {
			UiToolkitAPI.HideCustomLayoutTooltip('LobbySettingsTooltip');
		}
	}
	
	var _CancelStatsRefresh = function () {
		if( m_RefreshStatsScheduleHandle !== false ) {
			$.CancelScheduled( m_RefreshStatsScheduleHandle );
			m_RefreshStatsScheduleHandle = false;
		}
	}

	var _GetLobbyStatistics = function ()
	{
		m_RefreshStatsScheduleHandle = $.Schedule( 2, _GetLobbyStatistics );
		
		var searchingStatus = LobbyAPI.GetMatchmakingStatusString();
		var elMatchStats = $.GetContextPanel().FindChildInLayoutFile( 'LobbyTooltipStats' );
		var isSearching = searchingStatus !== '' && searchingStatus !== undefined ? true : false;

		elMatchStats.SetHasClass( 'hidden', !isSearching );

		                                  
		if( !isSearching )
			return;

		                  
		var elMatchStatsLabel = elMatchStats.FindChildInLayoutFile('LobbyTooltipStatsTitle');
		elMatchStatsLabel.text = $.Localize( searchingStatus );

		                              
		var matchmakeingStats = LobbyAPI.GetMatchmakingStatistics();
		var elStats = elMatchStats.FindChildInLayoutFile('LobbyTooltipStatsList');
		elStats.RemoveAndDeleteChildren();

		  
			                        
			                      
			                
			               
			                  
			                  
			               
			                  
		  
		
		var MakeStatsRow = function ( statType, iconName )
		{
			var p = $.CreatePanel( 'Panel', elStats, '' );
			p.BLoadLayoutSnippet("SettingsEntry");

			if( statType === 'avgSearchTimeSeconds' )
			{
				var time = FormatText.SecondsToDDHHMMSSWithSymbolSeperator( matchmakeingStats[ statType ] );
				p.SetDialogVariable( 'stat', time );
			}
			else
				p.SetDialogVariableInt( 'stat', matchmakeingStats[ statType ]);

			p.FindChildInLayoutFile('SettingText').text = $.Localize( '#matchmaking_stat_' + statType, p );
			p.FindChildInLayoutFile('SettingImage').SetImage( 'file://{images}/icons/ui/'+iconName+'.svg' );
			p.FindChildInLayoutFile('SettingImage').AddClass( 'tint' );
		}

		MakeStatsRow( 'avgSearchTimeSeconds', 'clock');
		                                            
		MakeStatsRow( 'playersOnline', 'lobby' );
		MakeStatsRow( 'playersSearching', 'find');
		MakeStatsRow( 'serversOnline', 'servers');
	}

	var _GetLobbySettings = function ()
	{
		var gss = LobbyAPI.GetSessionSettings();
		m_GameSettings = gss.game;
		m_GameOptions = gss.options;
	}

	var _SetPrimeStatus = function ()
	{
		var isLocalPlayerPrime = MyPersonaAPI.GetElevatedState() === "elevated";
		var displayText = !isLocalPlayerPrime ? '#prime_not_enrolled_label' :
			( m_GameSettings.prime === 1 && SessionUtil.AreLobbyPlayersPrime() )
				? '#prime_only_label' : '#prime_priority_label';
		
		var elPrimeText = $.GetContextPanel().FindChildInLayoutFile( 'LobbyTooltipPrime' );
		elPrimeText.text = $.Localize( displayText );
		                                                                        

		_SetRankedStatus( isLocalPlayerPrime );
	}

	function _SetDirectChallengeSettings ()
	{
		var elDirectChallengeText = $.GetContextPanel().FindChildInLayoutFile( 'LobbyDirectChallenge' );

		var gss = LobbyAPI.GetSessionSettings();
		var bPrivate = gss.options.hasOwnProperty( 'challengekey' ) && gss.options.challengekey != '';

		elDirectChallengeText.text = bPrivate ? $.Localize( '#DirectChallenge_lobbysettings_on2' ) : $.Localize( '#DirectChallenge_lobbysettings_off' );
		var elContainer = $.GetContextPanel().FindChildInLayoutFile( 'LobbyTooltipDirectChallengeContainer' );

		elContainer.visible = bPrivate;


	}


	function _SetGameModeFlags ()
	{
		var elContainer = $.GetContextPanel().FindChildInLayoutFile( 'LobbyTooltipGameModeFlagsContainer' );

		var flags = parseInt( m_GameSettings.gamemodeflags );
		
		if ( !flags || !GameModeFlags.DoesModeUseFlags( m_GameSettings.mode ) ||
			!GameModeFlags.DoesModeShowUserVisibleFlags( m_GameSettings.mode ) )
		{
			elContainer.visible = false;
			return;
		}

		elContainer.visible = true;

		var displayTextToken = '#play_setting_gamemodeflags_' + m_GameSettings.mode + '_' + m_GameSettings.gamemodeflags;
		elContainer.SetDialogVariable( 'gamemodeflags', $.Localize( displayTextToken ) );

		var elIcon = $.GetContextPanel().FindChildTraverse( 'LobbyTooltipGamdeModeFlagsImage' );
		var icon = GameModeFlags.GetIcon( m_GameSettings.mode, flags );
		elIcon.SetImage( icon );

		
	}

	var _SetRankedStatus = function( isLocalPlayerPrime )
	{
		var elRankedText = $.GetContextPanel().FindChildInLayoutFile( 'LobbyTooltipRanked' );

		if ( !isLocalPlayerPrime || !SessionUtil.DoesGameModeHavePrimeQueue( m_GameSettings.mode ) )
		{
			elRankedText.GetParent().visible = false;
			return
		}

		elRankedText.GetParent().visible = true;
		var isRanked = m_GameSettings.prime === 1 && SessionUtil.AreLobbyPlayersPrime()
		elRankedText.text = isRanked ? $.Localize( "#prime_ranked" ) : $.Localize( "#prime_unranked" );
	}

	var _Permissions = function ()
	{
		var systemSettings = LobbyAPI.GetSessionSettings().system;

		if ( !systemSettings )
			return;
		
		var systemAccess = systemSettings.access;
		var displayText = '';

		if( systemAccess === 'public')
		{
			displayText = '#permissions_' + systemAccess;
		}
		else
		{
			displayText = '#permissions_' + systemAccess;
		}

		$.GetContextPanel().FindChildInLayoutFile( 'LobbyTooltipPermissions' ).text = $.Localize( displayText );
	}

	var _SetMode = function ()
	{
		var elGameModeTitle = $.GetContextPanel().FindChildInLayoutFile( 'LobbyTooltipGameMode');
		elGameModeTitle.FindChild( 'SettingText' ).text =  $.Localize('#SFUI_GameMode' + m_GameSettings.mode );
		elGameModeTitle.FindChild( 'SettingImage' ).SetImage( 'file://{images}/icons/ui/' + m_GameSettings.mode + '.svg' );

		elGameModeTitle.FindChild( 'SettingImage' ).SetHasClass('tint', m_GameSettings.mode !== "competitive" );
	}
	

	var _SetMaps = function ()
	{
		if( !m_GameSettings.mapgroupname )
			return;
		
		var mapsList = m_GameSettings.mapgroupname.split(',');
		                                                                                   
		                                                 
		    
		   	                                  
		    

		var elMapsSection = $.GetContextPanel().FindChildInLayoutFile( 'LobbyTooltipMapsList' );

		elMapsSection.RemoveAndDeleteChildren();

		$.CreatePanel( 'Label', elMapsSection, 'LobbyMapsListTitle', { 
			class:'tooltip-player-xp__title--small',
			text:'#party_tooltip_maps'
		} );

		mapsList.forEach(function(element) {
			var p = $.CreatePanel( 'Panel', elMapsSection, element );
			p.BLoadLayoutSnippet("SettingsEntry");

			                                            
			var strMapText = $.Localize( GameTypesAPI.GetMapGroupAttribute(element, 'nameID'));
			if ( element === 'mg_lobby_mapveto' && m_GameOptions && m_GameOptions.challengekey )
			{
				strMapText = $.Localize( "#SFUI_Lobby_LeaderMatchmaking_Type_PremierPrivateQueue" );
			}

			p.FindChildInLayoutFile('SettingText').text = strMapText;

			var maps = GameTypesAPI.GetMapGroupAttributeSubKeys( element, 'maps' ).split(',');
			p.FindChildInLayoutFile('SettingImage').SetImage( 'file://{images}/map_icons/map_icon_'+ maps[0] + '.svg' );
		});
	}

	var _OnHideMainMenu = function () {
		_CancelStatsRefresh();
	}

	var _OnHidePauseMenu = function () {
		_CancelStatsRefresh();
	}

	return{
		Init	: _Init,
		CancelStatsRefresh : _CancelStatsRefresh,
		OnHideMainMenu	   : _OnHideMainMenu,
		OnHidePauseMenu	   : _OnHidePauseMenu
};

})();

(function()
{
	$.RegisterForUnhandledEvent( "PanoramaComponent_Lobby_MatchmakingSessionUpdate", TooltipLobby.Init );
	$.RegisterForUnhandledEvent( "CSGOHideMainMenu", TooltipLobby.OnHideMainMenu );
	$.RegisterForUnhandledEvent( "CSGOHidePauseMenu", TooltipLobby.OnHidePauseMenu );
})();