"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/iteminfo.ts" />
var InspectPurchaseBar;
(function (InspectPurchaseBar) {
    let m_itemid = '';
    let m_storeItemid = '';
    let m_elPanel = null;
    let m_showToolUpsell = false;
    let m_showXrayMachineUi = false;
    let m_allowXrayPurchase = false;
    let m_nOverridePurchaseMultiple = -1;
    function Init(elPanel, itemId, funcGetSettingCallback) {
        m_storeItemid = funcGetSettingCallback("storeitemid", "");
        m_showXrayMachineUi = (funcGetSettingCallback("showXrayMachineUi", "no") === 'yes');
        m_allowXrayPurchase = (funcGetSettingCallback("allowxraypurchase", "no") === 'yes');
        let paramOverridePurchaseMultiple = funcGetSettingCallback("overridepurchasemultiple", "");
        if (paramOverridePurchaseMultiple === '1') {
            m_nOverridePurchaseMultiple = 1;
        }
        else if (paramOverridePurchaseMultiple === '0') {
            m_nOverridePurchaseMultiple = 0;
        }
        m_itemid = !m_storeItemid ? itemId : m_storeItemid;
        let bFauxItemIdForPurchase = InventoryAPI.IsFauxItemID(m_itemid);
        let priceOriginal = bFauxItemIdForPurchase ? ItemInfo.GetStoreOriginalPrice(m_itemid, 1) : '';
        let sRestriction = (funcGetSettingCallback('restriction', ''));
        if (funcGetSettingCallback('onlyclosepurchasebar', 'false') === 'true') {
            elPanel.FindChildInLayoutFile('id-purchase-section').visible = false;
            elPanel.RemoveClass('hidden');
            return;
        }
        if ((funcGetSettingCallback('asyncworktype', '') === 'delete') ||
            (funcGetSettingCallback('inspectonly', 'false') === 'true') ||
            !InventoryAPI.IsValidItemID(m_itemid) ||
            !priceOriginal ||
            sRestriction === 'xray' && !m_showXrayMachineUi ||
            sRestriction === 'restricted') {
            elPanel.AddClass('hidden');
            return;
        }
        m_elPanel = elPanel;
        m_showToolUpsell = (funcGetSettingCallback("toolid", '') === '');
        elPanel.RemoveClass('hidden');
        _SetPurchaseImage(elPanel, itemId);
        _SetDialogVariables(elPanel, m_itemid);
        _UpdateDecString(elPanel, funcGetSettingCallback);
        _SetUpPurchaseBtn(elPanel);
        _UpdatePurchasePrice();
    }
    InspectPurchaseBar.Init = Init;
    function _SetDialogVariables(elPanel, itemId) {
        elPanel.SetDialogVariable("itemname", InventoryAPI.GetItemName(itemId));
    }
    function _SetPurchaseImage(elPanel, itemId) {
        let elImage = elPanel.FindChildInLayoutFile('PurchaseItemImage');
        elImage.itemid = itemId;
        elImage.SetHasClass('popup-capability-faded', m_showXrayMachineUi && !m_allowXrayPurchase);
    }
    function _UpdateDecString(elPanel, funcGetSettingCallback) {
        let elDesc = m_elPanel.FindChildInLayoutFile('PurchaseItemName');
        if (m_showXrayMachineUi) {
            elPanel.SetDialogVariable("itemprice", ItemInfo.GetStoreSalePrice(m_itemid, 1));
            elDesc.text = "#popup_capability_upsell_xray";
        }
        else if (!m_storeItemid && m_showToolUpsell) {
            elDesc.text = funcGetSettingCallback("allow-rent", "no") === 'yes' ? '#popup_capability_upsell_rental' : '#popup_capability_upsell';
        }
        else {
            elDesc.text = "#popup_capability_use";
        }
        elDesc.SetHasClass('popup-capability-faded', m_showXrayMachineUi && !m_allowXrayPurchase);
    }
    function _UpdatePurchasePrice() {
        if (!m_elPanel || !m_elPanel.IsValid())
            return;
        let elBtn = m_elPanel.FindChildInLayoutFile('PurchaseBtn');
        let elDropdown = m_elPanel.FindChildInLayoutFile('PurchaseCountDropdown');
        let qty = 1;
        let bCanShowQuantityDropdown = !m_showXrayMachineUi && _isAllowedToPurchaseMultiple();
        elDropdown.visible = bCanShowQuantityDropdown;
        if (bCanShowQuantityDropdown) {
            qty = Number(elDropdown.GetSelected().id);
        }
        let salePrice = ItemInfo.GetStoreSalePrice(m_itemid, qty);
        elBtn.text = m_showXrayMachineUi ? '#popup_totool_purchase_header2' : salePrice;
        _UpdateSalePrice(ItemInfo.GetStoreOriginalPrice(m_itemid, qty));
    }
    function _isAllowedToPurchaseMultiple() {
        if (m_nOverridePurchaseMultiple >= 0)
            return (m_nOverridePurchaseMultiple === 1);
        let attValue = InventoryAPI.GetItemAttributeValue(m_itemid, 'season access');
        if (attValue)
            return false;
        let strToolType = InventoryAPI.GetToolType(m_itemid);
        if (strToolType === 'fantoken')
            return false;
        let defName = InventoryAPI.GetItemDefinitionName(m_itemid);
        if (defName === 'casket')
            return false;
        if (defName && defName.startsWith('XpShopTicket'))
            return false;
        return true;
    }
    function _SetUpPurchaseBtn(elPanel) {
        elPanel.FindChildInLayoutFile('PurchaseBtn').enabled = !m_showXrayMachineUi || (m_showXrayMachineUi && m_allowXrayPurchase);
        elPanel.FindChildInLayoutFile('PurchaseBtn').SetPanelEvent('onactivate', _OnActivate);
    }
    function _UpdateSalePrice(salePrice) {
        let elSalePrice = m_elPanel.FindChildInLayoutFile('PurchaseSalePrice');
        let elSalePercent = m_elPanel.FindChildInLayoutFile('PurchaseItemPercent');
        let salePercent = StoreAPI.GetStoreItemPercentReduction(m_itemid);
        if (salePercent) {
            elSalePrice.visible = true;
            elSalePrice.text = salePrice;
            elSalePercent.visible = true;
            elSalePercent.text = salePercent;
            return;
        }
        elSalePrice.visible = false;
        elSalePercent.visible = false;
    }
    function OnDropdownUpdate() {
        _UpdatePurchasePrice();
    }
    InspectPurchaseBar.OnDropdownUpdate = OnDropdownUpdate;
    function _OnActivate() {
        let elDropdown = m_elPanel.FindChildInLayoutFile('PurchaseCountDropdown');
        let qty = Number(elDropdown.GetSelected().id);
        let itemDefitionNameString = InventoryAPI.GetItemDefinitionName(m_itemid);
        let purchaseList = [];
        for (let i = 0; i < qty; i++) {
            purchaseList.push(m_itemid);
        }
        let purchaseString = purchaseList.join(',');
        if (itemDefitionNameString && itemDefitionNameString.startsWith('coupon - crate_patch_') &&
            !ItemInfo.FindAnyUserOwnedCharacterItemID()) {
            UiToolkitAPI.ShowGenericPopupYesNo($.Localize('#CSGO_Patch_NoAgent_Title'), $.Localize('#CSGO_Patch_NoAgent_Message'), '', () => StoreAPI.StoreItemPurchase(purchaseString), () => { });
        }
        else {
            StoreAPI.StoreItemPurchase(purchaseString);
        }
        $.DispatchEvent("CSGOPlaySoundEffect", "UIPanorama.buymenu_purchase", "MOUSE");
    }
    function ClosePopup() {
        InventoryAPI.StopItemPreviewMusic();
        $.DispatchEvent('HideSelectItemForCapabilityPopup');
        $.DispatchEvent('UIPopupButtonClicked', '');
        $.DispatchEvent('CapabilityPopupIsOpen', false);
    }
    InspectPurchaseBar.ClosePopup = ClosePopup;
})(InspectPurchaseBar || (InspectPurchaseBar = {}));
