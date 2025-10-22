"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../notification/notification_equip.ts" />
/// <reference path="popup_inspect_action-bar.ts" />
/// <reference path="popup_inspect_async-bar.ts" />
/// <reference path="popup_inspect_header.ts" />
/// <reference path="popup_capability_header.ts" />
/// <reference path="popup_inspect_purchase-bar.ts" />
var InventoryInspect;
(function (InventoryInspect) {
    let _m_PanelRegisteredForEvents;
    function Init() {
        let itemId = $.GetContextPanel().GetAttributeString("itemid", '');
        $.GetContextPanel().SetAttributeString('popup-id', $.GetContextPanel().id);
        if (InventoryAPI.IsRental(itemId)) {
            $.GetContextPanel().SetAttributeString('showallitemactions', 'false');
            $.GetContextPanel().SetAttributeString('inspectonly', 'true');
        }
        if (!_m_PanelRegisteredForEvents) {
            _m_PanelRegisteredForEvents = $.RegisterForUnhandledEvent('PanoramaComponent_Loadout_EquipSlotChanged', _ShowNotification);
            $.RegisterForUnhandledEvent('PanoramaComponent_Store_PurchaseCompleted', _ItemAcquired);
            $.RegisterForUnhandledEvent("CSGOInspectBackgroundMapChanged", _UpdateInspectMap);
        }
        _SetupLootlistNavPanels(itemId);
        _UpdatePanelData(itemId);
        _PlayShowPanelSound(itemId);
        _LoadEquipNotification();
    }
    InventoryInspect.Init = Init;
    function _UpdatePanelData(itemId) {
        let elItemModelImagePanel = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectModelOrImage');
        InspectModelImage.Init(elItemModelImagePanel, itemId, _GetSettingCallback);
        let elActionBarPanel = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectActionBar');
        InspectActionBar.Init(elActionBarPanel, itemId, _GetSettingCallback, _GetSettingCallbackInt, elItemModelImagePanel);
        let elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectAsyncBar');
        InspectAsyncActionBar.Init(elAsyncActionBarPanel, itemId, _GetSettingCallback);
        let elHeaderPanel = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectHeader');
        InspectHeader.Init(elHeaderPanel, itemId, _GetSettingCallback);
        let elCapabilityPanel = $.GetContextPanel().FindChildInLayoutFile('PopUpCapabilityHeader');
        CapabilityHeader.Init(elCapabilityPanel, itemId, _GetSettingCallback);
        let elPurchasePanel = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectPurchaseBar');
        InspectPurchaseBar.Init(elPurchasePanel, itemId, _GetSettingCallback);
        _SetDescription(itemId);
    }
    let m_Inspectpanel = $.GetContextPanel();
    function _GetSettingCallback(settingname, defaultvalue) {
        return m_Inspectpanel.GetAttributeString(settingname, defaultvalue);
    }
    function _GetSettingCallbackInt(settingname, defaultvalue) {
        return m_Inspectpanel.GetAttributeInt(settingname, defaultvalue);
    }
    function _PlayShowPanelSound(itemId) {
        let category = InventoryAPI.GetLoadoutCategory(itemId);
        let slot = InventoryAPI.GetDefaultSlot(itemId);
        let inspectSound = "";
        if (category == "heavy" || category == "rifle" || category == "smg" || category == "secondary") {
            inspectSound = "inventory_inspect_weapon";
        }
        else if (category == "melee") {
            inspectSound = "inventory_inspect_knife";
        }
        else if (ItemInfo.IsSticker(itemId)) {
            inspectSound = "inventory_inspect_sticker";
        }
        else if (category == "spray") {
            inspectSound = "inventory_inspect_graffiti";
        }
        else if (category == "musickit") {
            inspectSound = "inventory_inspect_musicKit";
        }
        else if (category == "flair0") {
            inspectSound = "inventory_inspect_coin";
        }
        else if (category == "clothing" && slot == "clothing_hands") {
            inspectSound = "inventory_inspect_gloves";
        }
        else {
            inspectSound = "inventory_inspect_sticker";
        }
        $.DispatchEvent("CSGOPlaySoundEffect", inspectSound, "MOUSE");
    }
    function _SetDescription(id) {
        $.GetContextPanel().SetDialogVariable('item_description', '');
        if (!InventoryAPI.IsValidItemID(id)) {
            return;
        }
        let descText = InventoryAPI.GetItemDescription(id, '');
        let shortString = descText.substring(0, descText.indexOf("</font></b><br><font color='#9da1a9'>"));
        $.GetContextPanel().SetDialogVariable('item_description', shortString === '' ? descText : shortString);
    }
    function _LoadEquipNotification() {
        let elParent = $.GetContextPanel();
        let elNotification = $.CreatePanel('Panel', elParent, 'InspectNotificationEquip');
        elNotification.BLoadLayout('file://{resources}/layout/notification/notification_equip.xml', false, false);
    }
    function _ShowNotification(team, slot, oldItemId, newItemId, bNew) {
        if (!bNew)
            return;
        let elNotification = $.GetContextPanel().FindChildInLayoutFile('InspectNotificationEquip');
        if (elNotification && elNotification.IsValid()) {
            EquipNotification.ShowEquipNotification(elNotification, slot, newItemId);
        }
    }
    function _UpdateInspectMap() {
        InspectModelImage.SwitchMap($.GetContextPanel());
    }
    let m_lootlistItemIndex = 0;
    function _SetupLootlistNavPanels(itemId) {
        m_lootlistItemIndex = 0;
        let aLootlistIds = _GetLootlistItems();
        if (aLootlistIds.length < 1) {
            let rentalItemIds = $.GetContextPanel().GetAttributeString("rentalItems", '');
            if (!rentalItemIds) {
                $.GetContextPanel().FindChildInLayoutFile('id-lootlist-btns-container').visible = false;
                $.GetContextPanel().FindChildInLayoutFile('id-lootlist-title-container').visible = false;
                return;
            }
            aLootlistIds = rentalItemIds.split(',');
        }
        m_Inspectpanel.SetAttributeString('isItemInLootlist', 'true');
        $.GetContextPanel().FindChildInLayoutFile('id-lootlist-btns-container').visible = true;
        $.GetContextPanel().FindChildInLayoutFile('id-lootlist-title-container').visible = true;
        m_lootlistItemIndex = aLootlistIds.indexOf(itemId);
        let btnNext = $.GetContextPanel().FindChildInLayoutFile('id-lootlist-next');
        let btnPrev = $.GetContextPanel().FindChildInLayoutFile('id-lootlist-prev');
        let count = aLootlistIds.length;
        _EnableNextPrevBtns(aLootlistIds);
        _UpdateLootlistTitleBar(count);
        btnNext.SetPanelEvent('onactivate', () => {
            m_lootlistItemIndex = (m_lootlistItemIndex < (count - 1)) ? m_lootlistItemIndex + 1 : m_lootlistItemIndex;
            _EnableNextPrevBtns(aLootlistIds);
            _UpdatePanelData(aLootlistIds[m_lootlistItemIndex]);
            _UpdateCharacterModelPanel(aLootlistIds[m_lootlistItemIndex]);
        });
        btnPrev.SetPanelEvent('onactivate', () => {
            m_lootlistItemIndex = m_lootlistItemIndex > 0 ? m_lootlistItemIndex - 1 : m_lootlistItemIndex;
            _EnableNextPrevBtns(aLootlistIds);
            _UpdatePanelData(aLootlistIds[m_lootlistItemIndex]);
            _UpdateCharacterModelPanel(aLootlistIds[m_lootlistItemIndex]);
        });
    }
    function _UpdateCharacterModelPanel(itemId) {
        if (!ItemInfo.IsWeapon(itemId)) {
            return;
        }
        let elActionBarPanel = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectActionBar');
        InspectActionBar.OnUpdateCharModel(elActionBarPanel.FindChildInLayoutFile('InspectDropdownCharModels'), itemId);
    }
    function _EnableNextPrevBtns(aLootlistIds) {
        let btnNext = $.GetContextPanel().FindChildInLayoutFile('id-lootlist-next');
        let btnPrev = $.GetContextPanel().FindChildInLayoutFile('id-lootlist-prev');
        btnNext.enabled = (m_lootlistItemIndex < aLootlistIds.length - 1) && (aLootlistIds[m_lootlistItemIndex + 1] !== '0');
        btnPrev.enabled = m_lootlistItemIndex > 0;
        _SetBtnLabel(btnNext, btnPrev, aLootlistIds);
        _UpdateLootlistTitleBar(aLootlistIds.length);
    }
    function _SetBtnLabel(btnNext, btnPrev, aLootlistIds) {
        if (btnNext.enabled) {
            let elNextLabel = btnNext.FindChildInLayoutFile('id-lootlist-label');
            elNextLabel.text = InventoryAPI.GetItemName(aLootlistIds[m_lootlistItemIndex + 1]);
            let rarityColor = InventoryAPI.GetItemRarityColor(aLootlistIds[m_lootlistItemIndex + 1]);
            if (rarityColor) {
                btnNext.FindChildInLayoutFile('id-lootlist-rarity').style.washColor = rarityColor;
            }
        }
        if (btnPrev.enabled) {
            let elPrevLabel = btnPrev.FindChildInLayoutFile('id-lootlist-label');
            elPrevLabel.text = InventoryAPI.GetItemName(aLootlistIds[m_lootlistItemIndex - 1]);
            let rarityColor = InventoryAPI.GetItemRarityColor(aLootlistIds[m_lootlistItemIndex - 1]);
            if (rarityColor) {
                btnPrev.FindChildInLayoutFile('id-lootlist-rarity').style.washColor = rarityColor;
            }
        }
    }
    function _GetLootlistItems() {
        m_lootlistItemIndex = 0;
        let aLootlistIds = [];
        let caseId = $.GetContextPanel().GetAttributeString("caseidforlootlist", "");
        if (!caseId) {
            return aLootlistIds;
        }
        let count = InventoryAPI.GetLootListItemsCount(caseId);
        for (let i = 0; i < count; i++) {
            aLootlistIds.push(InventoryAPI.GetLootListItemIdByIndex(caseId, i));
        }
        return aLootlistIds;
    }
    function _UpdateLootlistTitleBar(count) {
        let elPanel = $.GetContextPanel().FindChildInLayoutFile('id-lootlist-title-container');
        let lootlistOverride = $.GetContextPanel().GetAttributeString("lootlistNameOverride", "");
        let caseName;
        if (lootlistOverride !== 'false' && lootlistOverride !== '') {
            caseName = $.Localize(lootlistOverride, $.GetContextPanel());
        }
        else {
            let caseId = $.GetContextPanel().GetAttributeString("caseidforlootlist", "");
            caseName = InventoryAPI.GetItemName(caseId);
        }
        elPanel.SetDialogVariable('container', caseName);
        elPanel.SetDialogVariableInt('index', m_lootlistItemIndex + 1);
        elPanel.SetDialogVariableInt('total', count);
        let rentalItemIds = $.GetContextPanel().GetAttributeString("rentalItems", '');
        let text = !rentalItemIds ? $.Localize('#popup_inv_lootlist_header', elPanel) : $.Localize('#popup_inv_lootlist_rental_header', elPanel);
        elPanel.SetDialogVariable('lootlist-header', text);
    }
    function _ItemAcquired(ItemId) {
        let storeItemId = $.GetContextPanel().GetAttributeString("storeitemid", "");
        if (storeItemId) {
            let storeItemSeasonAccess = InventoryAPI.GetItemAttributeValue(storeItemId, 'season access');
            let acquiredItemSeasonAccess = InventoryAPI.GetItemAttributeValue(ItemId, 'season access');
            if (acquiredItemSeasonAccess && (storeItemSeasonAccess === acquiredItemSeasonAccess)) {
                let nSeasonAccess = GameTypesAPI.GetActiveSeasionIndexValue();
                let nCoinRank = MyPersonaAPI.GetMyMedalRankByType((nSeasonAccess + 1) + "Operation$OperationCoin");
                if (nCoinRank === 1 && nSeasonAccess === acquiredItemSeasonAccess) {
                    ShowActiveItemPopup(ItemId);
                    return;
                }
            }
            let storeItemToolType = InventoryAPI.GetToolType(storeItemId);
            let acquiredItemToolType = InventoryAPI.GetToolType(ItemId);
            if (storeItemToolType === 'xp_shop_ticket' && acquiredItemToolType === 'xp_shop_ticket') {
                InventoryAPI.AcknowledgeNewItembyItemID(ItemId);
                ClosePopup();
                $.DispatchEvent('HideStoreStatusPanel');
            }
            let defName = InventoryAPI.GetItemDefinitionName(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(g_ActiveTournamentInfo.itemid_charge, 0));
            if (InventoryAPI.DoesItemMatchDefinitionByName(storeItemId, defName) && InventoryAPI.DoesItemMatchDefinitionByName(ItemId, defName)) {
                ClosePopup();
                $.DispatchEvent('ShowAcknowledgePopup', '', '');
                $.DispatchEvent('HideStoreStatusPanel');
                return;
            }
            ClosePopup();
            $.DispatchEvent('ShowAcknowledgePopup', '', ItemId);
            $.DispatchEvent('HideStoreStatusPanel');
        }
    }
    function ShowActiveItemPopup(itemId) {
        InventoryAPI.AcknowledgeNewItembyItemID(itemId);
        ClosePopup();
        $.DispatchEvent('HideStoreStatusPanel');
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + itemId +
            '&' + 'asyncworktype=useitem' +
            '&' + 'seasonpass=true');
    }
    function ClosePopup() {
        let elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectAsyncBar');
        let elPurchase = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectPurchaseBar');
        if (!elAsyncActionBarPanel.BHasClass('hidden')) {
            InspectAsyncActionBar.OnEventToClose();
        }
        else if (!elPurchase.BHasClass('hidden')) {
            InspectPurchaseBar.ClosePopup();
        }
        else {
            if (m_Inspectpanel.IsValid()) {
                InspectActionBar.CloseBtnAction(m_Inspectpanel.GetAttributeInt('callback', -1));
            }
        }
    }
    InventoryInspect.ClosePopup = ClosePopup;
    function _Refresh() {
        let itemId = $.GetContextPanel().GetAttributeString("itemid", '');
        if (!itemId || !InventoryAPI.IsValidItemID(itemId)) {
            ClosePopup();
            return;
        }
        _UpdatePanelData(itemId);
        InspectActionBar.NavigateModelPanel('InspectModel');
    }
    function _BlurPanel(panelId, shouldBlur) {
        if (shouldBlur) {
            if (panelId == $.GetContextPanel().id) {
                $.GetContextPanel().SetHasClass('popup-inspect-modelpanel_darken_blur', shouldBlur);
            }
        }
        else {
            if ($.GetContextPanel().BHasClass('popup-inspect-modelpanel_darken_blur')) {
                $.GetContextPanel().SetHasClass('popup-inspect-modelpanel_darken_blur', false);
            }
        }
    }
    $.RegisterForUnhandledEvent('CSGOShowMainMenu', _Refresh);
    $.RegisterForUnhandledEvent('PopulateLoadingScreen', ClosePopup);
    $.RegisterForUnhandledEvent('BlurPopupPanel', _BlurPanel);
})(InventoryInspect || (InventoryInspect = {}));
