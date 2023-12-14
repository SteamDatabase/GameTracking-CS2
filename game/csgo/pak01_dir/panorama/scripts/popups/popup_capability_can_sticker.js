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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfY2FwYWJpbGl0eV9jYW5fc3RpY2tlci5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL3BvcHVwcy9wb3B1cF9jYXBhYmlsaXR5X2Nhbl9zdGlja2VyLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUFDckMsc0NBQXNDO0FBQ3RDLDhDQUE4QztBQUM5QyxnRUFBZ0U7QUFDaEUsK0RBQStEO0FBZS9ELElBQUksd0JBQXdCLEdBQUcsQ0FBRTtJQUVoQyxNQUFNLElBQUksR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUM7SUFDakMsTUFBTSxnQkFBZ0IsR0FBRyxJQUFJLENBQUMscUJBQXFCLENBQUUsbUJBQW1CLENBQUUsQ0FBQztJQUMzRSxJQUFJLFVBQVUsR0FBRyxLQUFLLENBQUM7SUFDdkIsSUFBSSxVQUFVLEdBQUcsRUFBRSxDQUFDO0lBRXBCLFNBQVMsS0FBSztRQUViLElBQUksQ0FBQyxrQkFBa0IsQ0FBRSxvQkFBb0IsRUFBRSxNQUFNLENBQUUsQ0FBQztRQUV4RCxJQUFJLE1BQU0sR0FBVyxFQUFFLENBQUM7UUFDeEIsSUFBSSxNQUFNLEdBQVcsRUFBRSxDQUFDO1FBQ3hCLFVBQVUsR0FBRyxDQUFFLElBQUksQ0FBQyxrQkFBa0IsQ0FBRSxlQUFlLEVBQUUsRUFBRSxDQUFFLENBQUUsQ0FBQztRQUVoRSxVQUFVLEdBQUcsQ0FBRSxVQUFVLEtBQUssZ0JBQWdCLElBQUksVUFBVSxLQUFLLGNBQWMsQ0FBRSxDQUFDO1FBRWxGLElBQUssVUFBVSxFQUNmO1lBQ0MsTUFBTSxHQUFHLElBQUksQ0FBQyxrQkFBa0IsQ0FBRSxRQUFRLEVBQUUsYUFBYSxDQUFFLENBQUM7WUFDNUQsSUFBSyxDQUFDLE1BQU0sRUFDWjtnQkFFQyxXQUFXLEVBQUUsQ0FBQztnQkFDZCxPQUFNO2FBQ047U0FDRDthQUVEO1lBRUMsTUFBTSxNQUFNLEdB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