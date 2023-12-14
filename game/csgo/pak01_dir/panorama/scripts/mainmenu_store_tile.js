              
   
                                                            
'use strict';

var MainMenuStoreTile = ( function()
{
	var elItem = $.GetContextPanel();

	var _Init = function()
	{
		                         
		var id = elItem.Data().oData.id;
		var activationType = elItem.Data().oData.activationType;
		var isNewRelease = elItem.Data().oData.isNewRelease;
		var useItemId = elItem.Data().oData.useItemId;
		var isMarketItem = activationType === 'market';

		                  
		var elImage = elItem.FindChildInLayoutFile( 'StoreItemImage' );
		var LootListItemID = '';

		if( InventoryAPI.GetItemTypeFromEnum( id ) === 'coupon' )
			LootListItemID = InventoryAPI.GetLootListItemIdByIndex( id, 0 );

		elImage.itemid = ( !isMarketItem && !useItemId && LootListItemID ) ? LootListItemID : id;

		var elName = elItem.FindChildInLayoutFile( 'StoreItemName' );
		var strItemName = ItemInfo.GetName( id );
		if ( elItem.Data().oData.usetinynames )
			strItemName = $.Localize( InventoryAPI.GetRawDefinitionKey(id, 'item_name') + '_tinyname' );
		elName.text = strItemName;
		
		var elStattrak = elImage.FindChildInLayoutFile( 'StoreItemStattrak' );
		elStattrak.SetHasClass( 'hidden', !ItemInfo.IsStatTrak( id ) );

		var elNewHighlight = elImage.FindChildInLayoutFile( 'StoreItemNew' );
		elNewHighlight.SetHasClass( 'hidden', !isNewRelease );

		var elSale = elItem.FindChildInLayoutFile( 'StoreItemSalePrice' );
		var elPrecent = elItem.FindChildInLayoutFile( 'StoreItemPercent' );
		var reduction = ItemInfo.GetStoreSalePercentReduction( id, 1 );

		if ( reduction )
		{
			elSale.visible = true;
			elSale.text = ItemInfo.GetStoreOriginalPrice( id, 1 );

			elPrecent.visible = true;
			elPrecent.text = reduction;
		}
		else
		{
			elSale.visible = false;
			elPrecent.visible = false;
		}

		var elPrice = elItem.FindChildInLayoutFile( 'StoreItemPrice' );
		elPrice.text = ( isMarketItem ) ? $.Localize( '#SFUI_Store_Market_Link' ) : ItemInfo.GetStoreSalePrice( id, 1 );

		_OnActivateStoreItem( elItem, id, activationType );

	};

	var _OnActivateStoreItem = function( elItem, id, type )
	{
		if ( elItem.Data().oData.isDisabled )
		{
			elItem.enabled = false;
			return;
		}
		
		if ( type === "market" )
		{
			elItem.SetPanelEvent( 'onactivate', _OpenOverlayToMarket.bind( undefined, id ));
		}
		else if( ItemInfo.ItemHasCapability( id, 'decodable' ) )
		{
			var displayItemId = '';

			if ( InventoryAPI.GetItemTypeFromEnum( id ) === 'coupon' )
			{
				displayItemId = InventoryAPI.GetLootListItemIdByIndex( id, 0 );
				elItem.SetPanelEvent( 'onactivate', _ShowDecodePopup.bind( undefined, id, displayItemId, type ) );
			}
			else if ( ItemInfo.GetLootListCount( id ) > 0 )
			{
				elItem.SetPanelEvent( 'onactivate', _ShowDecodePopup.bind( undefined, id, id, type ) );
			}
			else
				elItem.SetPanelEvent( 'onactivate', _ShowInpsectPopup.bind( undefined, id, type ) );
		}
		else
			elItem.SetPanelEvent( 'onactivate', _ShowInpsectPopup.bind( undefined, id, type ) );
	};

	var _OpenOverlayToMarket = function( id )
	{
		var m_AppID = SteamOverlayAPI.GetAppID();
		var m_CommunityUrl = SteamOverlayAPI.GetSteamCommunityURL();
		var strSetName = InventoryAPI.GetItemSet( id );
		
		SteamOverlayAPI.OpenURL( m_CommunityUrl + "/market/search?q=&appid=" + m_AppID + "&lock_appid=" + m_AppID + "&category_" + m_AppID + "_ItemSet%5B%5D=tag_" + strSetName );
		StoreAPI.RecordUIEvent( "ViewOnMarket" );
	};

	var _ShowDecodePopup = function( id, displayItemId, type )
	{
		                                                                                     
		var strExtraSettings = '';
		if ( type === 'newstore' )
		{	                                                                                   
			strExtraSettings = '&overridepurchasemultiple=1';
		}

		if ( elItem.Data().oData.extrapopupfullscreenstyle )
		{
			strExtraSettings += '&extrapopupfullscreenstyle=solidbkgnd';
		}

		UiToolkitAPI.ShowCustomLayoutPopupParameters(
			'',
			'file://{resources}/layout/popups/popup_capability_decodable.xml',
			'key-and-case=' + '' + ',' + displayItemId
			+ '&' +
			'asyncworkitemwarning=no'
			+ '&' +
			'asyncforcehide=true'
			+ '&' +
			'storeitemid=' + id
			+ strExtraSettings
		);
	};

	var _ShowInpsectPopup = function( id )
	{
		var strExtraSettings = elItem.Data().oData.extrapopupfullscreenstyle ? '&extrapopupfullscreenstyle=solidbkgnd' : '';
		
		                                                            
		UiToolkitAPI.ShowCustomLayoutPopupParameters(
			'',
			'file://{resources}/layout/popups/popup_inventory_inspect.xml',
			'itemid=' + id
			+ '&' +
			'inspectonly=false'
			+ '&' +
			'asyncworkitemwarning=no'
			+ '&' +
			'storeitemid=' + id 
			+ '&' + 
			strExtraSettings,
			'none'
		);
	};
	

	return {
		Init: _Init
	};
} )();



