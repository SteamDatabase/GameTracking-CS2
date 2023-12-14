           
   
                                                                                                 
                                                                                          

"use strict";

                                                        
function UpdateStoreTiles() {
	                                                                          
	var banner_layout = StoreAPI.GetStoreLayoutObject(); 
	var bannerContents = $("#BannerContents");
	                                          
	Object.keys(banner_layout).forEach( function( key, index ) {
		var item = banner_layout[key];
		var storeTile = $.CreatePanel( "Panel", bannerContents, "" );
		storeTile.BLoadLayout( "file://{resources}/layout/storeitem.xml", false, false );
		storeTile.SetAttributeInt( "item_defidx", parseInt( key, 10 ) );
		var ItemDef = JSON.parse( InventoryAPI.GetEconItemDefinition( parseInt( key, 10 ) ) );
		storeTile.FindChildInLayoutFile( "ItemTitle" ).text = $.Localize( ItemDef.item_name );
		storeTile.FindChildInLayoutFile( "ItemDescription" ).text = $.Localize( "#SFUI_Store_Hint_" + ItemDef.name.split(' ').join('_') );
		var storeButton = storeTile.FindChildInLayoutFile( "ItemButton" );
		storeButton.BuyStoreItem = function () {
			var parentPanel = $.GetContextPanel();                                             
			                                                  
			}

		if ( item.market_link ) {
			storeButton.text = "#SFUI_Store_Market_Link";
		}
		else {
			storeButton.text = "price";
		}

		                                                        
		if ( item.custom_format === "double" ) {
			storeTile.AddClass( "Double" );
		}
		else if ( item.custom_format === "Triple" ) {
			storeTile.AddClass( "Triple" );
		}
	});
}


                                                                                    

                                                                                                    
                                           
                                                                                                    
(function()
{
	$.RegisterForUnhandledEvent( "PanoramaComponent_Store_UpdateStoreTiles", UpdateStoreTiles );
	StoreAPI.RequestStoreLayout();
})();
