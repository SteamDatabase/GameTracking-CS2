"use strict";
/// <reference path="csgo.d.ts" />
var Crafting;
(function (Crafting) {
    function _Init() {
        _AddSort();
    }
    function _AddSort() {
        let elDropdown = $.GetContextPanel().FindChildInLayoutFile('CraftingSortDropdown');
        let count = InventoryAPI.GetSortMethodsCount();
        for (let i = 0; i < count; i++) {
            let sort = InventoryAPI.GetSortMethodByIndex(i);
            let newEntry = $.CreatePanel('Label', elDropdown, sort, {
                class: 'DropDownMenu'
            });
            newEntry.text = $.Localize('#' + sort);
            elDropdown.AddOption(newEntry);
        }
        elDropdown.SetSelected(InventoryAPI.GetSortMethodByIndex(1));
    }
    function UpdateButtons() {
        let elTradeUpConfirmBtn = $.GetContextPanel().FindChildTraverse('TradeUpConfirmBtn');
        elTradeUpConfirmBtn.enabled = InventoryAPI.IsCraftReady();
        if (!elTradeUpConfirmBtn.enabled) {
            elTradeUpConfirmBtn.checked = false;
        }
        let elClearIngredientsBtn = $.GetContextPanel().FindChildTraverse('ClearIngredientsBtn');
        elClearIngredientsBtn.enabled = InventoryAPI.GetCraftIngredientCount() > 0;
        let elCraftItemBtn = $.GetContextPanel().FindChildTraverse('CraftItemBtn');
        elCraftItemBtn.enabled = elTradeUpConfirmBtn.checked;
    }
    Crafting.UpdateButtons = UpdateButtons;
    function UpdateItemList() {
        let elDropdown = $.GetContextPanel().FindChildInLayoutFile('CraftingSortDropdown');
        let sortType = elDropdown.GetSelected().id;
        $.DispatchEvent('SetInventoryFilter', $('#Crafting-Items'), 'inv_group_equipment', 'any', 'any', sortType, 'recipe,is_rental:false', '');
    }
    Crafting.UpdateItemList = UpdateItemList;
    function _UpdateCraftingPanelDisplay() {
        UpdateButtons();
        {
            UpdateItemList();
            $.DispatchEvent('SetInventoryFilter', $('#Crafting-Ingredients'), 'inv_group_equipment', 'any', 'any', '', 'ingredient', '');
        }
        {
            function _UpdateItemCount(ItemListName, LabelName) {
                let elItemList = $.GetContextPanel().FindChildTraverse(ItemListName);
                let elLabel = $.GetContextPanel().FindChildTraverse(LabelName);
                elLabel.SetDialogVariableInt('count', elItemList.count);
            }
            _UpdateItemCount('Crafting-Items', 'CraftingItemsText');
            _UpdateItemCount('Crafting-Ingredients', 'CraftingIngredientsText');
        }
    }
    {
        _Init();
        $.RegisterForUnhandledEvent('UpdateTradeUpPanel', _UpdateCraftingPanelDisplay);
        $.RegisterForUnhandledEvent('PanoramaComponent_Inventory_CraftIngredientAdded', _UpdateCraftingPanelDisplay);
        $.RegisterForUnhandledEvent('PanoramaComponent_Inventory_CraftIngredientRemoved', _UpdateCraftingPanelDisplay);
    }
})(Crafting || (Crafting = {}));
