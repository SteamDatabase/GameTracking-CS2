"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="popup_capability_can_patch.ts" />
/// <reference path="popup_can_apply_pick_slot.ts" />
/// <reference path="popup_can_apply_header.ts" />
var CapabilityCanApplyAction;
(function (CapabilityCanApplyAction) {
    const m_cP = $.GetContextPanel();
    const m_elPreviewPanel = m_cP.FindChildInLayoutFile('CanApplyItemModel');
    let m_isRemove = false;
    let m_worktype = '';
    function Init() {
        m_cP.SetAttributeString('stickerApplyRemove', 'true');
        let itemId = '';
        let toolId = '';
        m_worktype = (m_cP.GetAttributeString("asyncworktype", ""));
        m_isRemove = (m_worktype === "remove_sticker" || m_worktype === "remove_patch");
        if (m_isRemove) {
            itemId = m_cP.GetAttributeString("itemid", "(not found)");
            if (!itemId) {
                ClosePopUp();
                return;
            }
        }
        else {
            const strMsg = m_cP.GetAttributeString("toolid-and-itemid", "(not found)");
            let idList = strMsg.split(',');
            toolId = idList[0];
            itemId = idList[1];
        }
        let oSettings = {
            headerPanel: m_cP.FindChildInLayoutFile('PopUpCanApplyHeader'),
            infoPanel: m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot'),
            itemId: itemId,
            toolId: toolId,
            isRemove: m_isRemove,
            worktype: m_worktype,
            type: (m_worktype.indexOf('sticker') !== -1) ? 'sticker' : (m_worktype.indexOf('patch') !== -1) ? 'patch' : '',
            funcOnConfirm: _OnConfirmPressed,
            funcOnNext: _OnNextPressed,
            funcOnCancel: _OnCancelPressed,
            funcOnSelectForRemove: _OnSelectForRemove
        };
        CanApplyHeader.Init(oSettings);
        CanApplySlotInfo.ResetSlotIndex();
        CapabilityCanPatch.ResetPos();
        CanApplySlotInfo.UpdateEmptySlotList(itemId);
        CanApplyPickSlot.Init(oSettings);
        _SetItemModel(toolId, itemId);
        _SetUpAsyncActionBar(toolId, itemId);
        _UpdateEnableDisableOkBtn(false);
        if (m_worktype === "remove_sticker") {
            $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', CapabilityCanSticker.OnFinishedScratch);
        }
        $.DispatchEvent('CapabilityPopupIsOpen', true);
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
        if (m_worktype === 'can_sticker') {
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
        const strMsg = m_cP.GetAttributeString("toolid-and-itemid", "(not found)");
        let idList = strMsg.split(',');
        InspectAsyncActionBar.ZoomCamera(true);
        _UpdateItemToApplyPreview(idList[0]);
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
        InspectAsyncActionBar.Init(elAsyncActionBarPanel, itemId, _GetSettingCallback, _AsyncActionPerformedCallback);
    }
    function _GetSettingCallback(settingname, defaultvalue) {
        return m_cP.GetAttributeString(settingname, defaultvalue);
    }
    function _AsyncActionPerformedCallback(itemid, toolid, slot) {
        CanApplyPickSlot.DisableBtns(m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot'));
        if (m_worktype === 'remove_sticker') {
            CapabilityCanSticker.OnScratchSticker(itemid, slot);
        }
        else if (m_worktype === 'remove_patch') {
            CapabilityCanPatch.OnRemovePatch(itemid, slot);
        }
        else {
            let bIsValid = InventoryAPI.SetStickerToolSlot(itemid, slot);
            if (bIsValid) {
                InventoryAPI.UseTool(toolid, itemid);
            }
        }
    }
    function ClosePopUp() {
        const elAsyncActionBarPanel = m_cP.FindChildInLayoutFile('PopUpInspectAsyncBar');
        if (!elAsyncActionBarPanel.BHasClass('hidden')) {
            InspectAsyncActionBar.OnEventToClose();
        }
    }
    CapabilityCanApplyAction.ClosePopUp = ClosePopUp;
    {
        let _m_PanelRegisteredForEventsStickerApply;
        if (!_m_PanelRegisteredForEventsStickerApply) {
            _m_PanelRegisteredForEventsStickerApply = $.RegisterForUnhandledEvent('CSGOShowMainMenu', Init);
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
    function PreviewStickerInSlot(stickerId, slot) {
        $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_nextPosition', 'MOUSE');
        let elPanel = m_elPreviewPanel.FindChildTraverse('ItemPreviewPanel') || null;
        InventoryAPI.PreviewStickerInModelPanel(stickerId, slot, elPanel);
        InventoryAPI.PeelEffectStickerBySlot(slot);
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
    function OnScratchSticker(itemId, slotIndex) {
        $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_scratchOff', 'MOUSE');
        if (InventoryAPI.IsItemStickerAtExtremeWear(itemId, slotIndex)) {
            m_isFinalScratch = true;
            UiToolkitAPI.ShowGenericPopupTwoOptions($.Localize('#SFUI_Sticker_Remove'), $.Localize('#SFUI_Sticker_Remove_Desc'), '', $.Localize('#SFUI_Sticker_Remove'), () => {
                InspectAsyncActionBar.ResetTimeouthandle();
                InventoryAPI.WearItemSticker(itemId, slotIndex);
                InspectAsyncActionBar.SetCallbackTimeout();
            }, $.Localize('#UI_Cancel'), () => {
                m_isFinalScratch = false;
                InspectAsyncActionBar.ResetTimeouthandle();
                InspectAsyncActionBar.OnCloseRemove();
            });
        }
        else {
            HighlightStickerBySlot(slotIndex);
            InventoryAPI.WearItemSticker(itemId, slotIndex);
            const panelsList = m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons').Children();
            panelsList.forEach(element => element.enabled = false);
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
    }
    CapabilityCanSticker.OnFinishedScratch = OnFinishedScratch;
    function ShowCancelBtn() {
    }
    CapabilityCanSticker.ShowCancelBtn = ShowCancelBtn;
})(CapabilityCanSticker || (CapabilityCanSticker = {}));
