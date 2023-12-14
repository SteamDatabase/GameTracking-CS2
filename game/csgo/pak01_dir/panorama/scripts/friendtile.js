'use strict';

var friendTile = ( function (){

	var _m_xuid = '';
	var _m_tile = null;
	var _m_isClan = '';
	var _m_hasClanInfo = false;
	var _m_clanHandle = null;
	
	var _Init = function( elTile )
	{
		_m_xuid = elTile.GetAttributeString( 'xuid', '(not found)' );
		_m_isClan = elTile.GetAttributeString( 'isClan', 'false' ) === 'true';
		_m_tile = elTile;

		if ( _m_isClan )
		{
			_m_hasClanInfo = MyPersonaAPI.GetMyClanNameById( _m_xuid ) != '';

			if ( !_m_clanHandle )
				_m_clanHandle = $.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_ClansInfoUpdated', _ClansInfoUpdated );
		}

		_SetImage( elTile );
		_SetName( elTile );
		_SetStatus( elTile );
		_SetStatusBar( elTile );
		_SetInvitedFromCallback( elTile );
		_SetCanJoin( elTile );
		_SetCanWatch( elTile );
		_SetOnActivateEvent( elTile );
	};

	var _SetImage = function( elTile )
	{
		var elAvatarImg = elTile.FindChildTraverse( 'JsFriendAvatar' );
		elAvatarImg.PopulateFromSteamID( _m_xuid );

		                                                                   
		elAvatarImg.visible = !_m_isClan || _m_hasClanInfo;
			
	};

	var _SetStatusBar = function( elTile )
	{
		var elBg = elTile.FindChildTraverse( 'JsFriendTileStatusBg' );
		var statusBucket = FriendsListAPI.GetFriendStatusBucket( _m_xuid );
		var isFriend = FriendsListAPI.GetFriendRelationship( _m_xuid );

		                                                
		                                                                                                  
		if ( TeammatesAPI.GetCoPlayerInCSGO( _m_xuid ) && isFriend !== "friend" )
		{
			statusBucket = "PlayingCSGO";
		}
		else if ( isFriend !== "friend" )
		{
			statusBucket = "Offline";
		}

		elBg.SetHasClass( 'ingame', statusBucket === "PlayingCSGO" );

	};

	var _SetName = function( elTile )
	{
		var elLabel = elTile.FindChildTraverse( 'JsFriendName' );

		if ( !_m_isClan )
		{
			elLabel.text = FriendsListAPI.GetFriendName( _m_xuid );
		}
		else
		{
			elLabel.text = MyPersonaAPI.GetMyClanNameById( _m_xuid );
			elLabel.visible = !_m_isClan || _m_hasClanInfo;
		}
	};

	var _SetStatus = function( elTile )
	{
		var friendStatusText = '';

		if ( _m_isClan )
		{
			friendStatusText = "#steamgroup";
		}
		else
		{
			if ( elTile.Data().type === 'recent' )
			{
				friendStatusText = TeammatesAPI.GetCoPlayerTime( _m_xuid );
			}

			if ( !friendStatusText )
				friendStatusText = FriendsListAPI.GetFriendStatus( _m_xuid );
		}

		var elLabel = elTile.FindChildTraverse( 'JsFriendStatus' );
		elLabel.text = $.Localize( friendStatusText );
	};

	var _SetInvitedFromCallback = function( elTile )
	{
		var isInvited = FriendsListAPI.IsFriendInvited( _m_xuid );
		_SetInvited( elTile, isInvited );
	};

	var _SetInvitedFromContextMenu = function( elTile )
	{
		_SetInvited( elTile, true );
	};

	var _SetInvited = function( elTile, isInvited )
	{
		var elInvited = elTile.FindChildTraverse( 'JsFriendInvited' );

		if ( elInvited !== null )
			elInvited.SetHasClass( 'hidden', !isInvited );
	};

	var _SetCanJoin = function( elTile )
	{
		var canJoin = FriendsListAPI.IsFriendJoinable( _m_xuid );

		elTile.FindChildTraverse( 'JsFriendJoin' ).SetHasClass( 'hidden', !canJoin );
	};

	var _SetCanWatch = function( elTile )
	{
		var canWatch = FriendsListAPI.IsFriendWatchable( _m_xuid );

		elTile.FindChildTraverse( 'JsFriendWatch' ).SetHasClass( 'hidden', !canWatch );
	};


	var _SetOnActivateEvent = function( elTile )
	{
		if ( _m_isClan )
		{
			elTile.SetPanelEvent( 'onactivate', function ()
			{
				SteamOverlayAPI.OpenUrlInOverlayOrExternalBrowser( "https://" + SteamOverlayAPI.GetSteamCommunityURL() + "/gid/" + _m_xuid );
			} );

			return;
		}
		
		var OpenContextMenu = function( xuid )
		{
			                                                                                             
			$.DispatchEvent( 'SidebarContextMenuActive', true );
				
			var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent(
				'',
				'',
				'file://{resources}/layout/context_menus/context_menu_playercard.xml',
				'xuid=' + xuid +
				( elTile.Data().type ? ( '&type='+elTile.Data().type ) : '' ),                                      
				function()
				{
					$.DispatchEvent( 'SidebarContextMenuActive', false )
				}
			);
			contextMenuPanel.AddClass( "ContextMenu_NoArrow" );
		};

		elTile.FindChildTraverse( 'JsFriendTileBtn' ).SetPanelEvent( 'onactivate', OpenContextMenu.bind( undefined, _m_xuid ) );
		elTile.FindChildTraverse( 'JsFriendTileBtn' ).SetPanelEvent( 'oncontextmenu', OpenContextMenu.bind( undefined, _m_xuid ) );
	};

	function _ClansInfoUpdated ()
	{
		var elTile = $.GetContextPanel().FindChildTraverse( 'JsKeyValidatedResult' );

		if ( elTile.codeType === 'g' && !elTile.FindChildTraverse( 'JsAvatarImage' ) )
		{
			_Init( elTile );
		}
	}

	return {
		Init: 							_Init,		                      
		SetInvitedFromContextMenu:		_SetInvitedFromContextMenu,
	};
})();

( function (){
	                                                                                                      

})();


