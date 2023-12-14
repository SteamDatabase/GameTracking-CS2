'use strict';

var SettingsMenuChatwheel = ( function() {

	                                                                                             
	var m_options = [
		
		{ text: "#Chatwheel_section_prepare", title: 1 },
		{ text: "#Chatwheel_requestecoround", radio: "CW.EcoRound", icon: "icons/ui/chatwheel_requestecoround.svg"  },
		{ text: "#Chatwheel_requestspend", radio: "CW.SpendRound", icon: "icons/ui/chatwheel_requestspend.svg"  },
		{ text: "#Chatwheel_requestweapon", radio: "CW.NeedDrop", icon: "icons/ui/chatwheel_requestweapon.svg"  },
		{ text: "#Chatwheel_requestplan", radio: "CW.NeedPlan", icon: "icons/ui/chatwheel_requestplan.svg"  },
		
		{ text: "#Chatwheel_section_move", title: 1 },
		{ text: "#Chatwheel_gogogo", radio: "CW.GoGoGo", icon: "icons/ui/chatwheel_gogogo.svg" }, 
		{ text: "#Chatwheel_onmyway", radio: "CW.OMW", icon: "icons/ui/chatwheel_onmyway.svg"  },      
		{ text: "#Chatwheel_followme", radio: "CW.FollowMe", icon: "icons/ui/chatwheel_followme.svg"  },
		{ text: "#Chatwheel_followingyou", radio: "CW.FollowingYou", icon: "icons/ui/chatwheel_followyou.svg"  }, 
		{ text: "#Chatwheel_aplan", radio: "CW.GoA", icon: "icons/ui/map_bombzone_a.svg"  },
		{ text: "#Chatwheel_bplan", radio: "CW.GoB", icon: "icons/ui/map_bombzone_b.svg"  },
		{ text: "#Chatwheel_midplan", radio: "CW.GoToLocMid", icon: "icons/ui/chatwheel_midplan.svg"  },
		
		{ text: "#Chatwheel_section_command", title: 1 },  
		{ text: "#Chatwheel_rotatetome", radio: "CW.Regroup", icon: "icons/ui/chatwheel_rotatetome.svg"  },
		{ text: "#Chatwheel_sticktogether", radio: "CW.StickTogether", icon: "icons/ui/chatwheel_sticktogether.svg"  },
		{ text: "#Chatwheel_spreadout", radio: "CW.SpreadOut", icon: "icons/ui/chatwheel_spreadout.svg" },
		{ text: "#Chatwheel_fallback", radio: "CW.TeamFallBack", icon: "icons/ui/chatwheel_fallback.svg" },
		{ text: "#Chatwheel_holdposition", radio: "CW.HoldPosition", icon: "icons/ui/chatwheel_holdposition.svg"  },
		{ text: "#Chatwheel_gethostage", radio: "CW.CheckHostage", icon: "icons/ui/chatwheel_gethostage.svg" },
		
		{ text: "#Chatwheel_section_report", title: 1 }, 
		{ text: "#Chatwheel_heardnoise", radio: "CW.HeardNoise", icon: "icons/ui/chatwheel_heardnoise.svg"  }, 
		{ text: "#Chatwheel_enemyspotted", radio: "CW.SeesEnemy", icon: "icons/ui/chatwheel_enemyspotted.svg"  },
		{ text: "#Chatwheel_oneenemyhere", radio: "CW.SeesSingleEnemy", icon: "icons/ui/chatwheel_oneenemyhere.svg"  },
		{ text: "#Chatwheel_multipleenemieshere", radio: "CW.SeesEnemiesMultiple", icon: "icons/ui/chatwheel_multipleenemieshere.svg"  },
		{ text: "#Chatwheel_needbackup", radio: "CW.NeedBackup", icon: "icons/ui/chatwheel_needbackup.svg"  }, 
		{ text: "#Chatwheel_sniperspotted", radio: "CW.SniperWarning", icon: "icons/ui/chatwheel_sniperspotted.svg"  },
		{ text: "#Chatwheel_bombcarrierspotted", radio: "CW.BombCarrierHere", icon: "icons/ui/chatwheel_bombcarrierspotted.svg"  },
		{ text: "#Chatwheel_inposition", radio: "CW.InPosition", icon: "icons/ui/chatwheel_inposition.svg"  },
		{ text: "#Chatwheel_coveringyou", radio: "CW.CoveringYou", icon: "icons/ui/chatwheel_covering.svg"  },      
		{ text: "#Chatwheel_sectorclear", radio: "CW.SectorClear", icon: "icons/ui/chatwheel_sectorclear.svg"  },
		
		{ text: "#Chatwheel_section_bomb", title: 1 },
		{ text: "#Chatwheel_ifixbomb", radio: "CW.IFixBomb", icon: "icons/ui/chatwheel_ifixbomb.svg"  },      
		{ text: "#Chatwheel_youfixbomb", radio: "CW.YouFixBomb", icon: "icons/ui/chatwheel_youfixbomb.svg"  },      
		{ text: "#Chatwheel_droppedbomb", radio: "CW.DroppedBomb", icon: "icons/ui/chatwheel_droppedbomb.svg"  },
		{ text: "#Chatwheel_guardingbomb", radio: "CW.GuardingDroppedBomb", icon: "icons/ui/chatwheel_guardingbomb.svg"  },
		{ text: "#Chatwheel_bombat", radio: "CW.BombAt", icon: "icons/ui/chatwheel_bombat.svg"  },      
		{ text: "#Chatwheel_ihavethebomb", radio: "CW.WeHaveTheBomb", icon: "icons/ui/chatwheel_ihavethebomb.svg"  },
		
		{ text: "#Chatwheel_section_responses", title: 1 },
		{ text: "#Chatwheel_affirmative", radio: "CW.Agree", icon: "icons/ui/chatwheel_affirmative.svg"  },
		{ text: "#Chatwheel_negative", radio: "CW.Disagree", icon: "icons/ui/chatwheel_negative.svg"  },
		{ text: "#Chatwheel_compliment", radio: "CW.Compliment", icon: "icons/ui/chatwheel_compliment.svg"  },
		{ text: "#Chatwheel_thanks", radio: "CW.Thanks", icon: "icons/ui/chatwheel_thanks.svg"  },
		{ text: "#Chatwheel_cheer", radio: "CW.Cheer", icon: "icons/ui/chatwheel_cheer.svg"  }, 
		{ text: "#Chatwheel_peptalk", radio: "CW.PepTalk", icon: "icons/ui/chatwheel_peptalk.svg"  }, 
		{ text: "#Chatwheel_sorry", radio: "CW.Sorry", icon: "icons/ui/chatwheel_sorry.svg"  },

		{ text: "#Chatwheel_section_grenades", title: 1 },
		{ text: "#Chatwheel_decoy", radio: "CW.NeedDecoy", icon: "icons/ui/chatwheel_decoy.svg"  },
		{ text: "#Chatwheel_smoke", radio: "CW.NeedSmoke", icon: "icons/ui/chatwheel_smoke.svg"  },
		{ text: "#Chatwheel_grenade", radio: "CW.NeedGrenade", icon: "icons/ui/chatwheel_grenade.svg"  },
		{ text: "#Chatwheel_fire", radio: "CW.NeedFire", icon: "icons/ui/chatwheel_fire.svg"  },
		{ text: "#Chatwheel_flashbang", radio: "CW.NeedFlash", icon: "icons/ui/chatwheel_flashbang.svg"  },
		
	];
	
	      
	                                                                                                 
	                     
		                                                           
		                                                            
		                                                               
		                                                                     
		                                                                   
		                                                            
		                                                                          

		                                                          
		                                                                      
		                                                                      
		                                                                       
		                                                                     
		                                                                     

		                                                       
		                                                           
		                                                           
		                                                               
		                                                       
		                                                            
		                                                                
		
	      
	
	        		
	                     
		                                                  
		                                                                     
		                                                           
		                                                            
		                                                              
		                                                                
		                                                         

		                                                     
		                                                                  
		                                                                 
		                                                                
		                                                              
		                                                   
		                                                   
		                                                            

		
		                                                      
		                                                         
		                                                         
		                                                             
		                                                       
		                                                             

		
		                                                    
		                                                                   
		                                                            

		                                                  
		                                                                          
		                                                                     
		                                                                 
		                                                                    

		                                                         
		                                                                     
		                                                                            
		                                                                      
		                                                                                 

		                                                       
		                                                           
		                                                           
		                                                               
		                                                       
		                                                     
		
	      	

	var m_panelList = [];

	var m_chatwheelName = "0";

	var _ClickChatwheelPanel = function()
	{
		_ClearHighlights();
	};

	var _ActivateChatwheel = function( chatwheelNumber )
	{
		_ClearHighlights();
		m_chatwheelName = chatwheelNumber;

		_PopulateSegments();
	};

	var m_activeSegment = -1;

	var _ActivateSegment = function( segmentNumber )
	{
		m_activeSegment = segmentNumber;

		for(var i = 0; i < 8; ++i) {
			if(i != segmentNumber) {
				$( "#radio-segment-" + i ).RemoveClass( 'RadialRadioSettingsSegment--selected' );
			}
		}

		$( "#radio-segment-" + segmentNumber ).AddClass( 'RadialRadioSettingsSegment--selected' );

		$( '#chatwheel-settings-list' ).FindChildrenWithClassTraverse( 'RadialRadioSettingsSingleOptionPanel' ).forEach( el => el.AddClass( 'RadialRadioSettingsSingleOptionPanel--highlight' ) );
	};

	var _ClearHighlights = function()
	{
		$( '#chatwheel-settings-list' ).FindChildrenWithClassTraverse( 'RadialRadioSettingsSingleOptionPanel' ).forEach( el => el.RemoveClass( 'RadialRadioSettingsSingleOptionPanel--highlight' ) );
		m_activeSegment = -1;

		for(var i = 0; i < 8; ++i) {
			$( "#radio-segment-" + i ).RemoveClass( 'RadialRadioSettingsSegment--selected' );
		}
	};

	var _PopulateSegments = function()
	{
		for( var i = 0; i < 8; ++i ) {
			var elPanel = $( '#radio-segment-' + i );
			var elLabel = elPanel.FindChildTraverse( 'segment-label' );
			var strText =  GameInterfaceAPI.GetSettingString( 'cl_radial_radio_tab_' + m_chatwheelName + '_text_' + (i+1) );
			elLabel.text = $.Localize( strText );

			var elIcon = elPanel.FindChildTraverse( 'segment-icon' );

			for( var j = 0; j < m_options.length; ++j )
			{
				if( m_options[j].text == strText )
				{

					if( m_options[j].icon )
					{
						elIcon.SetImage( "file://{images}/" + m_options[j].icon );
					}
					else
					{
						elIcon.SetImage( "" );
					}

				}
			}

		}
	};

	var _PopulateSettingsList = function()
	{

		var elOptionsList = $( '#chatwheel-settings-list' );
		for( var i = 0; i < m_options.length; ++i )
		{
			var strOption = m_options[ i ].text;
			var strRadio = m_options[ i ].radio;
			var strIcon = m_options[ i ].icon;

			var elPanel;

			if( m_options[ i ].title )
			{
				elPanel = $.CreatePanel( "Panel", elOptionsList, "chatwheel-option-" + i );
				elPanel.BLoadLayoutSnippet( "ChatWheelHeadingPanel" );
			}
			else
			{
				elPanel = $.CreatePanel( "Button", elOptionsList, "chatwheel-option-" + i );
				elPanel.BLoadLayoutSnippet( "ChatWheelOptionPanel" );

				elPanel.SetPanelEvent( 'onactivate', function( num, text, radio )
				{
					if ( m_activeSegment != -1 )
					{
						var elSegment = $( "#radio-segment-" + m_activeSegment );
						elSegment.RemoveClass( 'RadialRadioSettingsSegment--selected' );
						elSegment.FindChildTraverse( 'segment-label' ).text = $.Localize( text );

						var elIcon = elSegment.FindChildTraverse( 'segment-icon' );

						for( var j = 0; j < m_options.length; ++j )
						{
							if( m_options[j].text == text )
							{
								if( m_options[j].icon )
								{
									elIcon.SetImage( "file://{images}/" + m_options[j].icon );
								}
								else
								{
									elIcon.SetImage( "" );
								}
							}
						}

						GameInterfaceAPI.SetSettingString( 'cl_radial_radio_tab_' + m_chatwheelName + '_text_' + (m_activeSegment+1), text );
						GameInterfaceAPI.ConsoleCommand( 'host_writeconfig' );
					}

					m_activeSegment = -1;
					_ClearHighlights();
				}.bind( undefined, i, strOption, strRadio ) );
			}

			var elLabel = elPanel.FindChildTraverse( 'chat-wheel-option-label' );
			elLabel.text = $.Localize( strOption );

			if ( strIcon )
			{
				var elImage = elPanel.FindChildTraverse( 'chat-wheel-option-icon' );
				elImage.SetImage("file://{images}/" + strIcon);
			}

			var searchEntry = {
				panel: elPanel,
				text: $.Localize( strOption ).toLowerCase(),
			};

			m_panelList.push( searchEntry );
		}
	};

	var _SearchChanged = function()
	{
		var text = $( '#RadialRadioSettingsSearchText' ).text.toLowerCase();
		for ( var i = 0; i < m_panelList.length; ++i )
		{
			var found = ( m_panelList[ i ].text.indexOf( text ) != -1 );
			m_panelList[ i ].panel.visible = found;
		}
	};

	       
	_PopulateSegments();
	_PopulateSettingsList();

	return {
		ActivateSegment: _ActivateSegment,
		ActivateChatwheel: _ActivateChatwheel,
		ClickChatwheelPanel: _ClickChatwheelPanel,
		SearchChanged: _SearchChanged,
	};
} )();
