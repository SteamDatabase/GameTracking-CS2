'use strict';

var mainmenu_watch = ( function()
{

	var _m_bPerfectWorld = ( MyPersonaAPI.GetLauncherType() === 'perfectworld' );
	var _m_activeTab;
	var _m_contextTab;                                                                                                               
	var _m_tabStack = [];
	var _m_contextPanel;
	var _m_myXuid = MyPersonaAPI.GetXuid();
	var MATCHLISTDESCRIPTOR = {
		"JsLive": "live",
		"JsYourMatches": _m_myXuid,
		"JsDownloaded": "downloaded"
	};
	var MATCHLISTTABBYNAME = {
		"live": "JsLive",
		                                                                
		"downloaded": "JsDownloaded"
	};
	MATCHLISTTABBYNAME[ _m_myXuid ] = "JsYourMatches";


	                                                                                                                                                                     
	          
	                                                                                                                                                                     

	function _PopulateStreamList ( parentPanel )
	{

		                           
		var streamNum = StreamsAPI.GetStreamCount();
		var count = 9;
		if ( streamNum < 9 )
		{
			count = streamNum;
		}

		var elStreamList = parentPanel.FindChildTraverse( "JsStreamList" );

		for ( var i = 0; i < elStreamList.GetChildCount(); i++ )
		{
			elStreamList.GetChild( i ).markForDelete = true;
		}

		if ( count === 0 )
		{
			matchList.ShowListSpinner( false, parentPanel );
			matchList.SetListMessage( $.Localize( "#CSGO_Watch_NoSteams" ), true, parentPanel );
			matchList.ShowInfoPanel( false, parentPanel );
		}
		else
		{
			matchList.SetListMessage( "", false, parentPanel );
			matchList.ShowInfoPanel( true, parentPanel );
		}

		function _SendToTwitch ( streamId )
		{
			var url = StreamsAPI.GetStreamVideoFeedByName( streamId );
			SteamOverlayAPI.OpenExternalBrowserURL( url );
		}

		function _ClearList ( elListPanel )
		{
			var activeTiles = elListPanel.Children();
			for ( var i = activeTiles.length - 1; i >= 0; i-- )
			{
				if ( activeTiles[ i ].markForDelete )
				{
					if ( elListPanel.activeButton === activeTiles[ i ] )
					{
						elListPanel.activeButton = undefined;
					}
					activeTiles[ i ].checked = false;
					watchTile.Delete( activeTiles[ i ] );
				}
			}
		}

		for ( var i = 0; i < count; i++ )
		{
			var streamName = StreamsAPI.GetStreamNameByIndex( i );
			var elStreamPanel = elStreamList.FindChildInLayoutFile( "TwitchStream_" + streamName );
			if ( elStreamPanel == undefined )
			{
				var elStreamPanel = $.CreatePanel( 'Button', elStreamList, "TwitchStream_" + streamName );
				var streamCountry = StreamsAPI.GetStreamCountryByName( streamName );
				elStreamPanel.BLoadLayout( "file://{resources}/layout/matchtiles/streams.xml", false, false );
				var elStreamText = elStreamPanel.FindChildTraverse( 'Text-Panel' );

				elStreamPanel.FindChildInLayoutFile( 'stream-button__blur-target' ).AddBlurPanel( elStreamText );

				                        
				elStreamPanel.SetDialogVariable( 'streamText', StreamsAPI.GetStreamTextDescriptionByName( streamName ) );
				elStreamPanel.SetDialogVariable( "numberOfViewers", StreamsAPI.GetStreamViewersByName( streamName ) );
				elStreamPanel.SetDialogVariable( "channel", StreamsAPI.GetStreamDisplayNameByName( streamName ) );

				elStreamPanel.FindChildTraverse( "TwitchThumb" ).SetImage( StreamsAPI.GetStreamPreviewImageByName( streamName ) );
				CommonUtil.SetLanguageOnLabel( streamCountry, elStreamPanel );


				elStreamPanel.SetPanelEvent( 'onactivate', _SendToTwitch.bind( undefined, streamName ) );
			}
			elStreamPanel.markForDelete = false;
		}

		_ClearList( parentPanel.FindChildTraverse( "JsStreamList" ) );
	}

	                                                                                                                                                                     
	              
	                                                                                                                                                                     

	function _OnMouseOverTextTooltip ( _panel, _text )
	{
		UiToolkitAPI.ShowTextTooltip(
			_panel,
			_text );
	}

	function _OnMouseOutTextTooltip ( __tooltipId )
	{
		UiToolkitAPI.HideTextTooltip();
	}

	function _PopulateTournamentPage ( parentPanel )
	{

		var elTournamentList = parentPanel.FindChildTraverse( "JsTournamentList" );

		if ( !elTournamentList.FindChildTraverse( "other-tournaments" ) )
		{

			                                  
			elTournamentList.BLoadLayout( "file://{resources}/layout/matchtiles/tournament_page.xml", false, false );
			var pastTournamentPanel = elTournamentList.FindChildTraverse( "other-tournaments" );

			                                                                                                                      
			                                                           
			      

			                                                                             
			var maxTournaments = g_ActiveTournamentInfo.eventid;
			      

			for ( let i = maxTournaments; i >= 1; i-- )
			{
				if ( i == 2 ) continue;             
				if ( i == 17 ) continue;            
				                                         
				let elTournamentPanel = $.CreatePanel( 'Panel', pastTournamentPanel, "Tournament_" + i );
				             
				elTournamentPanel.BLoadLayoutSnippet( "tournament_tile" );
				elTournamentPanel.SetDialogVariable( 'tournament-title', $.Localize( '#CSGO_Tournament_Event_Location_' + i ));

				let elTOLogo = elTournamentPanel.FindChildTraverse( 'id-tournament-to-logo' );
				elTOLogo.SetImage( 'file://{images}/tournaments/events/tournament_logo_' + i + '.svg' );

  				                                                                                 
  				                                                                                          

				            
				let ProEventJSO = TournamentsAPI.GetProEventDataJSO( i, 8);

				let oWinningTeam;
				let hasEventData = false;

				if ( ProEventJSO
					&& ProEventJSO.hasOwnProperty( 'eventdata' )
					&& ProEventJSO[ 'eventdata' ].hasOwnProperty( i ))
				{
					oWinningTeam = ProEventJSO[ 'eventdata' ][ i ][ 0 ];
					hasEventData = true;
				}

				let elChampions = elTournamentPanel.FindChildTraverse( 'JsChampions' );
				_SetTeam( elChampions, oWinningTeam, i, false );

				let elLegendsContainer = elTournamentPanel.FindChildTraverse( 'JsLegendsContainer' );

				let elPlayerRoot = elTournamentPanel.FindChildTraverse( "JsPlayersContainer" );

				let elHoverPanel = elTournamentPanel.FindChildTraverse( 'JsChampionsHoverTarget' );
				_PopulateTeamPlayers( elPlayerRoot, elHoverPanel, elLegendsContainer, oWinningTeam, i );

				          
				for ( let iTeam = 1; iTeam < 8; iTeam++ )
				{

					let oTeam;
					if ( hasEventData &&
						ProEventJSO[ 'eventdata' ][ i ].hasOwnProperty( iTeam ) &&
						ProEventJSO[ 'eventdata' ][ i ][ iTeam ] )
					{
						oTeam = ProEventJSO[ 'eventdata' ][ i ][ iTeam ];
					}

					let elLegend = $.CreatePanel( 'Panel', elLegendsContainer, iTeam );
					elLegend.BLoadLayoutSnippet( "snippet-tournament-legends" );

					_SetTeam( elLegend, oTeam, i );

				}
				
				var elModel = elTournamentPanel.FindChildTraverse( 'ParticleModel' );
				if ( elModel )
				{
					elModel.SetCameraPosition( -10, 0, 0.00 );
					elModel.SetCameraAngles( 0.00, 0.00, 0.00 );
					elModel.SetParticleSystemOffsetPosition( 0.0, 0.0, 0.0 );

					elModel.AddParticleSystem( 'ui_panel_liveambient', '', true );
					  			                      
				}

				let elButton = elTournamentPanel.FindChild( 'JsTournamentContent' );
				elButton.SetPanelEvent( 'onactivate', _NavigateToTab.bind( undefined, 'JsMainMenuSubContent_Tournament' + i, 'mainmenu_watch_tournament', 'tournament:' + i, true, true ) );
				

				var image = 'url("file://{images}/tournaments/events/bg_' + i +'.png")';
				elButton.style.backgroundImage = image;
				elButton.style.backgroundPosition = '50% 50%';
				elButton.style.backgroundSize = 'auto 110%';
				elButton.style.backgroundImgOpacity = '.7';
	  			                                                                                                                       
	  			                                                                                                                      
			}
		}


		function _SetTeam ( elTeam, oTeamData, uniqueIdentifier, bTooltip = true )
		{
			let elTeamLogo = elTeam.FindChildTraverse( 'JsTeamLogo' );

			let teamName = $.Localize( "#CSGO_PickEm_Team_TBD" );
			let teamPlaceStr = "";

			if ( oTeamData )
			{
				let team = oTeamData[ 'team_id' ];
				let teamTag = oTeamData[ 'tag' ];
				let teamGeo = oTeamData[ 'geo' ];
				let teamPlaceToken = oTeamData[ 'place_token' ];

				let teamLogo = 'file://{images}/tournaments/teams/' + teamTag.toLowerCase() + '.svg';
				teamName = $.Localize( '#CSGO_TeamID_' + team );
				teamPlaceStr = $.Localize( teamPlaceToken );

				elTeamLogo.SetImage( teamLogo );

				if ( bTooltip )
				{
					let TooltipString = $.Localize( teamName );
					let elTooltipAnchor = $.CreatePanel( "Panel", elTeam, uniqueIdentifier + "_" + elTeam.id, { style: "	tooltip-position: bottom;" } )
					  				                                                                                                                    
					  				                                                             
				}
			}

			elTeam.SetDialogVariable( "team-place", teamPlaceStr );
			elTeam.SetDialogVariable( "team-name", teamName );
		}

		function _PopulateTeamPlayers ( elPlayerContainer, elHoverPanel, elLegendsContainer, oTeamData, eventid )
		{
			if ( !oTeamData )
				return;
			
			          
			                  
			let arrIndices = [ 0, 1, 2, 3, 4 ];
			for ( var i = 0; i < 5; i++ )
			{
				var n = arrIndices.splice( Math.floor( Math.random() * 5 ), 1 )[ 0 ];
				arrIndices.push( n );
			}

			let arrTeamPlayers = Object.entries( oTeamData[ 'players' ] );

			arrIndices.forEach( function ( i )
			{
				let oPlayer = arrTeamPlayers[ i ][ 1 ];                                                    
				let elPlayer = $.CreatePanel( 'Panel', elPlayerContainer, 'JsPlayerCard' );
				elPlayer.BLoadLayoutSnippet( 'snippet-tournament-player' );

				              
				elPlayer.SetDialogVariable( 'tournament-player-name', oPlayer[ 'name' ] );

				              
				let elPlayerImage = elPlayer.FindChildTraverse( 'JsTournamentPlayerPhoto' );
				if ( elPlayerImage )
				{
					let photo_url = "file://{images}/tournaments/avatars/" + eventid + "/" + oPlayer[ 'accountid64' ] + ".png";
					elPlayerImage.SetImage( photo_url );
				}
			} );

			elHoverPanel.AddClass( "has-team-data" );
			elHoverPanel.SetPanelEvent( 'onmouseover', function ( elPlayerContainer, elLegendsContainer ) { _RevealPlayers( elPlayerContainer, elLegendsContainer ) }.bind( this, elPlayerContainer, elLegendsContainer ) );
			elHoverPanel.SetPanelEvent( 'onmouseout', function ( elPlayerContainer, elLegendsContainer ) { _HidePlayers( elPlayerContainer, elLegendsContainer ) }.bind( this, elPlayerContainer, elLegendsContainer ) );

			function _RevealPlayers ( elPlayerContainer, elLegendsContainer )
			{
				let arrElPlayers = elPlayerContainer.Children();

				elLegendsContainer.AddClass( 'hidden' );

				const DELAY_INIT = 0;
				const DELAY_DELTA = 0.1;

				arrElPlayers.forEach( function ( elPlayer, i )
				{
					let delay = DELAY_INIT + i * DELAY_DELTA;
					Scheduler.Schedule( delay, () =>
					{
						if ( elPlayer && elPlayer.IsValid() )
							elPlayer.RemoveClass( 'hidden' );
						
						                                            
						Scheduler.Schedule( 0.1, function ()
						{
							$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.mainmenu_rollover', 'MOUSE' );
						}, "player-reveal" );

					}, "player-reveal");

				});
			}

			function _HidePlayers ( elPlayerContainer, elLegendsContainer )
			{
				elLegendsContainer.RemoveClass( 'hidden' );

				let arrElPlayers = elPlayerContainer.Children();

				Scheduler.Cancel( "player-reveal" );
				
				arrElPlayers.forEach( function ( elPlayer )
				{
					elPlayer.AddClass( 'hidden' );
				} );
			}
		}
	}

	                                                                                                                                                                     
	                           
	                                                                                                                                                                     

	function _UpdateTab ( elTab, optbFromMatchListChangeEvent )
	{
		elTab.SetReadyForDisplay( true );
		elTab.visible = true;

		switch ( elTab.id )
		{
			case "JsTournaments":
				_PopulateTournamentPage( elTab );
				break;
			                             
			   	                                                                                                      
			   	      
			case "JsYourMatches":
			case "JsDownloaded":
			case "JsLive":
				matchList.UpdateMatchList( elTab, MATCHLISTDESCRIPTOR[ elTab.id ], optbFromMatchListChangeEvent );
				break;
			case "JsEvents":
				TournamentsAPI.RequestTournaments();
				break;
		}

		                                   
		                                   
		 
			                                                                 
			                                                                         

			                                                                        
			 
				                                               
				                                         
				                                             
				                                      
			 
			                                                                          
			 
				                                    

				                          
				 
					                                          
					                                                                     
					       
				 
				
				                                                  
			 
			       
		   

	}

	function _UpdateActiveTab ()
	{
		if ( _m_activeTab )
		{
			if ( _m_activeTab.id === 'JsActiveTournament' )
			{
				$.DispatchEvent( 'RefreshPickemPage', 'tournament:' + g_ActiveTournamentInfo.eventid );
				return;
			}

			_UpdateTab( _m_activeTab );
		}
	}

	function _UpdateMatchList ( listId, optbFromMatchListChangeEvent )
	{
		                                                  
		var tabbyid = MATCHLISTTABBYNAME[ listId ];
		if ( tabbyid )
		{
			                                                          
			_UpdateTab( $( "#" + tabbyid ), optbFromMatchListChangeEvent );
		}
	}
	function _UpdateMatchListFromMatchListChangeEvent ( listId )
	{
		_UpdateMatchList( listId, true );
	}

	function _NavigateToTab ( tab, xmlName, tournament_id = undefined, isSubTab = false, addToStack = false )
	{
		                               

		StoreAPI.RecordUIEvent( "WatchMenuTab_" + tab );

		                                                                                                                   

		                         
		if ( isSubTab && addToStack )
		{
			                                                                                 
			if ( _m_tabStack.length > 0 )
			{
				_m_tabStack[ _m_tabStack.length - 1 ].AddClass( "mainmenu-content--hidden" );
			}
			else
			{
				if ( !_m_contextPanel )
				{
					_m_contextPanel = $( "#main-content" );
				}
				if ( _m_contextPanel )
				{
					_m_contextPanel.AddClass( "mainmenu-content--hidden" );
				}
			}
		}

		                                                       
		var parent = $.GetContextPanel().FindChildInLayoutFile( tab );
		if ( isSubTab && !parent )
		{
			                              
			var newPanel = undefined;

			parent = $.CreatePanel( 'Panel', $( '#JsWatchContent' ), tab );
			parent.AddClass( "mainmenu-content--popuptab" );
			parent.AddClass( "mainmenu-content--hidden" );
			parent.AddClass( "mainmenu-content__container" );
			parent.AddClass( "no-margin" );
			parent.AddClass( 'hide' );
			newPanel = $.CreatePanel( 'Panel', parent, "tournament_content_" + tournament_id );
			newPanel.Data().elMainMenuRoot = $.GetContextPanel().Data().elMainMenuRoot;
			parent.RemoveClass( 'hide' );
			parent.RemoveClass( 'mainmenu-content--hidden' );
			parent.tournament_id = tournament_id;

			newPanel.BLoadLayout( 'file://{resources}/layout/' + xmlName + '.xml', false, false );
			newPanel.RegisterForReadyEvents( true );
			parent.isSubTab = true;

			                                                                          
			                                                       
			_InitResourceManagement( newPanel );
			$.DispatchEvent( 'InitializeTournamentsPage', newPanel, tournament_id );
		}

		var pressedTab = $( '#' + tab );

		if ( _m_activeTab != pressedTab )
		{
			if ( !isSubTab ) 
			{
				if ( _m_activeTab )
				{
					if ( !_m_activeTab.isSubTab )
					{
						_m_activeTab.AddClass( 'WatchMenu--Hide' );
					}
					else
					{
						_m_activeTab.AddClass( 'mainmenu-content--hidden' );
					}
				}

				_m_activeTab = pressedTab;
				_m_contextTab = pressedTab;
				if ( !_m_contextPanel )
				{
					_m_contextPanel = $( "#main-content" );
				}
				if ( _m_contextPanel )
				{
					_m_contextPanel.RemoveClass( "mainmenu-content--hidden" );
				}

				if ( !_m_activeTab )
				{
					                                                 
					return;
				}
				_m_activeTab.RemoveClass( 'WatchMenu--Hide' );
			}
			else
			{
				if ( !addToStack ) _m_activeTab.AddClass( 'mainmenu-content--hidden' );
				_m_activeTab = pressedTab;
				_m_activeTab.SetFocus();

				if ( !_m_activeTab )
				{
					                                                 
					return;
				}
				_m_activeTab.RemoveClass( 'mainmenu-content--hidden' );
				if ( _m_activeTab.tournament_id )
				{
					matchList.ReselectActiveTile( _m_activeTab );
				}
				if ( addToStack ) _m_tabStack.push( _m_activeTab );
			}
		}

		                                                                      
		_UpdateTab( _m_activeTab );
	}

	function _CloseSubMenuContent () 
	{
		if ( ( !_m_tabStack ) || ( _m_tabStack.length == 0 ) || ( !_m_tabStack[ _m_tabStack.length - 1 ].visible ) )
		{
			return false;
		}
		_m_tabStack.pop();
		                                                               
		if ( _m_tabStack.length >= 1 )
		{
			_NavigateToTab( _m_tabStack[ _m_tabStack.length - 1 ].id, undefined, true, false );
		}
		                                                                         
		else
		{
			_NavigateToTab( _m_contextTab.id );
		}
		return true;
	}

	function _InitResourceManagement ( elTab )
	{
		elTab.OnPropertyTransitionEndEvent = function( panelName, propertyName )
		{
			if ( elTab.id === panelName && propertyName === 'opacity' )
			{
				                                         
				if ( elTab.visible === true && elTab.BIsTransparent() )
				{
					                                               
					elTab.visible = false;
					elTab.SetReadyForDisplay( false );
					return true;
				}
			}

			return false;
		}

		$.RegisterEventHandler( 'PropertyTransitionEnd', elTab, elTab.OnPropertyTransitionEndEvent );
		elTab.Data().elMainMenuRoot = $.GetContextPanel().Data().elMainMenuRoot;
	}

	function _InitTab ( tab )
	{
		var elTab = $( '#' + tab );
		if ( !elTab.BLoadLayoutSnippet( "MatchListAndInfo" ) )
		{
			                                                                                                                                        
		}

		_InitResourceManagement( elTab );
	}



	                                                                                                                                                                     
	                     
	                                                                                                                                                                     

	function _InitMainWatchPanel ()
	{
		_m_activeTab = undefined;
		_m_contextPanel = $( "#main-content" );
		$.RegisterForUnhandledEvent( "PanoramaComponent_MatchList_StateChange", _UpdateMatchListFromMatchListChangeEvent );
		$.RegisterForUnhandledEvent( "CloseSubMenuContent", _CloseSubMenuContent );
		$.RegisterForUnhandledEvent( "NavigateToTab", _NavigateToTab );
		_InitTab( 'JsYourMatches' );
		_InitTab( 'JsDownloaded' )
		_InitTab( 'JsLive' );
		_InitResourceManagement( $( '#JsTournaments' ) );

		$.GetContextPanel().Data().elMainMenuRoot;

		                                             
		if ( _m_bPerfectWorld )
		{
			var elWatchNavBarButtonStreams = $( '#WatchNavBarButtonStreams' );
			if ( elWatchNavBarButtonStreams )
				elWatchNavBarButtonStreams.DeleteAsync( .0 );

			var elWatchNavBarButtonStreams = $( '#WatchNavBarButtonEvents' );
			if ( elWatchNavBarButtonStreams )
				elWatchNavBarButtonStreams.DeleteAsync( .0 );
		}
		else
		{
			_InitResourceManagement( $( '#JsEvents' ) );
		}

		var restrictions = LicenseUtil.GetCurrentLicenseRestrictions();
		if ( restrictions === false )
		{
			                                                                                       
			if ( false )
			{
				_InitResourceManagement( $( '#JsActiveTournament' ) );
				_NavigateToTab( 'JsActiveTournament' );
				$( '#WatchNavBarActiveTourament' ).checked = true;

				return;
			}
		}


		                                                                                  
		_NavigateToTab( 'JsYourMatches' );
		$( '#WatchNavBarYourMatches' ).checked = true;

		                                                                            
		                                
		                                                  
	}

	var _RunEveryTimeWatchIsShown = function()
	{
		                                                                                               
		                                                                                             
		                               

		if ( !MyPersonaAPI.IsInventoryValid() || !MyPersonaAPI.IsConnectedToGC() )
		{
			                                       
			UiToolkitAPI.ShowGenericPopupOk(
				$.Localize( '#SFUI_SteamConnectionErrorTitle' ),
				$.Localize( '#SFUI_Steam_Error_LinkUnexpected' ),
				'',
				function()
				{
					$.DispatchEvent( 'HideContentPanel' );
				},
				function()
				{
				}
			);
		}
	};

	var _OnReadyForDisplay = function()
	{
	};

	var _ShowActiveTournamentPage = function( idOfTab = '' )
	{
		while ( _CloseSubMenuContent() )
			continue;                                                                  

		                                   
		_NavigateToTab( 'JsTournaments' );
		$( '#WatchNavBarButtonTournaments' ).checked = true;

		                                                          
		var i = g_ActiveTournamentInfo.eventid;                    
		_NavigateToTab( 'JsMainMenuSubContent_Tournament' + i, 'mainmenu_watch_tournament', 'tournament:' + i, true, true );

		                                                            
		var elTournamentActive = _m_activeTab;                                                                              
		if ( idOfTab && elTournamentActive )
		{
			var elTabToActivate = elTournamentActive.FindChildTraverse( 'content-navbar__tabs' );
			if ( elTabToActivate )
			{
				elTabToActivate = elTabToActivate.FindChildInLayoutFile( idOfTab );
			}
			
			if ( elTabToActivate )
			{
				                                                                       
				$.DispatchEvent( "Activated", elTabToActivate, "mouse" );
			}
			else
			{
				                                                                      
			}
		}
	}


	                      
	return {
		NavigateToTab: _NavigateToTab,                        
		UpdateActiveTab: _UpdateActiveTab,
		                                               
		InitMainWatchPanel: _InitMainWatchPanel,
		CloseSubMenuContent: _CloseSubMenuContent,
		OnReadyForDisplay: _OnReadyForDisplay,
		ShowActiveTournamentPage: _ShowActiveTournamentPage
	};

} )();

                                                                                                    
                                           
                                                                                                    
( function()
{
	$.RegisterEventHandler( 'Cancelled', $( '#JsWatch' ), mainmenu_watch.CloseSubMenuContent );
	$.RegisterEventHandler( 'ReadyForDisplay', $( '#JsWatch' ), mainmenu_watch.OnReadyForDisplay );
	$.RegisterForUnhandledEvent( 'ShowActiveTournamentPage', mainmenu_watch.ShowActiveTournamentPage );
} )();


	      
	                                                                           
	  
	                              
	  
	                
	                                                 
