"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../popups/popup_capability_can_patch.ts" />
/// <reference path="../popups/popup_can_apply_pick_slot.ts" />
var CapabilityCanApplyAction = (function () {
    const m_cP = $.GetContextPanel();
    const m_elPreviewPanel = m_cP.FindChildInLayoutFile('CanApplyItemModel');
    let m_isRemove = false;
    let m_worktype = '';
    function _Init() {
        m_cP.SetAttributeString('stickerApplyRemove', 'true');
        let itemId = '';
        let toolId = '';
        m_worktype = (m_cP.GetAttributeString("asyncworktype", ""));
        m_isRemove = (m_worktype === "remove_sticker" || m_worktype === "remove_patch");
        if (m_isRemove) {
            itemId = m_cP.GetAttributeString("itemid", "(not found)");
            if (!itemId) {
                _ClosePopUp();
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
            type: (m_worktype.indexOf('sticker') !== -1) ? 'sticker' : (m_worktype.indexOf('patch') !== -1) ? 'patch' : '',
            funcOnConfirm: _OnConfirmPressed,
            funcOnNext: _OnNextPressed,
            funcOnSelectForRemove: _OnSelectForRemove
        };
        // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
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
    ;
    const _OnConfirmPressed = function () {
        $.DispatchEvent('CSGOPlaySoundEffect', 'generic_button_press', 'MOUSE');
        _SetSelectedSlot(CanApplySlotInfo.GetSelectedEmptySlot());
        _UpdateEnableDisableOkBtn(true);
    };
    const _OnNextPressed = function (itemToApplyId, activeSlot) {
        _UpdateEnableDisableOkBtn(false);
        if (m_worktype === 'can_sticker') {
            CapabilityCanSticker.PreviewStickerInSlot(itemToApplyId, activeSlot);
        }
        else if (m_worktype === 'can_patch') {
            $.Schedule(.25, () => CapabilityCanPatch.PreviewPatchOnChar(itemToApplyId, activeSlot));
        }
    };
    const _OnSelectForRemove = function (slotIndex) {
        if (m_worktype === 'remove_sticker') {
            CapabilityCanSticker.CameraAnim(slotIndex);
            _SetSelectedSlot(slotIndex);
            _UpdateEnableDisableOkBtn(true);
            CapabilityCanSticker.HighlightStickerBySlot(slotIndex);
        }
        else if (m_worktype === 'remove_patch') {
            CapabilityCanPatch.CameraAnim(slotIndex);
            _SetSelectedSlot(slotIndex);
            _UpdateEnableDisableOkBtn(true);
        }
    };
    const _UpdateEnableDisableOkBtn = function (bEnable) {
        let elAsyncActionBarPanel = m_cP.FindChildInLayoutFile('PopUpInspectAsyncBar');
        // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
        InspectAsyncActionBar.EnableDisableOkBtn(elAsyncActionBarPanel, bEnable);
    };
    const _SetSelectedSlot = function (slotIndex) {
        m_cP.SetAttributeString('selectedItemToApplySlot', slotIndex.toString());
    };
    const _SetItemModel = function (toolId, itemId) {
        if (!InventoryAPI.IsItemInfoValid(itemId))
            return;
        InspectModelImage.Init(m_elPreviewPanel, itemId, _GetSettingCallback);
        m_elPreviewPanel.Data().id = itemId;
        if (m_isRemove) {
            $.Schedule(.1, () => CanApplyPickSlot.SelectFirstRemoveItem());
        }
        else {
            if (m_worktype === 'can_sticker') {
                CapabilityCanSticker.PreviewStickerInSlot(toolId, CanApplySlotInfo.GetSelectedEmptySlot());
            }
            if (m_worktype === 'can_patch') {
                $.Schedule(.25, () => CapabilityCanPatch.PreviewPatchOnChar(toolId, CanApplySlotInfo.GetSelectedEmptySlot()));
            }
        }
    };
    const _SetUpAsyncActionBar = function (toolId, itemId) {
        m_cP.SetAttributeString('toolid', toolId);
        const elAsyncActionBarPanel = m_cP.FindChildInLayoutFile('PopUpInspectAsyncBar');
        // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
        InspectAsyncActionBar.Init(elAsyncActionBarPanel, itemId, _GetSettingCallback, _AsyncActionPerformedCallback);
    };
    const _GetSettingCallback = function (settingname, defaultvalue) {
        return m_cP.GetAttributeString(settingname, defaultvalue);
    };
    const _AsyncActionPerformedCallback = function (itemid, toolid, slot) {
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
    };
    const _ClosePopUp = function () {
        const elAsyncActionBarPanel = m_cP.FindChildInLayoutFile('PopUpInspectAsyncBar');
        if (!elAsyncActionBarPanel.BHasClass('hidden')) {
            // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
            InspectAsyncActionBar.OnEventToClose();
        }
    };
    return {
        Init: _Init,
        SetItemModel: _SetItemModel,
        ClosePopUp: _ClosePopUp,
    };
})();
var CapabilityCanSticker = (function () {
    let m_isFinalScratch = false;
    let m_firstCameraAnim = false;
    const m_cP = $.GetContextPanel();
    const m_elPreviewPanel = m_cP.FindChildInLayoutFile('CanApplyItemModel');
    const m_weaponPosSettings = [
        { weapontype: 'weapon_tec9', rotatation: -80, pitchAngle: 0, slot: 3 },
        { weapontype: 'weapon_revolver', rotatation: 180, pitchAngle: 0, slot: 4 },
        { weapontype: 'weapon_nova', rotatation: -80, pitchAngle: 0, slot: 0, camera: 'cam_weapon_nova_0' },
        { weapontype: 'weapon_m249', rotatation: -80, pitchAngle: 0, slot: 3 }
    ];
    const _PreviewStickerInSlot = function (stickerId, slot) {
        $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_nextPosition', 'MOUSE');
        let elPanel = m_elPreviewPanel.FindChildTraverse('ItemPreviewPanel') || null;
        InventoryAPI.PreviewStickerInModelPanel(stickerId, slot, elPanel);
        InventoryAPI.PeelEffectStickerBySlot(slot);
        _CameraAnim(slot);
    };
    const _CameraAnim = function (slot) {
        const defName = ItemInfo.GetItemDefinitionName(m_elPreviewPanel.Data().id);
        let elPanel = m_elPreviewPanel.FindChildTraverse('ItemPreviewPanel') || null;
        let aPosSettings = m_weaponPosSettings.filter(entry => entry.weapontype === defName && entry.slot === slot);
        if (aPosSettings.length > 0) {
            elPanel.SetRotation(aPosSettings[0].rotatation, aPosSettings[0].pitchAngle, 1);
            if (aPosSettings[0].hasOwnProperty('camera')) {
                InspectModelImage.ResetCameraScheduleHandle();
                InspectModelImage.SetItemCameraByWeaponType(m_elPreviewPanel.Data().id, elPanel, aPosSettings[0].camera, true);
            }
        }
        else {
            if (!m_firstCameraAnim) {
                m_firstCameraAnim = true;
                return;
            }
            InspectModelImage.SetItemCameraByWeaponType(m_elPreviewPanel.Data().id, elPanel, '', true);
            elPanel.SetRotation(0, 0, 1);
        }
    };
    const _OnRemoveSticker = function (slotIndex) {
    };
    const _OnScratchSticker = function (itemId, slotIndex) {
        $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_scratchOff', 'MOUSE');
        if (InventoryAPI.IsItemStickerAtExtremeWear(itemId, slotIndex)) {
            m_isFinalScratch = true;
            UiToolkitAPI.ShowGenericPopupTwoOptions($.Localize('#SFUI_Sticker_Remove'), $.Localize('#SFUI_Sticker_Remove_Desc'), '', $.Localize('#SFUI_Sticker_Remove'), function () {
                // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
                InspectAsyncActionBar.ResetTimeouthandle();
                InventoryAPI.WearItemSticker(itemId, slotIndex);
                // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
                InspectAsyncActionBar.SetCallbackTimeout();
            }, $.Localize('#UI_Cancel'), function () {
                m_isFinalScratch = false;
                // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
                InspectAsyncActionBar.ResetTimeouthandle();
                // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
                InspectAsyncActionBar.OnCloseRemove();
            });
        }
        else {
            _HighlightStickerBySlot(slotIndex);
            InventoryAPI.WearItemSticker(itemId, slotIndex);
            // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
            const panelsList = m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons').Children();
            panelsList.forEach(element => element.enabled = false);
        }
    };
    const _HighlightStickerBySlot = function (slotIndex) {
        InventoryAPI.HighlightStickerBySlot(slotIndex);
    };
    const _OnFinishedScratch = function () {
        if (m_isFinalScratch || !m_cP) {
            return;
        }
        // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
        InspectAsyncActionBar.ResetTimeouthandle();
        // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
        InspectAsyncActionBar.OnCloseRemove();
        InspectModelImage.UpdateModelOnly(m_elPreviewPanel.Data().id);
        _CameraAnim(CanApplySlotInfo.GetSelectedRemoveSlot());
        // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
        const elStickersToRemove = m_cP.FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons');
        if (elStickersToRemove) {
            const panelsList = elStickersToRemove.Children();
            panelsList.forEach(element => {
                element.enabled = true;
            });
            // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
        }
    };
    return {
        PreviewStickerInSlot: _PreviewStickerInSlot,
        OnScratchSticker: _OnScratchSticker,
        OnFinishedScratch: _OnFinishedScratch,
        CameraAnim: _CameraAnim,
        HighlightStickerBySlot: _HighlightStickerBySlot
    };
})();
(function () {
    var _m_PanelRegisteredForEventsStickerApply;
    if (!_m_PanelRegisteredForEventsStickerApply) {
        _m_PanelRegisteredForEventsStickerApply = $.RegisterForUnhandledEvent('CSGOShowMainMenu', CapabilityCanApplyAction.Init);
        $.RegisterForUnhandledEvent('PopulateLoadingScreen', CapabilityCanApplyAction.ClosePopUp);
    }
})();
