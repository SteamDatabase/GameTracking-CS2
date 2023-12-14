'use strict';

var ContextMenuAddToCart = ( function (){

	var _Init = function ()
	{
		var _OnActivateStoreItem = function( elItem, id, type )
		{
			if ( type === "megabundle" )
			{
				elItem.SetPanelEvent( 'onactivate', _ShowInspectPopup.bind( undefined, id ) );
			}
			else if( type === "capsule" )
			{
				elItem.SetPanelEvent( 'onactivate', _ShowDecodePopup.bind( undefined, id ) );
			}
			else
			{
				elItem.SetPanelEvent( 'onactivate', _ShowInspectPopup.bind( undefined, id ) );
			}
		};

		var _ShowMegaBundlePopup = function( id )
		{

			UiToolkitAPI.ShowCustomLayoutPopupParameters(
				'',
				'file://{resources}/layout/popups/popup_inventory_inspect.xml',
				'itemid=' + id +
				'&' + 'extrapopupfullscreenstyle=solidbkgnd' +
				'&' + 'inspectonly=true' +
				'&' + 'asyncworkitemwarning=no' +
				'&' + 'allowsave=false' +
				'&' + 'showequip=false' +
				'&' + 'showitemcert=false' +
				'&' + 'showmarketlink=false',
				'&' + 'asyncworkbtnstyle=hidden' +
				'none'
			);
		};

		var _ShowDecodePopup = function( id )
		{
			                                  
			UiToolkitAPI.ShowCustomLayoutPopupParameters(
				'',
				'file://{resources}/layout/popups/popup_capability_decodable.xml',
				'key-and-case=' + '' + ',' + id +
				'&' + 'extrapopupfullscreenstyle=solidbkgnd' +
				'&' + 'asyncworkitemwarning=no' +
				'&' + 'inspectonly=true' +
				'&' + 'allowtointeractwithlootlistitems=false' +
				'&' + 'asyncworktype=cartpreview' +
				'&' + 'asyncworkbtnstyle=hidden' +
				'&' + 'storeitemid=' + id
			);
		};

		var _ShowInspectPopup = function( id )
		{
			                                   
			UiToolkitAPI.ShowCustomLayoutPopupParameters(
				'',
				'file://{resources}/layout/popups/popup_inventory_inspect.xml',
				'itemid=' + id +
				'&' + 'extrapopupfullscreenstyle=solidbkgnd' +
				'&' + 'inspectonly=true' +
				'&' + 'allowsave=false' +
				'&' + 'showequip=false' +
				'&' + 'showitemcert=false' +
				'&' + 'showmarketlink=false',
				'none'
			);
		};

		function AddItemEntry( elParent, defIdx )
		{
			var elItemEntry = $.CreatePanel( "Panel", elParent, "item_" + defIdx );
			elItemEntry.BLoadLayoutSnippet( "Item" );
			var itemID = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( defIdx, 0 );
			var elItemImage = elItemEntry.FindChildTraverse( "ItemImage" );
			elItemImage.large = true;
			elItemImage.itemid = itemID;

			var _ShowTooltip = function( itemID )
			{
				if ( !InventoryAPI.IsItemInfoValid( itemID ) )
				{
					return;
				}
		
				UiToolkitAPI.ShowCustomLayoutParametersTooltip(
					'ItemImage',
					'JsItemTooltip',
					'file://{resources}/layout/tooltips/tooltip_inventory_item.xml',
					'itemid=' + itemID
				);
			};

			                                                                                                              
			var count = ItemInfo.GetLootListCount( itemID );
			                                                                                                                                                                   
			if ( count == 0 )
			{	              
				elItemEntry.SetDialogVariable( "name", ItemInfo.GetName( itemID ) );
				_OnActivateStoreItem( elItemImage, itemID, "megabundle" );
			}
			else if ( count == 1 )
			{	                                    
				var containedItem = ItemInfo.GetLootListItemByIndex( itemID, 0 );
				elItemEntry.SetDialogVariable( "name", $.Localize( InventoryAPI.GetItemBaseName( containedItem ) ) );
				_OnActivateStoreItem( elItemImage, ItemInfo.GetLootListItemByIndex( itemID, 0 ), "1" );
			}
			else
			{	                   
				elItemEntry.SetDialogVariable( "name", ItemInfo.GetName( itemID ) );
				_OnActivateStoreItem( elItemImage, itemID, "capsule" );
			}
			var itemCountFuncName = $.GetContextPanel().GetAttributeString( "item_count_func_name", null );

			function UpdateCount()
			{
				var countFunc = $('#ItemContainer').Data[ itemCountFuncName ];
				var nCount = ( typeof countFunc  === "function" ) ? countFunc( defIdx ) : 0;
				elItemEntry.SetDialogVariable( "s1", nCount );

				var itemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( defIdx, 0 );

				var nCountForPriceDisplay = ( nCount > 0 ) ? nCount : 1;                                           
				var price = ItemInfo.GetStoreSalePrice( itemId, nCountForPriceDisplay );
				elItemEntry.SetDialogVariable( "price", price );

				var reduction = ItemInfo.GetStoreSalePercentReduction( itemId, nCountForPriceDisplay );
				var elOriginalPrice = elItemEntry.FindChildInLayoutFile( 'ItemPriceOriginal' );

				if( reduction )
				{
					elOriginalPrice.visible = true;
					var originalPrice = ItemInfo.GetStoreOriginalPrice( itemId, nCountForPriceDisplay );
					elItemEntry.SetDialogVariable( "originalprice", originalPrice );
				}
				else
				{
					elOriginalPrice.visible = false;
				}
			}

			elItemEntry.FindChildTraverse( "RemoveItem" ).SetPanelEvent( "onactivate", function ()
			{
				$.DispatchEvent( "RemoveItemFromCart", defIdx );
				UpdateCount();
			} );

			elItemEntry.FindChildTraverse( "AddItem" ).SetPanelEvent( "onactivate", function ()
			{
				$.DispatchEvent( "AddItemToCart", defIdx );
				UpdateCount();
			} );

			UpdateCount();
		}

		var elParent = $( "#ItemContainer" );
		var items = $.GetContextPanel().GetAttributeString( "items", "" ).split( ',' );
		items.forEach( itemDefIdx => {
			AddItemEntry( elParent, itemDefIdx );
		});

	};

	return {
		Init		:	_Init 
	};

})();

                                                                                                    
                                            
                                                                                                    
(function(){
})();