"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/iteminfo.ts" />
var InspectPurchaseBar;
(function (InspectPurchaseBar) {
    let m_itemid = '';
    let m_storeItemid = '';
    let m_elPanel = null;
    let m_showToolUpsell = false;
    let m_isXrayMode = false;
    let m_allowXrayPurchase = false;
    let m_bOverridePurchaseMultiple = false;
    let m_blurOperationPanel = false;
    function Init(elPanel, itemId, funcGetSettingCallback) {
        m_storeItemid = funcGetSettingCallback("storeitemid", "");
        m_bOverridePurchaseMultiple = (funcGetSettingCallback("overridepurchasemultiple", "") === '1');
        m_blurOperationPanel = ($.GetContextPanel().GetAttributeString('bluroperationpanel', 'false') === 'true');
        m_itemid = !m_storeItemid ? itemId : m_storeItemid;
        let bFauxItemIdForPurchase = InventoryAPI.IsFauxItemID(m_itemid);
        let priceOriginal = bFauxItemIdForPurchase ? ItemInfo.GetStoreOriginalPrice(m_itemid, 1) : '';
        if (!priceOriginal && (funcGetSettingCallback('inspectonly', 'false') === 'true') && !InventoryAPI.IsValidItemID(m_itemid)) {
            elPanel.FindChildInLayoutFile('id-purchase-section').visible = false;
            elPanel.RemoveClass('hidden');
            return;
        }
        if ((funcGetSettingCallback('asyncworktype', '') === 'delete') ||
            (funcGetSettingCallback('inspectonly', 'false') === 'true') ||
            !InventoryAPI.IsValidItemID(m_itemid)) {
            elPanel.AddClass('hidden');
            return;
        }
        m_elPanel = elPanel;
        m_isXrayMode = (funcGetSettingCallback("isxraymode", "no") === 'yes');
        m_allowXrayPurchase = (funcGetSettingCallback("allowxraypurchase", "no") === 'yes');
        m_showToolUpsell = (funcGetSettingCallback("toolid", '') === '');
        elPanel.RemoveClass('hidden');
        _SetPurchaseImage(elPanel, itemId);
        _SetDialogVariables(elPanel, m_itemid);
        _UpdateDecString(elPanel);
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
        elImage.SetHasClass('popup-capability-faded', m_isXrayMode && !m_allowXrayPurchase);
    }
    function _UpdateDecString(elPanel) {
        let elDesc = m_elPanel.FindChildInLayoutFile('PurchaseItemName');
        if (m_isXrayMode) {
            elPanel.SetDialogVariable("itemprice", ItemInfo.GetStoreSalePrice(m_itemid, 1));
            elDesc.text = "#popup_capability_upsell_xray";
        }
        else if (!m_storeItemid && m_showToolUpsell) {
            elDesc.text = "#popup_capability_upsell";
        }
        else {
            elDesc.text = "#popup_capability_use";
        }
        elDesc.SetHasClass('popup-capability-faded', m_isXrayMode && !m_allowXrayPurchase);
    }
    function _UpdatePurchasePrice() {
        if (!m_elPanel || !m_elPanel.IsValid())
            return;
        let elBtn = m_elPanel.FindChildInLayoutFile('PurchaseBtn');
        let elDropdown = m_elPanel.FindChildInLayoutFile('PurchaseCountDropdown');
        let qty = 1;
        let bCanShowQuantityDropdown = !m_isXrayMode && _isAllowedToPurchaseMultiple();
        elDropdown.visible = bCanShowQuantityDropdown;
        if (bCanShowQuantityDropdown) {
            qty = Number(elDropdown.GetSelected().id);
        }
        let salePrice = ItemInfo.GetStoreSalePrice(m_itemid, qty);
        elBtn.text = m_isXrayMode ? '#popup_totool_purchase_header' : salePrice;
        _UpdateSalePrice(ItemInfo.GetStoreOriginalPrice(m_itemid, qty));
    }
    function _isAllowedToPurchaseMultiple() {
        if (m_bOverridePurchaseMultiple)
            return true;
        let attValue = InventoryAPI.GetItemAttributeValue(m_itemid, 'season access');
        if (attValue)
            return false;
        let strToolType = InventoryAPI.GetToolType(m_itemid);
        if (strToolType === 'fantoken')
            return false;
        let defName = InventoryAPI.GetItemDefinitionName(m_itemid);
        if (defName === 'casket')
            return false;
        return true;
    }
    function _SetUpPurchaseBtn(elPanel) {
        elPanel.FindChildInLayoutFile('PurchaseBtn').enabled = !m_isXrayMode || (m_isXrayMode && m_allowXrayPurchase);
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
    }
    function ClosePopup() {
        InventoryAPI.StopItemPreviewMusic();
        if (m_blurOperationPanel) {
            $.DispatchEvent('UnblurOperationPanel');
        }
        $.DispatchEvent('HideSelectItemForCapabilityPopup');
        $.DispatchEvent('UIPopupButtonClicked', '');
        $.DispatchEvent('CapabilityPopupIsOpen', false);
    }
    InspectPurchaseBar.ClosePopup = ClosePopup;
})(InspectPurchaseBar || (InspectPurchaseBar = {}));
