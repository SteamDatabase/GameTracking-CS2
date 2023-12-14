"use strict";

                                                                                                    
          
                                                                                                    
var SettingsMenu = ( function () {

	var activeTab;
	
	let tabInfo = {
		Promoted: {
			xml: "settings_promoted",
			radioid: "PromotedSettingsRadio"
		},
		KeybdMouseSettings: {
			xml: 'settings_kbmouse',                            
			radioid: "KBMouseRadio"                                            
		},
		                       
		  	                           
		  	                          
		    
		GameSettings: {
			xml: "settings_game",
			radioid: "GameRadio"
		},
		AudioSettings: {
			xml: "settings_audio",
			radioid: "AudioRadio"
		},
		VideoSettings: {
			xml: "settings_video",
			radioid: "VideoRadio"
		},
		Search: {
			xml: "settings_search",
			radioid: "SearchRadio"
		}
	};

    var _NavigateToTab = function( tabID ) {
		
        var bDisplaySteamInputSettings = false;

        if ( tabID == 'ControllerSettings' )
        {
           if ( OptionsMenuAPI.BIsSteamInputActiveAndControllersConnected() )                                                                                
            {
                bDisplaySteamInputSettings = true;
            }
		}
	
        var parentPanel = $('#SettingsMenuContent');

                                               
                                    
        if (!parentPanel.FindChildInLayoutFile(tabID))
        {
            var newPanel = $.CreatePanel('Panel', parentPanel, tabID);
                                                             

			let XmlName = tabInfo[ tabID ].xml;
			if (bDisplaySteamInputSettings) {
                XmlName = "settings_steaminput";
            }
            newPanel.BLoadLayout('file://{resources}/layout/settings/' + XmlName + '.xml', false, false );
            
                                                                                        
                                                                   
            newPanel.OnPropertyTransitionEndEvent = function ( panelName, propertyName )
            {   
                if( newPanel.id === panelName && propertyName === 'opacity')
                {
                                                             
                    if( newPanel.visible === true && newPanel.BIsTransparent() )
                    {
                                                                       
                        newPanel.visible = false;
                        newPanel.SetReadyForDisplay( false );
                        return true;
                    }
                }

                return false;
            }

            $.RegisterEventHandler( 'PropertyTransitionEnd', newPanel, newPanel.OnPropertyTransitionEndEvent );
  
                                                                                                                
            newPanel.visible = false;

			                                                                                        
			let contentPanel = newPanel.FindChildInLayoutFile( 'SettingsMenuTabContent' );
			let jumpButtons = newPanel.FindChildInLayoutFile( 'SettingsMenuJumpButtons' );
			if ( contentPanel && jumpButtons )
			{
				contentPanel.SetSendScrollPositionChangedEvents( true );
				$.RegisterEventHandler( 'ScrollPositionChanged', contentPanel, () =>
				{
					if ( newPanel.Data().bScrollingToId )
						newPanel.Data().bScrollingToId = false;
					else
						jumpButtons.Children().forEach( jumpButton => jumpButton.checked = false );
				} );

				                                            
				jumpButtons.Children()[ 0 ].checked = true;
			}


			const newSettings = PromotedSettingsUtil.GetUnacknowledgedPromotedSettings();
			newSettings.forEach( setting => {
				const el = newPanel.FindChildTraverse( setting.id );
				if ( el )
				{
					el.AddClass( "setting-is-new" );
				}
			} )
        }

		if ( tabID == "Search" )
		{
			let settings = parentPanel.FindChildInLayoutFile(tabID)
			let searchTextEntry = settings.FindChildInLayoutFile( 'SettingsSearchTextEntry' );
			searchTextEntry.SetFocus()
		}

                                                                                  
                                
        if( activeTab !==  tabID )
        {
                                             
            if( activeTab )
            {
                var panelToHide = $.GetContextPanel().FindChildInLayoutFile( activeTab );
                panelToHide.RemoveClass( 'Active' ); 
                                                   
            }

			                                        
            $( "#" + tabInfo[ tabID ].radioid ).checked = true;
            
                               
            var prevTab = activeTab;
            activeTab = tabID;
            var activePanel = $.GetContextPanel().FindChildInLayoutFile( tabID );
            activePanel.AddClass( 'Active' );

                                          

                                                                                     
                                                
            {
                activePanel.visible = true;
                activePanel.SetReadyForDisplay( true );   
            }

            SettingsMenuShared.NewTabOpened( activeTab );
        }
    };

    var _AccountPrivacySettingsChanged = function()
    {
                                                                                        
                                                                                           
                                                                                           
        var gameSettingPanel = $.GetContextPanel().FindChildInLayoutFile ( "GameSettings" );
        if ( gameSettingPanel != null )
        {
            var twitchTvSetting = gameSettingPanel.FindChildInLayoutFile( "accountprivacydropdown" );
            if ( twitchTvSetting != null )
            {
                twitchTvSetting.OnShow();                
            }
        }
    }

	var _OnSettingsMenuShown = function ()
	{
		                                                                             
		                                                                                   
		                                               
		SettingsMenuShared.NewTabOpened( activeTab );
	}

	var _OnSettingsMenuHidden = function ()
	{
	                                   
	GameInterfaceAPI.ConsoleCommand( "host_writeconfig" );
	InventoryAPI.StopItemPreviewMusic();
	}

	var _NavigateToSetting = function ( tab, id )
	{
		                                                  
		$.DispatchEvent( "Activated", $( "#" + tabInfo[ tab ].radioid ), "mouse" );
		SettingsMenuShared.ScrollToId( id );                     
	}

	var _NavigateToSettingPanel = function( tab, submenuRadioId, p )
	{
		$.DispatchEvent( "Activated", $( "#" + tabInfo[ tab ].radioid ), "mouse" );
		if ( submenuRadioId != '' )
		{
			let elSubMenuRadio = $.GetContextPanel().GetParent().FindChildTraverse( submenuRadioId );
			if ( elSubMenuRadio )
			{
				$.DispatchEvent("Activated", elSubMenuRadio, "mouse");
			}
		}
		p.ScrollParentToMakePanelFit(3, false);
		p.AddClass('Highlight');
	}

	var _Init = function( )
	{
		                                                             
		for (let tab in tabInfo) {
			if ( tab !== "Promoted" && tab !== "Search" )
				_NavigateToTab(tab);
		}
	}

	return {
		Init                            : _Init,
		NavigateToTab	                : _NavigateToTab,
		NavigateToSetting	            : _NavigateToSetting,
		NavigateToSettingPanel	        : _NavigateToSettingPanel,
		AccountPrivacySettingsChanged   : _AccountPrivacySettingsChanged,
		OnSettingsMenuShown             : _OnSettingsMenuShown,
		OnSettingsMenuHidden            : _OnSettingsMenuHidden
};

} )() ;

                                                                                                    
                                           
                                                                                                    
(function ()
{
	SettingsMenu.Init();

	if ( PromotedSettingsUtil.GetUnacknowledgedPromotedSettings().length > 0 )
	{
		SettingsMenu.NavigateToTab( 'Promoted' );
	}
	else
	{
		const now = new Date();
		if ( g_PromotedSettings.filter( setting => setting.start_date <= now && setting.end_date > now ).length == 0 )
			$( '#PromotedSettingsRadio' ).visible = false;

		SettingsMenu.NavigateToTab( 'VideoSettings' );
	}

	MyPersonaAPI.RequestAccountPrivacySettings();
	$.RegisterForUnhandledEvent( "PanoramaComponent_MyPersona_AccountPrivacySettingsChanged", 
		SettingsMenu.AccountPrivacySettingsChanged );

	$.RegisterEventHandler( 'ReadyForDisplay', $( '#JsSettings' ), SettingsMenu.OnSettingsMenuShown );
	$.RegisterEventHandler( 'UnreadyForDisplay', $( '#JsSettings' ), SettingsMenu.OnSettingsMenuHidden );
	$.RegisterForUnhandledEvent( 'SettingsMenu_NavigateToSetting',  SettingsMenu.NavigateToSetting );
	$.RegisterForUnhandledEvent( 'SettingsMenu_NavigateToSettingPanel',  SettingsMenu.NavigateToSettingPanel );
	
})();

