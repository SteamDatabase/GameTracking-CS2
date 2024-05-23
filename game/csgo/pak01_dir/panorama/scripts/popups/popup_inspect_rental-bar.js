"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="popup_acknowledge_item.ts" />
/// <reference path="popup_capability_decodable.ts" />
var InspectRentalBar;
(function (InspectRentalBar) {
    let m_itemId = '';
    let m_itemToUseId = '';
    let m_worktype = '';
    let m_elPanel = null;
    let m_popupActionCallbackHandle = null;
    let m_scheduleActionTimoutHandle = null;
    let m_bPanelRegisteredForEvents = false;
    let m_confirmPopUpOpen = false;
    let m_onlyRentalItemIds = [];
    let m_actionType = '';
    let m_keyToSellId = '';
    function Init(elPanel, itemId, ItemToUseId, keyToSellId, funcGetSettingCallback) {
        m_itemId = itemId;
        m_itemToUseId = ItemToUseId;
        m_keyToSellId = keyToSellId;
        m_elPanel = elPanel;
        m_worktype = funcGetSettingCallback('asyncworktype', '');
        let allowRental = (funcGetSettingCallback('allow-rent', 'no') === 'yes');
        let sRestriction = (funcGetSettingCallback('restriction', ''));
        let showXrayMachineUi = (funcGetSettingCallback('showXrayMachineUi', 'no') === 'yes');
        let isXrayRestriction = sRestriction === 'xray';
        if ((funcGetSettingCallback('inspectonly', 'false') === 'true') ||
            m_worktype !== 'decodeable' ||
            !allowRental ||
            (keyToSellId && !sRestriction) ||
            showXrayMachineUi ||
            !InventoryAPI.IsValidItemID(m_itemId)) {
            elPanel.AddClass('hidden');
            return;
        }
        elPanel.RemoveClass('hidden');
        elPanel.SetHasClass('show-xray-buttons', sRestriction !== '');
        _SetNumLootlistItems();
        _SetuUpButtonsBasedOnRestrictions(sRestriction);
        if (!isXrayRestriction && ItemToUseId) {
            m_elPanel.FindChildInLayoutFile('UseItemImage').itemid = ItemToUseId;
            _SetDescString();
        }
        if (!m_bPanelRegisteredForEvents) {
            m_bPanelRegisteredForEvents = true;
            $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', _OnMyPersonaInventoryUpdated);
        }
    }
    InspectRentalBar.Init = Init;
    function _SetDescString() {
        let elLabel = m_elPanel.FindChildInLayoutFile('UseItemName');
        elLabel.SetDialogVariable('itemname', InventoryAPI.GetItemName(m_itemToUseId));
        elLabel.text = $.Localize('#popup_' + m_worktype + '_async_desc', elLabel);
        elLabel.visible = true;
    }
    function _SetuUpButtonsBasedOnRestrictions(sRestriction) {
        if (sRestriction) {
            let elPurchaseBtn = m_elPanel.FindChildInLayoutFile('PurchaseKeyBtn');
            let elXrayRentBtn = m_elPanel.FindChildInLayoutFile('RentBtnXray');
            if (m_keyToSellId) {
                elPurchaseBtn.SetHasClass('hide', false);
                elXrayRentBtn.SetHasClass('hide', true);
                elPurchaseBtn.FindChildInLayoutFile('SellItemImage').itemid = m_keyToSellId;
                m_elPanel.SetDialogVariable('itemname', InventoryAPI.GetItemName(m_keyToSellId));
                m_elPanel.SetDialogVariable("price", ItemInfo.GetStoreSalePrice(m_keyToSellId, 1));
                elPurchaseBtn.SetPanelEvent('onactivate', () => {
                    StoreAPI.StoreItemPurchase(m_keyToSellId);
                    m_confirmPopUpOpen = true;
                });
                if (sRestriction === 'xray')
                    _HoverEvents(elPurchaseBtn, null);
            }
            else {
                elPurchaseBtn.SetHasClass('hide', true);
                elXrayRentBtn.SetHasClass('hide', false);
                elXrayRentBtn.SetPanelEvent('onactivate', () => {
                    _SetUpRentActionBtn('rent');
                });
                if (sRestriction === 'xray')
                    _HoverEvents(elXrayRentBtn, null);
            }
            let xrayBtn = m_elPanel.FindChildInLayoutFile('OpenXray');
            xrayBtn.SetHasClass('hide', sRestriction === 'restricted');
            if (sRestriction !== 'restricted') {
                xrayBtn.SetPanelEvent('onactivate', () => {
                    $.DispatchEvent("ShowXrayCasePopup", '', m_itemId, false);
                    ClosePopup();
                });
                _HoverEvents(null, xrayBtn);
            }
            if (sRestriction === 'restricted') {
                m_elPanel?.GetParent().GetParent().SetHasClass('rental-mode', true);
            }
        }
        else {
            let RentBtn = m_elPanel.FindChildInLayoutFile('RentBtn');
            let ActionBtn = m_elPanel.FindChildInLayoutFile('OpenBtn');
            _HoverEvents(RentBtn, ActionBtn);
            RentBtn.SetPanelEvent('onactivate', () => {
                _SetUpRentActionBtn('rent');
            });
            ActionBtn.SetPanelEvent('onactivate', () => {
                OpenConfirmPopup('open');
            });
        }
    }
    function _SetNumLootlistItems() {
        let count = InventoryAPI.GetLootListItemsCount(m_itemId);
        count = InventoryAPI.GetLootListItemIdByIndex(m_itemId, (count - 1)) == '0' ? count - 1 : count;
        m_elPanel?.SetDialogVariableInt('numlootlist', count);
    }
    function _SetUpRentActionBtn(type) {
        let sTimeRemainingString = GetAlreadyRentedItemsExpirationTime();
        m_confirmPopUpOpen = true;
        if (sTimeRemainingString) {
            $.GetContextPanel().SetDialogVariable('time-remaining', sTimeRemainingString);
            $.GetContextPanel().SetDialogVariable('name', InventoryAPI.GetItemName(m_itemId));
            $.GetContextPanel().SetDialogVariable('expiration-time', $.Localize(sTimeRemainingString));
            UiToolkitAPI.ShowGenericPopupOk('#popup_container_confirm_title_rent', $.Localize('#popup_container_confirm_already_rented', $.GetContextPanel()), '', function () { () => { $.DispatchEvent('UIPopupButtonClicked', ''); }; });
        }
        else {
            OpenConfirmPopup(type);
        }
    }
    function OpenConfirmPopup(type) {
        m_popupActionCallbackHandle = UiToolkitAPI.RegisterJSCallback(_OnPopupActionPressed);
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_container_open_confirm.xml', 'action-type=' + type
            + '&' + 'case=' + m_itemId
            + '&' + 'callback=' + m_popupActionCallbackHandle);
    }
    function _OnPopupActionPressed(actionType) {
        _OpenActions();
        m_actionType = actionType;
        if (actionType === 'open') {
            InventoryAPI.UseTool(m_itemToUseId, m_itemId);
            $.DispatchEvent('StartDecodeableAnim');
            return;
        }
        InventoryAPI.UseToolWithIntArg(m_itemToUseId, m_itemId, 1);
        $.DispatchEvent('StartRentalAnim');
        $.Schedule(2.75, ShowRentalInspect);
    }
    function _OpenActions() {
        if (m_popupActionCallbackHandle) {
            UiToolkitAPI.UnregisterJSCallback(m_popupActionCallbackHandle);
        }
        m_elPanel.FindChildInLayoutFile('OpenBtn').SetHasClass('is-active-action', true);
        m_elPanel.FindChildInLayoutFile('OpenBtn').enabled = false;
        m_elPanel.FindChildInLayoutFile('RentBtn').enabled = false;
        _ResetTimeoutHandle();
        m_scheduleActionTimoutHandle = $.Schedule(5, _ShowActionTimeOutPopup);
    }
    function _HoverEvents(RentBtn, ActionBtn) {
        if (RentBtn) {
            RentBtn.SetPanelEvent('onmouseover', () => {
                m_confirmPopUpOpen = false;
                m_elPanel?.GetParent().GetParent().SetHasClass('rental-mode', true);
            });
            RentBtn.SetPanelEvent('onmouseout', () => {
                if (!m_confirmPopUpOpen) {
                    m_elPanel?.GetParent().GetParent().SetHasClass('rental-mode', false);
                }
            });
        }
        if (ActionBtn) {
            ActionBtn.SetPanelEvent('onmouseover', () => {
                m_elPanel?.GetParent().GetParent().SetHasClass('rental-mode', false);
            });
        }
    }
    function GetAlreadyRentedItemsExpirationTime() {
        let defIndex = InventoryAPI.GetItemDefinitionIndex(m_itemId);
        const nRentalHistoryCount = InventoryAPI.GetCacheTypeElementsCount('RentalHistory');
        if (nRentalHistoryCount < 1) {
            return '';
        }
        let nExpirationDate = 0;
        for (let i = 0; i < nRentalHistoryCount; ++i) {
            const oRentalHistory = InventoryAPI.GetCacheTypeElementJSOByIndex('RentalHistory', i);
            if (oRentalHistory.crate_def_index === defIndex) {
                nExpirationDate = nExpirationDate < oRentalHistory.expiration_date ? oRentalHistory.expiration_date : nExpirationDate;
            }
        }
        let oLocData = FormatText.FormatRentalTime(nExpirationDate);
        return oLocData.time;
    }
    function _ShowActionTimeOutPopup() {
        m_scheduleActionTimoutHandle = null;
        if (!m_elPanel || !m_elPanel?.IsValid()) {
            return;
        }
        ClosePopup();
        UiToolkitAPI.ShowGenericPopupOk($.Localize('#SFUI_SteamConnectionErrorTitle'), $.Localize('#SFUI_InvError_Item_Not_Given'), '', () => { });
    }
    InspectRentalBar._ShowActionTimeOutPopup = _ShowActionTimeOutPopup;
    function _ResetTimeoutHandle() {
        if (m_scheduleActionTimoutHandle && typeof m_scheduleActionTimoutHandle === "number") {
            $.CancelScheduled(m_scheduleActionTimoutHandle);
            m_scheduleActionTimoutHandle = null;
        }
    }
    function ClosePopup() {
        _ResetTimeoutHandle();
        $.DispatchEvent('HideSelectItemForCapabilityPopup');
        $.DispatchEvent('UIPopupButtonClicked', '');
        $.DispatchEvent('CapabilityPopupIsOpen', false);
    }
    InspectRentalBar.ClosePopup = ClosePopup;
    function _OnMyPersonaInventoryUpdated() {
        if (m_worktype === 'decodeable') {
            const newItems = AcknowledgeItems.GetItems();
            if (newItems.length > 0 && newItems.filter(entry => entry.pickuptype === 'found_in_crate').length > 0) {
                _ResetTimeoutHandle();
            }
            if (m_actionType === 'rent') {
                newItems.filter(entry => InventoryAPI.IsRental(entry.id)).forEach(entry => {
                    m_onlyRentalItemIds.push(entry.id);
                    InventoryAPI.SetItemSessionPropertyValue(entry.id, 'recent', '1');
                    InventoryAPI.AcknowledgeNewItembyItemID(entry.id);
                });
            }
        }
    }
    function ShowRentalInspect() {
        if (m_onlyRentalItemIds.length > 0) {
            UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + m_onlyRentalItemIds[0] +
                '&' + 'inspectonly=true' +
                '&' + 'allowsave=false' +
                '&' + 'showequip=false' +
                '&' + 'showitemcert=true' +
                '&' + 'rentalItems=' + m_onlyRentalItemIds.join(',') +
                '&' + 'caseidforlootlist=' + m_itemId);
            ClosePopup();
        }
        else {
            _ShowActionTimeOutPopup();
        }
    }
})(InspectRentalBar || (InspectRentalBar = {}));
