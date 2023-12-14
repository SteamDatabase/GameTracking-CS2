'use strict';

var SettingsMenuSearch = ( function() {

	var m_SettingsSearchTextEntry = $("#SettingsSearchTextEntry");
	var m_ResultsContainer = $("#SearchResultsContainer");

	function _Init()
	{
		$.RegisterEventHandler( 'ReadyForDisplay', m_SettingsSearchTextEntry, _OnReadyForDisplay );
		$.RegisterEventHandler( 'UnreadyForDisplay', m_SettingsSearchTextEntry, _OnUnreadyForDisplay );
		m_SettingsSearchTextEntry.RegisterForReadyEvents(true);
		m_SettingsSearchTextEntry.SetReadyForDisplay(true);

		m_SettingsSearchTextEntry.SetPanelEvent( 'ontextentrychange', OnTextEntryChanged );
		OnTextEntryChanged();
	}

	function _OnReadyForDisplay() 
	{
		m_SettingsSearchTextEntry.SetFocus();
		m_SettingsSearchTextEntry.RaiseChangeEvents( true );
	}
	function _OnUnreadyForDisplay()
	{
		m_SettingsSearchTextEntry.GetParent().SetFocus();	
		m_SettingsSearchTextEntry.RaiseChangeEvents( false );
	}

	function OnTextEntryChanged()
	{
		m_ResultsContainer.RemoveAndDeleteChildren();

		                          
		var hasText = /.*\S.*/;
		if ( !hasText.test( m_SettingsSearchTextEntry.text ) )
		{
			PopulateWithPromotedSettings();
			return;
		}

		                                                                 
		var arrStrings = m_SettingsSearchTextEntry.text.split( /\s/ ).filter( s => /^\w+$/.test( s ) );

		                                                                                     
		                                                                                        
		let searchableMenus = [
			'GameSettings',
			'AudioSettings',
			'video_settings',
			'advanced_video',
			'KeybdMouseSettings',
			'ControllerSettings'
		];

		var arrMatches = [];
		var elSettingsMenu = $.GetContextPanel().GetParent();
		var curMenuTab = null;

		                                                             
		searchableMenus.forEach( id => 
		{
			curMenuTab = id;
			var elRootPanel = elSettingsMenu.FindChildTraverse( id );
			if ( !elRootPanel || !elRootPanel.IsValid() ) return;
			
			TraverseChildren( elRootPanel, SearchSettingText ) ;
				
			function TraverseChildren( elRoot, fnSearch )
			{
				if ( typeof elRoot.Children !== 'function' ) return;
				elRoot.Children().forEach( c => { TraverseChildren( c, fnSearch );fnSearch( c ); } );
			}

			function SearchSettingText( setting )
			{
				if ( ShouldSearchPanelText( setting ) ) {
					                                                      
					var bPass = arrStrings.every( s => {
						var search = new RegExp( s, "giu" );
						return search.test( setting.text );
					});
					if ( bPass ) {
						let curSubMenu = '';
						                                                                       
						                                                                                    
						                                                                         
						if (curMenuTab.includes('video')) 
						{
							curSubMenu = curMenuTab.includes('advanced') ? 'AdvancedVideoSettingsRadio' : 'SimpleVideoSettingsRadio';
							curMenuTab = 'VideoSettings'
						}
						arrMatches.push( {
							panel: setting.GetParent(),
							text: setting.text,
							menu: curMenuTab,
							submenu: curSubMenu 
						} );
					}
				}
						
				                                                                      
				                                                                                
				                                                                                                                             
				                                                                                          
				function ShouldSearchPanelText( setting ) 
				{				
					                                   
					if ( !setting.hasOwnProperty( 'text' ) )
						return false;
					
					if ( setting.paneltype === 'TextEntry')
						return false;

					if ( setting.BHasClass( 'DropDownChild' ) )
						return false;

					if ( setting.BHasClass( 'BindingRowButton' ) )
						return false;

					if ( setting.GetParent().paneltype === ( 'RadioButton' ) )
						return false;
					  
					                                     
					                                                                       
						            

					                                    
					                                                                                                  
						            
					  

					return true;
				}
			}
		} );

		                               
		arrMatches.forEach( searchResult => { 
			CreateSearchResultPanel( searchResult.text, searchResult.menu, searchResult.submenu, searchResult.panel );
		});
	}	

	function CreateSearchResultPanel( text, menuid, submenu, panel )
	{
		var elSearchResult = $.CreatePanel( "Panel", m_ResultsContainer, "setting_result_link" );
		if ( elSearchResult.BLoadLayoutSnippet( "SearchResult" ) )
		{
			elSearchResult.FindChild( "ResultString" ).SetAlreadyLocalizedText( text, true );
			elSearchResult.SetPanelEvent( 'onactivate', function() {
				$.DispatchEvent( "SettingsMenu_NavigateToSettingPanel", menuid, submenu, panel );
			});
		}
	}

	function PopulateWithPromotedSettings()
	{
		var elTitle = $.CreatePanel( "Label", m_ResultsContainer, "promoted_settings_title" );
		elTitle.text = $.Localize( "#GameUI_Settings_Promoted" );
		elTitle.AddClass( "SettingsSectionTitleLabel" );
		elTitle.AddClass( "setting-search-recently-added-header" );
		g_PromotedSettings.forEach( s => {
			var elSettingsMenu = $.GetContextPanel().GetParent();
			var elPanel = elSettingsMenu.FindChildTraverse( s.id );
			if ( elPanel ) {
				CreateSearchResultPanel( $.Localize( s.loc_name ), s.section, s.subsection || "", elPanel );
			}
		});
	}

    return {
        Init : _Init,
    };

})();

              
(function ()
{
	SettingsMenuSearch.Init();
})();