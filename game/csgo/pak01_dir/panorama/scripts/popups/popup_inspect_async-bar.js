"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/hold_button.ts" />
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
    let m_showXrayMachineUi = false;
    let m_allowXrayClaim = false;
    let m_allowRental = false;
    let m_inspectOnly = false;
    let m_isSeasonPass = false;
    let m_panel = null;
    let _m_PanelRegisteredForEvents = undefined;
    let m_isWorkshopPreview = false;
    function Init(elPanel, itemId, funcGetSettingCallback, funcCallbackOnAction, funcCallbackOnActionNegative) {
        m_itemid = itemId;
        m_worktype = funcGetSettingCallback('asyncworktype', '');
        m_toolid = funcGetSettingCallback('toolid', '');
        m_allowRental = (funcGetSettingCallback('allow-rent', 'no') === 'yes');
        m_isDecodeableKeyless = (funcGetSettingCallback('decodeablekeyless', 'false') === 'true');
        m_asynActionForceHide = (funcGetSettingCallback('asyncforcehide', 'false') === 'true');
        m_showAsyncActionDesc = (funcGetSettingCallback('asyncactiondescription', 'no') === 'yes');
        m_showXrayMachineUi = (funcGetSettingCallback("showXrayMachineUi", "no") === 'yes');
        m_allowXrayClaim = (funcGetSettingCallback("allowxrayclaim", "no") === 'yes');
        m_inspectOnly = (funcGetSettingCallback('inspectonly', 'false') === 'true');
        m_isSeasonPass = (funcGetSettingCallback('seasonpass', 'false') === 'true');
        m_isWorkshopPreview = (funcGetSettingCallback('workshopPreview', 'false') === 'true');
        m_panel = elPanel;
        if (m_asynActionForceHide ||
            !m_worktype ||
            (m_allowRental && !m_showXrayMachineUi) ||
            (m_worktype === 'nameable' && !m_toolid) ||
            _DoesNotMeetDecodalbeRequirements()) {
            elPanel.AddClass('hidden');
            return;
        }
        elPanel.RemoveClass('hidden');
        m_okButtonClass = funcGetSettingCallback('asyncworkbtnstyle', m_okButtonClass);
        _SetUpDescription(elPanel);
        _SetUpButtonStates(elPanel, funcGetSettingCallback, funcCallbackOnAction, funcCallbackOnActionNegative);
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
            if (sRestriction === 'restricted' || (sRestriction === 'xray' && !m_showXrayMachineUi) || m_inspectOnly)
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
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.StickerScratch', 'MOUSE');
            funcCallbackOnAction(m_itemid, m_toolid, selectedSlot);
        }
        else if (m_worktype === 'remove_keychain') {
            let selectedSlot = parseInt(funcGetSettingCallback('selectedItemToApplySlot', ''));
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.StickerScratch', 'MOUSE');
            funcCallbackOnAction(m_itemid, m_toolid, selectedSlot);
        }
        else if (m_worktype === 'remove_sticker') {
            let selectedSlot = parseInt(funcGetSettingCallback('selectedItemToApplySlot', ''));
            funcCallbackOnAction(m_itemid, m_toolid, selectedSlot);
        }
        else if (m_worktype === 'can_wrap_sticker') {
            let selectedSlot = parseInt(funcGetSettingCallback('selectedItemToApplySlot', ''));
            $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_applyConfirm', 'MOUSE');
            funcCallbackOnAction(m_itemid, m_toolid, selectedSlot);
        }
        else if (m_worktype === 'can_sticker' || m_worktype === 'can_patch' || m_worktype === 'can_keychain') {
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
            else if (InventoryAPI.GetItemAttributeValue(m_itemid, '{uint32}volatile container')) {
                $.DispatchEvent('CSGOPlaySoundEffect', 'UI.Laptop.Unlock', 'MOUSE');
                InventoryAPI.UseTool(m_toolid, m_itemid);
            }
            else {
                InventoryAPI.UseTool(m_toolid, m_itemid);
            }
            if (InventoryAPI.GetDecodeableRestriction(m_itemid) !== "xray") {
                $.DispatchEvent('StartDecodeableAnim');
            }
        }
    }
    function _SetUpButtonStates(elPanel, funcGetSettingCallback, funcCallbackOnAction, funcCallbackOnActionNegative) {
        let elOK = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm');
        let elNegative = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegative');
        let sOkButtonText = '#popup_' + m_worktype + '_button';
        if (m_isWorkshopPreview) {
            elOK.AddClass('hidden');
            if (elNegative)
                elNegative.AddClass('hidden');
        }
        function _SetPanelEventOnAccept() {
            elOK.SetPanelEvent('onactivate', () => _OnAccept(elPanel, funcGetSettingCallback, funcCallbackOnAction));
        }
        if (m_worktype === '') {
            return;
        }
        if (m_worktype === 'can_wrap_sticker') {
            elOK.visible = false;
            elNegative.visible = false;
            let btnId = m_toolid ? 'AsyncItemWorkAcceptConfirmHold' : 'AsyncItemWorkAcceptNegativeHold';
            let btnHoldAction = elPanel.FindChildInLayoutFile(btnId);
            let locString = !m_toolid ? '#popup_' + m_worktype + '_button_negative' : '#popup_' + m_worktype + '_button';
            btnHoldAction.RemoveClass('AsyncItemWorkAcceptNegativeHidden');
            let btnSettings = {
                btn: btnHoldAction,
                tooltip: !m_toolid ? '#popup_can_wrap_sticker_button_negative_tooltip' : '#popup_can_wrap_sticker_button_tooltip',
                locString: locString,
                loopingSound: 'UI.Laptop.ButtonFillLoop',
                timerCompleteAction: () => {
                    _OnAccept(elPanel, funcGetSettingCallback, !m_toolid ? funcCallbackOnActionNegative : funcCallbackOnAction);
                    btnHoldAction.enabled = false;
                }
            };
            HoldButton.SetupButton(btnSettings);
            return;
        }
        if (m_worktype === 'remove_keychain') {
            elOK.visible = false;
            elNegative.visible = false;
            let btnHoldAction = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegativeHold');
            btnHoldAction.RemoveClass('AsyncItemWorkAcceptNegativeHidden');
            let btnSettings = {
                btn: btnHoldAction,
                tooltip: '#SFUI_Keychain_Remove_Tooltip',
                locString: '#popup_' + m_worktype + '_button',
                loopingSound: 'UI.Laptop.ButtonFillLoop',
                timerCompleteAction: () => {
                    _OnAccept(elPanel, funcGetSettingCallback, funcCallbackOnAction);
                    btnHoldAction.enabled = false;
                }
            };
            HoldButton.SetupButton(btnSettings);
            return;
        }
        if (m_worktype === 'remove_patch') {
            elOK.visible = false;
            elNegative.visible = false;
            let btnHoldAction = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegativeHold');
            btnHoldAction.RemoveClass('AsyncItemWorkAcceptNegativeHidden');
            let btnSettings = {
                btn: btnHoldAction,
                tooltip: '#SFUI_Patch_Remove_Desc_Tooltip',
                locString: '#popup_' + m_worktype + '_button',
                loopingSound: 'UI.Laptop.ButtonFillLoop',
                timerCompleteAction: () => {
                    _OnAccept(elPanel, funcGetSettingCallback, funcCallbackOnAction);
                    btnHoldAction.enabled = false;
                }
            };
            HoldButton.SetupButton(btnSettings);
            return;
        }
        if (m_worktype === 'remove_sticker') {
            elNegative.visible = false;
            let btnHoldAction = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegativeHold');
            btnHoldAction.RemoveClass('AsyncItemWorkAcceptNegativeHidden');
            let btnSettings = {
                btn: btnHoldAction,
                tooltip: '#SFUI_Sticker_RemoveImmediate_Tooltip',
                locString: '#popup_' + m_worktype + '_button_negative',
                loopingSound: 'UI.Laptop.ButtonFillLoop',
                timerCompleteAction: () => {
                    _OnAccept(elPanel, funcGetSettingCallback, funcCallbackOnActionNegative);
                    btnHoldAction.enabled = false;
                }
            };
            HoldButton.SetupButton(btnSettings);
        }
        let itemDefName = InventoryAPI.GetItemDefinitionName(m_itemid);
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
            if (m_showXrayMachineUi) {
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
            if (itemDefName && itemDefName.indexOf("spray") != -1)
                sOkButtonText = sOkButtonText + "_graffiti";
            else if (itemDefName && itemDefName.indexOf("tournament_pass_") != -1)
                sOkButtonText = sOkButtonText + "_fantoken";
            else if (InventoryAPI.GetItemAttributeValue(m_itemid, '{uint32}volatile container'))
                sOkButtonText = sOkButtonText + "_terminal";
        }
        if (m_worktype === 'can_sticker') {
            let listStickers = ItemInfo.GetitemStickerList(m_itemid);
            elOK.SetDialogVariableInt('sticker_count', listStickers.length + 1);
            elOK.SetDialogVariableInt('max_stickers', 5);
        }
        if (m_worktype === 'nameable' && itemDefName === 'casket') {
            sOkButtonText = '#popup_newcasket_button';
        }
        if (m_worktype === 'useitem') {
            if (itemDefName && itemDefName.startsWith('Remove Keychain Tool')) {
                elOK.SetDialogVariableInt('item_count', Number(InventoryAPI.GetItemAttributeValue(m_itemid, '{uint32}items count')));
                sOkButtonText = '#popup_useitem_button_getkeychaincharges';
            }
            if (itemDefName && itemDefName.startsWith('XpShopTicket')) {
                let bHasPrime = FriendsListAPI.GetFriendPrimeEligible(MyPersonaAPI.GetXuid());
                sOkButtonText = bHasPrime ? '#xpshop_pass_activate_open_armory' : '#SFUI_Elevated_Status_upgrade_status';
            }
        }
        elOK.text = sOkButtonText;
        elOK.AddClass(m_okButtonClass);
        _SetPanelEventOnAccept();
    }
    function _SetUpDescription(elPanel) {
        let elDescLabel = elPanel.FindChildInLayoutFile('AsyncItemWorkDesc');
        let elDescImage = elPanel.FindChildInLayoutFile('AsyncItemWorkDescImage');
        elDescLabel.SetHasClass('popup-capability-faded', m_showXrayMachineUi && !m_allowXrayClaim);
        elDescImage.SetHasClass('popup-capability-faded', m_showXrayMachineUi && !m_allowXrayClaim);
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
        if (elOK.visible) {
            if (elOK.enabled !== bEnable)
                elOK.TriggerClass('popup-capability-update-anim');
            elOK.enabled = bEnable;
        }
        let elNegative = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegative');
        if (elNegative && elNegative.visible) {
            if (elNegative.enabled !== bEnable)
                elNegative.TriggerClass('popup-capability-update-anim');
            elNegative.enabled = bEnable;
        }
        elNegative = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegativeHold');
        if (elNegative && elNegative.visible) {
            if (elNegative.enabled !== bEnable)
                elNegative.TriggerClass('popup-capability-update-anim');
            elNegative.enabled = bEnable;
        }
    }
    InspectAsyncActionBar.EnableDisableOkBtn = EnableDisableOkBtn;
    function ShowHideOkBtn(elPanel, bShow) {
        let elOK = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm');
        elOK.SetHasClass('move-down', !bShow);
        let elNegative = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegative');
        if (elNegative)
            elNegative.SetHasClass('move-down', !bShow);
        elNegative = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegativeHold');
        if (elNegative)
            elNegative.SetHasClass('move-down', !bShow);
    }
    InspectAsyncActionBar.ShowHideOkBtn = ShowHideOkBtn;
    function ShowHideBackBtn(elPanel, bShow) {
    }
    InspectAsyncActionBar.ShowHideBackBtn = ShowHideBackBtn;
    function _OnAccept(elPanel, funcGetSettingCallback, funcCallbackOnAction) {
        ResetTimeouthandle();
        if (m_worktype === 'useitem') {
            if (ItemInfo.ItemDefinitionNameSubstrMatch(m_itemid, 'XpShopTicket')) {
                let bHasPrime = FriendsListAPI.GetFriendPrimeEligible(MyPersonaAPI.GetXuid());
                if (!bHasPrime) {
                    UiToolkitAPI.ShowCustomLayoutPopup('prime_status', 'file://{resources}/layout/popups/popup_prime_status.xml');
                    return;
                }
                let oXpShopTrackProgress = InventoryAPI.GetCacheTypeElementJSOByIndex('XpShop', 0);
                let bTooManyTracks = (oXpShopTrackProgress && (oXpShopTrackProgress.xp_tracks.length >= StoreAPI.GetXpShopMaxTracks()));
                if (bTooManyTracks) {
                    UiToolkitAPI.ShowGenericPopupOk('#CSGO_Purchasable_XpShop_Ticket', '#CSGO_Purchasable_XpShop_Ticket_TooManyTracks', '', () => { });
                    return;
                }
                ResetTimeouthandle();
                _ClosePopup();
                $.DispatchEvent('MainMenuGoToStore', 'id-store-nav-xpshop');
                return;
            }
        }
        elPanel.FindChildInLayoutFile('NameableSpinner').RemoveClass('hidden');
        elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm').AddClass('hidden');
        let elNegative = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegative');
        if (elNegative)
            elNegative.AddClass('hidden');
        elNegative = elPanel.FindChildInLayoutFile('AsyncItemWorkAcceptNegativeHold');
        if (elNegative)
            elNegative.AddClass('hidden');
        _PerformAsyncAction(funcGetSettingCallback, funcCallbackOnAction);
    }
    function _ShowHideInspectViewButtons() {
        if (m_worktype === 'can_sticker' || m_worktype === 'can_keychain') {
            m_panel.FindChildInLayoutFile('InspectWeaponBtn').SetPanelEvent('onactivate', () => {
                InspectModelImage.EndWeaponLookat();
                CanApplyPickSlot.ShowHideInfoPanel(false);
                CanApplyPickSlot.IsContinueEnabled();
                ShowHideOkBtn(m_panel, true);
                EnableDisableOkBtn(m_panel, !CanApplyPickSlot.IsContinueEnabled());
                m_panel.FindChildInLayoutFile('AsyncItemWorkCancelBtn').text = "#GameUI_Close";
                if (m_panel.FindChildInLayoutFile('InspectItemModelZoom').visible) {
                    m_panel.FindChildInLayoutFile('InspectItemModelZoom').enabled = true;
                }
            });
            m_panel.FindChildInLayoutFile('LookatWeaponBtn').SetPanelEvent('onactivate', () => {
                InspectModelImage.StartWeaponLookat();
                CanApplyPickSlot.ShowHideInfoPanel(true);
                ShowHideOkBtn(m_panel, false);
                EnableDisableOkBtn(m_panel, false);
                m_panel.FindChildInLayoutFile('AsyncItemWorkCancelBtn').text = "#SFUI_Back";
                m_panel.FindChildInLayoutFile('InspectItemModelZoom').enabled = false;
            });
            m_panel.FindChildInLayoutFile('InspectWeaponBtn').GetParent().SetHasClass('hidden', false);
        }
        else {
            m_panel.FindChildInLayoutFile('InspectWeaponBtn').GetParent().SetHasClass('hidden', true);
        }
        m_panel.FindChildInLayoutFile('ChangeScenery').SetHasClass('hidden', m_worktype === 'decodeable' || m_worktype === 'remove_patch'
            || m_worktype === 'can_wrap_sticker'
            || m_worktype === 'remove_sticker' || m_worktype === 'remove_keychain');
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
        if (InspectModelImage.PanZoomEnabled())
            return;
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
            let elNegative = m_panel.FindChildInLayoutFile('AsyncItemWorkAcceptNegative');
            if (elNegative)
                elNegative.RemoveClass('hidden');
            elNegative = m_panel.FindChildInLayoutFile('AsyncItemWorkAcceptNegativeHold');
            if (elNegative)
                elNegative.RemoveClass('hidden');
        }
    }
    InspectAsyncActionBar.OnCloseRemove = OnCloseRemove;
    function _ClosePopup() {
        ResetTimeouthandle();
        HoldButton.StopLoopingSound('UI.Laptop.ButtonFillLoop');
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
        if (m_panel && (m_worktype === 'can_sticker' || m_worktype === 'can_keychain')) {
            let elLookatBtn = m_panel.FindChildInLayoutFile('LookatWeaponBtn');
            if (elLookatBtn && elLookatBtn.IsValid()
                && elLookatBtn.checked
                && m_scheduleHandle === null) {
                $.DispatchEvent("Activated", m_panel.FindChildInLayoutFile('InspectWeaponBtn'), "mouse");
                return;
            }
        }
        ResetTimeouthandle();
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
        if (type === 'xp_shop_use_ticket' || type === 'xp_shop_ack_tracks') {
        }
        else if (type === 'keychain_tool_charges' && m_worktype === 'useitem') {
            let defidxContract = InventoryAPI.GetItemDefinitionIndexFromDefinitionName("Remove Keychain Tool");
            let fauxItemID = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(defidxContract, 0);
            $.DispatchEvent("ShowCustomLayoutPopupParametersAsEvent", '', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + fauxItemID +
                '&' + 'inspectonly=true');
        }
        else {
            $.DispatchEvent('ShowAcknowledgePopup', type, itemid);
        }
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
            m_worktype === "remove_keychain" ||
            m_worktype === "can_sticker" ||
            m_worktype === "can_wrap_sticker" ||
            m_worktype === "can_patch" ||
            m_worktype === "can_keychain" ||
            m_worktype === "useitem" ||
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
            $.DispatchEvent('InventoryItemPreview', upgradeid, '');
        }
    }
})(InspectAsyncActionBar || (InspectAsyncActionBar = {}));
