"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="popup_can_apply_pick_slot.ts" />
/// <reference path="popup_inspect_async-bar.ts" />
var CapabilityCanPatch;
(function (CapabilityCanPatch) {
    function ResetPos() {
        $.GetContextPanel().Data().patchCharPos = 0;
        $.GetContextPanel().Data().bFirstCameraAnim = false;
        $.GetContextPanel().Data().prevCameraSlot = 0;
    }
    CapabilityCanPatch.ResetPos = ResetPos;
    function PreviewPatchOnChar(toolId, activeIndex, contextPanel) {
        $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_nextPosition', 'MOUSE');
        let elPreviewPanel = contextPanel.FindChildInLayoutFile('CanApplyItemModel');
        let elCharPanel = elPreviewPanel.FindChildInLayoutFile("CharPreviewPanel");
        if (!elCharPanel || !elCharPanel.IsValid()) {
            return;
        }
        InventoryAPI.PreviewStickerInModelPanel(toolId, activeIndex, elCharPanel);
        CameraAnim(activeIndex, contextPanel);
    }
    CapabilityCanPatch.PreviewPatchOnChar = PreviewPatchOnChar;
    ;
    function CameraAnim(activeIndex, contextPanel) {
        let prevCameraSlot = contextPanel.Data().prevCameraSlot;
        if ((prevCameraSlot === activeIndex || activeIndex == -1) && prevCameraSlot)
            return;
        let elPreviewPanel = contextPanel.FindChildInLayoutFile('CanApplyItemModel');
        if (!InventoryAPI.IsItemInfoValid(elPreviewPanel.Data().id))
            return;
        contextPanel.Data().bFirstCameraAnim = true;
        InventoryAPI.HighlightPatchBySlot(activeIndex);
        _UpdatePreviewPanelSettingsForPatchPosition(elPreviewPanel.Data().id, activeIndex, contextPanel);
        prevCameraSlot = activeIndex;
    }
    CapabilityCanPatch.CameraAnim = CameraAnim;
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
    function _UpdatePreviewPanelSettingsForPatchPosition(charItemId, activeIndex = 0, contextPanel) {
        let elPreviewPanel = contextPanel.FindChildInLayoutFile('CanApplyItemModel');
        const charTeam = InventoryAPI.GetItemTeam(elPreviewPanel.Data().id);
        let setting_team = charTeam.search('Team_CT') !== -1 ? 'ct' : 't';
        let patchPosition = InventoryAPI.GetCharacterPatchPosition(charItemId, activeIndex.toString());
        let oPositionData = m_positionData.filter(entry => entry.type === patchPosition)[0];
        if (!oPositionData) {
            contextPanel.Data().bFirstCameraAnim = false;
            return;
        }
        InspectModelImage.SetCharScene(elPreviewPanel.Data().id, LoadoutAPI.GetItemID(setting_team, oPositionData.loadoutSlot));
        let numTurns = 0;
        let CharPos = contextPanel.Data().patchCharPos;
        if (CharPos !== oPositionData.pos) {
            if (CharPos === 0 && oPositionData.pos === 1 ||
                CharPos === 1 && oPositionData.pos === 2 ||
                CharPos === 2 && oPositionData.pos === -1 ||
                CharPos === -1 && oPositionData.pos === 0) {
                numTurns = 1;
            }
            else if (CharPos === 2 && oPositionData.pos === 1 ||
                CharPos === 1 && oPositionData.pos === 0 ||
                CharPos === 0 && oPositionData.pos === -1 ||
                CharPos === -1 && oPositionData.pos === 2) {
                numTurns = -1;
            }
            else if (CharPos === 2 && oPositionData.pos === 0 ||
                CharPos === 1 && oPositionData.pos === -1 ||
                CharPos === -1 && oPositionData.pos === 1 ||
                CharPos === 0 && oPositionData.pos === 2) {
                numTurns = 2;
            }
        }
        contextPanel.Data().patchCharPos = oPositionData.pos;
        let elModelPanel = elPreviewPanel.FindChildInLayoutFile("CharPreviewPanel");
        if (numTurns < 0) {
            elModelPanel.TurnLeftCount(numTurns * -1);
        }
        else {
            elModelPanel.TurnRightCount(numTurns);
        }
        patchPosition = !patchPosition ? 'wide_intro' : patchPosition + _CameraForModel(charItemId, activeIndex);
        elModelPanel.Data().camera = 'char_inspect_' + patchPosition;
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
})(CapabilityCanPatch || (CapabilityCanPatch = {}));
