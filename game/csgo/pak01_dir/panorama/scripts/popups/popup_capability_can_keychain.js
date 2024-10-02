"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="popup_can_apply_pick_slot.ts" />
/// <reference path="popup_inspect_async-bar.ts" />
var CapabilityCanKeychain;
(function (CapabilityCanKeychain) {
    let m_cP = $.GetContextPanel();
    let m_elPreviewPanel = m_cP.FindChildInLayoutFile('CanApplyItemModel');
    let m_prevCameraSlot = 0;
    let m_firstCameraAnim = false;
    let m_pos = 0;
    function ResetPos() {
        m_pos = 0;
        m_prevCameraSlot = 0;
        m_firstCameraAnim = false;
    }
    CapabilityCanKeychain.ResetPos = ResetPos;
    function OnRemoveKeychain(itemId, slotIndex) {
        UiToolkitAPI.ShowGenericPopupTwoOptions($.Localize('#SFUI_Keychain_Remove'), $.Localize('#SFUI_Keychain_Remove_Desc'), '', $.Localize('#SFUI_Keychain_Remove'), () => {
            InspectAsyncActionBar.ResetTimeouthandle();
            InventoryAPI.RemoveKeychain(itemId, 0);
            InspectAsyncActionBar.SetCallbackTimeout();
        }, $.Localize('#UI_Cancel'), () => {
            InspectAsyncActionBar.ResetTimeouthandle();
            InspectAsyncActionBar.OnCloseRemove();
        });
    }
    CapabilityCanKeychain.OnRemoveKeychain = OnRemoveKeychain;
})(CapabilityCanKeychain || (CapabilityCanKeychain = {}));
