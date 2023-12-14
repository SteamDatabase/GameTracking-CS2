"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/tint_spray_icon.ts" />
/// <reference path="common/store_items.ts" />
/// <reference path="common/formattext.ts" />
/// <reference path="common/iteminfo.ts" />
/// <reference path="rankup_redemption_store.ts" />
var ItemTileStore;
(function (ItemTileStore) {
    function Init(elPanel, oItemData) {
        if (oItemData.hasOwnProperty('noDropsEarned') && oItemData.noDropsEarned) {
            elPanel.SetHasClass('no-drops-earned', true);
            return;
        }
        elPanel.SetHasClass('no-drops-earned', false);
        SetDropItemStyle(elPanel, oItemData);
        SetItemImages(elPanel, oItemData);
        SetName(elPanel, oItemData);
        SetStatTrack(elPanel, oItemData.id);
        SetNewRelease(elPanel, (isNewRelease(oItemData) || oItemData.isDropItem));
        SetPrice(elPanel, oItemData);
        SetOnActivate(elPanel, oItemData);
        SetClaimed(elPanel, oItemData);
        SetSelected(elPanel, oItemData);
        AddMouseOverEvents(elPanel, oItemData);
    }
    ItemTileStore.Init = Init;
    function SetItemImages(elPanel, oItemData) {
        let displayId = GetDisplayItemId(oItemData, oItemData.id);
        let elImage = elPanel.FindChildInLayoutFile('id-itemtile-store-image-main');
        elImage.itemid = displayId;
        TintSprayImage(elImage, displayId);
        elImage = elPanel.FindChildInLayoutFile('id-itemtile-store-image-bg');
        elImage.itemid = displayId;
        if (oItemData.hasOwnProperty('linkedid')) {
            displayId = GetDisplayItemId(oItemData, oItemData.linkedid);
            elImage = elPanel.FindChildInLayoutFile('id-itemtile-store-image-linked');
            elImage.itemid = displayId;
        }
        elPanel.FindChildInLayoutFile('id-itemtile-store-image-linked').visible = oItemData.hasOwnProperty('linkedid');
        elPanel.SetHasClass('is-linked', oItemData.hasOwnProperty('linkedid'));
    }
    function TintSprayImage(elImage, ItemId) {
        TintSprayIcon.CheckIsSprayAndTint(ItemId, elImage);
    }
    function GetDisplayItemId(oItemData, itemId) {
        if (InventoryAPI.GetItemTypeFromEnum(itemId) === 'coupon')
            return InventoryAPI.GetLootListItemIdByIndex(itemId, 0);
        return itemId;
    }
    function SetName(elPanel, oItemData) {
        var strItemName = '';
        if (oItemData.useTinyNames) {
            strItemName = $.Localize(InventoryAPI.GetRawDefinitionKey(oItemData.id, 'item_name') + '_tinyname');
        }
        else {
            strItemName = ItemInfo.GetName(oItemData.linkedid ? oItemData.linkedid : oItemData.id);
        }
        elPanel.SetDialogVariable('item-name', strItemName);
    }
    function SetStatTrack(elPanel, itemId) {
        let elStattrak = elPanel.FindChildInLayoutFile('id-itemtile-store-stattrak');
        elStattrak.SetHasClass('hidden', !ItemInfo.IsStatTrak(itemId));
    }
    function SetNewRelease(elPanel, isNew) {
        let elNew = elPanel.FindChildInLayoutFile('id-itemtile-store-new');
        elNew.SetHasClass('hidden', !isNew);
    }
    function SetPrice(elPanel, oItemData) {
        if (oItemData.isDropItem) {
            elPanel.SetDialogVariable('sale-price', $.Localize('#op_reward_free'));
            return;
        }
        let reduction = ItemInfo.GetStoreSalePercentReduction(oItemData.id);
        let isMarketItem = IsMarketItem(oItemData);
        elPanel.FindChildInLayoutFile('id-itemtile-store-price').SetHasClass('is-marketlink', isMarketItem);
        elPanel.FindChildInLayoutFile('id-itemtile-store-price').SetHasClass('has-reduction', reduction !== '' && reduction !== undefined && !isMarketItem);
        elPanel.SetDialogVariable('reduction', reduction);
        let origPrice = (oItemData.hasOwnProperty('linkedid')) &&
            ItemInfo.GetStoreOriginalPrice(oItemData.linkedid, 1) !== ItemInfo.GetStoreOriginalPrice(oItemData.id, 1) ?
            ItemInfo.GetStoreOriginalPrice(oItemData.linkedid, 1) + ' - ' + ItemInfo.GetStoreOriginalPrice(oItemData.id, 1) :
            ItemInfo.GetStoreOriginalPrice(oItemData.id, 1);
        let salePrice = (isMarketItem) ?
            $.Localize('#SFUI_Store_Market_Link') :
            (oItemData.hasOwnProperty('linkedid')) &&
                ItemInfo.GetStoreOriginalPrice(oItemData.linkedid, 1) !== ItemInfo.GetStoreOriginalPrice(oItemData.id, 1) ?
                ItemInfo.GetStoreSalePrice(oItemData.linkedid, 1) + ' - ' + ItemInfo.GetStoreSalePrice(oItemData.id, 1) :
                ItemInfo.GetStoreSalePrice(oItemData.id, 1);
        elPanel.SetDialogVariable('original-price', origPrice);
        elPanel.SetDialogVariable('sale-price', salePrice);
    }
    function SetDropItemStyle(elPanel, oItemData) {
        if (oItemData.hasOwnProperty('isDropItem')) {
            elPanel.SetHasClass('is-drop-item', oItemData.isDropItem);
            if (oItemData.isDropItem) {
                elPanel.SetHasClass('is-case-drop', ItemInfo.IsCase(oItemData.id));
            }
        }
        else {
            elPanel.SetHasClass('is-drop-item', false);
        }
    }
    function SetClaimed(elPanel, oItemData) {
        if (oItemData.isDropItem) {
            const bIsFauxItem = InventoryAPI.IsFauxItemID(oItemData.id);
            elPanel.SetHasClass('item-claimed', bIsFauxItem);
        }
    }
    function SetSelected(elPanel, oItemData) {
    }
    function isNewRelease(oItemData) {
        if (oItemData.hasOwnProperty('isNewRelease')) {
            return oItemData.isNewRelease ? true : false;
        }
        return false;
    }
    function IsMarketItem(oItemData) {
        if (oItemData.hasOwnProperty('isMarketItem')) {
            return oItemData.isMarketItem ? true : false;
        }
        return false;
    }
    function SetOnActivate(elPanel, oItemData) {
        if (oItemData.isDropItem || oItemData.isDisabled) {
            return;
        }
        else if (IsMarketItem(oItemData)) {
            elPanel.SetPanelEvent('onactivate', OpenOverlayToMarket.bind(undefined, oItemData.id));
        }
        else if (oItemData.hasOwnProperty('linkedid')) {
            let OpenContextMenu = function (itemId, linkedid, isNotReleased, warning) {
                var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParameters('', '', 'file://{resources}/layout/context_menus/context_menu_store_linked_items.xml', 'itemids=' + itemId + ',' + linkedid +
                    'is-not-released' + isNotReleased +
                    'warning' + warning);
                contextMenuPanel.AddClass("ContextMenu_NoArrow");
            };
            let isNotReleased = oItemData.isNotReleased ? 'true' : 'false';
            let warning = oItemData.linkedWarning ? oItemData.linkedWarning : '';
            elPanel.SetPanelEvent('onactivate', OpenContextMenu.bind(undefined, oItemData.id, oItemData.linkedid, isNotReleased, warning));
            elPanel.SetPanelEvent('oncontextmenu', OpenContextMenu.bind(undefined, oItemData.id, oItemData.linkedid, isNotReleased, warning));
        }
        else if (ItemInfo.ItemHasCapability(oItemData.id, 'decodable')) {
            let displayItemId = '';
            let isNew = isNewRelease(oItemData);
            if (InventoryAPI.GetItemTypeFromEnum(oItemData.id) === 'coupon') {
                displayItemId = InventoryAPI.GetLootListItemIdByIndex(oItemData.id, 0);
                elPanel.SetPanelEvent('onactivate', ShowDecodePopup.bind(undefined, oItemData.id, displayItemId, isNew));
            }
            else if (ItemInfo.GetLootListCount(oItemData.id) > 0) {
                elPanel.SetPanelEvent('onactivate', ShowDecodePopup.bind(undefined, oItemData.id, oItemData.id, isNew));
            }
            else {
                elPanel.SetPanelEvent('onactivate', ShowInpsectPopup.bind(undefined, oItemData.id));
            }
        }
        else
            elPanel.SetPanelEvent('onactivate', ShowInpsectPopup.bind(undefined, oItemData.id));
    }
    function OpenOverlayToMarket(itemId) {
        let m_AppID = SteamOverlayAPI.GetAppID();
        let m_CommunityUrl = SteamOverlayAPI.GetSteamCommunityURL();
        let strSetName = InventoryAPI.GetItemSet(itemId);
        SteamOverlayAPI.OpenURL(m_CommunityUrl + "/market/search?q=&appid=" + m_AppID + "&lock_appid=" + m_AppID + "&category_" + m_AppID + "_ItemSet%5B%5D=tag_" + strSetName);
        StoreAPI.RecordUIEvent("ViewOnMarket");
    }
    function ShowDecodePopup(id, displayItemId, isNew) {
        var strExtraSettings = '';
        if (isNew) {
            strExtraSettings = '&overridepurchasemultiple=1';
        }
        UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + id, 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=' + '' + ',' + displayItemId
            + '&' +
            'asyncworkitemwarning=no'
            + '&' +
            'asyncforcehide=true'
            + '&' +
            'storeitemid=' + id
            + strExtraSettings);
    }
    ;
    function ShowInpsectPopup(id) {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + id
            + '&' +
            'inspectonly=false'
            + '&' +
            'asyncworkitemwarning=no'
            + '&' +
            'storeitemid=' + id);
    }
    ;
    let jsTooltipDelayHandle = null;
    function AddMouseOverEvents(elPanel, oItemData) {
        const tooltipHotspot = elPanel.FindChildTraverse('tooltip-hotspot');
        const tooltipTargetPanelId = oItemData.isDropItem ? elPanel.id : oItemData.hasOwnProperty('linkedid') ? 'tooltip-hotspot' : 'id-itemtile-store-image-main';
        tooltipHotspot.SetPanelEvent('onmouseover', ShowTooltip.bind(undefined, elPanel, oItemData, tooltipTargetPanelId));
        tooltipHotspot.SetPanelEvent('onmouseout', HideTooltip);
    }
    function ShowTooltip(elPanel, oItemData, tooltipTargetPanelId) {
        jsTooltipDelayHandle = $.Schedule(.1, ShowToolTipOnDelay.bind(undefined, elPanel, oItemData, tooltipTargetPanelId));
    }
    function ShowToolTipOnDelay(elPanel, oItemData, tooltipTargetPanelId) {
        jsTooltipDelayHandle = null;
        let itemId = GetDisplayItemId(oItemData, oItemData.id);
        if (!InventoryAPI.IsItemInfoValid(itemId)) {
            return;
        }
        if (oItemData.hasOwnProperty('linkedid')) {
            UiToolkitAPI.ShowTextTooltip(tooltipTargetPanelId, '#store_linked_item_tooltip');
            return;
        }
        UiToolkitAPI.ShowCustomLayoutParametersTooltip(tooltipTargetPanelId, 'JsItemStoreTooltip', 'file://{resources}/layout/tooltips/tooltip_inventory_item.xml', 'itemid=' + itemId);
    }
    ;
    function HideTooltip() {
        UiToolkitAPI.HideCustomLayoutTooltip('JsItemStoreTooltip');
        UiToolkitAPI.HideTextTooltip();
        if (jsTooltipDelayHandle) {
            $.CancelScheduled(jsTooltipDelayHandle);
            jsTooltipDelayHandle = null;
        }
    }
    ;
})(ItemTileStore || (ItemTileStore = {}));
(function () {
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaXRlbXRpbGVfc3RvcmUuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9pdGVtdGlsZV9zdG9yZS50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsa0NBQWtDO0FBQ2xDLGtEQUFrRDtBQUNsRCw4Q0FBOEM7QUFDOUMsNkNBQTZDO0FBQzdDLDJDQUEyQztBQUMzQyxtREFBbUQ7QUFFbkQsSUFBVSxhQUFhLENBa1d0QjtBQWxXRCxXQUFVLGFBQWE7SUFFdEIsU0FBZ0IsSUFBSSxDQUFHLE9BQWdCLEVBQUUsU0FBcUI7UUFFN0QsSUFBSyxTQUFTLENBQUMsY0FBYyxDQUFFLGVBQWUsQ0FBRSxJQUFJLFNBQVMsQ0FBQyxhQUFhLEVBQzNFO1lBQ0MsT0FBTyxDQUFDLFdBQVcsQ0FBRSxpQkFBaUIsRUFBRSxJQUFJLENBQUUsQ0FBQztZQUMvQyxPQUFPO1NBQ1A7UUFFRCxPQUFPLENBQUMsV0FBVyxDQUFFLGlCQUFpQixFQUFFLEtBQUssQ0FBRSxDQUFDO1FBRWhELGdCQUFnQixDQUFFLE9BQU8sRUFBRSxTQUFTLENBQUUsQ0FBQztRQUN2QyxhQUFhLENBQUUsT0FBTyxFQUFFLFNBQVMsQ0FBRSxDQUFDO1FBQ3BDLE9BQU8sQ0FBRSxPQUFPLEVBQUUsU0FBUyxDQUFFLENBQUM7UUFDOUIsWUFBWSxDQUFFLE9BQU8sRUFBRSxTQUFTLENBQUMsRUFBRSxDQUFFLENBQUM7UUFDdEMsYUFBYSxDQUFFLE9BQU8sRUFBRSxDQUFFLFlBQVksQ0FBRSxTQUFTLENBQUUsSUFBSSxTQUFTLENBQUMsVUFBVyxDQUFFLENBQUMsQ0FBQztRQUNoRixRQUFRLENBQUUsT0FBTyxFQUFFLFNBQVMsQ0FBRSxDQUFDO1FBQy9CLGFBQWEsQ0FBRSxPQUFPLEVBQUUsU0FBUyxDQUFFLENBQUM7UUFDcEMsVUFBVSxDQUFFLE9BQU8sRUFBRSxTQUFTLENBQUUsQ0FBQztRQUNqQyxXQUFXLENBQUUsT0FB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