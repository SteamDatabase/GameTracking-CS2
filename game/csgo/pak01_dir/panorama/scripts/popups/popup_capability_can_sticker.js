"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="popup_inspect_purchase-bar.ts" />
/// <reference path="popup_capability_can_keychain.ts" />
/// <reference path="popup_capability_can_patch.ts" />
/// <reference path="popup_can_apply_pick_slot.ts" />
/// <reference path="popup_can_apply_header.ts" />
/// <reference path="popup_acknowledge_item.ts" />
var CapabilityCanApplyAction;
(function (CapabilityCanApplyAction) {
    const m_cP = $.GetContextPanel();
    const m_elPreviewPanel = m_cP.FindChildInLayoutFile('CanApplyItemModel');
    let m_isRemove = false;
    let m_worktype = '';
    let m_isWorkshopPreview = false;
    let m_toolId = "(not found)";
    let m_itemId = "(not found)";
    let m_itemIdCreatedTemp = '';
    let m_szRemoveKeychainToolChargesForPurchase = 'Remove Keychain Tool Pack';
    function Init() {
        m_cP.SetAttributeString('stickerApplyRemove', 'true');
        let itemId = '';
        let toolId = '';
        m_worktype = (m_cP.GetAttributeString("asyncworktype", ""));
        m_isWorkshopPreview = (m_cP.GetAttributeString("workshopPreview", "false") === "true");
        m_isRemove = (m_worktype === "remove_sticker" || m_worktype === "remove_patch" || m_worktype === "remove_keychain");
        if (m_isRemove) {
            m_itemId = itemId = m_cP.GetAttributeString("itemid", "(not found)");
            if (!itemId) {
                ClosePopUp();
                return;
            }
        }
        else {
            const strMsg = m_cP.GetAttributeString("toolid-and-itemid", "(not found)");
            let idList = strMsg.split(',');
            m_toolId = toolId = idList[0];
            m_itemId = itemId = idList[1];
            if (m_worktype === 'can_keychain' || m_worktype === 'can_sticker') {
                m_itemIdCreatedTemp = itemId = InventoryAPI.CreateTempCombinedItemWithTool(m_itemId, m_toolId);
                if (!itemId) {
                    ClosePopUp();
                    return;
                }
            }
            if ((m_worktype === 'can_wrap_sticker') && m_toolId) {
                m_itemIdCreatedTemp = itemId = InventoryAPI.CreateTempCombinedItemWithTool(m_itemId, m_toolId);
                if (!itemId) {
                    ClosePopUp();
                    return;
                }
            }
        }
        let oSettings = {
            headerPanel: m_cP.FindChildInLayoutFile('PopUpCanApplyHeader'),
            infoPanel: m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot'),
            asyncbarPanel: m_cP.FindChildInLayoutFile('PopUpInspectAsyncBar'),
            itemId: itemId,
            toolId: toolId,
            isRemove: (m_worktype === 'can_wrap_sticker') ? true
                : m_isRemove,
            worktype: m_worktype,
            type: (m_worktype === 'can_wrap_sticker') ? 'keychain'
                : (m_worktype.indexOf('sticker') !== -1) ? 'sticker'
                    : (m_worktype.indexOf('patch') !== -1) ? 'patch'
                        : (m_worktype.indexOf('keychain') !== -1) ? 'keychain'
                            : '',
            isWorkshopPreview: m_isWorkshopPreview,
            funcOnConfirm: _OnConfirmPressed,
            funcOnNext: _OnNextPressed,
            funcOnCancel: _OnCancelPressed,
            funcOnSelectForRemove: _OnSelectForRemove
        };
        CanApplyHeader.Init(oSettings);
        CanApplySlotInfo.ResetSlotIndex();
        CapabilityCanPatch.ResetPos();
        CapabilityCanKeychain.ResetPos();
        CanApplySlotInfo.UpdateEmptySlotList(itemId);
        CanApplyPickSlot.Init(oSettings);
        _SetItemModel(toolId, itemId);
        _SetUpAsyncActionBar(toolId, itemId);
        _UpdateEnableDisableOkBtn(false);
        if (oSettings.isRemove && oSettings.type === 'keychain') {
            _OnConfirmPressed();
        }
        if (m_worktype === "remove_sticker") {
            $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', CapabilityCanSticker.OnFinishedScratch);
        }
        $.DispatchEvent('CapabilityPopupIsOpen', true);
        if (m_worktype === 'remove_keychain') {
            let numKeychainRemoveToolChargesRemaining = InventoryAPI.GetCacheTypeElementFieldByIndex('KeychainRemoveToolCharges', 0, 'charges');
            if (numKeychainRemoveToolChargesRemaining > 0) {
            }
            else {
                let ownedKeychainRemoveChargesID = '';
                let bAutoAcknowledge = true;
                let unackItems = AcknowledgeItems.GetItemsByType([m_szRemoveKeychainToolChargesForPurchase], bAutoAcknowledge);
                if (unackItems && unackItems.length > 0) {
                    ownedKeychainRemoveChargesID = unackItems[0];
                }
                if (!ownedKeychainRemoveChargesID) {
                    InventoryAPI.SetInventorySortAndFilters('inv_sort_age', false, 'item_definition:' + m_szRemoveKeychainToolChargesForPurchase, '', '');
                    let countOfChargeItemsOwned = InventoryAPI.GetInventoryCount();
                    if (countOfChargeItemsOwned > 0) {
                        ownedKeychainRemoveChargesID = InventoryAPI.GetInventoryItemIDByIndex(0);
                    }
                }
                if (ownedKeychainRemoveChargesID) {
                    ClosePopUp();
                    $.DispatchEvent("ShowCustomLayoutPopupParametersAsEvent", '', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + ownedKeychainRemoveChargesID +
                        '&' + 'asyncworktype=useitem');
                }
                else {
                }
            }
        }
    }
    CapabilityCanApplyAction.Init = Init;
    function _OnConfirmPressed() {
        $.DispatchEvent('CSGOPlaySoundEffect', 'generic_button_press', 'MOUSE');
        _SetSelectedSlot(CanApplySlotInfo.GetSelectedEmptySlot());
        _UpdateEnableDisableOkBtn(true);
        InspectAsyncActionBar.EnableDisableChangeSceneryBtn(false);
    }
    function _OnNextPressed(itemToApplyId, activeSlot) {
        _UpdateEnableDisableOkBtn(false);
        if (m_worktype === 'can_sticker' || m_worktype === 'can_keychain') {
            CapabilityCanSticker.NextStickerButtonPressed();
            CapabilityCanSticker.ShowCancelBtn();
        }
        else if (m_worktype === 'can_patch') {
            $.Schedule(.25, () => CapabilityCanPatch.PreviewPatchOnChar(itemToApplyId, activeSlot));
        }
    }
    function _OnCancelPressed() {
        _UpdateEnableDisableOkBtn(false);
        InspectAsyncActionBar.EnableDisableChangeSceneryBtn(true);
    }
    function _StickerPlacementUpdated() {
        let elParent = m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot');
        let elCancelBtn = elParent.FindChildInLayoutFile('CanApplyCancel');
        if (elCancelBtn.visible)
            $.DispatchEvent("Activated", elParent.FindChildInLayoutFile('CanApplyCancel'), "mouse");
    }
    function _OnSelectForRemove(slotIndex) {
        if (m_worktype === 'remove_sticker') {
            _SetSelectedSlot(slotIndex);
            CanApplyPickSlot.UpdateSelectedRemoveForSticker(slotIndex);
            _UpdateEnableDisableOkBtn(true);
        }
        else if (m_worktype === 'remove_patch') {
            _SetSelectedSlot(slotIndex);
            _UpdateEnableDisableOkBtn(true);
            CapabilityCanPatch.CameraAnim(slotIndex);
        }
    }
    function _UpdateEnableDisableOkBtn(bEnable) {
        let elAsyncActionBarPanel = m_cP.FindChildInLayoutFile('PopUpInspectAsyncBar');
        InspectAsyncActionBar.EnableDisableOkBtn(elAsyncActionBarPanel, bEnable);
        return;
    }
    function _SetSelectedSlot(slotIndex) {
        m_cP.SetAttributeString('selectedItemToApplySlot', slotIndex.toString());
    }
    function _UpdateInspectMap() {
        InspectModelImage.SwitchMap(m_cP);
        if (m_worktype === 'can_patch') {
            CapabilityCanPatch.ResetPos();
        }
        InspectAsyncActionBar.ZoomCamera(true);
        _UpdateItemToApplyPreview(m_toolId);
    }
    function _SetItemModel(toolId, itemId) {
        if (!InventoryAPI.IsItemInfoValid(itemId))
            return;
        InspectModelImage.Init(m_elPreviewPanel, itemId, _GetSettingCallback);
        m_elPreviewPanel.Data().id = itemId;
        if (m_isRemove) {
            if (m_worktype === 'remove_patch') {
                $.Schedule(.3, () => CanApplyPickSlot.SelectFirstRemoveItem());
            }
        }
        else {
            _UpdateItemToApplyPreview(toolId);
        }
    }
    function _UpdateItemToApplyPreview(toolId) {
        if (m_worktype === 'can_sticker') {
            CapabilityCanSticker.PreviewStickerInSlot(toolId, CanApplySlotInfo.GetSelectedEmptySlot());
        }
        if (m_worktype === 'can_patch') {
            $.Schedule(.3, () => CapabilityCanPatch.PreviewPatchOnChar(toolId, CanApplySlotInfo.GetSelectedEmptySlot()));
        }
    }
    function _SetUpAsyncActionBar(toolId, itemId) {
        m_cP.SetAttributeString('toolid', toolId);
        const elAsyncActionBarPanel = m_cP.FindChildInLayoutFile('PopUpInspectAsyncBar');
        InspectAsyncActionBar.Init(elAsyncActionBarPanel, itemId, _GetSettingCallback, _AsyncActionPerformedPositiveBind, (m_worktype === 'remove_sticker'
            || (m_worktype === 'can_wrap_sticker' && !toolId)) ? _AsyncActionPerformedNegativeBind : undefined);
        let elPurchase = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectPurchaseBar');
        let bConfigurePurchaseBar = false;
        let mustPurchaseItemID = '';
        if (m_worktype === 'can_wrap_sticker' && InventoryAPI.IsFauxItemID(m_itemId)) {
            bConfigurePurchaseBar = true;
            mustPurchaseItemID = m_itemId;
        }
        if (m_worktype === 'remove_keychain' || m_worktype === 'can_keychain') {
            bConfigurePurchaseBar = true;
            if (m_worktype === 'remove_keychain') {
                let numKeychainRemoveToolChargesRemaining = InventoryAPI.GetCacheTypeElementFieldByIndex('KeychainRemoveToolCharges', 0, 'charges');
                let defidxForPurchase = (numKeychainRemoveToolChargesRemaining > 0) ? 0 : InventoryAPI.GetItemDefinitionIndexFromDefinitionName(m_szRemoveKeychainToolChargesForPurchase);
                if (defidxForPurchase) {
                    mustPurchaseItemID = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(defidxForPurchase, 0);
                }
            }
        }
        if (elPurchase && bConfigurePurchaseBar) {
            if (mustPurchaseItemID) {
                $.GetContextPanel().SetAttributeString('purchaseItemId', mustPurchaseItemID);
                m_cP.SetAttributeString('toolid', '');
            }
            InspectPurchaseBar.Init(elPurchase, mustPurchaseItemID, _GetSettingCallback);
            if (mustPurchaseItemID) {
                m_cP.SetAttributeString('toolid', toolId);
                elAsyncActionBarPanel.AddClass('hidden');
            }
        }
    }
    function _OnStorePurchaseCompleted(ItemId) {
        if (InventoryAPI.DoesItemMatchDefinitionByName(ItemId, m_szRemoveKeychainToolChargesForPurchase)) {
            $.DispatchEvent('HideStoreStatusPanel');
            let bAutoAcknowledge = true;
            AcknowledgeItems.GetItemsByType([m_szRemoveKeychainToolChargesForPurchase], bAutoAcknowledge);
            ClosePopUp();
            $.DispatchEvent("ShowCustomLayoutPopupParametersAsEvent", '', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + ItemId +
                '&' + 'asyncworktype=useitem');
        }
        if (m_worktype === 'can_wrap_sticker' &&
            InventoryAPI.IsFauxItemID(m_itemId) &&
            InventoryAPI.DoesItemMatchDefinitionByName(ItemId, "sticker_display_case")) {
            $.DispatchEvent('HideStoreStatusPanel');
            let bAutoAcknowledge = true;
            AcknowledgeItems.GetItemsByType(["sticker_display_case"], bAutoAcknowledge);
            ClosePopUp();
            $.DispatchEvent("ShowCustomLayoutPopupParametersAsEvent", '', 'file://{resources}/layout/popups/popup_capability_can_keychain.xml', 'toolid-and-itemid=' + m_toolId + ',' + ItemId
                + '&' +
                'asyncworktype=can_wrap_sticker');
        }
    }
    ;
    function _GetSettingCallback(settingname, defaultvalue) {
        if (settingname === 'overridepurchasemultiple')
            return '0';
        return m_cP.GetAttributeString(settingname, defaultvalue);
    }
    function _AsyncActionPerformedPositiveBind(itemid, toolid, slot) {
        _AsyncActionPerformedCallback(true, itemid, toolid, slot);
    }
    function _AsyncActionPerformedNegativeBind(itemid, toolid, slot) {
        _AsyncActionPerformedCallback(false, itemid, toolid, slot);
    }
    function _AsyncActionPerformedCallback(bPositiveAction, itemid, toolid, slot) {
        CanApplyPickSlot.DisableBtns(m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot'));
        if (m_itemIdCreatedTemp !== '' && itemid === m_itemIdCreatedTemp) {
            itemid = m_itemId;
        }
        if (m_worktype === 'remove_sticker') {
            CapabilityCanSticker.OnScratchSticker(itemid, slot, !bPositiveAction);
        }
        else if (m_worktype === 'remove_patch') {
            InspectAsyncActionBar.ResetTimeouthandle();
            InventoryAPI.WearItemSticker(itemid, slot, 0);
            InspectAsyncActionBar.SetCallbackTimeout();
        }
        else if (m_worktype === 'remove_keychain') {
            InspectAsyncActionBar.ResetTimeouthandle();
            InventoryAPI.RemoveKeychain(itemid, 0);
            InspectAsyncActionBar.SetCallbackTimeout();
        }
        else if (m_worktype === 'can_wrap_sticker' && !toolid) {
            InspectAsyncActionBar.ResetTimeouthandle();
            InventoryAPI.RemoveKeychain(itemid, 0);
            InspectAsyncActionBar.SetCallbackTimeout();
        }
        else {
            InventoryAPI.SetStickerToolSlot(itemid, slot);
            InventoryAPI.UseTool(toolid, itemid);
        }
    }
    function ClosePopUp() {
        const elAsyncActionBarPanel = m_cP.FindChildInLayoutFile('PopUpInspectAsyncBar');
        let elPurchase = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectPurchaseBar');
        if (!elAsyncActionBarPanel.BHasClass('hidden')) {
            InspectAsyncActionBar.OnEventToClose();
        }
        else if (elPurchase && elPurchase.IsValid() && !elPurchase.BHasClass('hidden')) {
            InspectPurchaseBar.ClosePopup();
        }
    }
    CapabilityCanApplyAction.ClosePopUp = ClosePopUp;
    {
        let _m_PanelRegisteredForEventsStickerApply;
        if (!_m_PanelRegisteredForEventsStickerApply) {
            _m_PanelRegisteredForEventsStickerApply = $.RegisterForUnhandledEvent('CSGOShowMainMenu', Init);
            $.RegisterForUnhandledEvent('PanoramaComponent_Store_PurchaseCompleted', _OnStorePurchaseCompleted);
            $.RegisterForUnhandledEvent("CSGOInspectBackgroundMapChanged", _UpdateInspectMap);
            $.RegisterForUnhandledEvent("CS2StickerPreviewMoved", _StickerPlacementUpdated);
            $.RegisterForUnhandledEvent("CS2StickerScrapeClickedStickerIndex", _OnSelectForRemove);
            $.RegisterForUnhandledEvent('PopulateLoadingScreen', ClosePopUp);
        }
    }
})(CapabilityCanApplyAction || (CapabilityCanApplyAction = {}));
var CapabilityCanSticker;
(function (CapabilityCanSticker) {
    let m_isFinalScratch = false;
    let m_firstCameraAnim = false;
    const m_cP = $.GetContextPanel();
    const m_elPreviewPanel = m_cP.FindChildInLayoutFile('CanApplyItemModel');
    function NextStickerButtonPressed() {
        let elPanel = m_elPreviewPanel.FindChildTraverse('ItemPreviewPanel') || null;
        if (elPanel != null) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_nextPosition', 'MOUSE');
            InventoryAPI.OnNextStickerButtonPressed(elPanel);
        }
    }
    CapabilityCanSticker.NextStickerButtonPressed = NextStickerButtonPressed;
    function SetStickerScrapeLevel(valScrapeLevel) {
        let elPanel = m_elPreviewPanel.FindChildTraverse('ItemPreviewPanel') || null;
        if (elPanel != null) {
            InventoryAPI.SetStickerScrapeLevel(elPanel, valScrapeLevel);
        }
    }
    CapabilityCanSticker.SetStickerScrapeLevel = SetStickerScrapeLevel;
    function PreviewStickerInSlot(stickerId, slot) {
        $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_nextPosition', 'MOUSE');
        let elPanel = m_elPreviewPanel.FindChildTraverse('ItemPreviewPanel') || null;
        InventoryAPI.PreviewStickerInModelPanel(stickerId, slot, elPanel);
    }
    CapabilityCanSticker.PreviewStickerInSlot = PreviewStickerInSlot;
    function CameraAnim(slot) {
        let elPanel = m_elPreviewPanel.FindChildTraverse('ItemPreviewPanel') || null;
        if (!m_firstCameraAnim) {
            m_firstCameraAnim = true;
            return;
        }
        InspectModelImage.SetItemCameraByWeaponType(m_elPreviewPanel.Data().id, elPanel, true);
        elPanel.SetRotation(0, 0, 1);
    }
    CapabilityCanSticker.CameraAnim = CameraAnim;
    function OnScratchSticker(itemId, slotIndex, bRemoveCompletely) {
        if (bRemoveCompletely || InventoryAPI.IsItemStickerAtExtremeWear(itemId, slotIndex)) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.StickerScratch', 'MOUSE');
            m_isFinalScratch = true;
            InspectAsyncActionBar.ResetTimeouthandle();
            InventoryAPI.WearItemSticker(itemId, slotIndex, 111);
            InspectAsyncActionBar.SetCallbackTimeout();
        }
        else {
            let valTargetWear = 0;
            let elStickerScrapeLevelContainer = m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('StickerScrapeLevelContainer');
            if (elStickerScrapeLevelContainer) {
                let elStickerScrapeLevelSlider = elStickerScrapeLevelContainer.FindChildInLayoutFile('StickerScrapeLevelSlider');
                if (elStickerScrapeLevelSlider) {
                    valTargetWear = elStickerScrapeLevelSlider.value;
                    if (valTargetWear <= elStickerScrapeLevelSlider.default) {
                        InspectAsyncActionBar.ResetTimeouthandle();
                        InspectAsyncActionBar.OnCloseRemove();
                        return;
                    }
                }
            }
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.StickerScratch', 'MOUSE');
            HighlightStickerBySlot(slotIndex);
            InventoryAPI.WearItemSticker(itemId, slotIndex, valTargetWear);
        }
    }
    CapabilityCanSticker.OnScratchSticker = OnScratchSticker;
    function HighlightStickerBySlot(slotIndex) {
        InventoryAPI.HighlightStickerBySlot(slotIndex);
    }
    CapabilityCanSticker.HighlightStickerBySlot = HighlightStickerBySlot;
    function OnFinishedScratch() {
        if (m_isFinalScratch || !m_cP) {
            return;
        }
        InspectAsyncActionBar.ResetTimeouthandle();
        InspectAsyncActionBar.OnCloseRemove();
        InspectModelImage.UpdateModelOnly(m_elPreviewPanel.Data().id);
        const elStickersToRemove = m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons');
        if (elStickersToRemove && m_cP.GetAttributeString("asyncworktype", "") === "remove_patch") {
            const panelsList = elStickersToRemove.Children();
            panelsList.forEach(element => element.enabled = true);
        }
        if (elStickersToRemove && m_cP.GetAttributeString("asyncworktype", "") === "remove_sticker") {
            const panelsList = elStickersToRemove.Children();
            panelsList.forEach(element => { if (element.checked) {
                $.DispatchEvent("Activated", element, "mouse");
            } });
        }
    }
    CapabilityCanSticker.OnFinishedScratch = OnFinishedScratch;
    function ShowCancelBtn() {
    }
    CapabilityCanSticker.ShowCancelBtn = ShowCancelBtn;
})(CapabilityCanSticker || (CapabilityCanSticker = {}));
