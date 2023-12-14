'use strict';

var Crafting = ( function ()
{
    var _Init = function()
    {
        _AddSort();
    }    

    var _AddSort = function()
	{
		var elDropdown = $.GetContextPanel().FindChildInLayoutFile( 'CraftingSortDropdown' );
		var count = InventoryAPI.GetSortMethodsCount();

		for ( var i = 0; i < count; i++ ) 
		{
			var sort = InventoryAPI.GetSortMethodByIndex( i );
			var newEntry = $.CreatePanel( 'Label', elDropdown, sort, {
				class: 'DropDownMenu'
			} );

			newEntry.text = $.Localize( '#' + sort );
			elDropdown.AddOption( newEntry );
		}

		                        
		elDropdown.SetSelected( InventoryAPI.GetSortMethodByIndex( 1 ) );
	};

    var _UpdateButtons = function ()
    {
        var elTradeUpConfirmBtn = $.GetContextPanel().FindChildTraverse( 'TradeUpConfirmBtn' );
        elTradeUpConfirmBtn.enabled = InventoryAPI.IsCraftReady();
        if ( !elTradeUpConfirmBtn.enabled )
        {
            elTradeUpConfirmBtn.checked = false;
        }    

        var elClearIngredientsBtn = $.GetContextPanel().FindChildTraverse( 'ClearIngredientsBtn' );
        elClearIngredientsBtn.enabled = InventoryAPI.GetCraftIngredientCount() > 0;

        var elCraftItemBtn = $.GetContextPanel().FindChildTraverse( 'CraftItemBtn' );
        elCraftItemBtn.enabled = elTradeUpConfirmBtn.checked;
    }

    var _UpdateItemList = function()
    {
                                                                  
                                                                                            
                                                                        
        var elDropdown = $.GetContextPanel().FindChildInLayoutFile( 'CraftingSortDropdown' );
		var sortType = elDropdown.GetSelected().id;

        $.DispatchEvent( 'SetInventoryFilter',
            $( '#Crafting-Items' ),
            'inv_group_equipment',
            'any',
            'any',
            sortType,
            'recipe',                                 
            ''               
        );
    }

    var _UpdateCraftingPanelDisplay = function()
	{
        _UpdateButtons();

		                          
        {
            _UpdateItemList();

			$.DispatchEvent( 'SetInventoryFilter',
				$( '#Crafting-Ingredients' ),
				'inv_group_equipment',
				'any',
				'any',
				'',
				'ingredient',                            
				''               
			);
        }
        
                       
         {
            function _UpdateItemCount( ItemListName, LabelName )
            {
                var elItemList = $.GetContextPanel().FindChildTraverse( ItemListName );
                var elLabel = $.GetContextPanel().FindChildTraverse( LabelName );
                elLabel.SetDialogVariableInt( 'count', elItemList.count );
            }

            _UpdateItemCount( 'Crafting-Items', 'CraftingItemsText' );
            _UpdateItemCount( 'Crafting-Ingredients', 'CraftingIngredientsText' );
        }
    }

                          
    return {
        Init: _Init,
        UpdateCraftingPanelDisplay: _UpdateCraftingPanelDisplay,
        UpdateButtons: _UpdateButtons,
        UpdateItemList: _UpdateItemList
    };

} )();

                                                                                                    
                                           
                                                                                                    
(function ()
{
    Crafting.Init();
    
    $.RegisterForUnhandledEvent( 'UpdateTradeUpPanel', Crafting.UpdateCraftingPanelDisplay );
    $.RegisterForUnhandledEvent( 'PanoramaComponent_Inventory_CraftIngredientAdded', Crafting.UpdateCraftingPanelDisplay );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_Inventory_CraftIngredientRemoved', Crafting.UpdateCraftingPanelDisplay );
})();
