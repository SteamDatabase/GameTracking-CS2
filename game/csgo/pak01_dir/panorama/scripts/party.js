'use strict';

                                               
	            
		     
		  
		          
		    
		           
			    
				      
				        
				     
				   
				     
				       
				         
				    
				     
			    
			    
	           
	          
	        
  


                                                     
                                                       
                                                     
var elPartySection = $( '#PartyList' );

var PartyMenu = ( function()
{
	var m_eventRebuildPartyList;

	var m_prevMembersInParty = -1;

	var _Init = function()
	{
		_RefreshPartyMembers();
		_AddOnActivateLeaveBtn();
		_ShowMatchmakingStatusTooltipEvent();
	};

	var _RefreshPartyMembers = function()
	{
		if ( !_IsSessionActive() )
		{
			return;
		}

		var lobbySettings = LobbyAPI.GetSessionSettings().game;
		if ( !lobbySettings )
		{
			return;
		}

		var elPartyMembersList = elPartySection.FindChildInLayoutFile( 'PartyMembers' );
		_UpdateNumPlayersInparty();

		                                                                                    
		var bIsSearching = _IsSearching();
		if ( m_prevMembersInParty >= PartyListAPI.GetPartySessionUiThreshold() || bIsSearching )
		{
			elPartyMembersList.RemoveAndDeleteChildren();
			_UpdateMembersList( lobbySettings, m_prevMembersInParty );
		}
		else
		{
			elPartySection.AddClass( 'hidden' );
			friendsList.UpdateHeightOpenSection();
			elPartyMembersList.RemoveAndDeleteChildren();
		}

		                                                               
		                                                                                                                               
		elPartySection.GetParent().SetHasClass( 'friendslist-party-searching', bIsSearching && ( m_prevMembersInParty <= 1 ) );

		_UpdateLeaveBtn( m_prevMembersInParty );
	};

	var _UpdateNumPlayersInparty = function()
	{
		var numPlayersActuallyInParty = PartyListAPI.GetCount();

		if ( numPlayersActuallyInParty > m_prevMembersInParty )
		{
			$.DispatchEvent( 'CSGOPlaySoundEffectMuteBypass', 'PanoramaUI.Lobby.Joined', 'PartyList', 1.0 );
		}
		else if ( numPlayersActuallyInParty < m_prevMembersInParty )
		{
			$.DispatchEvent( 'CSGOPlaySoundEffectMuteBypass', 'PanoramaUI.Lobby.Left', 'PartyList', 1.0 );
		}
		
		m_prevMembersInParty = numPlayersActuallyInParty;
		elPartySection.SetDialogVariable( 'alert_value', numPlayersActuallyInParty );
	}

	var _IsSessionActive = function()
	{
		if ( !LobbyAPI.IsSessionActive() )
		{
			elPartySection.AddClass( 'hidden' );
			friendsList.UpdateHeightOpenSection();
			elPartySection.GetParent().SetHasClass( 'friendslist-party-searching', false );
			return false;
		}

		return true;
	};

	var _UpdateMembersList = function( lobbySettings, numPlayersActuallyInParty )
	{
		                                                                  
		                                                                                          
		var maxAllowedInLobby = 10;
		var numPlayersPossibleInMode = SessionUtil.GetMaxLobbySlotsForGameMode( lobbySettings.mode );

		if ( elPartySection.BHasClass( 'hidden' ) )
		{
			elPartySection.RemoveClass( 'hidden' );
		}
		friendsList.UpdateHeightOpenSection();

		for ( var i = 0; i < maxAllowedInLobby; i++ )
		{
			var xuid = i < numPlayersActuallyInParty ? PartyListAPI.GetXuidByIndex( i ) : 0;
		
			var isOverPossible = ( numPlayersActuallyInParty > numPlayersPossibleInMode ) ? true : false;
			var elPartyMemberCurrent = null;

			if ( i < numPlayersActuallyInParty )
			{
				elPartyMemberCurrent = _MakeNewPartyMemberTile( "PartyMember" + i, xuid );
				_SetPartyMemberName( elPartyMemberCurrent, xuid );
				_SetPartyMemberRank( elPartyMemberCurrent, xuid );
				_SetPrimeForMember( elPartyMemberCurrent, xuid );
				_UpdateAvatar( elPartyMemberCurrent, xuid )
				_TintForOverPlayerCountForMode( elPartyMemberCurrent, isOverPossible );
			}
		}

		_SetLobbyTitle( numPlayersPossibleInMode, numPlayersActuallyInParty );
	};

	var _MakeNewPartyMemberTile = function( panelIdToLoad, xuid )
	{
		var elParent = $.GetContextPanel().FindChildInLayoutFile( 'PartyMembers' );
		var elPartyMember = $.CreatePanel( "Panel", elParent, panelIdToLoad );
		elPartyMember.BLoadLayoutSnippet( 'PartyMember' );
		elPartyMember.Data().xuid = xuid; 
		var memberBtn = elPartyMember.FindChildInLayoutFile( 'PartyMemberBtn');

		var elAvatar =  $.CreatePanel( "Panel", memberBtn, xuid );
		_SetAttributeStringsOnAvatarPanel( elAvatar, xuid );
		elAvatar.BLoadLayout( 'file://{resources}/layout/avatar.xml', false, false );
		elAvatar.BLoadLayoutSnippet( "AvatarParty" );
		elAvatar.enabled = false;

		memberBtn.MoveChildBefore( elAvatar,memberBtn.GetChild( 0 ) );

		if ( xuid !== 0 && xuid )
			_AddOpenPlayerCardAction( memberBtn, xuid );
		else
			_ClearExisitingOnActivateEvent( memberBtn );

		return elPartyMember;
	};

	var _UpdateAvatar = function( elPartyMember, xuid )
	{
		var elAvatar = elPartyMember.FindChildInLayoutFile( xuid );
		Avatar.Init( elAvatar, xuid, 'playercard' );
	};

	var _SetPartyMemberName = function( elPartyMember, xuid )
	{
		var elName = elPartyMember.FindChildInLayoutFile( 'JsFriendName' );
		elName.text = FriendsListAPI.GetFriendName( xuid );
	};

	var _SetPartyMemberRank = function( elPartyMember, xuid )
	{
		var skillgroupType = PartyListAPI.GetFriendCompetitiveRankType( xuid );
		var skillGroup = PartyListAPI.GetFriendCompetitiveRank( xuid, skillgroupType );
		var wins = PartyListAPI.GetFriendCompetitiveWins( xuid, skillgroupType );
		var winsNeededForRank = SessionUtil.GetNumWinsNeededForRank( skillgroupType );
		var elRank = elPartyMember.FindChildInLayoutFile( 'PartyRank' ); 

		                                                                                                                                                    
		
		if ( wins < winsNeededForRank || ( wins >= winsNeededForRank && skillGroup < 1 ) || !PartyListAPI.GetFriendPrimeEligible( xuid ) )
		{
			elRank.visible = false;
			return;
		}

		var imageName = ( skillgroupType !== 'Competitive' ) ? skillgroupType : 'skillgroup';
		elRank.SetImage( 'file://{images}/icons/skillgroups/' + imageName + skillGroup + '.svg' );
		elRank.visible = true;
	};

	var _SetPrimeForMember = function( elPartyMember, xuid )
	{
		var elPrime = elPartyMember.FindChildInLayoutFile( 'PartyPrime' );
		elPrime.visible = PartyListAPI.GetFriendPrimeEligible( xuid );
	};

	var _TintForOverPlayerCountForMode = function ( elPartyMember, isOverCount )
	{
		elPartyMember.SetHasClass( 'friendtile--warning', isOverCount );
	}

	var _SetLobbyTitle = function (  numPlayersPossibleInMode, numPlayersActuallyInParty )
	{
		var elPanel = $( '#PartyList' ).FindChildInLayoutFile( 'PartyListHeader' );
		var isSoloSearch = ( numPlayersActuallyInParty === 1 );

		elPanel.FindChildInLayoutFile( 'PartyCancelBtn' ).visible = LobbyAPI.BIsHost() && _IsSearching();
	
		var elCount = elPanel.FindChildInLayoutFile( 'PartyTitleAlertText' );
		elCount.text = numPlayersActuallyInParty +'/' +numPlayersPossibleInMode;

		                                                                         
		                                                          
	}

	var _SetAttributeStringsOnAvatarPanel = function( elAvatar, xuid )
	{
		elAvatar.SetAttributeString( 'xuid', xuid );
		elAvatar.SetAttributeString( 'showleader', _ShowLobbyLeaderIcon( xuid ) );
	};

	var _ShowLobbyLeaderIcon = function( xuid )
	{
		return LobbyAPI.GetHostSteamID() === xuid ? 'show' : '';
	};

	var _AddOpenPlayerCardAction = function( elPartyMember, xuid )
	{
		var openCard = function( xuid )
		{
			                                                                                             
			$.DispatchEvent( 'SidebarContextMenuActive', true );

			if ( xuid !== 0 )
			{
				var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent(
					'',
					'',
					'file://{resources}/layout/context_menus/context_menu_playercard.xml',
					'xuid=' + xuid,
					function()
					{
						$.DispatchEvent( 'SidebarContextMenuActive', false );
					}
				);
				contextMenuPanel.AddClass( "ContextMenu_NoArrow" );
			}
		};

		elPartyMember.SetPanelEvent( "onactivate", openCard.bind( undefined, xuid ) );
		elPartyMember.SetPanelEvent( "oncontextmenu", openCard.bind( undefined, xuid ) );
	};

	var _ClearExisitingOnActivateEvent = function( elPartyMember )
	{
		elPartyMember.SetPanelEvent( "onactivate", function()
		{

		} );

		var OnMouseOver = function( elPartyMember )
		{
			UiToolkitAPI.ShowTextTooltip( elPartyMember.id, '#tooltip_invite_to_lobby' );
		};

		elPartyMember.SetPanelEvent( "onmouseover", OnMouseOver.bind( undefined, elPartyMember ) );

		elPartyMember.SetPanelEvent( "onmouseout", function()
		{
			UiToolkitAPI.HideTextTooltip();
		} );
	};

	var _SessionUpdate = function( updateType )
	{
		                                                                                                      
		if ( LobbyAPI.IsSessionActive() )
		{
			if ( m_eventRebuildPartyList == undefined )
			{
				m_eventRebuildPartyList = $.RegisterForUnhandledEvent( "PanoramaComponent_PartyList_RebuildPartyList", PartyMenu.RefreshPartyMembers );
			}
		}
		else
		{
			if ( m_eventRebuildPartyList )
			{
				$.UnregisterForUnhandledEvent( "PanoramaComponent_PartyList_RebuildPartyList", m_eventRebuildPartyList );
				m_eventRebuildPartyList = undefined;
			}
		}

		_RefreshPartyMembers();
		_TintBgForSearch();
	};

	var _TintBgForSearch = function()
	{	
		var serverWarning = NewsAPI.GetCurrentActiveAlertForUser();
		var isWarning = serverWarning !== '' && serverWarning !== undefined ? true : false;

		$.GetContextPanel().FindChildInLayoutFile( 'MatchStatusBackground' ).SetHasClass( 'party-list__bg--warning', ( isWarning && _IsSeaching() ) );
		$.GetContextPanel().FindChildInLayoutFile( 'MatchStatusBackground' ).SetHasClass( 'party-list__bg--searching', _IsSeaching() );
		
	};

	var _IsSeaching = function()
	{
		var StatusString = _GetSearchStatus();
		return ( StatusString !== '' && StatusString !== null ) ? true : false;
	};

	var _PlayerActivityVoice = function( xuid )
	{
		var elPartyMembersList = elPartySection.FindChildInLayoutFile( 'PartyMembers' );

		elPartyMembersList.Children().forEach(element => {
			if ( element.Data().xuid === xuid )
			{
				var elAvatar = element.FindChildInLayoutFile( xuid );
				if ( elAvatar )
				{
					Avatar.UpdateTalkingState( elAvatar, xuid );
				}
			}
		});
	};

	                                                                                                    
	var _UpdateLeaveBtn = function ()
	{
		var elLeaveBtn = elPartySection.FindChildInLayoutFile( 'PartyLeaveBtn' );
		elLeaveBtn.visible = ( !GameStateAPI.IsLocalPlayerPlayingMatch() && LobbyAPI.IsSessionActive() );
	};

	var _AddOnActivateLeaveBtn= function ()
	{
		var elLeaveBtn = elPartySection.FindChildInLayoutFile( 'PartyLeaveBtn' );
		elLeaveBtn.SetPanelEvent( 'onactivate', function(){ LobbyAPI.CloseSession(); } );
	};
	
	                                                                                                    
	                          
	                                                                                                    
	var _GetSearchStatus = function()
	{
		return LobbyAPI.GetMatchmakingStatusString();
	};

	var _IsSearching = function()
	{
		var StatusString = _GetSearchStatus();
		return ( StatusString !== '' && StatusString !== null ) ? true : false;
	};

	                                                                                                    

	var _ShowMatchmakingStatusTooltipEvent = function()
	{
		var btnSettings = $.GetContextPanel().FindChildInLayoutFile( 'MatchStatusInfo' );
		btnSettings.SetPanelEvent( 'onmouseover', function()
		{
			UiToolkitAPI.ShowCustomLayoutParametersTooltip( 'MatchStatusInfo',
				'LobbySettingsTooltip',
				'file://{resources}/layout/tooltips/tooltip_lobby_settings.xml',
				'xuid=' + ''
			);
		} );

		btnSettings.SetPanelEvent( 'onmouseout', function() { UiToolkitAPI.HideCustomLayoutTooltip('LobbySettingsTooltip'); } );
	};

	var _IsPartySectionOpen = function()
	{
		return !elPartySection.BHasClass( 'hidden' );
	}

	return {
		Init	: _Init,
		SessionUpdate	: _SessionUpdate,
		RefreshPartyMembers	:_RefreshPartyMembers,
		PlayerActivityVoice: _PlayerActivityVoice,
		IsPartySectionOpen: _IsPartySectionOpen
	};
} )();




                                                                                                    
                                           
                                                                                                    
(function()
{
	PartyMenu.Init();
	$.RegisterForUnhandledEvent( "PanoramaComponent_Lobby_MatchmakingSessionUpdate", PartyMenu.SessionUpdate );
	$.RegisterForUnhandledEvent( "PanoramaComponent_Lobby_PlayerUpdated", PartyMenu.SessionUpdate );
	$.RegisterForUnhandledEvent( "PanoramaComponent_PartyList_PlayerActivityVoice", PartyMenu.PlayerActivityVoice );

})();
