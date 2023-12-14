'use strict';

var PopupPermissionsSettings = ( function(){

	var m_clanList = [];
	var m_bPerfectWorld = ( MyPersonaAPI.GetLauncherType() === 'perfectworld' );
	var m_nWasAdvertising = 0;
	
	var _Init = function ()
	{
		$( '#PermissionsSettingsGroupsBlock' ).visible = !m_bPerfectWorld;
		_SyncDialogsFromSessionSettings( LobbyAPI.GetSessionSettings() );
	}

	var _SyncDialogsFromSessionSettings = function ( settings )
	{
		if ( !LobbyAPI.IsSessionActive() )
		{
			                                                                      
			                                                              
			$.DispatchEvent( 'UIPopupButtonClicked', '' );
			return;
		}
		                       
		                                                                                   
		                                                                               

		$('#JsPopUpPermissionsPrivate').checked = settings.system.access === "private" 
		$('#JsPopUpPermissionsPublic').checked = settings.system.access === "public";

		$('#JsPopUpPermissionsPrivate').SetPanelEvent( 'onactivate', function(){ _ShowPublicExtraSettings(); });
		$('#JsPopUpPermissionsPublic').SetPanelEvent( 'onactivate', function(){ _ShowPublicExtraSettings(); });

		var elDropdown = $('#JsPopUpPermissionsGroupsDropdown');
		var elDropdownCheckbox = $('#JsPopUpPermissionsGroupsDropdownEnabled');

		var clanCount = MyPersonaAPI.GetMyClanCount();
		var bClanDropDownSupport = ( clanCount > 0 ) ? true : (  settings.game.clanid ? true : false );                                                                   
		elDropdown.enabled = bClanDropDownSupport;
		elDropdownCheckbox.enabled = bClanDropDownSupport;

		if( bClanDropDownSupport )
		{
			var bFoundLobbyCurrentClanID = false;

			for( var i = 0; i < clanCount; i++ )
			{
				var clan = {};
				var id = MyPersonaAPI.GetMyClanIdByIndex( i );
				var newEntry = $.CreatePanel( 'Label', elDropdown, id, {
					class: 'DropDownMenu'
				});

				if	( settings.game.clanid && ( id === settings.game.clanid ) )
				{
					bFoundLobbyCurrentClanID = true;
				}

				newEntry.text = MyPersonaAPI.GetMyClanTagById( id );
				elDropdown.AddOption(newEntry);
				                                                               
			}

			if ( !bFoundLobbyCurrentClanID && settings.game.clanid )
			{
				var newEntry = $.CreatePanel( 'Label', elDropdown, settings.game.clanid, {
					class: 'DropDownMenu'
				});

				newEntry.text = PartyListAPI.GetPartyClanTag();
				elDropdown.AddOption(newEntry);
				                                                                    
			}

			if( settings.game.clanid )
			{
				elDropdown.SetSelected( settings.game.clanid );
				elDropdownCheckbox.checked = true;
			}
			else
			{
				                                                            
				var strUsersClan = GameInterfaceAPI.GetSettingString( "lobby_clanid" );
				                                                
				if ( strUsersClan !== '103582791429521408' && strUsersClan !== '175640385467449344' )                                                  
				{	                                     
					elDropdown.SetSelected( strUsersClan );
				}
				else
				{	                                                      
					elDropdown.SetSelected( MyPersonaAPI.GetMyClanIdByIndex( 0 ) );
				}
			}

			                                              
			elDropdown.SetPanelEvent( 'oninputsubmit', function () { elDropdownCheckbox.checked = ( elDropdown.GetSelected().id !== 'NoGroup' ); } );
		}

		                      
		$('#JsPopUpPermissionsNearby').checked = ( settings.game.nby === 1 );
		_ShowPublicExtraSettings();

		m_nWasAdvertising = ( ( ( settings.system.access === "public" ) && ( settings.game.clanid ) ) ? 1 : 0 ) +
			( ( ( settings.system.access === "public" ) && ( settings.game.nby === 1 ) ) ? 2 : 0 );
	}

	var _ShowPublicExtraSettings = function ()
	{
		$('#JsPopUpPermissionsGroupsDropdownEnabled').enabled = $('#JsPopUpPermissionsPublic').checked;
		$('#JsPopUpPermissionsGroupsDropdown').enabled = $('#JsPopUpPermissionsPublic').checked;
		$('#JsPopUpPermissionsNearby').enabled = $('#JsPopUpPermissionsPublic').checked;
	}

	var _ApplySessionSettings = function ()
	{
		var selectedGroupEntryId = $('#JsPopUpPermissionsGroupsDropdown').GetSelected().id;
		var bGroupEntryEnabled = $('#JsPopUpPermissionsGroupsDropdownEnabled').checked && ( selectedGroupEntryId !== 'NoGroup' );
		var nearbySetting = $('#JsPopUpPermissionsNearby').checked ? 1 : 0;
		var accessSetting = $('#JsPopUpPermissionsPublic').checked ? "public" : "private";
		
		var settings = {
			update: {
				System: {
					access: accessSetting
				},
				Game: {
					nby: nearbySetting,
					clanid: bGroupEntryEnabled ? selectedGroupEntryId : ''
				}
			}
		};

		if ( !bGroupEntryEnabled )
		{
			settings.delete = {
				Game: {
					clandid: '#empty#'
				}
			}
		}

		                                                                                              
		GameInterfaceAPI.SetSettingString( 'lobby_default_privacy_bits', "0" );
		GameInterfaceAPI.SetSettingString( 'lobby_default_privacy_clan_enabled', bGroupEntryEnabled ? "1" : "0" );
		GameInterfaceAPI.SetSettingString( 'lobby_default_privacy_nearby_enabled', ''+nearbySetting );
		if ( bGroupEntryEnabled )
		{
			GameInterfaceAPI.SetSettingString( 'lobby_clanid', selectedGroupEntryId );
		}
		if ( $('#JsPopUpPermissionsPublic').checked && GameInterfaceAPI.GetSettingString( 'lobby_default_privacy_bits' ) === "0" )
		{
			GameInterfaceAPI.SetSettingString( 'lobby_default_privacy_bits', $('#JsPopUpPermissionsPublic').checked ? "1" : "0" );
		}

		LobbyAPI.UpdateSessionSettings( settings );
		$.DispatchEvent( 'UIPopupButtonClicked', '' );

		var nNowAdvertising = ( ( ( accessSetting === "public" ) && ( bGroupEntryEnabled ) ) ? 1 : 0 ) +
			( ( ( accessSetting === "public" ) && ( nearbySetting ) ) ? 2 : 0 );
		if ( ( nNowAdvertising != m_nWasAdvertising ) && ( m_nWasAdvertising > 0 ) )
		{
			PartyListAPI.SessionCommand( 'Game::ChatReportAdvertising', '' );
		}
		if ( nNowAdvertising > 0 )
		{	                                                                   
			var settings = LobbyAPI.GetSessionSettings();
			if ( settings && settings.system && ( settings.system.network === 'offline' ) )
			{
				PartyListAPI.SessionCommand( 'MakeOnline', '' );
			}
		}
	}

	return {
		Init					:	_Init,
		ApplySessionSettings	:	_ApplySessionSettings
	};

})();

  

			              
			          
				              
					                            
				       
				            
					                             
					                            
					                                         
				       
				               
					                          
					                                               
				       
				                
					      
				       
				                  
					      
				                

					
	         
	               
	                 
	                    
	                             
	 
	      
	              
	             
	               
	                   
	                    
	                    
	      
	                       
	                      
	                  
	                                                    
	 
	        
	               
	              
	 
	         
	                            
	                           
	                         
	            
		                                                
		                    
		                         
		                      
		              
		                   
		         
		                                                    
		             
		        
			                     
			                      
			                      
			                    
			                                   
			                     
			                        
			                    
			    
		   
		 
	   
	 
 
  