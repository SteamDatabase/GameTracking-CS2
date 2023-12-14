'use strict';

var contextmenuPlayerCard = ( function (){

	var _Init = function ()
	{
		_LoadPlayerCard();
		_GetContextMenuEntries();

		                                                                                 
	};

	var _LoadPlayerCard = function( xuid )
	{
		var xuid = $.GetContextPanel().GetAttributeString( "xuid", "(not found)" );
		var newPanel = $.GetContextPanel().FindChildInLayoutFile( 'JsContextMenuPlayercard' );

		if( newPanel )
			newPanel.DeleteAsync( .0 );

		var newPanel = $.CreatePanel('Panel', $.GetContextPanel().FindChildInLayoutFile('JsContextMenuSections'), 'JsContextMenuPlayercard' ); 
		newPanel.SetAttributeString( "xuid", xuid );
		newPanel.BLoadLayout('file://{resources}/layout/playercard.xml', false, false);
	};

	var _ContextMenus = [
		  
		 
			                                                                            
			                                   
				                                                                 
				            	
			  
			                              
				                                    
			 
		  
		  
		
		{
			name: 'invite',
			icon: 'invite',
			AvailableForItem: function ( id ) {
				                                                                                              
				return !GameStateAPI.IsLocalPlayerPlayingMatch() && !( LobbyAPI.IsPartyMember( id ) ) && !_IsSelf( id) &&
					( 'purchased' === MyPersonaAPI.GetLicenseType() );
			},
			OnSelected:  function ( id, type ) {
				if ( type ) StoreAPI.RecordUIEvent( "ActionInviteFriendFrom_" + type );
				else StoreAPI.RecordUIEvent( "ActionInviteFriendGeneric" );
				
				FriendsListAPI.ActionInviteFriend( id, '' );
				$.DispatchEvent( 'ContextMenuEvent', '' );
				$.DispatchEvent( 'FriendInvitedFromContextMenu', id ); 
			},
			IsDisabled: function() {
				var gss = LobbyAPI.GetSessionSettings();
				if( !gss || !gss.hasOwnProperty( 'game' ) )
				{
					return false;
				}
				                                        
				return gss.game.apr > 1 ? true : false;
		}
		},
		{
			name: 'join',
			icon: 'JoinPlayer',
			AvailableForItem: function ( id ) {
				if ( FriendsListAPI.IsFriendJoinable( id ) )
				{
					if ( GameStateAPI.IsPlayerConnected( id ) )
						return false;
					
					if (LobbyAPI.IsSessionActive()) {
						var party = LobbyAPI.GetSessionSettings().members;

						for (var i = 0; i < party.numPlayers; i++) {
							if ( id === party['machine' + i].player0.xuid )
								return false;
						}
					}

					return ( 'purchased' === MyPersonaAPI.GetLicenseType() );
				}
			},
			OnSelected:  function ( id ) {
				FriendsListAPI.ActionJoinFriendSession( id );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'watch',
			icon: 'watch_tv',
			AvailableForItem: function ( id )
			{
				return !GameStateAPI.IsLocalPlayerPlayingMatch() &&
					FriendsListAPI.IsFriendWatchable( id ) &&
					!GameStateAPI.IsPlayerConnected( id );
			},
			OnSelected:  function ( id ) {
				FriendsListAPI.ActionWatchFriendSession( id );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'steamprofile',
			icon: 'profile',
			AvailableForItem: function ( id )
			{
				return 	MyPersonaAPI.GetLauncherType() !== "perfectworld";
				
			},
			OnSelected:  function ( id ) {
				SteamOverlayAPI.ShowUserProfilePage( id );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'kick_from_lobby',
			icon: 'friendignore',
			AvailableForItem: function( id )
			{
				if ( GameStateAPI.IsLocalPlayerPlayingMatch() )
					return false;
				
				if (LobbyAPI.IsSessionActive() && LobbyAPI.BIsHost()) {
					var party = LobbyAPI.GetSessionSettings().members;

					for (var i = 0; i < party.numPlayers; i++) {
						if (id === party['machine' + i].player0.xuid && !_IsSelf( id ))
							return true;
					}

				}
			},
			OnSelected:  function ( id ) {
				LobbyAPI.KickPlayer( id );                               
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			                                                              
			name: 'leave_lobby',
			icon: 'leave',
			AvailableForItem: function ( id )
			{
				if( !GameStateAPI.IsLocalPlayerPlayingMatch() && _IsSelf( id ) && LobbyAPI.IsSessionActive() )
				{
					var party = LobbyAPI.GetSessionSettings().members;
					return party.numPlayers > 1 ? true : false;
				}

				return false;
			},
			OnSelected:  function ( id ) {
				LobbyAPI.CloseSession();
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'message',
			icon: 'message',
			AvailableForItem: function ( id )
			{	                                                                                           
				return !_IsSelf( id );                                                                   
			},
			OnSelected:  function ( id ) {
				SteamOverlayAPI.StartChatWithUser( id );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'trade',
			icon: 'trade',
			AvailableForItem: function ( id )
			{
				return FriendsListAPI.GetFriendRelationship( id ) === "friend";
			},
			OnSelected:  function ( id ) {
				SteamOverlayAPI.StartTradeWithUser( id );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'summonmissioncoopmission',
			icon: 'coop',
			AvailableForItem: function ( id ) {
				return false;
			},
			OnSelected:  function ( id ) {
			}
		},
		{
			name: 'summonmissioncoop',
			icon: 'coop',
			AvailableForItem: function ( id ) {
				return false;
			},
			OnSelected:  function ( id ) {
			}
		},
		{
			name: 'friendaccept',
			icon: 'friendaccept',
			AvailableForItem: function ( id )
			{
				return FriendsListAPI.GetFriendStatusBucket( id ) === 'AwaitingLocalAccept';
			},
			OnSelected:  function ( id ) {
				SteamOverlayAPI.InteractWithUser( id, 'friendrequestaccept' );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'friendignore',
			icon: 'friendignore',
			AvailableForItem: function ( id )
			{
				return FriendsListAPI.GetFriendStatusBucket( id ) === 'AwaitingLocalAccept';
			},
			OnSelected:  function ( id ) {
				SteamOverlayAPI.InteractWithUser( id, 'friendrequestignore' );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'cancelinvite',
			icon: 'friendignore',
			AvailableForItem: function ( id )
			{
				return FriendsListAPI.GetFriendStatusBucket( id ) === 'AwaitingRemoteAccept';
			},
			OnSelected:  function ( id ) {
				SteamOverlayAPI.InteractWithUser( id, 'friendremove' );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'removefriend',
			icon: 'friendremove',
			AvailableForItem: function ( id ) {
				if( MyPersonaAPI.GetLauncherType() === "perfectworld" )
				{
					if ( _IsSelf( id ) ) return false;
					var status = FriendsListAPI.GetFriendStatusBucket( id );
					return status !== 'AwaitingRemoteAccept' && status !== 'AwaitingLocalAccept';
				}

				return false;
			},
			OnSelected:  function ( id ) {
				SteamOverlayAPI.InteractWithUser( id, 'friendremove' );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'request',
			icon: 'addplayer',
			AvailableForItem: function ( id )
			{
				var status = FriendsListAPI.GetFriendStatusBucket( id );
				var isRequest = status === 'AwaitingRemoteAccept' || status === 'AwaitingLocalAccept';
				
				return FriendsListAPI.GetFriendRelationship( id ) !== "friend" && !_IsSelf( id ) && !isRequest;
			},
			OnSelected:  function ( id ) {
				SteamOverlayAPI.InteractWithUser( id, 'friendadd' );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'editprofile',
			icon: 'edit',
			AvailableForItem: function ( id ) {
				return _IsSelf( id );
			},
			OnSelected:  function ( id ) {
				var appID = SteamOverlayAPI.GetAppID();
				var communityUrl = SteamOverlayAPI.GetSteamCommunityURL();
				SteamOverlayAPI.OpenURL( communityUrl+"/profiles/"+id+"/minimaledit" );
	
				                                   
				                                                      
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'changecolor',
			icon: 'colorwheel',
			AvailableForItem: function ( id )
			{
				return !GameStateAPI.IsLocalPlayerPlayingMatch() &&
					LobbyAPI.IsSessionActive() &&
					_IsSelf( id );
			},
			OnSelected: function ( id ) {
				LobbyAPI.ChangeTeammateColor();
				                                                                                                        
			}
		},
		{
			name: 'mute',
			xml: 'file://{resources}/layout/mute_spinner.xml',
			icon: null,                      
			AvailableForItem: function ( id ) {
				return GameStateAPI.IsLocalPlayerPlayingMatch() && 
					!_IsSelf( id ) && 
					GameStateAPI.IsPlayerConnected( id );
			},
			OnSelected: null                      
		},
		    
		   	               
		   	              
		   	                                   
		   		                                                   
		   			                  
		   			                                           
		   			                                     
		   	  
		   	                             
		   		                              
		   		                                          
		   	 
		     
		{
			name: 'report',
			icon: 'alert',
			AvailableForItem: function ( id ) {
				return (
					GameStateAPI.IsLocalPlayerPlayingMatch() ||
					( GameStateAPI.IsLocalPlayerWatchingOwnDemo() && MatchInfoAPI.CanReportFromCurrentlyPlayingDemo() ) ||
					GameStateAPI.GetGameModeInternalName( false ) === "survival"
				) &&
				!_IsSelf( id ) &&
				GameStateAPI.IsPlayerConnected( id );
			},
			OnSelected: function ( id ) {
				UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_report_player.xml', 'xuid=' + id );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'commend',
			icon: 'smile',
			AvailableForItem: function ( id )
			{
				return ( GameStateAPI.IsLocalPlayerPlayingMatch() || GameStateAPI.GetGameModeInternalName( false ) === "survival" ) &&
					!_IsSelf( id ) &&
					GameStateAPI.IsPlayerConnected( id );
			},
			OnSelected: function ( id ) {
				UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_commend_player.xml', 'xuid=' + id );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'borrowmusickit',
			icon: 'music_kit',
			AvailableForItem: function ( id )
			{
				var borrowedPlayerSlot = parseInt( GameInterfaceAPI.GetSettingString( "cl_borrow_music_from_player_slot" ) );
				return GameStateAPI.IsLocalPlayerPlayingMatch() &&
					!_IsSelf( id ) &&
					borrowedPlayerSlot !== GameStateAPI.GetPlayerSlot( id ) &&
					_HasMusicKit( id ) &&
					GameStateAPI.IsPlayerConnected( id );
			},
			OnSelected: function( id )
			{
				GameInterfaceAPI.SetSettingString( "cl_borrow_music_from_player_slot", "" + GameStateAPI.GetPlayerSlot( id ) );
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},
		{
			name: 'stopborrowmusickit',
			icon: 'no_musickit',
			AvailableForItem: function ( id )
			{
				var borrowedPlayerSlot = parseInt(GameInterfaceAPI.GetSettingString( "cl_borrow_music_from_player_slot" ) );
				if ( borrowedPlayerSlot === -1 )
					return false;

				return GameStateAPI.IsLocalPlayerPlayingMatch() &&
					((_IsSelf(id) && borrowedPlayerSlot !== -1 ) ||
					(borrowedPlayerSlot === GameStateAPI.GetPlayerSlot( id ) ) ) &&
					GameStateAPI.IsPlayerConnected( id );
			},
			OnSelected: function( id )
			{
				$.DispatchEvent('Scoreboard_UnborrowMusicKit');
				$.DispatchEvent( 'ContextMenuEvent', '' );
			}
		},		
		{
			name: 'copycrosshair',
			icon: 'crosshair',
			AvailableForItem: function ( id )
			{
				return GameStateAPI.IsLocalPlayerPlayingMatch() && 
					!_IsSelf( id ) && 
					GameStateAPI.IsPlayerConnected( id );
			},
			OnSelected: function( xuid )
			{
				$.DispatchEvent( 'Scoreboard_ApplyPlayerCrosshairCode', xuid ); 
				$.DispatchEvent( 'ContextMenuEvent', '' );

				  
				                                   
					                                       
					                                                
					   
					                                                                                                          
					              
				  
				  

			}
		},
	];

	var _HasMusicKit = function( id )
	{
		return ( InventoryAPI.GetMusicIDForPlayer( id ) > 1 );
	};

	var _IsSelf = function ( id )
	{
		return id === MyPersonaAPI.GetXuid();
	};


	var _GetContextMenuEntries = function ()
	{
		$.CreatePanel('Panel', $.GetContextPanel(), '', { class: 'context-menu-playercard-seperator' } );
		var elContextMenuBtnsParent = $.CreatePanel( 'Panel', $.GetContextPanel(), '', { class: 'context-menu-playercard-btns' } );

		var items = [];
		var xuid = $.GetContextPanel().GetAttributeString( "xuid", "(not found)" );
		var type = $.GetContextPanel().GetAttributeString( "type", "" );

		let count = 0;
		let rowCount = 0;
		let elContextMenuBtns;

		_ContextMenus.forEach( function( entry, index) {
			if ( entry.AvailableForItem( xuid )) 
			{	
				                                     
				var elEntryBtn;
				count = count === 5 ? 0 : count;
				if ( count === 0 )
				{
					elContextMenuBtns = $.GetContextPanel().FindChildInLayoutFile( 'id_playercard-button-row' + rowCount );

					if ( !elContextMenuBtns )
					{
						elContextMenuBtns = $.CreatePanel( 'Panel', elContextMenuBtnsParent, 'id_playercard-button-row' + rowCount, { class: 'context-menu-playercard-btns__container' } );
						elContextMenuBtns.xuid = xuid;                                                                     
						rowCount++;
					}
				}

				if ( 'xml' in entry )                                 
				{
					elEntryBtn = $.CreatePanel( 'Panel', elContextMenuBtns, entry.name, { 
						class: 'IconButton',
						style: 'tooltip-position: bottom;'
					} );
					
					elEntryBtn.BLoadLayout( entry.xml, false, false );
				}
				else                
				{
					elEntryBtn = $.CreatePanel( 'Button', elContextMenuBtns, entry.name, { 
						class: 'IconButton',
						style: 'tooltip-position: bottom;'
					} );

					$.CreatePanel( 'Image', elEntryBtn, entry.name, { src: 'file://{images}/icons/ui/' + entry.icon + '.svg' } );
					let label = $.CreatePanel( 'Label', elEntryBtn, entry.name +'-label' );
					label.text = $.Localize( '#tooltip_short_' + entry.name );

					let tooltip = '#tooltip_' + entry.name;

					if( 'IsDisabled' in entry )
					{
						if( entry.IsDisabled() ){
							elEntryBtn.enabled = false;
							tooltip = '#tooltip_disabled_' + entry.name;
						}
						else{
							elEntryBtn.enabled = true;
						}
					}

					elEntryBtn.SetPanelEvent( 'onactivate', entry.OnSelected.bind( this, xuid, type ) );

					          
					var OnMouseOver = function ()
					{
						UiToolkitAPI.ShowTextTooltip( elEntryBtn.id, tooltip );
					}

					var OnMouseOut = function ()
					{
						UiToolkitAPI.HideTextTooltip();
					}
					
					elEntryBtn.SetPanelEvent('onmouseover', OnMouseOver );
					elEntryBtn.SetPanelEvent( 'onmouseout', OnMouseOut );
				}
				
				count++;
				              
					                                           
					                                                           
					                                                 
				     
			}
		});
	};

	return {
		Init		:	_Init,                 
	};

})();

                                                                                                    
                                            
                                                                                                    
(function(){
})();