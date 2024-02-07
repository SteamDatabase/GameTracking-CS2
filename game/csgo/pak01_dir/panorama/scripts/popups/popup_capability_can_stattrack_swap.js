"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
var CapabilityCanStatTrackSwap;
(function (CapabilityCanStatTrackSwap) {
    let m_scheduleHandle = null;
    let m_toolId = '';
    let m_itemids = ['', ''];
    let m_statNumbersOriginal = [0, 0];
    let m_distanceLerped = 9999999;
    let m_flLerpProgress = 0.0;
    function Init() {
        m_toolId = $.GetContextPanel().GetAttributeString("swaptool", "");
        m_itemids = [
            $.GetContextPanel().GetAttributeString("swapitem1", ""),
            $.GetContextPanel().GetAttributeString("swapitem2", "")
        ];
        m_itemids.forEach((item, idx) => {
            m_statNumbersOriginal[idx] = parseInt(String(InventoryAPI.GetItemAttributeValue(item, "kill eater")));
            _SetItemModel(idx);
        });
        _SetUpButtonStates();
        $.DispatchEvent('CapabilityPopupIsOpen', true);
        m_scheduleHandle = $.Schedule(0.01, _LerpTimer);
    }
    CapabilityCanStatTrackSwap.Init = Init;
    function _SetItemModel(idx) {
        let elPanel = $.GetContextPanel().FindChildInLayoutFile('StatTrackSwapItemModel' + idx);
        InspectModelImage.Init(elPanel, m_itemids[idx]);
        elPanel.AddClass('darken');
        elPanel.RemoveClass('full-width');
        elPanel.RemoveClass('full-height');
    }
    function _SetUpButtonStates() {
        $.GetContextPanel().FindChildInLayoutFile('StatTrackSwapAcceptConfirm').SetPanelEvent('onactivate', _OnAccept);
        $.GetContextPanel().FindChildInLayoutFile('StatTrackSwapCancelBtn').SetPanelEvent('onactivate', ClosePopup);
    }
    function _LerpTimer() {
        m_scheduleHandle = null;
        let originalLen = m_statNumbersOriginal[1] - m_statNumbersOriginal[0];
        let newDistanceLerped = (m_flLerpProgress < 1.0) ? Math.round(m_flLerpProgress * originalLen) : originalLen;
        if (newDistanceLerped != m_distanceLerped) {
            m_distanceLerped = newDistanceLerped;
            $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'popup_accept_match_waitquiet', 'MOUSE', 1.0);
            let elSwapNumber0 = $.GetContextPanel().FindChildInLayoutFile('StatTrackSwapNumber0');
            let elSwapNumber1 = $.GetContextPanel().FindChildInLayoutFile('StatTrackSwapNumber1');
            elSwapNumber0.text = (m_statNumbersOriginal[0] + m_distanceLerped).toString().padStart(6, "0");
            elSwapNumber1.text = (m_statNumbersOriginal[1] - m_distanceLerped).toString().padStart(6, "0");
        }
        if (m_flLerpProgress < 1.0) {
            m_flLerpProgress += 0.01;
            m_scheduleHandle = $.Schedule(0.04, _LerpTimer);
        }
        else {
        }
    }
    function _OnAccept() {
        if (m_scheduleHandle) {
            $.CancelScheduled(m_scheduleHandle);
            m_flLerpProgress = 1.0;
            _LerpTimer();
        }
        $.GetContextPanel().FindChildInLayoutFile('NameableSpinner').RemoveClass('hidden');
        m_scheduleHandle = $.Schedule(5, _CancelWaitforCallBack);
        InventoryAPI.SetStatTrakSwapToolItems(m_itemids[0], m_itemids[1]);
        InventoryAPI.UseTool(m_toolId, '');
    }
    function ClosePopup() {
        $.DispatchEvent('HideSelectItemForCapabilityPopup');
        $.DispatchEvent('UIPopupButtonClicked', '');
        $.DispatchEvent('CapabilityPopupIsOpen', false);
    }
    CapabilityCanStatTrackSwap.ClosePopup = ClosePopup;
    function _CancelWaitforCallBack() {
        let elSpinner = $.GetContextPanel().FindChildInLayoutFile('NameableSpinner');
        elSpinner.AddClass('hidden');
        ClosePopup();
        UiToolkitAPI.ShowGenericPopupOk($.Localize('#SFUI_SteamConnectionErrorTitle'), $.Localize('#SFUI_InvError_Item_Not_Given'), '', () => { });
    }
    function _OnItemCustomization(numericType, type, itemid) {
        if (m_scheduleHandle) {
            $.CancelScheduled(m_scheduleHandle);
            m_scheduleHandle = null;
        }
        ClosePopup();
        $.DispatchEvent('ShowAcknowledgePopup', type, itemid);
    }
    $.RegisterForUnhandledEvent('PanoramaComponent_Inventory_ItemCustomizationNotification', _OnItemCustomization);
})(CapabilityCanStatTrackSwap || (CapabilityCanStatTrackSwap = {}));
