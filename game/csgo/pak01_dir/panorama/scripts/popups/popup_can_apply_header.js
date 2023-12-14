'use strict';

var CanApplyHeader = ( function()
{
	var m_cP = $.GetContextPanel();
	
	var _Init = function( oTitleSettings )
	{
		oTitleSettings.headerPanel.RemoveClass( 'hidden' );
		
		_SetTitle( oTitleSettings );
		_SetUpDesc( oTitleSettings );
		_SetUpWarning( oTitleSettings );
	};

	var _SetTitle = function( oTitleSettings )
	{
		var title = oTitleSettings.isRemove ?'#SFUI_InvContextMenu_can_stick_Wear_full_'+ oTitleSettings.type : '#SFUI_InvContextMenu_stick_use_'+ oTitleSettings.type;
		m_cP.SetDialogVariable( "CanApplyTitle", $.Localize( title, m_cP ));
	};
	
	var _SetUpDesc = function ( oTitleSettings)
	{
		var currentName = ItemInfo.GetName( oTitleSettings.itemId );
		m_cP.SetDialogVariable( 'tool_target_name', currentName );

		var desc = oTitleSettings.isRemove ?'#popup_can_stick_scrape_full_'+ oTitleSettings.type : '#popup_can_stick_desc';
		m_cP.SetDialogVariable( "CanApplyDesc", $.Localize( desc, m_cP ));
	};

	var _SetUpWarning = function( oTitleSettings )
	{
		let elLabel = m_cP.FindChildInLayoutFile( 'id-can-apply-warning' );
		elLabel.visible = !oTitleSettings.isRemove;
		if ( oTitleSettings.isRemove )
		{
			                        
			return;
		}

		                                                                                                           
		var warningText = _GetWarningTradeRestricted( oTitleSettings.type, oTitleSettings.toolId, oTitleSettings.itemId );
		warningText = !warningText ? '#SFUI_InvUse_Warning_use_can_stick_' + oTitleSettings.type : warningText;

		warningText = $.Localize( warningText, elLabel );
		m_cP.SetDialogVariable( "CanApplyWarning", warningText );
	};
	
	var _GetWarningTradeRestricted = function( type, toolId, itemId )
	{
		         
		                                                                                                                           
		                                                                                                                                    
		var strSpecialWarning = '';
		var strSpecialParam = null;
		var bIsPerfectWorld = MyPersonaAPI.GetLauncherType() === "perfectworld" ? true : false;

		if ( !bIsPerfectWorld )
		{
			                                                                                                                                           
			                                                                                                                                           
			if ( InventoryAPI.IsMarketable( itemId ) )
			{
				if ( !InventoryAPI.IsPotentiallyMarketable( toolId ) )
				{	                                                                                                                                                             
					                                                                                                                                   
					strSpecialParam = InventoryAPI.GetItemAttributeValue( toolId, "tradable after date" );
					if ( strSpecialParam !== undefined && strSpecialParam !== null )
					{
						strSpecialWarning = _GetSpecialWarningString( type, strSpecialParam, "marketrestricted" );
					}
				}
				else
				{
					strSpecialWarning = _GetStickerMarketDateGreater( type, toolId, itemId );
				}
			}
		}
		else
		{
			strSpecialWarning = _GetStickerMarketDateGreater( type, toolId, itemId );
		}
		
		return strSpecialWarning;
	}

	var _GetStickerMarketDateGreater = function( type, toolId, itemId )
	{
		                                                                               
		var rtTradableAfterSticker = InventoryAPI.GetItemAttributeValue( toolId, "{uint32}tradable after date" );
		var rtTradableAfterWeapon = InventoryAPI.GetItemAttributeValue( itemId, "{uint32}tradable after date" );
		if ( rtTradableAfterSticker != undefined && rtTradableAfterSticker != null &&
			( rtTradableAfterWeapon == undefined || rtTradableAfterWeapon == null || rtTradableAfterSticker > rtTradableAfterWeapon ) )
		{
			var strSpecialParam = null;
			strSpecialParam = InventoryAPI.GetItemAttributeValue( toolId, "tradable after date" );
			if ( strSpecialParam != undefined && strSpecialParam != null )
			{
				return _GetSpecialWarningString( type, strSpecialParam, "traderestricted");
			}
		}

		return '';
	};

	var _GetSpecialWarningString = function( type, strSpecialParam, warningText )
	{
		var elLabel = m_cP.FindChildInLayoutFile( 'id-can-apply-warning' );
		elLabel.SetDialogVariable( 'date', strSpecialParam );
		return "#popup_can_stick_warning_" + warningText + "_" + type;
	}

	return {
		Init : _Init
	};
} )();