"use strict";

var friendsList = (function() {

	var _m_activeTabIndex = 0;
	var _m_tabs = [];
	var _m_isPerfectWorld = MyPersonaAPI.GetLauncherType() === "perfectworld" ? true : false;
	var m_activeSection = 'id-friendslist-section-friends';
	var m_Sections = $.GetContextPanel().FindChildInLayoutFile( 'id-friendslist-accordian' );
	var _m_sLobbiesTabListFiltersString = GameInterfaceAPI.GetSettingString( 'ui_nearbylobbies_filter' );
	var _m_schfnUpdateAntiAddiction = null;
	var _m_ClosedSectionHeight = Math.floor( $.GetContextPanel().FindChildInLayoutFile( 'id-friendslist-section-recent' ).desiredlayoutheight / $.GetContextPanel().actualuiscale_x );
	var _Init = function()
	{
		                               

		var btnLobbiesTabListFilters = $( '#JsFriendsList-lobbies-toolbar-button-' + _m_sLobbiesTabListFiltersString );
		AdvertisingToggle.OnFilterPressed( _m_sLobbiesTabListFiltersString );
		if ( btnLobbiesTabListFilters )
		{	                                                                         
			btnLobbiesTabListFilters.checked = true;

			                                                                
			var elParent = btnLobbiesTabListFilters.GetParent();
			elParent.Children().forEach( child =>
			{
				var gameMode = child.GetAttributeString( 'data-type', '' )
				if ( gameMode !== '' )
				{
					child.visible = PartyListAPI.IsPlayerForHireAdvertisingEnabledForGameMode( gameMode ) ;
				}
			} );
		}

		_UpdateBroadcastIcon();
	};

	var _UpdateBroadcastIcon = function()
	{
		var adSetting = AdvertisingToggle.GetAdvertisingSetting();
		_ActiveFilterOnTab( adSetting );
		
		$.GetContextPanel().FindChildInLayoutFile( 'id-friendslist-section-broadcast-icon' ).SetHasClass(
			'advertising-active',
			adSetting !== ""
		);
	}

	var _UpdateAntiAddiction = function()
	{
		var elAAGroup = $.GetContextPanel().FindChildInLayoutFile( 'AntiAddiction' );
		var numSec = _m_isPerfectWorld ? MyPersonaAPI.GetAntiAddictionTimeRemaining() : -1;
		if ( numSec < 0 )
		{
			elAAGroup.AddClass( 'hidden' );
			return false;
		}

		elAAGroup.RemoveClass( 'hidden' );
		var szSeverity = 'Green';
		if ( numSec <= 300 )                  
			szSeverity = 'Red';
		else if ( numSec <= 1800 )                   
			szSeverity = 'Yellow';

		var elAAIcon = elAAGroup.FindChildInLayoutFile( 'AntiAddictionIcon' );
		elAAIcon.SetHasClass( 'anti-addiction-Green', 'Green' === szSeverity );
		elAAIcon.SetHasClass( 'anti-addiction-Yellow', 'Yellow' === szSeverity );
		elAAIcon.SetHasClass( 'anti-addiction-Red', 'Red' === szSeverity );

		                                                                                                 
		var strTimeRemainingSentence = ( numSec >= 60 )
			? FormatText.SecondsToSignificantTimeString(numSec)
			: $.Localize('#AntiAddiction_Label_TimeRemainingNone');
		elAAGroup.SetDialogVariable( 'aatime', strTimeRemainingSentence );

		var szLocalizedTooltip = $.Localize( ( (numSec >= 60)
			? '#UI_AntiAddiction_Tooltip_GameTime'
			: '#UI_AntiAddiction_Tooltip_GameTimeNone' ), elAAGroup);
		elAAGroup.SetPanelEvent( "onmouseover", function()
		{
			UiToolkitAPI.ShowTextTooltip( 'AntiAddiction', szLocalizedTooltip );
		} );

		if ( _m_schfnUpdateAntiAddiction )
			$.CancelScheduled( _m_schfnUpdateAntiAddiction );
		
		_m_schfnUpdateAntiAddiction = $.Schedule( 30, _UpdateAntiAddictionTimer );
	}

	var _UpdateAntiAddictionTimer = function()
	{
		_m_schfnUpdateAntiAddiction = null;
		_UpdateAntiAddiction();
	}

	                                                               
	   	                                
	   	 
	   		                                                                                             
	   		                                                    
			
	   		                   
	   			                                                                                      
	   				   
	   				   
	   				                                                                       
	   				             
	   				             
	   					                                                   
	   				 
	   			  
	   			                                                   
	   		         
	   	 

	   	                                                                        
	     

	var _UpdateIncomingInvitesContainer = function()
	{
		var elInviteRoot = $.GetContextPanel().FindChildInLayoutFile( 'JsIncomingInvites' );
		elInviteRoot.AddClass( 'hidden' );

		var elInviteContainer = elInviteRoot.FindChildInLayoutFile( 'JsIncomingInviteContainer' );
		elInviteContainer.RemoveAndDeleteChildren();
		
		var numInvites = PartyBrowserAPI.GetInvitesCount();
		if ( numInvites > 0 )
		{	                                             
			var xuid = PartyBrowserAPI.GetInviteXuidByIndex( 0 );
			_AddTile( elInviteContainer, null, xuid, 0, 'friendlobby', null );
			elInviteRoot.RemoveClass( 'hidden' );
		}

		_UpdateHeightOpenSection();

		                                                         
		                                                                                      
		                                                                                            
		
		                                                     

		                         
		    
		   	                                 
		   	                                            
		   	                           
		   	       
		    

		                                       
		                                               
		                            

		                                        
		    
		   	                                                     
		   	                             
		    

		                                                                 

		                                                     
		    
		   	                              
		   	                                                         
		   	                                            
			
		   	             
		   		                                                                  
		   	    
		   		                                                                                   
		    

		                                              
	}

                                                                               
                                                                               
                                                                               
	var _OnSectionPressed = function( sectionId )
	{
		if ( !sectionId )
		{
			return;
		}

		if ( m_activeSection !== sectionId )
		{
			m_activeSection = sectionId;
		}

		_UpdateSection( sectionId, false );
	}

	var _UpdateAllSections = function()
	{
		_UpdateSection( '', true );
	}

	var _UpdateSection = function( sectionId, bUpdateAll )
	{
		                                                                
		
		                                    
		if ( _m_ClosedSectionHeight === 0 || _m_ClosedSectionHeight === undefined)
		{
			_m_ClosedSectionHeight = Math.floor( $.GetContextPanel().FindChildInLayoutFile( 'id-friendslist-section-recent' ).desiredlayoutheight / $.GetContextPanel().actualuiscale_x );
			                                                           
		};

		var funcGetXuid;

		if ( sectionId === 'id-friendslist-section-friends' || bUpdateAll )
		{
			funcGetXuid = _GetXuidByIndex;
			_UpdateSectionContent( {
				id: 'id-friendslist-section-friends',
				count: _GetFriendsCount(),
				xml: 'friendtile',
				xuid_func: funcGetXuid,
				no_data_String: '#FriendsList_nodata_friends'
			} );
		}
		
		if ( sectionId === 'id-friendslist-section-recent' || bUpdateAll )
		{
			funcGetXuid = _GetRecentXuidByIndex;
			_UpdateSectionContent( {
				id: 'id-friendslist-section-recent',
				count: _GetRecentsCount(),
				xml: 'friendtile',
				xuid_func: funcGetXuid,
				type: 'recent',
				no_data_String: '#FriendsList_nodata_recents',
				show_loading_bar_only: _ShowRecentsLoadingBar(),
				loading_bar_id: 'JsFriendsListRecentsLoadingBar'
			} );
		}
		
		if ( sectionId === 'id-friendslist-section-invite' || bUpdateAll )
		{
			funcGetXuid = _GetRequestsXuidByIndex;
			_UpdateSectionContent( {
				id: 'id-friendslist-section-invite',
				count: _GetRequestsCount(),
				alerts_count: _GetRequestsAlertCount(),
				xml: 'friendtile',
				xuid_func: funcGetXuid,
				no_data_String: '#FriendsList_nodata_requests',
				hide_if_empty: true
			});
		}
		
		if ( sectionId === 'id-friendslist-section-broadcast' || bUpdateAll )
		{
			_UpdateLobbiesLoadingBar();
			funcGetXuid = _GetLobbyXuidByIndex;
			
			_UpdateSectionContent( {
				id: 'id-friendslist-section-broadcast',
				count: _GetLobbiesCount(),
				xml: 'friend_advertise_tile',
				xuid_func: funcGetXuid,
				no_data_String: '#FriendsList_nodata_advertising'
			} );
		}
	}

	var _UpdateSectionContent = function( oSettings )
	{
		var elSection = m_Sections.FindChildInLayoutFile( oSettings.id );
		var count = oSettings.hasOwnProperty( 'alerts_count' ) ? oSettings.alerts_count : oSettings.count;

		_ShowHideCounter( elSection, count );
		                                                               

		if( oSettings.hasOwnProperty( 'hide_if_empty' ) && oSettings.hide_if_empty === true && count < 1 )
		{
			elSection.SetHasClass( 'hidden', true );
			return;
		}

		elSection.SetHasClass( 'hidden', false );

		if ( oSettings.hasOwnProperty( 'show_loading_bar_only' ) && oSettings.show_loading_bar_only )
		{
			return;
		}

		                                                              
		if ( m_activeSection === oSettings.id )
		{
			var elNodata = elSection.FindChildInLayoutFile( 'id-friendslist-nodata' );
			var elList = elSection.FindChildInLayoutFile( 'id-friendslist-section-list-contents' );
			
			if ( oSettings.count && oSettings.count > 0 )
			{
				elNodata.visible = false;
				elList.visible = true;
				
				_MakeOrUpdateTiles( elList, oSettings );
				_SetSectionHeight( oSettings.id );

				return;
			}

			elNodata.SetDialogVariable( 'no_data_title', $.Localize( oSettings.no_data_String + '_title') );
			elNodata.SetDialogVariable( 'no_data_body', $.Localize( oSettings.no_data_String ));
			elNodata.visible = true;
			elList.visible = false;

			_SetSectionHeight( oSettings.id );
		}
	}

	var _GetAddtionalSectionHeight = function( idSection)
	{
		var elPanel = $.GetContextPanel().FindChildInLayoutFile( idSection );
		return elPanel.BHasClass( 'hidden' ) ? 0 :
			Math.floor( elPanel.desiredlayoutheight / m_Sections.actualuiscale_x );
	};

	var _SetSectionHeight = function( sectionId )
	{
		var aSectionsToClose = m_Sections.Children().filter( element => element.id !== m_activeSection && !element.BHasClass( 'hidden'));
		
		aSectionsToClose.forEach( element =>
		{
			var elList = element.FindChildInLayoutFile( 'id-friendslist-section-list' );
			elList.style.height = '0px;'
		});

		var closedSectionsHeight = _m_ClosedSectionHeight * ( aSectionsToClose.length + 1 );

		var basicHeight = Math.floor( ( $.GetContextPanel().desiredlayoutheight / $.GetContextPanel().actualuiscale_x ) ) -
			( closedSectionsHeight + _GetAddtionalSectionHeight( 'PartyList' ) + _GetAddtionalSectionHeight( 'JsIncomingInvites' ) );
		
		m_Sections.FindChildInLayoutFile( sectionId ).FindChildInLayoutFile( 'id-friendslist-section-list' ).style.height = basicHeight + "px;";
	}

	var _ShowHideCounter = function( elSection, count )
	{
		if ( !count )
		{
			elSection.SetHasClass( 'hide-notification', true );
			return;
		}
		
		elSection.SetDialogVariable( 'alert_value', count );
		elSection.SetHasClass( 'hide-notification', false );
	}

	var _MakeOrUpdateTiles = function ( elList, oSettings )
	{
		var xuidsFromUpdate = [];

		for( var i = 0; i < oSettings.count; i++ )
		{
			var xuid = oSettings.xuid_func( i );
			xuidsFromUpdate.push( xuid );
		}

		_DeleteTilesNotInUpdate( elList, xuidsFromUpdate );

		for ( var i = 0; i < xuidsFromUpdate.length; i++ )
		{
			var xuid = xuidsFromUpdate[i];
			var elTile = elList.FindChildTraverse( xuid );
			var children = elList.Children();
			
			if( !elTile )
				_AddTile( elList, children, xuid, i, oSettings.xml, oSettings.type );
			else
				_UpdateTilePosition( elList, children, elTile, xuid, i,  oSettings.xml );
		}
	};

	var _DeleteTilesNotInUpdate = function( elList , xuidsFromUpdate )
	{
		var children = elList.Children();
		var sectionChildrenCount = children.length;
		
		                                                                    
		                                 
		for ( var i = 0; i < sectionChildrenCount; i++ )
		{
			if ( xuidsFromUpdate.indexOf( children[ i ].id ) < 0 )
				children[ i ].DeleteAsync(0);
		}
	};

	var _AddTile = function( elList, children, xuid, index, tileXmlToUse, type )
	{
		var elTile = $.CreatePanel( "Panel", elList, xuid );
		elTile.SetAttributeString( 'xuid', xuid );
		elTile.BLoadLayout( 'file://{resources}/layout/' + tileXmlToUse + '.xml', false, false );

		if ( type )
		{
			elTile.Data().type = type;
		}

		if ( tileXmlToUse )
		{
			elTile.Data().tileXmlToUse = tileXmlToUse;
		}

		if( children && children[index + 1] )
			elList.MoveChildBefore( elTile, children[index + 1] );
		
		_AddTransitionEndEventHandler( elTile );
		_InitTile( elTile, tileXmlToUse );

		return elTile;
	};

	var _UpdateTilePosition = function( elList, children, elTile, xuid, index, tileXmlToUse )
	{
		if( children[index] )
			elList.MoveChildBefore( elTile, children[index] );
		
		_InitTile( elTile, tileXmlToUse );
	};

	var _InitTile = function ( elTile, tileXmlToUse )
	{
		                                                                        
		                                           
		                                    
		                          
		if ( tileXmlToUse === "friendtile" )
		{
			friendTile.Init( elTile );
		}
		else if ( tileXmlToUse === "friendlobby" )
		{
			elTile.SetAttributeString( 'showinpopup', 'false' );
			friendLobby.Init( elTile );
		}
		else
		{
			FriendAdvertiseTile.Init( elTile );
		}
		elTile.RemoveClass( 'hidden' );
	};

	var _AddTransitionEndEventHandler =  function ( elTile )
	{
		                                                                          
		elTile.OnPropertyTransitionEndEvent = function( panelName, propertyName )
		{
			if( elTile.id === panelName && propertyName === 'opacity' )
			{
				                                         
				if( elTile.visible === true && elTile.BIsTransparent() )
				{
					elTile.DeleteAsync( .0 );
					                                                                       
					return true;
				}
			}
			return false;
		};
		
		$.RegisterEventHandler( 'PropertyTransitionEnd', elTile, elTile.OnPropertyTransitionEndEvent );
	};

                                                                               
                                                                               
                                                                               
	var _ShowRecentsLoadingBar = function()
	{
		var elBarOuter = $( '#JsFriendsListRecentsLoadingBar' ),
		elBarInner = $( '#JsFriendsListRecentsLoadingBarInner' );
		
		if( TeammatesAPI.GetSecondsAgoFinished() < 0 )
		{
			if( elBarOuter.BHasClass( 'hidden' ))
				elBarOuter.RemoveClass( 'hidden' );

			elBarInner.AddClass( 'loadingbar-indeterminate' );
			return true;
		}	
		else
		{
			elBarInner.RemoveClass( 'loadingbar-indeterminate' );
			elBarOuter.AddClass( 'hidden' );
			
			return false;
		}
	};

	var _UpdateLobbiesLoadingBar = function()
	{
		var progress = PartyBrowserAPI.GetProgress();

		var elBarOuter = $( '#JsFriendsListLobbyLoadingBar' ),
			elBarInner = $( '#JsFriendsListLobbyLoadingBarInner' );
		
		                                                    

		if( progress > 1 && progress < 100 )
		{
			if( elBarOuter.BHasClass( 'hidden' ))
				elBarOuter.RemoveClass( 'hidden' );

			elBarInner.style.width = progress +'%';
			return true;
		}
		else
		{
			elBarOuter.AddClass( 'hidden' );
			return false;
		}
	};

	var _UpdateHeightOpenSection = function()
	{
		_UpdateSection( m_activeSection, false );
	}

	                                                                               
	                                                                               
	                                                                               
	var _SetLobbiesTabListFilters = function( sFilterString )
	{
		_m_sLobbiesTabListFiltersString = sFilterString;
		AdvertisingToggle.OnFilterPressed( sFilterString );

		var adSetting = AdvertisingToggle.GetAdvertisingSetting();
		_ActiveFilterOnTab( adSetting );

		_RefreshLobbyListings();
	};

	var _ActiveFilterOnTab = function( adSetting )
	{
		var aBtns = $.GetContextPanel().FindChildInLayoutFile( 'JsFriendsListSettingsBtns' ).Children();

		aBtns.forEach( btn =>
		{
			btn.SetHasClass( 'toggle-active', ( ( btn.GetAttributeString( 'data-type', '' ) === adSetting ) && adSetting !== '' ) );
		} );
		
	};

	var _RefreshLobbyListings = function ()
	{
		m_Sections.FindChildInLayoutFile( 'id-friendslist-section-broadcast' ).FindChildInLayoutFile( 'id-friendslist-section-list-contents' ).ScrollToTop();
		GameInterfaceAPI.SetSettingString( 'ui_nearbylobbies_filter', _m_sLobbiesTabListFiltersString );
		PartyBrowserAPI.SetSearchFilter( _m_sLobbiesTabListFiltersString, "" );
		PartyBrowserAPI.Refresh();
	};

                                                                               
                                                                               
                                                                               
	var _SidebarContextMenuActive = function ( isSidebarContextMenuActive )
	{
		                                                     
		if( isSidebarContextMenuActive )
			_OnSideBarHover ( !isSidebarContextMenuActive );
		else
			_OnSideBarHover ( isSidebarContextMenuActive );
	};

	var _OnSideBarHover = function ( isCollapsed )
	{
		if ( !isCollapsed )
		{
			for( var i = 0; i < _m_tabs.length; i++ )
			{
				_m_tabs[i].elTabRadioBtn.RemoveClass( 'hidden' );
			}
		}
		else 
		{
			for( var i = 0; i < _m_tabs.length; i++ )
			{
				if( i !== _m_activeTabIndex )
					_m_tabs[i].elTabRadioBtn.AddClass( 'hidden' );
				else
					_m_tabs[i].elTabRadioBtn.RemoveClass( 'hidden' );
			}
		}
	};

	var _OnGcHello = function()
	{
		_UpdateAllSections();
		_UpdateHeightOpenSection();
	};

	var _FriendsListNameChanged = function ( xuid )
	{
		  
		       
		                                                 
		  

		var elSection = m_Sections.FindChildInLayoutFile( m_activeSection );
		if ( !elSection ) return;

		var elList = elSection.FindChildInLayoutFile( 'id-friendslist-section-list-contents' );
		if ( !elList ) return;

		var elTile = elList.FindChildTraverse( xuid );
		if ( !elTile ) return;

		_InitTile( elTile, elTile.Data().tileXmlToUse );
	};

	var _OnAddFriend = function ()
	{
		UiToolkitAPI.ShowCustomLayoutPopup('', 'file://{resources}/layout/popups/popup_add_friend.xml');
	};

	var _OpenLobbyFaq = function ()
	{
		var link = _m_isPerfectWorld ?
				"http://blog.counter-strike.net/index.php/nearby-lobby-faq/" :
				"http://blog.counter-strike.net/index.php/steam-group-lobbies/";

		SteamOverlayAPI.OpenURL( link ); 
	};

	var _SetInvitedTile = function ( xuid )
	{
		                                                     
		if ( _m_activeTabIndex === 3 || _m_activeTabIndex === 0 )
		{		
			var tile = _m_tabs[ _m_activeTabIndex ].elList.FindChild( xuid );
			if ( tile )
			{
				friendTile.SetInvitedFromContextMenu( tile );
			}
		}
	};

	                                                                               
	                                                                               
	                                                                               
	var _GetFriendsCount = function()
	{
		                                                             
		return FriendsListAPI.GetCount();
	};

	var _GetRequestsCount = function()
	{
		                                                                            
		return FriendsListAPI.GetFriendRequestsCount();
	};

	var _GetRecentsCount = function()
	{
		                                                           
		TeammatesAPI.Refresh();
		var count = TeammatesAPI.GetCount();

		if( count )
			return count;
	};

	var _GetLobbiesCount = function()
	{
		                                                                  
		var count = PartyBrowserAPI.GetResultsCount();

		if( count )
			return count;
	};

	var _GetRequestsAlertCount = function()
	{
		return FriendsListAPI.GetFriendRequestsNotificationNumber();
	};

	var _GetXuidByIndex = function( index )
	{
		return FriendsListAPI.GetXuidByIndex( index );
	};

	var _GetRequestsXuidByIndex = function( index )
	{
		return FriendsListAPI.GetFriendRequestsXuidByIdx( index );
	};

	var _GetRecentXuidByIndex = function( index )
	{
		return TeammatesAPI.GetXuidByIndex( index );
	}

	var _GetLobbyXuidByIndex = function( index )
	{
		return PartyBrowserAPI.GetXuidByIndex( index );
	};

	var _ShowMatchAcceptPopUp = function( map, location, ping )
	{
		var popup = UiToolkitAPI.ShowGlobalCustomLayoutPopupParameters(
			'',
			'file://{resources}/layout/popups/popup_accept_match.xml',
			'map_and_isreconnect=' + map + ',false' + ( ( location && ping ) ? '&ping='+ping+'&location='+location : '' ),
			'dim'
			);
	};

	                      
	return {
		Init						: _Init,
		SetLobbiesTabListFilters	: _SetLobbiesTabListFilters,
		UpdateIncomingInvitesContainer : _UpdateIncomingInvitesContainer,
		FriendsListNameChanged		: _FriendsListNameChanged,
		RefreshLobbyListings		: _RefreshLobbyListings,
		OpenLobbyFaq				: _OpenLobbyFaq,
		OnSideBarHover				: _OnSideBarHover,
		OnAddFriend					: _OnAddFriend,
		SidebarContextMenuActive	: _SidebarContextMenuActive,
		SetInvitedTile				: _SetInvitedTile,
		OnSectionPressed			: _OnSectionPressed,
		UpdateAllSections			: _UpdateAllSections,
		UpdateSection				: _UpdateSection,
		OnGcHello					: _OnGcHello,
		UpdateBroadcastIcon: _UpdateBroadcastIcon,
		ShowMatchAcceptPopUp: _ShowMatchAcceptPopUp,
		UpdateHeightOpenSection: _UpdateHeightOpenSection,
	};
})();

                                                                                                    
                                           
                                                                                                    
(function()
{
	friendsList.Init();
	$.RegisterForUnhandledEvent( 'PanoramaComponent_GC_Hello', friendsList.OnGcHello );
	$.RegisterForUnhandledEvent( "PanoramaComponent_FriendsList_RebuildFriendsList", friendsList.UpdateSection.bind( undefined,'id-friendslist-section-friends', false ));
	$.RegisterForUnhandledEvent( 'PanoramaComponent_Teammates_Refresh', friendsList.UpdateSection.bind( undefined,'id-friendslist-section-recent', false ) );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_PartyBrowser_Refresh', friendsList.UpdateSection.bind( undefined,'id-friendslist-section-broadcast', false ) );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_FriendsList_NameChanged', friendsList.FriendsListNameChanged );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_PartyBrowser_InviteConsumed', friendsList.UpdateIncomingInvitesContainer );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_PartyBrowser_InviteReceived', friendsList.UpdateIncomingInvitesContainer );
	$.RegisterForUnhandledEvent( 'SidebarIsCollapsed', friendsList.OnSideBarHover );
	$.RegisterForUnhandledEvent( 'SidebarContextMenuActive', friendsList.SidebarContextMenuActive );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_PartyBrowser_LocalPlayerForHireAdvertisingChanged', friendsList.UpdateBroadcastIcon );
	                                                                                             
	                                                                                                
	$.RegisterForUnhandledEvent( "ServerReserved", friendsList.ShowMatchAcceptPopUp );
})();


  
                                                                  
                                                                                 
	 
                      
 
	                                         
	                                           
	 
		                                             

		                         
		                                 
		                                           
	 
   

		                           

		              
		   	 
		   		                                         
		   		                                                                        
		   		                                            
		   		                           
		   		                                 
		   		                                
		   		                           
		   		                                          
		   	  

		   	 
		   		                                          
		   		                                                                         
		   		                                             
		   		                            
		   		                                       
		   		                                        
		   		                           
		   		                                           
		   	  

		   	 
		   		                                         
		   		                                                                        
		   		                                            
		   		                           
		   		                                 
		   		                                      
		   		                           
		   		                                           
		   		              
		   	  

		   	 
		   		                                         
		   		                                                                        
		   		                                            
		   		                           
		   		                                 
		   		                                     
		   		                                      
		   		                                              
		   	 
		     

		                               
		                         

		                                     

		                                                                                                                  
		                                  
		    	                                                                         
		   	                                        

		   	                                                                
		   	                                                    
		   	                                       
		   		                                                            
		   			       
				
		   		                                                        
		   		                                        
		   			       
				
		   		                                                      
		   		                                                                                 
		   			                      
		   	    
		    
	   	                        	                                       
	    
	   	           
	   	       
		
	   	                                  

	   	                                                                                

	   	                       

	   	              
	   	 
	   		       
	   	 

	   	                                                                                  
	   	                                            
	   	                                                                       
	   	                                                                               

	   	                                                                                                   

	   	                                                       
	   	                                                                                        
	    

	                                                  
	    
	   	                                   
	   	              
	   	                                                                     
		
	   	                                                 
	   		                                 

	   	            
	   	 
	   		                             
	   		       
	   	 

	   	                                

	   	                                                           
	   	                     
	     

	                   
	                                               
	    
	   	                                                                             
		
	   	                                    
	   		                                                            

	   	                     
	   	                                                                        
	   	                                                                             

	   	                             
	   	                                                      

	   	                     
	   	 
	   		                        
	   	 

	   	                           
	   	                                  
	     

	                               
	                                         
	    
	   	                             
	   		                         
		
	   	                    
	     

	                                          
	    
	   	                    
	   	                           
	     

	                                         
	    
	   	                    
	   	                           
	     

	                                         
	    	
	   	                    
	   	                           
	     

	                                                                                                        
	                                                            
	    
	   	                                                
	   	                                                                                                
	   	                        
	     

	                                          
	    
	   	                                  
	   	                                                                       
	   	                          
	     

	                                            
	    	
	   	                                  
	   	                               

	   	                                                                 
	   	                    
	   	 
	   		                           
	   	 

	   	                                              
	   	            
	   	 
	   		                                  
	   		       
	   	 

	   	                                                                
	   	                                                        
	   	                    
	   	 
	   		                              
	   			       
	   	 

	   	                                      
	   	                                                 
	   	                                                                 
	   	               
	   		                              

	   	                                     
	     

	                                                    
	    
	   	                            
	   	                                 

	   	                                                      
		
		                
		    
		   	                                                                
		   	                                      

		   	                                     
		   	                                                             

			        
			                                                                                   
			                               

			                                              
			   		                                           
			       
			   	                                                       
			    
			   	                                                                      
				
			   	                       
			   	 
			   		                                           
			   	 
			   	                                                                                      
			   	 
			   		                                           
			   		 
			   			                           
			   					                                                              
			   					                                                        
						
			   			                                                   
			   		 
			   		    
			   		 
			   			                                  
			   			                           
			   				                                                                
			   				                                                          
						
			   			                                           
			   		 

			   		                            
			   		 
			   			                                    
			   		 

			   		                                                
			   		                     
			   	 
			    
			       
			      

	   		                      
			
	   		                                                                                              
	   		                                                                                  
	   		                               
	   	 
	     