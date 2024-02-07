"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="popup_can_apply_pick_slot.ts" />
var InspectAsyncActionBar;
(function (InspectAsyncActionBar) {
    let m_scheduleHandle = null;
    let m_itemid = '';
    let m_worktype = '';
    let m_okButtonClass = 'Positive';
    let m_toolid = '';
    let m_isDecodeableKeyless = false;
    let m_asynActionForceHide = false;
    let m_showAsyncActionDesc = false;
    let m_isXrayMode = false;
    let m_allowXrayClaim = false;
    let m_inspectOnly = false;
    let m_isSeasonPass = false;
    let m_panel = null;
    let _m_PanelRegisteredForEvents = undefined;
    function Init(elPanel, itemId, funcGetSettingCallback, funcCallbackOnAction) {
        m_itemid = itemId;
        m_worktype = funcGetSettingCallback('asyncworktype', '');
        m_toolid = funcGetSettingCallback('toolid', '');
        m_isDecodeableKeyless = (funcGetSettingCallback('decodeablekeyless', 'false') === 'true');
        m_asynActionForceHide = (funcGetSettingCallback('asyncforcehide', 'false') === 'true');
        m_showAsyncActionDesc = (funcGetSettingCallback('asyncactiondescription', 'no') === 'yes');
        m_isXrayMode = (funcGetSettingCallback("isxraymode", "no") === 'yes');
        m_allowXrayClaim = (funcGetSettingCallback("allowxrayclaim", "no") === 'yes');
        m_inspectOnly = (funcGetSettingCallback('inspectonly', 'false') === 'true');
        m_isSeasonPass = (funcGetSettingCallback('seasonpass', 'false') === 'true');
        if (m_asynActionForceHide ||
            !m_worktype ||
            (m_worktype === 'nameable' && !m_toolid) ||
            _DoesNotMeetDecodalbeRequirements()) {
            elPanel.AddClass('hidden');
            return;
        }
        m_panel = elPanel;
        elPanel.RemoveClass('hidden');
        m_okButtonClass = funcGetSettingCallback('asyncworkbtnstyle', m_okButtonClass);
        _SetUpDescription(elPanel);
        _SetUpButtonStates(elPanel, funcGetSettingCallback, funcCallbackOnAction);
        m_panel.FindChildInLayoutFile('InspectWeaponBtn').checked = true;
        _ShowHideInspectViewButtons();
        _ShowZoomBtn();
        if (m_worktype === 'prestigecheck') {
            _OnAccept(elPanel);
        }
        if (!_m_PanelRegisteredForEvents) {
            _m_PanelRegisteredForEvents = $.RegisterForUnhandledEvent('PanoramaComponent_Inventory_ItemCustomizationNotification', _OnItemCustomization);
            if (m_worktype !== 'decodeable' && m_worktype !== 'nameable' && m_worktype !== 'remove_sticker') {
                $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', _OnMyPersonaInventoryUpdated);
                $.RegisterForUnhandledEvent('PanoramaComponent_Inventory_PrestigeCoinResponse', _OnInventoryPrestigeCoinResponse);
            }
        }
    }
    InspectAsyncActionBar.Init = Init;
    function _DoesNotMeetDecodalbeRequirements() {
        if (m_worktype === 'decodeable') {
            let sRestriction = InventoryAPI.GetDecodeableRestriction(m_itemid);
            if (sRestriction === 'restricted' || (sRestriction === 'xray' && !m_isXrayMode) || m_inspectOnly)
                return false;
            return (!m_toolid && !m_isDecodeableKeyless);
        }
        return false;
    }
    function _PerformAsyncAction(funcGetSettingCallback, funcCallbackOnAction) {
        if (m_worktype === 'useitem' || m_worktype === 'usegift') {
            InventoryAPI.UseTool(m_itemid, '');
        }
        else if (m_worktype === 'delete') {
            InventoryAPI.DeleteItem(m_itemid);
        }
        else if (m_worktype === 'prestigecheck') {
            InventoryAPI.RequestPrestigeCoinCheck();
        }
        else if (m_worktype === 'prestigeget' || m_worktype === 'prestigeupgrade') {
            InventoryAPI.RequestPrestigeCoin(InventoryAPI.GetItemDefinitionIndex(m_itemid));
        }
        else if (m_worktype === 'nameable') {
            $.DispatchEvent("CSGOPlaySoundEffect", "rename_applyConfirm", "MOUSE");
            InventoryAPI.UseTool(m_toolid, m_itemid);
            funcCallbackOnAction();
        }
        else if (m_worktype === 'remove_patch') {
            let selectedSlot = parseInt(funcGetSettingCallback('selectedItemToApplySlot', ''));
            funcCallbackOnAction(m_itemid, m_toolid, selectedSlot);
        }
        else if (m_worktype === 'remove_sticker') {
            let selectedSlot = parseInt(funcGetSettingCallback('selectedItemToApplySlot', ''));
            $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_scratchOff', 'MOUSE');
            funcCallbackOnAction(m_itemid, m_toolid, selectedSlot);
        }
        else if (m_worktype === 'can_sticker' || m_worktype === 'can_patch') {
            $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_applyConfirm', 'MOUSE');
            let selectedSlot = parseInt(funcGetSettingCallback('selectedItemToApplySlot', ''));
            funcCallbackOnAction(m_itemid, m_toolid, selectedSlot);
        }
        else if (m_worktype === 'decodeable') {
            if (ItemInfo.IsSpraySealed(m_itemid) || ItemInfo.ItemDefinitionNameSubstrMatch(m_itemid, 'tournament_pass_')) {
                InventoryAPI.UseTool(m_itemid, '');
            }
            else if (InventoryAPI.GetDecodeableRestriction(m_itemid) === "xray" && !m_allowXrayClaim) {
                InventoryAPI.UseTool(m_itemid, m_itemid);
            }
            else {
                InventoryAPI.UseTool(m_toolid, m_itemid);
            }
            if (InventoryAPI.GetDecodeableRestriction(m_itemid) !== "xray") {
                $.DispatchEvent('StartDecodeableAnim');
            }
        }
    }
    function _SetUpButtonStates(elPanel, funcGetSettingCallback, funcCallbackOnAction) {
        let elOK = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm');
        function _SetPanelEventOnAccept() {
            elOK.SetPanelEvent('onactivate', () => _OnAccept(elPanel, funcGetSettingCallback, funcCallbackOnAction));
        }
        if (m_worktype === 'decodeable') {
            let sRestriction = InventoryAPI.GetDecodeableRestriction(m_itemid);
            let elDescLabel = elPanel.FindChildInLayoutFile('AsyncItemWorkDesc');
            let elDescImage = elPanel.FindChildInLayoutFile('AsyncItemWorkDescImage');
            if (m_inspectOnly || sRestriction === 'restricted') {
                elOK.visible = false;
                elDescLabel.visible = false;
                elDescImage.visible = false;
                return;
            }
            if (m_isXrayMode) {
                let enabled = m_allowXrayClaim ? true : false;
                EnableDisableOkBtn(elPanel, enabled);
                elOK.AddClass(m_okButtonClass);
                elOK.text = '#popup_xray_claim_item';
                _SetPanelEventOnAccept();
                return;
            }
            if (sRestriction === 'xray' && !m_inspectOnly) {
                elOK.visible = true;
                elOK.text = '#popup_xray_button_goto';
                elOK.AddClass(m_okButtonClass);
                elOK.SetPanelEvent('onactivate', () => {
                    $.DispatchEvent("ShowXrayCasePopup", m_toolid, m_itemid, true);
                    _ClosePopup();
                });
                elDescLabel.visible = true;
                elDescLabel.text = '#popup_decodeable_async_xray_desc';
                elDescImage.visible = false;
                return;
            }
        }
        let sOkButtonText = '#popup_' + m_worktype + '_button';
        if (m_worktype === 'can_sticker') {
            let listStickers = ItemInfo.GetitemStickerList(m_itemid);
            elOK.SetDialogVariableInt('sticker_count', listStickers.length + 1);
            elOK.SetDialogVariableInt('max_stickers', 5);
        }
        let itemDefName = InventoryAPI.GetItemDefinitionName(m_itemid);
        if (m_worktype === 'decodeable') {
            if (itemDefName && itemDefName.indexOf("spray") != -1)
                sOkButtonText = sOkButtonText + "_graffiti";
            else if (itemDefName && itemDefName.indexOf("tournament_pass_") != -1)
                sOkButtonText = sOkButtonText + "_fantoken";
        }
        if (m_worktype === 'nameable' && itemDefName === 'casket') {
            sOkButtonText = '#popup_newcasket_button';
        }
        elOK.text = sOkButtonText;
        elOK.AddClass(m_okButtonClass);
        _SetPanelEventOnAccept();
    }
    function _SetUpDescription(elPanel) {
        let elDescLabel = elPanel.FindChildInLayoutFile('AsyncItemWorkDesc');
        let elDescImage = elPanel.FindChildInLayoutFile('AsyncItemWorkDescImage');
        elDescLabel.SetHasClass('popup-capability-faded', m_isXrayMode && !m_allowXrayClaim);
        elDescImage.SetHasClass('popup-capability-faded', m_isXrayMode && !m_allowXrayClaim);
        if (m_showAsyncActionDesc) {
            elDescImage.itemid = m_toolid;
            let itemName = InventoryAPI.GetItemName(m_toolid);
            if (itemName) {
                elDescLabel.SetDialogVariable('itemname', itemName);
                elDescLabel.text = $.Localize('#popup_' + m_worktype + '_async_desc', elDescLabel);
            }
        }
        elDescLabel.visible = m_showAsyncActionDesc;
    }
    function EnableDisableOkBtn(elPanel, bEnable) {
        let elOK = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm');
        if (!elOK.visible)
            return;
        if (elOK.enabled !== bEnable)
            elOK.TriggerClass('popup-capability-update-anim');
        elOK.enabled = bEnable;
    }
    InspectAsyncActionBar.EnableDisableOkBtn = EnableDisableOkBtn;
    function ShowHideOkBtn(elPanel, bShow) {
        let elOK = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm');
        elOK.SetHasClass('move-down', !bShow);
    }
    InspectAsyncActionBar.ShowHideOkBtn = ShowHideOkBtn;
    function _OnAccept(elPanel, funcGetSettingCallback, funcCallbackOnAction) {
        ResetTimeouthandle();
        elPanel.FindChildInLayoutFile('NameableSpinner').RemoveClass('hidden');
        elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm').AddClass('hidden');
        if (m_worktype !== 'remove_patch' && m_worktype !== 'remove_sticker') {
            m_scheduleHandle = $.Schedule(5, () => _CancelWaitforCallBack(elPanel));
        }
        _PerformAsyncAction(funcGetSettingCallback, funcCallbackOnAction);
    }
    function _ShowHideInspectViewButtons() {
        if (m_worktype === 'can_sticker') {
            m_panel.FindChildInLayoutFile('InspectWeaponBtn').SetPanelEvent('onactivate', () => {
                InspectModelImage.EndWeaponLookat();
                CanApplyPickSlot.ShowHideInfoPanel(false);
                CanApplyPickSlot.IsContinueEnabled();
                ShowHideOkBtn(m_panel, true);
                EnableDisableOkBtn(m_panel, !CanApplyPickSlot.IsContinueEnabled());
                if (m_panel.FindChildInLayoutFile('InspectItemModelZoom').visible) {
                    m_panel.FindChildInLayoutFile('InspectItemModelZoom').enabled = true;
                }
            });
            m_panel.FindChildInLayoutFile('LookatWeaponBtn').SetPanelEvent('onactivate', () => {
                InspectModelImage.StartWeaponLookat();
                CanApplyPickSlot.ShowHideInfoPanel(true);
                ShowHideOkBtn(m_panel, false);
                EnableDisableOkBtn(m_panel, false);
                m_panel.FindChildInLayoutFile('InspectItemModelZoom').enabled = false;
            });
        }
        m_panel.FindChildInLayoutFile('ChangeScenery').SetHasClass('hidden', m_worktype === 'decodeable' || m_worktype === 'remove_patch' || m_worktype === 'remove_sticker');
        m_panel.FindChildInLayoutFile('InspectWeaponBtn').GetParent().SetHasClass('hidden', m_worktype !== 'can_sticker');
    }
    function UpdateScenery() {
        UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('id-inspect-contextmenu-maps', '', 'file://{resources}/layout/context_menus/context_menu_mainmenu_vanity.xml', 'type=maps' +
            '&' + 'inspect-map=true', () => { $.DispatchEvent('ContextMenuEvent', ''); });
    }
    InspectAsyncActionBar.UpdateScenery = UpdateScenery;
    function EnableDisableChangeSceneryBtn(bEnable) {
        m_panel.FindChildInLayoutFile('ChangeScenery').enabled = bEnable;
    }
    InspectAsyncActionBar.EnableDisableChangeSceneryBtn = EnableDisableChangeSceneryBtn;
    function _ShowZoomBtn() {
        const defName = InventoryAPI.GetItemDefinitionName(m_itemid);
        let result = InspectModelImage.m_CameraSettingsPerWeapon.find(({ type }) => type === defName);
        if (!result || !result.hasOwnProperty('zoom_camera'))
            return;
        let elZoomBtn = m_panel.FindChildInLayoutFile('InspectItemModelZoom');
        elZoomBtn.SetHasClass('hidden', false);
        let strCamera = result?.zoom_camera;
        let aCameras = strCamera?.split(',');
        elZoomBtn.Data().can_pan_camera = (aCameras && aCameras?.length > 1) ? true : false;
    }
    function ZoomCamera(bForceZoomOut = false) {
        let elZoomButton = m_panel.FindChildInLayoutFile('InspectItemModelZoom');
        if (bForceZoomOut) {
            InspectModelImage.ZoomCamera(false);
            CanApplyPickSlot.ShowHidePanBtns(false);
            elZoomButton.checked = false;
            return;
        }
        if (elZoomButton.checked) {
            InspectModelImage.ZoomCamera(true);
            CanApplyPickSlot.ShowHidePanBtns(elZoomButton.Data().can_pan_camera);
        }
        else {
            InspectModelImage.ZoomCamera(false);
            CanApplyPickSlot.ShowHidePanBtns(false);
        }
    }
    InspectAsyncActionBar.ZoomCamera = ZoomCamera;
    function OnCloseRemove() {
        if (m_panel.IsValid()) {
            m_panel.FindChildInLayoutFile('NameableSpinner').AddClass('hidden');
            m_panel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm').RemoveClass('hidden');
        }
    }
    InspectAsyncActionBar.OnCloseRemove = OnCloseRemove;
    function _ClosePopup() {
        ResetTimeouthandle();
        $.DispatchEvent('HideSelectItemForCapabilityPopup');
        $.DispatchEvent('UIPopupButtonClicked', '');
        $.DispatchEvent('CapabilityPopupIsOpen', false);
    }
    function SetCallbackTimeout() {
        let elPanel = $.GetContextPanel();
        $.Schedule(5, () => _CancelWaitforCallBack(elPanel));
    }
    InspectAsyncActionBar.SetCallbackTimeout = SetCallbackTimeout;
    function _CancelWaitforCallBack(elPanel) {
        m_scheduleHandle = null;
        let elSpinner = elPanel.FindChildInLayoutFile('NameableSpinner');
        elSpinner.AddClass('hidden');
        _ClosePopup();
        UiToolkitAPI.ShowGenericPopupOk($.Localize('#SFUI_SteamConnectionErrorTitle'), $.Localize('#SFUI_InvError_Item_Not_Given'), '', () => { });
    }
    function OnEventToClose(bCloseForLootlistPreview = false) {
        ResetTimeouthandle();
        if (!bCloseForLootlistPreview) {
            $.DispatchEvent('UnblurOperationPanel');
        }
        _ClosePopup();
    }
    InspectAsyncActionBar.OnEventToClose = OnEventToClose;
    function ResetTimeouthandle() {
        if (m_scheduleHandle) {
            $.CancelScheduled(m_scheduleHandle);
            m_scheduleHandle = null;
        }
    }
    InspectAsyncActionBar.ResetTimeouthandle = ResetTimeouthandle;
    function _OnItemCustomization(numericType, type, itemid) {
        if (_IgnoreClose()) {
            ResetTimeouthandle();
            return;
        }
        OnEventToClose();
        $.DispatchEvent('ShowAcknowledgePopup', type, itemid);
    }
    function _IgnoreClose() {
        return m_worktype === 'decodeable';
    }
    function _OnMyPersonaInventoryUpdated() {
        if (m_isSeasonPass && InventoryAPI.IsValidItemID(m_itemid)) {
            return;
        }
        if (m_worktype === "remove_sticker" ||
            m_worktype === "remove_patch" ||
            m_worktype === "can_sticker" ||
            m_worktype === "can_patch" ||
            m_worktype === "nameable") {
            return;
        }
        OnEventToClose();
    }
    function _OnInventoryPrestigeCoinResponse(defidx, upgradeid, hours, prestigetime) {
        OnEventToClose();
        if (m_worktype === 'prestigecheck') {
            UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(defidx, 0) +
                '&' + 'asyncworkitemwarning=no' +
                '&' + 'asyncworktype=' + ((upgradeid === '0') ? 'prestigeget' : 'prestigeupgrade'));
        }
        else if (upgradeid !== '0') {
            InventoryAPI.AcknowledgeNewItembyItemID(upgradeid);
            InventoryAPI.SetItemSessionPropertyValue(upgradeid, 'recent', '1');
            $.DispatchEvent('InventoryItemPreview', upgradeid);
        }
    }
})(InspectAsyncActionBar || (InspectAsyncActionBar = {}));
