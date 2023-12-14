'use strict';

var PopupLeaderboards = ( function()
{
	var m_type = '';
	var m_myXuid = MyPersonaAPI.GetXuid();

	var _Init = function()
	{
		var type = $.GetContextPanel().GetAttributeString( 'type', '' );

		if ( type === '' )
		{
			return;
		}

		var aTypes = type.split( ',' );

		_SetTitle( aTypes[ 0 ] );
		_SetPointsTitle();
		_MakeTabs( aTypes );
		_ShowGlobalRank();

		$( '#id-popup-leaderboard-refresh-button' ).SetPanelEvent(
			'onactivate',
			function( lbType ) { LeaderboardsAPI.Refresh( lbType ); }.bind( undefined, type )
		);
	};

	var _SetTitle = function( type )
	{
		var titleOverride = $.GetContextPanel().GetAttributeString( 'titleoverride', '' );
		var title = titleOverride !== '' ? titleOverride : '#CSGO_' + type;
		$.GetContextPanel().FindChildInLayoutFile( 'id-popup-leaderboard-title' ).text = $.Localize( title );
	};

	var _SetPointsTitle = function()
	{
		var strPointsTitle = $.GetContextPanel().GetAttributeString( 'points-title', '' );
		if ( strPointsTitle !== '' )
		{
	  		                                                                                                                
		}
	};

	var _MakeTabs = function( aTypes )
	{
		if ( aTypes.length <= 1 )
		{
			m_type = aTypes[ 0 ];
			_UpdateLeaderboard( aTypes[ 0 ] );
			return;
		}

		var elNavBar = $.GetContextPanel().FindChildInLayoutFile( 'id-popup-leaderboard-navbar' );
		elNavBar.RemoveClass( 'hidden' );

		var elTabs = elNavBar.FindChild( 'id-popup-leaderboard-tabs' );

		for ( var i = 0; i < aTypes.length; i++ )
		{
			var elTab = $.CreatePanel( "RadioButton", elTabs, aTypes[ i ] );
			elTab.BLoadLayoutSnippet( "leaderboard-tab" );
			elTab.SetPanelEvent(
				'onactivate',
				_UpdateLeaderboard.bind( undefined, aTypes[ i ] )
			);

			elTab.FindChildInLayoutFile( 'leaderboard-tab-label' ).text = $.Localize( '#CSGO_' + aTypes[ i ] + '_tab' );
		}
		
		$.DispatchEvent( "Activated", elTabs.Children()[ 0 ], "mouse" );
	};

	var _ShowGlobalRank = function()
	{
		var showRank = $.GetContextPanel().GetAttributeString( 'showglobaloverride', 'true' );
		$.GetContextPanel().SetHasClass( 'hide-global-rank', showRank === 'false' );
	};

	var _UpdateLeaderboard = function( type )
	{
		                                
		m_type = type;

		var status = LeaderboardsAPI.GetState( type );
		                                         

		var elStatus = $.GetContextPanel().FindChildInLayoutFile( 'id-popup-leaderboard-loading' );
		var elData = $.GetContextPanel().FindChildInLayoutFile( 'id-popup-leaderboard-nodata' );
		var elLeaderboardList = $.GetContextPanel().FindChildInLayoutFile( 'id-popup-leaderboard-list' );

		if ( "none" == status )
		{
			elStatus.SetHasClass( 'hidden', false );
			elData.SetHasClass( 'hidden', true );
			elLeaderboardList.SetHasClass( 'hidden', true );
			LeaderboardsAPI.Refresh( type );
		}
	
		if ( "loading" == status )
		{
			elStatus.SetHasClass( 'hidden', false );
			elData.SetHasClass( 'hidden', true );
			elLeaderboardList.SetHasClass( 'hidden', true );
		}
	
		if ( "ready" == status )
		{
			var count = LeaderboardsAPI.GetCount( type );
			
			if ( count === 0 )
			{
				elData.SetHasClass( 'hidden', false );
				elStatus.SetHasClass( 'hidden', true );
				elLeaderboardList.SetHasClass( 'hidden', true );
			}
			else
			{
				elLeaderboardList.SetHasClass( 'hidden', false );
				elStatus.SetHasClass( 'hidden', true );
				elData.SetHasClass( 'hidden', true );

				_FillOutEntries( type, count );
			}
			
			if ( 1 <= LeaderboardsAPI.HowManyMinutesAgoCached( type ) )
			{
				LeaderboardsAPI.Refresh( type );
			}
		}
	};

	var _FillOutEntries = function( type, count )
	{
		var elParent = $.GetContextPanel().FindChildInLayoutFile( 'id-popup-leaderboard-entries' );
		elParent.RemoveAndDeleteChildren();

		function _AddOpenPlayerCardAction( elAvatar, xuid ) {
			var openCard = function ( xuid ) {
				                                                                                             
				$.DispatchEvent( 'SidebarContextMenuActive', true );
	
				if ( xuid !== 0 )
				{
					var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent(
						'',
						'',
						'file://{resources}/layout/context_menus/context_menu_playercard.xml',
						'xuid=' + xuid,
						function () {
							$.DispatchEvent( 'SidebarContextMenuActive', false );
						}
					);
					contextMenuPanel.AddClass( "ContextMenu_NoArrow" );
				}
			};
	
			elAvatar.SetPanelEvent( "onactivate", openCard.bind( undefined, xuid ) );
			elAvatar.SetPanelEvent( "oncontextmenu", openCard.bind( undefined, xuid ) );
		}

		var strThousandsSeparator = $.Localize( '#csgo_thousands_separator' );
		for ( var i = 0; i < count; i++ )
		{
			var xuid = LeaderboardsAPI.GetEntryXuidByIndex( type, i );
			var score = LeaderboardsAPI.GetEntryScoreByIndex( type, i );             
			var rankpct = LeaderboardsAPI.GetEntryGlobalPctByIndex( type, i );              

			var detailsHandle = LeaderboardsAPI.GetEntryDetailsHandleByIndex( type, i );              

			var MatchesWon = LeaderboardsAPI.GetDetailsMatchEntryStat( detailsHandle, 'MatchesWon' );
			var MatchesTied = LeaderboardsAPI.GetDetailsMatchEntryStat( detailsHandle, 'MatchesTied' );
			var MatchesLost = LeaderboardsAPI.GetDetailsMatchEntryStat( detailsHandle, 'MatchesLost' );
			var RankWindowStats = LeaderboardsAPI.GetDetailsMatchEntryStat( detailsHandle, 'RankWindowStats' );

			let windowStats = MatchDraftAPI.DecodePackedWindowStats( 1, RankWindowStats );

			                                                         

			let winRate = MatchesWon * 100.00 / ( MatchesWon + MatchesTied + MatchesLost );

			var elEntry = $.CreatePanel( "Panel", elParent, xuid );
			elEntry.BLoadLayoutSnippet( "leaderboard-entry" );

			elEntry.FindChildInLayoutFile('popup-leaderboard-entry-avatar').PopulateFromSteamID(xuid);
			_AddOpenPlayerCardAction( elEntry, xuid );

			let elRatingEmblem = elEntry.FindChildTraverse( 'jsRatingEmblem' );
			RatingEmblem.SetXuid( elRatingEmblem, null, score );
			
			elEntry.SetDialogVariable( 'player-rank', i + 1 );
			elEntry.SetDialogVariable( 'player-name', FriendsListAPI.GetFriendName(xuid) );
			elEntry.SetDialogVariable( 'player-wins', MatchesWon );
			elEntry.SetDialogVariable( 'player-winrate', winRate.toFixed( 2 ) + '%' );
			elEntry.SetDialogVariable( 'player-percentile', rankpct.toFixed( 2 ) + '%' );

			var children = elEntry.FindChildrenWithClassTraverse( 'popup-leaderboard__list__column' );
			
			if ( i % 2 === 0 )
			{
				children.forEach(element => {
					element.AddClass( 'background' );
				});
			}
		}

		_HighightMySelf();
	};

	var _HighightMySelf = function()
	{
		var elParent = $.GetContextPanel().FindChildInLayoutFile( 'id-popup-leaderboard-entries' );
		var elEntry = elParent.FindChildInLayoutFile( m_myXuid );

		if ( elEntry )
		{
			elEntry.AddClass( 'local-player' );
			elEntry.ScrollParentToMakePanelFit( 1, false );
		}
	};

	var _RefreshLeaderBoard = function( type )
	{
		if ( m_type === type )
		{
			_UpdateLeaderboard( type );
			return;
		}
	};

	var _UpdateName = function( xuid )
	{
		var elParent = $.GetContextPanel().FindChildInLayoutFile( 'id-popup-leaderboard-entries' );
		var elEntry = elParent.FindChildInLayoutFile( xuid );

		if ( elEntry )
		{
			elEntry.FindChildInLayoutFile( 'popup-leaderboard-entry-name' ).text = FriendsListAPI.GetFriendName( xuid );
		}
	};

	var _Close = function()
	{
		                   
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
	};

	return {
		Init: _Init,
		RefreshLeaderBoard: _RefreshLeaderBoard,
		UpdateName: _UpdateName,
		Close: _Close
	};

})();

(function(){

	$.RegisterForUnhandledEvent( 'PanoramaComponent_Leaderboards_StateChange', PopupLeaderboards.RefreshLeaderBoard );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_FriendsList_NameChanged', PopupLeaderboards.UpdateName );
	                                                                                                                             
	PopupLeaderboards.Init();
})();