'use strict';


var MainmenuWatchNotice = (function () {

	var _m_cP = $.GetContextPanel();

	var _m_elRoot = $( "#JsWatchNoticePanel" );
	var _m_elWatchNoticeContainer = $( "#id-watchnotice-events-container" );

	var _m_arrEvents = undefined;                          
	var _m_arrFavorites = undefined;
	var _m_prevSchedeventsString = "";
	var _m_isPerfectWorld = MyPersonaAPI.GetLauncherType() === "perfectworld" ? true : false;

	function _Init()
	{
		$.RegisterForUnhandledEvent( 'Tournaments_EventsReceived', _EventsReceived );
		$.RegisterForUnhandledEvent( 'Tournaments_RequestMatch', _RequestMatchString );
		$.RegisterForUnhandledEvent( 'Tournaments_FavoritesReceived', _FavoritesReceived );

		$.RegisterForUnhandledEvent( 'HideContentPanel', _RefreshAll );

		_m_cP.SetHasClass( "hidden", true );

		TournamentsAPI.RequestFavorites();
		TournamentsAPI.RequestTournaments();
	};

	function _StartDateCompareFunction ( a, b )
	{
		return a['start_date_time']['seconds'] - b['start_date_time']['seconds'];
	}
	
	function _RefreshAll ()
	{
		                                  
		TournamentsAPI.RequestFavorites( false                              );
	}

	function _PopulateLister ()
	{
		_m_elWatchNoticeContainer.RemoveAndDeleteChildren();

		_FindNoticeEvents().forEach( event => _PopulateEvent( event ) );
	}

	var openUrl = function ( url )
	{
		SteamOverlayAPI.OpenUrlInOverlayOrExternalBrowser( url ); 
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.sidemenu_select', 'MOUSE' );
	}

	                                            
	function _EventsReceived ( eventsAsString )
	{
		if ( ADD_DEBUG_EVENT == 1 )
			_m_prevSchedeventsString = "";
		
		if ( eventsAsString != _m_prevSchedeventsString )
		{		
			_IngestEvents( eventsAsString );

			_m_prevSchedeventsString = eventsAsString;			
		}

		_PopulateLister();	
	}

	function _FavoritesReceived ( jsonFavorites, jsonFeatured )
	{
		if ( ( jsonFavorites.length > 0 ) )
		{
			_m_arrFavorites = JSON.parse( jsonFavorites );
		}
	}

	                          
	function _IngestEvents ( eventsAsString )
	{
		if ( eventsAsString != undefined && eventsAsString != "" )
		{
			var arrEvents = [];
			var jsonEvents = JSON.parse( eventsAsString );
			arrEvents = EventUtil.AnnotateOfficialEvents( jsonEvents );
			arrEvents.sort( _StartDateCompareFunction );

			if ( _m_isPerfectWorld )
			{
				                                        
				                                      
				_m_arrEvents = arrEvents.filter( o => o.is_official === true );
			}
			else
			{
				_m_arrEvents = arrEvents;
			}
		}
	}
	
	function GetEventMonthString ( oEvent )
	{
		var startTimeUTCSeconds = -1;
		var endTimeUTCSeconds = -1;

		var startDate = new Date( 0 );
		var endDate = new Date( 0 );

		if ( 'start_date_time' in oEvent && 'seconds' in oEvent[ 'start_date_time' ] )
		{
			startTimeUTCSeconds = Number( oEvent[ 'start_date_time' ][ 'seconds' ] );
			startDate.setUTCSeconds( startTimeUTCSeconds );

			if ( 'end_date_time' in oEvent && 'seconds' in oEvent[ 'end_date_time' ] )
			{
				endTimeUTCSeconds = Number( oEvent[ 'end_date_time' ][ 'seconds' ] );
				endDate.setUTCSeconds( endTimeUTCSeconds );
			}

			var monthPaddedNumber = ( '0' + ( startDate.getMonth() + 1 ) ).slice( -2 );
			return $.Localize( '#MonthName' + monthPaddedNumber + '_long' );                      
		}
	}

	                                          
	function _FindNoticeEvents ()
	{
		var retArr = [];

		if ( ADD_DEBUG_EVENT == 1 )
		{
			watchEventLiveExample_01[ 'DEBUG_IGNORE_DATES_FORCE_SHOW' ] = true;
			watchEventLiveExample_02[ 'DEBUG_IGNORE_DATES_FORCE_SHOW' ] = true;
			watchEventLiveExample_03[ 'DEBUG_IGNORE_DATES_FORCE_SHOW' ] = true;

			if ( _m_arrEvents )
			{
				_m_arrEvents.unshift( watchEventLiveExample_01 );
				_m_arrEvents.unshift( watchEventLiveExample_02 );
				_m_arrEvents.unshift( watchEventLiveExample_03 );
			}

			if ( _m_arrFavorites )
			{
				_m_arrFavorites.unshift( Number( watchEventLiveExample_01[ 'event_id' ] ) );
				_m_arrFavorites.unshift( Number( watchEventLiveExample_02[ 'event_id' ] ) );
				_m_arrFavorites.unshift( Number( watchEventLiveExample_03[ 'event_id' ] ) );
			}
		}

		                          
		for ( var idx in _m_arrFavorites )
		{
			for ( var jdx in _m_arrEvents )
			{
				if ( _m_arrEvents[ jdx ][ 'event_id' ] == _m_arrFavorites[ idx ] )
				{
					var oEvent = _m_arrEvents[ jdx ];

					if ( 'live_matches' in oEvent &&
						Object.keys( oEvent[ 'live_matches' ] ).length > 0 )
					{
						retArr.push( oEvent );

						break;
					}
				}
			}
		}

		                                      
		for ( var jdx in _m_arrEvents )
		{
			var oEvent = _m_arrEvents[ jdx ];

			if ( ( oEvent[ 'is_featured' ] || oEvent[ 'is_official' ] ) &&
				( 'live_matches' in oEvent && Object.keys( oEvent[ 'live_matches' ] ).length > 0 ) )
			{
				if ( !retArr.includes( oEvent ) )
				{
					retArr.push( oEvent );
				}
			}
		}

		                                              
		_m_elRoot.SetHasClass( 'hidden', retArr.length == 0 );

		return retArr;

	}

	function _GetEventObject ( eventNumber )
	{
		_m_arrEvents.forEach( o =>
		{
			if ( o[ 'event_id' ] == eventNumber )
			{
				return o;
			}
		} )

		return undefined;

	}

	function _RequestMatchString ( matchId )
	{
		_m_arrEvents.forEach( o =>
		{
			o[ 'live_matches' ].forEach( m =>
			{
				if ( m[ 'match_id' ] == matchId )
				{
					$.DispatchEvent( 'Tournaments_RequestMatch_Response', JSON.stringify( m ) );
					return;
				}
			} )
		} )
		
		return undefined;

	}

	function _OnMouseOverTextTooltip ( _panel, _text  )
	{
		UiToolkitAPI.ShowTextTooltip(
			_panel,
			_text );
	}

	function _OnMouseOutTextTooltip ( __tooltipId )
	{
		UiToolkitAPI.HideTextTooltip();
	}

	                   
	function _PopulateEvent ( oEvent )
	{

		var elEvent = $.CreatePanel( "Panel", _m_elWatchNoticeContainer, oEvent[ 'event_id' ] );
		elEvent.BLoadLayoutSnippet( 'snippet-wn-event', oEvent[ 'event_id' ] );
		                                                                           

		var elCarouselContainer = elEvent.FindChildTraverse( "id-watchnotice__matches-carousel-container" );

		var carouselId = "Match-Carousel--" + oEvent[ 'event_id' ];
		var elCarousel = $.CreatePanel( "Carousel", elCarouselContainer, carouselId, { 'autoscroll-delay':"20s"} );
		elCarousel.AddClass( "watchnotice__matches-carousel" );

		$.CreatePanel( "CarouselNav", elCarouselContainer, "Match-Carousel-Nav--" + oEvent[ 'event_id' ],
			{
			class: 'full-width vertical-center',
			carouselid: carouselId,
			hittest: 'false'
			} );
		
		       
		if ( !( 'logo_url' in oEvent ) );
		{
			var elLogo = elEvent.FindChildTraverse( "id-watchnotice__logo__image" );
			if ( elLogo )
				elLogo.SetImage( oEvent[ 'logo_url' ] );
			
  			                                                                                   
  			                                          
		}
		
		       
		elEvent.SetDialogVariable( 'watchnotice_name', oEvent[ 'name' ] );

		         

		var locReason = "";

		if ( 'is_official' in oEvent && oEvent[ 'is_official'] == true )
		{
			locReason = '#WatchNotice_Reason_Official';

			elEvent.AddClass( 'eventsched-official' );
		}
		else if ( 'is_featured' in oEvent && oEvent[ 'is_featured'] == true )
		{
			locReason = '#WatchNotice_Reason_Community';

			elEvent.AddClass( 'eventsched-featured' );
		}
		else if ( _m_arrFavorites && _m_arrFavorites.includes( Number( oEvent[ 'event_id' ] ) ) )
		{
			locReason = '#WatchNotice_Reason_Personal';
		}
		else
		{
			locReason = '#WatchNotice_Reason_Personal';
		}

		elEvent.SetDialogVariable( 'watchnotice_fave_month', GetEventMonthString( oEvent ) );
		elEvent.SetDialogVariable( 'watchnotice_reason', $.Localize( locReason, elEvent))
		
		      
		if ( 'event_page_url' in oEvent )
		{
			var url = oEvent[ 'event_page_url' ];
			var elLinkBtn = elEvent.FindChildTraverse( "id-watchnotice__link__btn" );

			function OnSimpleContextMenu( url )
			{
				var items = [];
				items.push( { label: $.Localize( '#eventsched_event_link' ), jsCallback: function() {
					StoreAPI.RecordUIEvent( "WatchNoticeSchedEventLink" );
					openUrl( url );
				} } );
			
				UiToolkitAPI.ShowSimpleContextMenu( '', 'externallink', items );
			}

			if ( !_m_isPerfectWorld )
			{
				elLinkBtn.SetPanelEvent( 'onactivate', OnSimpleContextMenu.bind( undefined, url ) );
			}

			                                    
			    
			   	                                                          
			   	                                                                                
			    

			                                                                              
		}

		          
		
		var carouselId = "Match-Carousel--" + oEvent[ 'event_id' ];

		var elMatchContainer = elEvent.FindChildTraverse( carouselId );

		for ( var idx in oEvent[ 'live_matches' ] )
		{
			var oMatch = oEvent[ 'live_matches' ][ idx ];

			var pageId = "watchnotice__matches-page--" + Math.floor( idx / 1 );

			var elMatchPage = elMatchContainer.FindChildTraverse( pageId );
			if ( !elMatchPage )
			{
				elMatchPage = $.CreatePanel( "Panel", elMatchContainer, pageId );
				elMatchPage.AddClass( "watchnotice__matches-page" );
			}

			var elMatch = $.CreatePanel( "Panel", elMatchPage, oMatch[ 'match_id' ] );
			elMatch.BLoadLayoutSnippet( 'snippet-wn-event__match' );

			elMatch.BLoadLayout( 'file://{resources}/layout/watchmatchtile.xml', false, false );
			elMatch.Data().isofficial = oEvent[ 'is_official'];

			function _GetTeam ( num )
			{
				var arrTeams = oEvent[ 'teams' ];

				if ( !arrTeams )
					return undefined;

				{
					for ( var idx in arrTeams )
					{
						var oTeam = arrTeams[ idx ];

						var matchTeamName = num == 1 ? 'team1_name' : 'team2_name';

						if ( oTeam[ 'name' ] == oMatch[ matchTeamName ] )
							return oTeam;
					}
				}

				return undefined;
			}

			watchMatchTile.Init( elMatch, oMatch, _GetTeam( 1 ), _GetTeam( 2 ) );
		}
	}
		


	return {
		Init: _Init,
		GetEventJSO: _GetEventObject,
	};

})();

(function()
{
	MainmenuWatchNotice.Init();
})();