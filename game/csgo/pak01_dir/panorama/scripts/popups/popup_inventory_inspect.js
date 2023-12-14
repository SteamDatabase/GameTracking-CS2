'use strict';

var InventoryInspect = ( function()
{
	var _m_PanelRegisteredForEvents;
	var _Init = function ()
	{
		var itemId = $.GetContextPanel().GetAttributeString( "itemid", null );

		                                               
		    
		   	                                              
		   	       
		    

		                                                                      
		                                
		                                                                        
		                                                                                                     
		if ( !_m_PanelRegisteredForEvents )
		{
			_m_PanelRegisteredForEvents = $.RegisterForUnhandledEvent( 'PanoramaComponent_Loadout_EquipSlotChanged', InventoryInspect.ShowNotification );
			$.RegisterForUnhandledEvent( 'PanoramaComponent_Store_PurchaseCompleted', InventoryInspect.ItemAcquired );
		}

		_UpdatePanelData( itemId );
		_PlayShowPanelSound( itemId );
		_SetupLootlistNavPanels( itemId );
		_LoadEquipNotification();

		var styleforPopUpInspectFullScreenHostContainer = $.GetContextPanel().GetAttributeString( 'extrapopupfullscreenstyle', null );
		if ( styleforPopUpInspectFullScreenHostContainer )
		{
			var elPopUpInspectFullScreenHostContainer = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectFullScreenHostContainer' );
			elPopUpInspectFullScreenHostContainer.AddClass( styleforPopUpInspectFullScreenHostContainer );
		}

		var blurOperationPanel = ( $.GetContextPanel().GetAttributeString( 'bluroperationpanel', 'false' ) === 'true' ) ? true : false;
		if ( blurOperationPanel )
		{
			$.DispatchEvent( 'BlurOperationPanel' );
		}

		var defIdx = InventoryAPI.GetItemDefinitionIndex( itemId );
		if ( defIdx > 0 )
		{
			StoreAPI.RecordUIEvent( "Inventory_Inspect", defIdx );
		}
	};

	var _UpdatePanelData = function( itemId )
	{
		var elItemModelImagePanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectModelOrImage' );
		InspectModelImage.Init( elItemModelImagePanel, itemId, _GetSettingCallback );
		
		var elActionBarPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectActionBar' );

		InspectActionBar.Init(
			elActionBarPanel,
			itemId,
			_GetSettingCallback,
			_GetSettingCallbackInt,
			elItemModelImagePanel
		);

		var elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectAsyncBar' );
		InspectAsyncActionBar.Init(
			elAsyncActionBarPanel,
			itemId,
			_GetSettingCallback
		);

		var elHeaderPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectHeader' );
		InspectHeader.Init( elHeaderPanel, itemId, _GetSettingCallback );

		var elCapabilityPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpCapabilityHeader' );
		CapabilityHeader.Init( elCapabilityPanel, itemId, _GetSettingCallback );

		var elPurchasePanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectPurchaseBar' );
		InspectPurchaseBar.Init( elPurchasePanel, itemId, _GetSettingCallback );

		_SetDescription( itemId );
	}

	var m_Inspectpanel = $.GetContextPanel();
	var _GetSettingCallback = function( settingname, defaultvalue )
	{
		return m_Inspectpanel.GetAttributeString( settingname, defaultvalue );
	};

	var _GetSettingCallbackInt = function( settingname, defaultvalue )
	{
		return m_Inspectpanel.GetAttributeInt( settingname, defaultvalue );
	};

	var _PlayShowPanelSound = function ( itemId )
	{
		var category = ItemInfo.GetLoadoutCategory( itemId );
		var slot = ItemInfo.GetDefaultSlot( itemId );

		                                                                       
		var inspectSound = "";
		if(category == "heavy" || category == "rifle" || category == "smg" || category == "secondary") {
			                   
			inspectSound = "inventory_inspect_weapon";
		} else if(category == "melee") {
			                     
			inspectSound = "inventory_inspect_knife";
		} else if(ItemInfo.ItemMatchDefName( itemId, 'sticker' )) {
			               
			inspectSound = "inventory_inspect_sticker";
		} else if(category == "spray") {
			                
			inspectSound = "inventory_inspect_graffiti";
		} else if(category == "musickit") {
			                 
			inspectSound = "inventory_inspect_musicKit";
		} else if(category == "flair0") {
			            
			inspectSound = "inventory_inspect_coin";
		} else if(category == "clothing" && slot == "clothing_hands") {
			              
			inspectSound = "inventory_inspect_gloves";
		} else {
			               
			inspectSound = "inventory_inspect_sticker";
		}

		$.DispatchEvent( "CSGOPlaySoundEffect", inspectSound, "MOUSE" );
	}

	var _SetDescription = function (id)
	{
	    $.GetContextPanel().SetDialogVariable( 'item_description', '' );

		if ( !InventoryAPI.IsValidItemID( id ) )
		{
			return;
		}
		
		var elDesc = $.GetContextPanel().FindChildInLayoutFile( 'InspectItemDesc' );
		var descText = InventoryAPI.GetItemDescription( id, '' );

		                                           
		var shortString = descText.substring( 0, descText.indexOf( "</font></b><br><font color='#9da1a9'>" ) );
		$.GetContextPanel().SetDialogVariable( 'item_description', shortString === '' ? descText : shortString );
	};

	                                                                                                    
	var _LoadEquipNotification = function()
	{
		var elParent = $.GetContextPanel();
		
		var elNotification = $.CreatePanel( 'Panel', elParent, 'InspectNotificationEquip' );
		elNotification.BLoadLayout( 'file://{resources}/layout/notification/notification_equip.xml', false, false );
	};

	var _ShowNotification = function( team, slot, oldItemId, newItemId, bNew )
	{
		if ( !bNew )
			return;

		var elNotification = $.GetContextPanel().FindChildInLayoutFile( 'InspectNotificationEquip' );
		if ( elNotification && elNotification.IsValid() )
		{
			EquipNotification.ShowEquipNotification( elNotification, slot, newItemId );
		}
	};
	
		var m_lootlistItemIndex = 0;

	var _SetupLootlistNavPanels = function( itemId )
	{
		m_lootlistItemIndex = 0;
		var aLootlistIds = _GetLootlistItems();
		if ( aLootlistIds.length < 1 )
		{
			$.GetContextPanel().FindChildInLayoutFile( 'id-lootlist-btns-container' ).visible = false;
			$.GetContextPanel().FindChildInLayoutFile( 'id-lootlist-title-container' ).visible = false;
			return;
		}

		$.GetContextPanel().FindChildInLayoutFile( 'id-lootlist-btns-container' ).visible = true;
		$.GetContextPanel().FindChildInLayoutFile( 'id-lootlist-title-container' ).visible = true;

		m_lootlistItemIndex = aLootlistIds.indexOf( itemId );

		var btnNext = $.GetContextPanel().FindChildInLayoutFile( 'id-lootlist-next' );
		var btnPrev = $.GetContextPanel().FindChildInLayoutFile( 'id-lootlist-prev' );

		var count = aLootlistIds.length;
		_EnableNextPrevBtns( aLootlistIds );
		_UpdateLootlistTitleBar( count );

		btnNext.SetPanelEvent( 'onactivate', function()
		{
			m_lootlistItemIndex = ( m_lootlistItemIndex < ( count - 1 ) ) ? m_lootlistItemIndex + 1 : m_lootlistItemIndex;
			_EnableNextPrevBtns( aLootlistIds );
			_UpdatePanelData( aLootlistIds[ m_lootlistItemIndex ] );
			_UpdateCharacterModelPanel( aLootlistIds[ m_lootlistItemIndex ] );
			_PrecacheCustomMaterials( aLootlistIds, count, false, true );
		} );

		btnPrev.SetPanelEvent( 'onactivate', function()
		{
			m_lootlistItemIndex = m_lootlistItemIndex > 0 ? m_lootlistItemIndex - 1 : m_lootlistItemIndex;
			_EnableNextPrevBtns( aLootlistIds );
			_UpdatePanelData( aLootlistIds[ m_lootlistItemIndex ] );
			_UpdateCharacterModelPanel( aLootlistIds[ m_lootlistItemIndex ] );
			_PrecacheCustomMaterials( aLootlistIds, count, true, false );
		} );

		btnNext.SetPanelEvent( 'onmouseover', function()
		{
			_PrecacheCustomMaterials( aLootlistIds, count, false, true );
		} );

		btnPrev.SetPanelEvent( 'onmouseover', function()
		{
			_PrecacheCustomMaterials( aLootlistIds, count, true, false );
		} );
	}

	var _UpdateCharacterModelPanel = function( itemId )
	{
		if ( !ItemInfo.IsWeapon(itemId) )
		{
			return;
		}
		
		var elActionBarPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectActionBar' );
		InspectActionBar.OnUpdateCharModel( false,
			elActionBarPanel.FindChildInLayoutFile( 'InspectDropdownCharModels' ),
			itemId );
	}

	var _PrecacheCustomMaterials = function( aLootlistIds, count, bPrev, bNext )
	{
		if ( bNext )
		{
			if ( m_lootlistItemIndex + 1 < ( count - 1 ) )
			{
				InventoryAPI.PrecacheCustomMaterials( aLootlistIds[ m_lootlistItemIndex + 1 ] );
			}
		}

		if ( bPrev )
		{
			if ( m_lootlistItemIndex - 1 > 0 )
			{
				InventoryAPI.PrecacheCustomMaterials( aLootlistIds[ m_lootlistItemIndex - 1 ] );
			}
		}
	}

	var _EnableNextPrevBtns = function( aLootlistIds )
	{
		var btnNext = $.GetContextPanel().FindChildInLayoutFile( 'id-lootlist-next' );
		var btnPrev = $.GetContextPanel().FindChildInLayoutFile( 'id-lootlist-prev' );
		
		btnNext.enabled = ( m_lootlistItemIndex < aLootlistIds.length - 1 ) && ( aLootlistIds[ m_lootlistItemIndex + 1 ] !== '0' );
		btnPrev.enabled = m_lootlistItemIndex > 0;
		_SetBtnLabel( btnNext, btnPrev, aLootlistIds );
		_UpdateLootlistTitleBar( aLootlistIds.length );
	}

	var _SetBtnLabel = function( btnNext, btnPrev, aLootlistIds )
	{
		if ( btnNext.enabled )
		{
			btnNext.FindChildInLayoutFile( 'id-lootlist-label' ).text = InventoryAPI.GetItemName( aLootlistIds[ m_lootlistItemIndex + 1 ] );
			var rarityColor = ItemInfo.GetRarityColor( aLootlistIds[ m_lootlistItemIndex + 1 ] );

			if ( rarityColor )
			{
				btnNext.FindChildInLayoutFile( 'id-lootlist-rarity' ).style.washColor = rarityColor;
			}
		}

		if ( btnPrev.enabled )
		{
			btnPrev.FindChildInLayoutFile( 'id-lootlist-label' ).text = InventoryAPI.GetItemName( aLootlistIds[ m_lootlistItemIndex - 1 ] );
			var rarityColor = ItemInfo.GetRarityColor( aLootlistIds[ m_lootlistItemIndex - 1 ] );

			if ( rarityColor )
			{
				btnPrev.FindChildInLayoutFile( 'id-lootlist-rarity' ).style.washColor = rarityColor;
			}
		}
	}

	var _GetLootlistItems = function()
	{
		m_lootlistItemIndex = 0;
		var aLootlistIds = [];
		
		var caseId = $.GetContextPanel().GetAttributeString( "caseidforlootlist", "" );
		if ( !caseId )
		{
			return aLootlistIds;
		}

		var count = ItemInfo.GetLootListCount( caseId );
		for ( var i = 0; i < count; i++ )
		{
			aLootlistIds.push( ItemInfo.GetLootListItemByIndex( caseId, i ) );
		}

		return aLootlistIds;
	}

	var _UpdateLootlistTitleBar = function( count )
	{
		var caseId = $.GetContextPanel().GetAttributeString( "caseidforlootlist", "" );

		var elPanel = $.GetContextPanel().FindChildInLayoutFile( 'id-lootlist-title-container' );
		elPanel.SetDialogVariable( 'container', InventoryAPI.GetItemName( caseId ) );
		elPanel.SetDialogVariableInt( 'index', m_lootlistItemIndex + 1);
		elPanel.SetDialogVariableInt( 'total', count );
	};

	var _ItemAcquired = function( ItemId )
	{
		var storeItemId = $.GetContextPanel().GetAttributeString( "storeitemid", "" );
		if( storeItemId )
		{
			var storeItemSeasonAccess = InventoryAPI.GetItemAttributeValue( storeItemId, 'season access' );
			var acquiredItemSeasonAccess = InventoryAPI.GetItemAttributeValue( ItemId, 'season access' );
			if( storeItemSeasonAccess === acquiredItemSeasonAccess )
			{
				var nSeasonAccess = GameTypesAPI.GetActiveSeasionIndexValue();
				var nCoinRank = MyPersonaAPI.GetMyMedalRankByType( ( nSeasonAccess + 1 ) + "Operation$OperationCoin" );

				                                                                    
				if( nCoinRank === 1 && nSeasonAccess === acquiredItemSeasonAccess )
				{
					_ClosePopup();
					$.DispatchEvent( 'HideStoreStatusPanel' );
	
					UiToolkitAPI.ShowCustomLayoutPopupParameters(
						'',
						'file://{resources}/layout/popups/popup_inventory_inspect.xml',
						'itemid=' + ItemId +
						'&' + 'asyncworktype=useitem' + 
						'&' + 'seasonpass=true' +
						'&' + 'bluroperationpanel=true'
					);
	
					return;
				}
			}

			var defName = ItemInfo.GetItemDefinitionName(  InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( g_ActiveTournamentInfo.itemid_charge, 0 ));
			if ( ItemInfo.ItemMatchDefName( storeItemId, defName ) &&
				ItemInfo.ItemMatchDefName( ItemId, defName ) )
			{
				                                                        
				_ClosePopup();
				$.DispatchEvent( 'ShowAcknowledgePopup', '', '' );
				$.DispatchEvent( 'HideStoreStatusPanel' );

				return;
			}

			_ClosePopup();
			$.DispatchEvent( 'ShowAcknowledgePopup', '', ItemId );
			$.DispatchEvent( 'HideStoreStatusPanel' );
		}
	};

	var _ClosePopup = function()
	{
		var elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectAsyncBar' );
		var elPurchase = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectPurchaseBar' );
		var elInspectBar = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectActionBar' );

		if( !elAsyncActionBarPanel.BHasClass( 'hidden' ))
		{
			InspectAsyncActionBar.OnEventToClose();
		}
		else if ( !elPurchase.BHasClass( 'hidden' ) )
		{
			InspectPurchaseBar.ClosePopup();
		}
		else
		{
			InspectActionBar.CloseBtnAction();
		}
	};

	var _Refresh = function()
	{
		let itemId = $.GetContextPanel().GetAttributeString( "itemid", null );
		if( !itemId || !InventoryAPI.IsValidItemID( itemId ) )
		{
			ClosePopup();
			return;
		}
		
		_UpdatePanelData( itemId );
		InspectActionBar.NavigateModelPanel('InspectModel');
	}

	return{
		Init: _Init,
		ShowNotification: _ShowNotification,
		ClosePopup: _ClosePopup,
		ItemAcquired: _ItemAcquired,
		Refresh: _Refresh
	};
} )();

( function()
{
	$.RegisterForUnhandledEvent( 'PanoramaComponent_Loadout_EquipSlotChanged', InventoryInspect.ShowNotification );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_Store_PurchaseCompleted', InventoryInspect.ItemAcquired );
	$.RegisterForUnhandledEvent( 'CSGOShowMainMenu', InventoryInspect.Refresh );
	$.RegisterForUnhandledEvent( 'PopulateLoadingScreen', InventoryInspect.ClosePopup );
} )();
