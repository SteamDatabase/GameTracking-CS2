'use strict';

var SettingsMenuPromoted = ( function() {

	function CreatePromotedSettingEntry( setting )
	{
		this.id = setting.id; 
		this.loc_name = setting.loc_name; 
		this.loc_desc = setting.loc_desc; 

		let elRoot = $('#SettingContainer');
		let elemID = "PromotedSetting__" + setting.id;
		this.view = function()
		{
			$.DispatchEvent( "SettingsMenu_NavigateToSetting", setting.section, setting.id );
		};
		this.createPanel = function()
		{
			let elNewSetting = $.CreatePanel( "Panel", elRoot, elemID );
			if ( elNewSetting.BLoadLayoutSnippet( "PromotedSetting" ) )
			{
				elNewSetting.FindChild( "SettingName" ).text = $.Localize( this.loc_name );
				elNewSetting.FindChild( "SettingDesc" ).text = $.Localize( this.loc_desc );
				elNewSetting.FindChildTraverse( "ViewSetting" ).SetPanelEvent( 'onactivate', this.view );
				if ( setting.highlight )
				{
					elNewSetting.AddClass( "Highlight" );
				}
			}
		}
		
	}

	function _Init()
	{
		                                                
		let arrUnacknowledgedSettings = PromotedSettingsUtil.GetUnacknowledgedPromotedSettings()
		arrUnacknowledgedSettings.forEach( setting => setting.highlight = true );

		for ( const setting of g_PromotedSettings )
		{
			const now = new Date();
			if ( setting.end_date > now && setting.start_date <= now )
			{
				let elGoToSettingPanel = new CreatePromotedSettingEntry( setting );
				elGoToSettingPanel.createPanel();
			}
		}

		if ( arrUnacknowledgedSettings.length > 0 )
		{
			                                                             
			$.DispatchEvent( "MainMenu_PromotedSettingsViewed" );
		}
	}

    return {
        Init : _Init,
    };

})();

              
(function ()
{
	SettingsMenuPromoted.Init();
})();