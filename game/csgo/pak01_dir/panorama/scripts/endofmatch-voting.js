'use strict';


var EOM_Voting = (function () {

	var _m_pauseBeforeEnd = 2.0;	
	var _m_cP = $( '#eom-voting' );

                                                     

	var _m_elVoteItemPanels = {};
	var _m_updateJob = undefined;
	var m_randIdx = 0;
	
	function _DisplayMe ()
	{
	  	                                                              
		if (!_m_cP || !_m_cP.IsValid())
			return;

		if ( GameStateAPI.IsDemoOrHltv() )
		{
			return false;
		}

		       
		var oTime = MockAdapter.GetTimeDataJSO();

		if ( !oTime )
		{ 
			return false;
		}

		$.RegisterForUnhandledEvent( 'EndOfMatch_Shutdown', _CancelUpdateJob );
		
		                        
		var oMatchEndVoteData = MockAdapter.NextMatchVotingData( _m_cP );

		$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.submenu_leveloptions_slidein', 'MOUSE' );

		if ( !oMatchEndVoteData || !oMatchEndVoteData[ "voting_options" ] )
		{
			return false;
		}

		var elMapSelectionList = _m_cP.FindChildInLayoutFile( 'id-map-selection-list' );

		                                           
		  

		Object.keys( oMatchEndVoteData[ "voting_options" ] ).forEach( function( key, index ) {

			var type = oMatchEndVoteData[ "voting_options" ][ key ][ "type" ];

			            
			if ( type == "separator" )
			{
			                                                                                                                   
				var elVoteItem = $.CreatePanel( "Panel", elMapSelectionList, "" );
				elVoteItem.AddClass( "vote-item--separator" );
			}
			else
			{
				var text;

				var elVoteItem = $.CreatePanel( "RadioButton", elMapSelectionList, "id-vote-item--" + key );
				elVoteItem.BLoadLayoutSnippet( "MapGroupSelection" );
				elVoteItem.group = "radiogroup_vote";

				elVoteItem.m_key = key;

				if ( type == "skirmish" )
				{
					var skirmishId = oMatchEndVoteData[ "voting_options" ][ key ][ "id" ];

					text = $.Localize( GameTypesAPI.GetSkirmishName( skirmishId ) );

					var cfg = GameTypesAPI.GetConfig();
					if ( cfg )
					{
						var mg = cfg.mapgroups[ 'mg_skirmish_' + GameTypesAPI.GetSkirmishInternalName( skirmishId ) ];
						if ( mg )
						{
							Object.keys( mg.maps ).forEach( function( map, i )
							{
								var elMapImage = $.CreatePanel( 'Panel', elVoteItem.FindChildInLayoutFile( 'MapGroupImagesCarousel' ), 'MapSelectionScreenshot' + i );
								elMapImage.AddClass( 'map-selection-btn__screenshot' );

								var image = 'url("file://{images}/map_icons/screenshots/360p/' + map + '.png")';

								if ( map in cfg.maps )
								{
									elMapImage.style.backgroundImage = image;
									elMapImage.style.backgroundPosition = '50% 0%';
									elMapImage.style.backgroundSize = 'auto 100%';
								}
							} );
						}
					}

					var elMapIcon = elVoteItem.FindChildInLayoutFile( "id-map-selection-btn__modeicon" );

					var modeIcon = "file://{images}/icons/ui/" + GameTypesAPI.GetSkrimishIcon( skirmishId ) + ".svg";
					elMapIcon.SetImage( modeIcon );

					elMapIcon.RemoveClass( 'hidden' );
				}
				else if ( type == "map" )
				{
					var internalName = oMatchEndVoteData[ "voting_options" ][ key ][ "name" ];
					text = GameTypesAPI.GetFriendlyMapName( internalName );

					var image;
					
					var elMapImage = $.CreatePanel( 'Panel', elVoteItem.FindChildInLayoutFile( 'MapGroupImagesCarousel' ), 'MapSelectionScreenshot' );
					elMapImage.AddClass( 'map-selection-btn__screenshot' );
	
					var cfg = GameTypesAPI.GetConfig();
					if ( cfg && ( 'maps' in cfg ) && ( internalName in cfg.maps ))
					{
						image = 'url("file://{images}/map_icons/screenshots/360p/' + internalName + '.png")';			
					}	
					else
					{
						image = 'url("file://{images}/map_icons/screenshots/360p/random.png")';
					}
					
					elMapImage.style.backgroundImage = image;
					elMapImage.style.backgroundPosition = '50% 0%';
					elMapImage.style.backgroundSize = 'auto 100%';		
				}
				else
				{
					  	
				}

				elVoteItem.FindChildTraverse( "MapGroupName" ).text = text;
				elVoteItem.m_name = text;


				                  
				var onActivate = function( element )
				{
					GameInterfaceAPI.ConsoleCommand( "endmatch_votenextmap" + " " + element.m_key );

					                       
					elMapSelectionList.FindChildrenWithClassTraverse( "map-selection-btn" ).forEach( btn => btn.enabled = false );
					$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.submenu_leveloptions_select', 'MOUSE' );

					                                                                 
				};

				elVoteItem.SetPanelEvent( 'onactivate', onActivate.bind( undefined, elVoteItem ) );

				_m_elVoteItemPanels[ index ] = elVoteItem;
			}

		});

		_UpdateVotes();

		_m_cP.SetFocus();

		return true;

	}

	var _UpdateVotes = function() {

		_m_updateJob = undefined;
		        

		if ( !_m_cP || !_m_cP.IsValid() )
			return;
		
		var oMatchEndVoteData = MockAdapter.NextMatchVotingData( _m_cP );

		if ( !oMatchEndVoteData )
		{	
			return;
		}

		var _GetWinningMaps = function() {

			                         
			var arrVoteWinnersKeys = [];

			var highestVote = 0;

			                              
			Object.keys( oMatchEndVoteData[ "voting_options" ] ).forEach( function( key )
			{
				var nVotes = oMatchEndVoteData[ "voting_options" ][ key ][ "votes" ];

				if ( nVotes > highestVote )
					highestVote = nVotes;
			});

			                           
			Object.keys( oMatchEndVoteData[ "voting_options" ] ).forEach( function( key )
			{
				var nVotes = oMatchEndVoteData[ "voting_options" ][ key ][ "votes" ];

				if ( ( nVotes === highestVote ) &&
				( oMatchEndVoteData[ "voting_options" ][ key ][ 'type' ] != 'separator' ) )
				arrVoteWinnersKeys.push( key );
			});
			
			return arrVoteWinnersKeys;
		}

		if ( oMatchEndVoteData )
		{
			                               
			  
			if ( oMatchEndVoteData[ "voting_done" ] == "1" )
			{
				var elMapSelectionList = _m_cP.FindChildInLayoutFile( 'id-map-selection-list' );
				
				                      
				elMapSelectionList.FindChildrenWithClassTraverse( "map-selection-btn" ).forEach( btn => btn.enabled = false );

				var winner = oMatchEndVoteData[ "voting_winner" ];

				                                       

				if ( winner !== -1 )
				{
					var winningIndex;

					Object.keys( _m_elVoteItemPanels ).forEach( function( key )
					{
						if ( _m_elVoteItemPanels[ key ].m_key == winner )
							winningIndex = key;
					} );

					if ( _m_elVoteItemPanels[ winningIndex ] )
					{
						                          
						var elCheckmark = _m_elVoteItemPanels[ winningIndex ].FindChildTraverse( 'id-map-selection-btn__winner' );
						
						if ( !elCheckmark.BHasClass( 'appear' ) )
						{
							elCheckmark.AddClass( "appear" );
							$.DispatchEvent( 'CSGOPlaySoundEffect', 'mainmenu_press_GO', 'MOUSE' );
						}
					}
				}
				else
				{
					var arrWinners = _GetWinningMaps();

					if ( arrWinners.length == 0 )
						return;

					                 
					                                                              

					var randIdx;

					if ( arrWinners.length > 2 )
					{
						randIdx = Math.floor( Math.random() * arrWinners.length );
					}

					                                                        
					if ( randIdx == m_randIdx )
					{
						m_randIdx++;

						                    
						if ( m_randIdx >= arrWinners.length )
						{
							m_randIdx = 0;
						}
					}
					else
					{
						m_randIdx = randIdx;
					}

					var elMapSelectionList = _m_cP.FindChildInLayoutFile( 'id-map-selection-list' );

					var voteidx = arrWinners[ m_randIdx ];

					var elVoteItem = _m_elVoteItemPanels[ voteidx ];

					if ( !elVoteItem || !elVoteItem.IsValid() )
						return;
					
					var panelToHilite = elVoteItem.FindChildTraverse( "id-map-selection-btn__gradient" );
					
					if ( !panelToHilite || !panelToHilite.IsValid() )
						return;
					
					panelToHilite.RemoveClass( "map-selection-btn__gradient--whiteout" );
					panelToHilite.AddClass( "map-selection-btn__gradient--whiteout" );
					$.DispatchEvent('CSGOPlaySoundEffect', 'buymenu_select', elVoteItem.id );
				}
			}
			else
			{
				Object.keys( _m_elVoteItemPanels ).forEach( function( key ) {

					var elVoteItem = _m_elVoteItemPanels[ key ];
					var oVoteOptions = oMatchEndVoteData[ "voting_options" ][ _m_elVoteItemPanels[ key ].m_key ];

					                    
					  
					var elVoteCountLabel = elVoteItem.FindChildTraverse( "id-map-selection-btn__count" );

					var votes = oVoteOptions[ "votes" ];
					var votesNeeded = oMatchEndVoteData[ "votes_to_succeed" ];

					if ( votes > 0 && votes !== elVoteCountLabel.Data().votecount )
					{
						$.DispatchEvent('CSGOPlaySoundEffect', 'tab_settings_settings', elVoteItem.id );
						elVoteCountLabel.Data().votecount = votes;
					}

					elVoteCountLabel.text = "<font color='#ffc130'>" + votes + '</font>/' + votesNeeded;
				});
			}

			_m_updateJob = $.Schedule( 0.2, _UpdateVotes );
		}

	}


                                                         
                                                                      
  
  

	function _Start()  
	{
		if ( MockAdapter.GetMockData() && !MockAdapter.GetMockData().includes( 'VOTING' ) )
		{
			_End();
			return;
		}

		if ( _DisplayMe() )
		{
			EndOfMatch.SwitchToPanel( 'eom-voting' );
		}
		else
		{
			_End();
		}	
	}


	function _End() 
	{
		_CancelUpdateJob();
		
		EndOfMatch.ShowNextPanel();
	}

	function _CancelUpdateJob ()
	{
		if ( _m_updateJob != undefined )
		{
			$.CancelScheduled( _m_updateJob );
			_m_updateJob = undefined;
		}

	}


                      
return {
    name: 'eom-voting',
	Start: _Start,
	
};


})();


                                                                                                    
                                           
                                                                                                    
(function () {

	EndOfMatch.RegisterPanelObject( EOM_Voting );


})();
