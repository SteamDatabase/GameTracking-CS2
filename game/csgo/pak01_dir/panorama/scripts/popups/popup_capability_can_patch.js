"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../popups/popup_can_apply_pick_slot.ts" />
var CapabilityCanPatch = (function () {
    let m_cP = $.GetContextPanel();
    let m_elPreviewPanel = m_cP.FindChildInLayoutFile('CanApplyItemModel');
    let m_prevCameraSlot = 0;
    let m_firstCameraAnim = false;
    let m_pos = 0;
    function _ResetPos() {
        m_pos = 0;
        m_prevCameraSlot = 0;
        m_firstCameraAnim = false;
    }
    function _PreviewPatchOnChar(toolId, activeIndex) {
        $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_nextPosition', 'MOUSE');
        let elCharPanel = m_elPreviewPanel.FindChildInLayoutFile("CharPreviewPanel");
        if (!elCharPanel || !elCharPanel.IsValid()) {
            return;
        }
        InventoryAPI.PreviewStickerInModelPanel(toolId, activeIndex, elCharPanel);
        _CameraAnim(activeIndex);
    }
    ;
    function _OnRemovePatch(itemId, slotIndex) {
        UiToolkitAPI.ShowGenericPopupTwoOptions($.Localize('#SFUI_Patch_Remove'), $.Localize('#SFUI_Patch_Remove_Desc'), '', $.Localize('#SFUI_Patch_Remove'), function () {
            // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
            InspectAsyncActionBar.ResetTimeouthandle();
            InventoryAPI.WearItemSticker(itemId, slotIndex);
            // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
            InspectAsyncActionBar.SetCallbackTimeout();
        }, $.Localize('#UI_Cancel'), function () {
            // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
            InspectAsyncActionBar.ResetTimeouthandle();
            // @ts-ignore remove after popup_inspect_async-bar.js is TypeScript
            InspectAsyncActionBar.OnCloseRemove();
        });
    }
    function _CameraAnim(activeIndex) {
        if ((m_prevCameraSlot === activeIndex || activeIndex == -1) && m_firstCameraAnim)
            return;
        if (!InventoryAPI.IsItemInfoValid(m_elPreviewPanel.Data().id))
            return;
        InventoryAPI.HighlightPatchBySlot(activeIndex);
        _UpdatePreviewPanelSettingsForPatchPosition(m_elPreviewPanel.Data().id, activeIndex);
        m_prevCameraSlot = activeIndex;
        m_firstCameraAnim = m_firstCameraAnim === false ? true : true;
    }
    ;
    let m_positionData = [
        { type: 'chest', loadoutSlot: 'melee', pos: 0 },
        { type: 'rightarm', loadoutSlot: 'rifle1', pos: 1 },
        { type: 'rightleg', loadoutSlot: 'rifle1', pos: 1 },
        { type: 'rightside', loadoutSlot: 'rifle1', pos: 1 },
        { type: 'back', loadoutSlot: 'rifle1', pos: 2 },
        { type: 'leftarm', loadoutSlot: 'rifle1', pos: -1 },
        { type: 'leftside', loadoutSlot: 'rifle1', pos: -1 },
        { type: 'leftleg', loadoutSlot: 'rifle1', pos: -1 },
    ];
    function _UpdatePreviewPanelSettingsForPatchPosition(charItemId, activeIndex = 0) {
        const charTeam = ItemInfo.GetTeam(m_elPreviewPanel.Data().id);
        let setting_team = charTeam.search('Team_CT') !== -1 ? 'ct' : 't';
        let patchPosition = InventoryAPI.GetCharacterPatchPosition(charItemId, activeIndex.toString());
        let oPositionData = m_positionData.filter(entry => entry.type === patchPosition)[0];
        if (!oPositionData) {
            return;
        }
        InspectModelImage.SetCharScene(m_elPreviewPanel, m_elPreviewPanel.Data().id, LoadoutAPI.GetItemID(setting_team, oPositionData.loadoutSlot));
        let numTurns = 0;
        if (m_pos !== oPositionData.pos) {
            if (m_pos === 0 && oPositionData.pos === 1 ||
                m_pos === 1 && oPositionData.pos === 2 ||
                m_pos === 2 && oPositionData.pos === -1 ||
                m_pos === -1 && oPositionData.pos === 0) {
                numTurns = 1;
            }
            else if (m_pos === 2 && oPositionData.pos === 1 ||
                m_pos === 1 && oPositionData.pos === 0 ||
                m_pos === 0 && oPositionData.pos === -1 ||
                m_pos === -1 && oPositionData.pos === 2) {
                numTurns = -1;
            }
            else if (m_pos === 2 && oPositionData.pos === 0 ||
                m_pos === 1 && oPositionData.pos === -1 ||
                m_pos === -1 && oPositionData.pos === 1 ||
                m_pos === 0 && oPositionData.pos === 2) {
                numTurns = 2;
            }
        }
        m_pos = oPositionData.pos;
        let elModelPanel = m_elPreviewPanel.FindChildInLayoutFile("CharPreviewPanel");
        if (numTurns < 0) {
            elModelPanel.TurnLeftCount(numTurns * -1);
        }
        else {
            elModelPanel.TurnRightCount(numTurns);
        }
        patchPosition = !patchPosition ? 'wide_intro' : patchPosition + _CameraForModel(charItemId, activeIndex);
        elModelPanel.TransitionToCamera('cam_char_inspect_' + patchPosition, 1.25);
    }
    function _CameraForModel(charItemId, activeIndex) {
        const modelplayer = ItemInfo.GetModelPlayer(charItemId);
        if (modelplayer.indexOf('tm_jungle_raider_variantb2') !== -1 && activeIndex === 2) {
            return '_low';
        }
        if (modelplayer.indexOf('tm_professional_letg') !== -1 && activeIndex === 0) {
            return '_shoulder';
        }
        if (modelplayer.indexOf('tm_professional_letg') !== -1 && activeIndex === 2) {
            return '_offset';
        }
        if (modelplayer.indexOf('tm_professional_leth') !== -1 && activeIndex === 2) {
            return '_shoulder_top_left';
        }
        return '';
    }
    // @ts                                                             
    // @ts                                                             
    return {
        PreviewPatchOnChar: _PreviewPatchOnChar,
        CameraAnim: _CameraAnim,
        OnRemovePatch: _OnRemovePatch,
        ResetPos: _ResetPos,
        UpdatePreviewPanelSettingsForPatchPosition: _UpdatePreviewPanelSettingsForPatchPosition,
    };
})();
