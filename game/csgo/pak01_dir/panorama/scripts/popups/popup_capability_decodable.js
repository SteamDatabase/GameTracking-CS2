"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="popup_capability_header.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="popup_inspect_async-bar.ts" />
/// <reference path="popup_inspect_purchase-bar.ts" />
/// <reference path="popup_inspect_rental-bar.ts" />
/// <reference path="popup_inspect_header.ts" />
/// <reference path="popup_acknowledge_item.ts" />
var CapabilityDecodable;
(function (CapabilityDecodable) {
    let m_aItemsInLootlist = [];
    let m_scrollListsPanelIds = ['ScrollList', 'ScrollListMagnified'];
    let m_caseId = '';
    let m_caseAttributes = '';
    let m_existingRewardFromXrayId = '';
    let m_itemFromContainer = '';
    let m_InspectPanel = $.GetContextPanel();
    let m_keyId = '';
    let m_keyToSellId = '';
    let m_isKeyless = false;
    let m_storeItemId = '';
    let m_unusualItemImagePath = '';
    let m_showInspectScheduleHandle = null;
    let m_isAllowedToInteractWithLootlistItems = true;
    let m_showXrayMachineUi = false;
    let m_specialItemId = 'id-special-item';
    let m_elCaseModelImagePanel = null;
    function Init() {
        function GetItemVarsFromMsg() {
            let idList = strMsg.split(',');
            return { key: idList[0], case: idList[1] };
        }
        function SetsItemVarsFromMsg() {
            let oData = GetItemVarsFromMsg();
            m_keyId = oData.key;
            m_caseId = oData.case;
        }
        let strMsg = $.GetContextPanel().GetAttributeString("key-and-case", "");
        m_caseAttributes = $.GetContextPanel().GetAttributeString("case-attributes", "");
        m_showXrayMachineUi = $.GetContextPanel().GetAttributeString("showXrayMachineUi", "no") === 'yes' ? true : false;
        m_isAllowedToInteractWithLootlistItems = ($.GetContextPanel().GetAttributeString('allowtointeractwithlootlistitems', 'true') === 'true') ? true : false;
        if (m_showXrayMachineUi) {
            m_InspectPanel.SetHasClass('popup-in-xray', m_showXrayMachineUi);
            let oData = ItemInfo.GetItemsInXray();
            m_existingRewardFromXrayId = oData.reward;
            if (m_existingRewardFromXrayId) {
                if (m_existingRewardFromXrayId) {
                    if (InventoryAPI.IsFauxItemID(m_existingRewardFromXrayId)) {
                        let elPopup = UiToolkitAPI.ShowGenericPopupOk('#popup_xray_first_use_title', '#popup_xray_first_use_desc', '', () => { });
                        let elMessageLabel = elPopup.FindChildInLayoutFile('MessageLabel');
                        elMessageLabel.html = true;
                        elPopup.SetDialogVariable('itemname', InventoryAPI.GetItemName(m_existingRewardFromXrayId));
                        elMessageLabel.text = $.Localize('#popup_xray_first_use_desc', elPopup);
                    }
                    else if ($.GetContextPanel().GetAttributeString("showxraypopup", "no") === 'yes') {
                        UiToolkitAPI.ShowGenericPopupOk('#popup_xray_in_use_title', '#popup_xray_in_use_desc', '', () => { });
                    }
                }
                m_caseId = oData.case;
            }
            else {
                SetsItemVarsFromMsg();
            }
            if (!GetItemVarsFromMsg().key) {
                let keyId = ItemInfo.GetKeyForCaseInXray(m_caseId);
                if (keyId) {
                    m_keyId = keyId;
                }
            }
            else {
                m_keyId = GetItemVarsFromMsg().key;
            }
        }
        else {
            SetsItemVarsFromMsg();
        }
        if ((m_keyId && InventoryAPI.IsRental(m_keyId)) ||
            InventoryAPI.IsRental(m_caseId)) {
            $.GetContextPanel().SetAttributeString('asyncworkitemwarning', 'no');
            $.GetContextPanel().SetAttributeString('asyncforcehide', 'true');
            $.GetContextPanel().SetAttributeString('inspectonly', 'true');
            $.GetContextPanel().SetAttributeString('onlyclosepurchasebar', 'true');
        }
        if (!m_keyId) {
            let associatedItemCount = InventoryAPI.GetAssociatedItemsCount(m_caseId);
            if (!InventoryAPI.IsItemInfoValid(m_caseId)) {
                return;
            }
            m_storeItemId = $.GetContextPanel().GetAttributeString("storeitemid", "");
            if ((associatedItemCount === 0 || !associatedItemCount) && !m_storeItemId) {
                m_isKeyless = true;
            }
            else if (!m_storeItemId) {
                m_keyToSellId = InventoryAPI.GetAssociatedItemIdByIndex(m_caseId, 0);
            }
        }
        else {
            if (!InventoryAPI.IsItemInfoValid(m_keyId)) {
                return;
            }
        }
        _SetUpPanelElements();
        $.DispatchEvent('CapabilityPopupIsOpen', true);
    }
    CapabilityDecodable.Init = Init;
    function _SetUpPanelElements() {
        if (!m_keyId) {
            $.GetContextPanel().SetAttributeString('asyncworkitemwarning', 'no');
            $.GetContextPanel().SetAttributeString('asyncactiondescription', 'no');
            if (m_existingRewardFromXrayId) {
                $.GetContextPanel().SetAttributeString('allowxraypurchase', 'yes');
            }
        }
        else {
            $.GetContextPanel().SetAttributeString('toolid', m_keyId);
            $.GetContextPanel().SetAttributeString('asyncworkitemwarning', 'yes');
            $.GetContextPanel().SetAttributeString('asyncactiondescription', 'yes');
            if (m_existingRewardFromXrayId) {
                $.GetContextPanel().SetAttributeString('allowxrayclaim', 'yes');
            }
        }
        if (m_isKeyless) {
            if (m_existingRewardFromXrayId) {
                $.GetContextPanel().SetAttributeString('allowxrayclaim', 'yes');
            }
            $.GetContextPanel().SetAttributeString('decodeablekeyless', 'true');
            $.GetContextPanel().SetAttributeString('asyncworkitemwarning', 'yes');
            $.GetContextPanel().SetAttributeString('asyncactiondescription', 'yes');
        }
        $.GetContextPanel().SetAttributeString('allow-rent', InventoryAPI.CanOpenForRental(m_caseId) ? 'yes' : 'no');
        let sRestriction = m_storeItemId ? '' : InventoryAPI.GetDecodeableRestriction(m_caseId);
        $.GetContextPanel().SetAttributeString('restriction', sRestriction);
        _SetUpPurchaseBar((m_keyId) ? '' : m_keyToSellId);
        let category = InventoryAPI.GetLoadoutCategory(m_caseId);
        if (category == "musickit") {
            InventoryAPI.PlayItemPreviewMusic(m_caseId, '');
        }
        _SetUpAsyncActionBar(m_caseId);
        _SetUpRentalBar(m_caseId, m_keyId, m_keyToSellId);
        _SetupHeader(m_caseId);
        _SetupDescription(m_caseId);
        if (m_showXrayMachineUi) {
            _SetUpXrayPanel();
        }
        else {
            _SetCaseModelImage(m_caseId, 'PopUpInspectModelOrImage');
            if (!ItemInfo.IsSpraySealed(m_caseId) && !ItemInfo.ItemDefinitionNameSubstrMatch(m_caseId, 'tournament_pass_')) {
                _PlayContainerSound(m_caseId, 'fall');
            }
            _SetLootListItems(m_caseId, m_keyId);
        }
    }
    function _SetupHeader(caseId) {
        let elCapabilityHeaderPanel = $.GetContextPanel().FindChildInLayoutFile('PopUpCapabilityHeader');
        CapabilityHeader.Init(elCapabilityHeaderPanel, caseId, _GetSettingCallback);
    }
    function _SetupDescription(caseId) {
        let elPanel = $.GetContextPanel().FindChildInLayoutFile('InspectItemDesc');
        let count = InventoryAPI.GetLootListItemsCount(caseId);
        if (count === 0 && m_storeItemId) {
            elPanel.visible = true;
            elPanel.text = InventoryAPI.GetItemDescription(caseId, '');
        }
        else {
            elPanel.visible = false;
        }
    }
    function _GetSettingCallback(settingname, defaultvalue) {
        return m_InspectPanel.GetAttributeString(settingname, defaultvalue);
    }
    function _SetCaseModelImage(caseId, PanelId) {
        let elItemModelImagePanel = $.GetContextPanel().FindChildInLayoutFile(PanelId);
        InspectModelImage.Init(elItemModelImagePanel, caseId, undefined, m_caseAttributes);
        m_elCaseModelImagePanel = InspectModelImage.GetModelPanel();
    }
    function _SetUpAsyncActionBar(itemId) {
        let elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectAsyncBar');
        InspectAsyncActionBar.Init(elAsyncActionBarPanel, itemId, _GetSettingCallback);
    }
    function _SetUpPurchaseBar(itemId) {
        let elPurchase = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectPurchaseBar');
        InspectPurchaseBar.Init(elPurchase, itemId, _GetSettingCallback);
    }
    function _SetUpRentalBar(itemId, keyId, keyToSellId) {
        let elBar = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectRentalBar');
        InspectRentalBar.Init(elBar, itemId, keyId, keyToSellId, _GetSettingCallback);
    }
    function _SetLootListItems(caseId, keyId) {
        let count = InventoryAPI.GetLootListItemsCount(caseId);
        let elLootList = $.GetContextPanel().FindChildInLayoutFile('DecodableLootlist');
        if (count === 0) {
            _ShowHideLootList(false);
            return;
        }
        if (m_elCaseModelImagePanel && m_elCaseModelImagePanel.IsValid() && m_elCaseModelImagePanel.id === 'ImagePreviewPanel') {
            m_elCaseModelImagePanel.AddClass('y-offset');
        }
        _ShowHideLootList(true);
        _SetLootlistHintText(caseId, count);
        for (let i = 0; i < count; i++) {
            let itemid = InventoryAPI.GetLootListItemIdByIndex(caseId, i) === '0' ? m_specialItemId : InventoryAPI.GetLootListItemIdByIndex(caseId, i);
            let elItem = elLootList.FindChildInLayoutFile(itemid);
            if (!elItem) {
                let elItem = $.CreatePanel('Panel', elLootList, itemid);
                elItem.SetAttributeString('itemid', itemid);
                elItem.BLoadLayoutSnippet('LootListItem');
                _UpdateLootListItemInfo(elItem, itemid, caseId);
                let funcActivation = m_isAllowedToInteractWithLootlistItems ? _OnActivateLootlistTile : () => { };
                elItem.SetPanelEvent('onactivate', funcActivation.bind(undefined, itemid, caseId, keyId));
                elItem.SetPanelEvent('oncontextmenu', funcActivation.bind(undefined, itemid, caseId, keyId));
                if (i === 0 && m_isAllowedToInteractWithLootlistItems) {
                    $.GetContextPanel().FindChildInLayoutFile('CanDecodableBrowseBtn').SetPanelEvent('onactivate', callBackFunc.bind(undefined, itemid, caseId, keyId));
                }
                if (itemid !== m_specialItemId) {
                    m_aItemsInLootlist.push({
                        id: itemid,
                        weight: _GetDisplayWeightForScroll(itemid),
                    });
                }
            }
        }
    }
    function _OnActivateLootlistTile(itemid, caseId, keyId) {
        if (!InventoryAPI.IsValidItemID(itemid))
            return;
        let items = [];
        items.push({ label: '#UI_Inspect', jsCallback: callBackFunc.bind(undefined, itemid, caseId, keyId) });
        if (MyPersonaAPI.GetLauncherType() !== "perfectworld" && !InventoryAPI.CannotTrade(itemid)) {
            items.push({ label: '#SFUI_Store_Market_Link', jsCallback: _ViewOnMarket.bind(undefined, itemid) });
        }
        UiToolkitAPI.ShowSimpleContextMenu('', 'ControlLibSimpleContextMenu', items);
    }
    function callBackFunc(itemid, caseId, keyId) {
        $.DispatchEvent('ContextMenuEvent', '');
        _HidePanelForLootlistItemPreview();
        let storeid = (m_storeItemId) ? m_storeItemId : '';
        $.DispatchEvent("LootlistItemPreview", itemid, caseId +
            ',' + storeid);
    }
    function _ViewOnMarket(id) {
        SteamOverlayAPI.OpenURL(ItemInfo.GetMarketLinkForLootlistItem(id));
    }
    function _GetDisplayWeightForScroll(itemid) {
        let rarityVal = InventoryAPI.GetItemRarity(itemid);
        let displayItemWeight = [150000, 30000, 6000, 1250, 250, 50, 10];
        return displayItemWeight[rarityVal];
    }
    function _UpdateLootListItemInfo(elItem, itemid, caseId) {
        if (itemid == m_specialItemId) {
            m_unusualItemImagePath = InventoryAPI.GetLootListUnusualItemImage(caseId) + ".png";
            _UpdateUnusualItemInfo(elItem, caseId, m_unusualItemImagePath, true);
        }
        else {
            elItem.FindChildInLayoutFile('ItemImage').itemid = itemid;
            elItem.FindChildInLayoutFile('JsRarity').style.backgroundColor = InventoryAPI.GetItemRarityColor(itemid);
            ItemInfo.GetFormattedName(itemid).SetOnLabel(elItem.FindChildInLayoutFile('JsItemName'));
        }
    }
    function _ShowHideLootList(bshow) {
        let elLootListContainer = $.GetContextPanel().FindChildInLayoutFile('DecodableLootlistContainer');
        elLootListContainer.SetHasClass('hidden', !bshow);
    }
    function _SetLootlistHintText(caseId, count) {
        let bAllItems = InventoryAPI.GetLootListAllEntriesAreAdditionalDrops(caseId);
        $.GetContextPanel().FindChildInLayoutFile('CanDecodableDesc').visible = !bAllItems;
        if (count > 1 || bAllItems) {
            $.GetContextPanel().FindChildInLayoutFile('CanDecodableDescMulti').SetDialogVariableInt('num_items', count);
            $.GetContextPanel().FindChildInLayoutFile('CanDecodableDescMulti').visible = (count > 1 && bAllItems);
        }
    }
    function _UpdateUnusualItemInfo(elItem, caseId, unusualItemImagePath, bisDisplayedInLootlist = false) {
        if (!elItem || !elItem.IsValid()) {
            return;
        }
        elItem.FindChildInLayoutFile('ItemImage').SetImage("file://{images}/" + unusualItemImagePath);
        if (bisDisplayedInLootlist) {
            elItem.FindChildInLayoutFile('JsRarity').AddClass('popup-decodable-wash-color-unusual');
            let elBg = elItem.FindChildInLayoutFile('ItemTileBg');
            elBg.AddClass('popup-decodable-wash-color-unusual-bg');
            let elName = elItem.FindChildInLayoutFile('JsItemName');
            elName.text = InventoryAPI.GetLootListUnusualItemName(caseId);
        }
        else {
            elItem.FindChildInLayoutFile('JsRarity').style.washColor = '#ffd700';
            elItem.FindChildInLayoutFile('JItemTint').style.washColor = '#ffd700';
        }
    }
    function _SetUpCaseOpeningScroll() {
        _ShowHideLootList(false);
        let delay = 0;
        if (m_elCaseModelImagePanel &&
            m_elCaseModelImagePanel.IsValid() &&
            m_elCaseModelImagePanel.id == 'ImagePreviewPanel' &&
            !m_elCaseModelImagePanel.BHasClass('hidden')) {
            m_elCaseModelImagePanel.RemoveClass('y-offset');
            delay = 0.1;
        }
        else {
            m_elCaseModelImagePanel.TransitionToCamera('cam_case_open', 1.5);
            $.Schedule(0.75, () => { m_elCaseModelImagePanel?.SetAnimgraphBool('open', true); });
            delay = 2.0;
        }
        $.Schedule(delay, _ShowScroll.bind(undefined, m_elCaseModelImagePanel));
    }
    function _ShowScroll(elCase) {
        let elScroll = $.GetContextPanel().FindChildInLayoutFile('DecodableItemsScroll');
        if (!elScroll || !elScroll.IsValid() || !elCase || !elCase.IsValid()) {
            return;
        }
        elScroll.RemoveClass('hidden');
        elCase.AddClass('popup-inspect-modelpanel_darken_blur');
        _FillScrollsWithItems(m_scrollListsPanelIds);
        $.Schedule(0.1, _PlayScrollAnim.bind(undefined, m_scrollListsPanelIds));
    }
    function _PlayScrollAnim(scrolllists) {
        let targetId = 'ItemFromContainer';
        let xOffsetSlackPercent = (Math.floor(Math.random() * ((90) - 10 + 1) + 10) / 100);
        for (let element of scrolllists) {
            let xPos = _GetStopPosition($.GetContextPanel().FindChildInLayoutFile(element), targetId, xOffsetSlackPercent);
            let elScroll = $.GetContextPanel().FindChildInLayoutFile(element);
            elScroll.ScrollToFitRegion(xPos, xPos, 0, 0, 3, true, false);
        }
        let revealDelay = 6;
        m_showInspectScheduleHandle = $.Schedule(revealDelay, _ShowInspect);
        let itemDefName = InventoryAPI.GetItemDefinitionName(m_caseId);
        let soundEventName = "container_weapon_ticker";
        if (itemDefName && itemDefName.indexOf("sticker") != -1) {
            soundEventName = "container_sticker_ticker";
        }
        for (let i = 0; i < _TickSoundIntervals.length; ++i) {
            $.Schedule(_TickSoundIntervals[i], _ScrollTick.bind(undefined, soundEventName));
        }
    }
    let _TickSoundIntervals = [0.000, 0.063, 0.125, 0.188, 0.250, 0.313, 0.375, 0.438, 0.500, 0.563, 0.625, 0.688, 0.750, 0.813, 0.875, 0.938, 1.000, 1.063, 1.125, 1.188, 1.250, 1.313, 1.375, 1.483, 1.351, 1.620, 1.701, 1.786, 1.872, 2.003, 2.154, 2.313, 2.466, 2.615, 2.773, 2.941, 3.104, 3.339, 3.630, 3.953, 4.385, 5.004,];
    function _ScrollTick(soundEventName) {
        $.DispatchEvent("CSGOPlaySoundEffect", soundEventName, "MOUSE");
    }
    function _GetStopPosition(elParent, targetId, xOffsetSlackPercent) {
        let elTile = elParent.FindChildInLayoutFile(targetId);
        if (!elTile || !elTile.IsValid())
            return 0;
        let tileWidth = elTile.contentwidth;
        return (elTile.actualxoffset + (tileWidth * xOffsetSlackPercent));
    }
    function _ShowInspect() {
        m_showInspectScheduleHandle = null;
        if (m_itemFromContainer) {
            InventoryAPI.SetItemSessionPropertyValue(m_itemFromContainer, 'recent', '1');
            InventoryAPI.AcknowledgeNewItembyItemID(m_itemFromContainer);
            if (ItemInfo.ItemDefinitionNameSubstrMatch(m_itemFromContainer, 'tournament_journal_')) {
                $.Schedule(0.2, () => {
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_major_hub.xml', 'journalid=' + m_itemFromContainer);
                });
            }
            else {
                $.DispatchEvent("InventoryItemPreview", m_itemFromContainer, '');
            }
            CapabilityDecodable.ClosePopUp();
            let rarityVal = InventoryAPI.GetItemRarity(m_itemFromContainer);
            let soundEvent = "ItemRevealRarityCommon";
            if (rarityVal == 4) {
                soundEvent = "ItemRevealRarityUncommon";
            }
            else if (rarityVal == 5) {
                soundEvent = "ItemRevealRarityRare";
            }
            else if (rarityVal == 6) {
                soundEvent = "ItemRevealRarityMythical";
            }
            else if (rarityVal == 7) {
                soundEvent = "ItemRevealRarityLegendary";
            }
            else if (rarityVal == 8) {
                soundEvent = "ItemRevealRarityAncient";
            }
            $.DispatchEvent("CSGOPlaySoundEffect", soundEvent, "MOUSE");
        }
        else {
            _TimeoutPopup();
        }
    }
    function _TimeoutPopup() {
        CapabilityDecodable.ClosePopUp();
        UiToolkitAPI.ShowGenericPopupOk($.Localize('#SFUI_SteamConnectionErrorTitle'), $.Localize('#SFUI_InvError_Item_Not_Given'), '', () => { });
    }
    function _FillScrollsWithItems(lists) {
        let numTilesInScroll = 38;
        let indexItemsFromContainer = 3;
        let indexStart = (numTilesInScroll - 3);
        let totalWeight = 0;
        for (let element of m_aItemsInLootlist) {
            totalWeight += element.weight;
        }
        let displayItemsList = [];
        for (let i = 0; i < numTilesInScroll; i++) {
            let itemToAdd = GetItemBasedOnDisplayWeight(totalWeight, m_aItemsInLootlist);
            if (itemToAdd)
                displayItemsList.push(itemToAdd);
        }
        for (let element of lists) {
            let elParent = $.GetContextPanel().FindChildInLayoutFile(element);
            for (let i = 0; i < displayItemsList.length; i++) {
                let itemId = displayItemsList[i];
                let tileId = (i === indexItemsFromContainer) ? 'ItemFromContainer' : (i === indexStart) ? 'ItemStart' : itemId;
                let elTile = $.CreatePanel('Panel', elParent, tileId);
                elTile.BLoadLayoutSnippet('ScrollItem');
                _UpdateScrollTile(element, elTile, itemId);
            }
        }
    }
    function _UpdateScrollTile(listId, elTile, itemId) {
        if (listId === 'ScrollListMagnified') {
            elTile.AddClass('magnified');
        }
        itemId = (elTile.id === 'ItemFromContainer' && m_itemFromContainer) ? m_itemFromContainer : itemId;
        if ((InventoryAPI.GetItemQuality(itemId) === 3) && m_unusualItemImagePath) {
            _UpdateUnusualItemInfo(elTile, m_caseId, m_unusualItemImagePath);
        }
        else {
            elTile.FindChildInLayoutFile('ItemImage').itemid = itemId;
            elTile.FindChildInLayoutFile('JsRarity').style.washColor = InventoryAPI.GetItemRarityColor(itemId);
            elTile.FindChildInLayoutFile('JItemTint').style.washColor = InventoryAPI.GetItemRarityColor(itemId);
        }
    }
    function GetItemBasedOnDisplayWeight(totalWeight, aItemsInLootlist) {
        let weightOfItem = 0;
        let Random = Math.floor(Math.random() * totalWeight);
        for (let i = 0; i < aItemsInLootlist.length; i++) {
            weightOfItem += aItemsInLootlist[i].weight;
            if (Random <= weightOfItem)
                return aItemsInLootlist[i].id;
        }
    }
    function _SetUpCaseOpeningCountdown() {
        _UpdateOpeningCounter.SetIsGraffiti(_GetContainerType(m_caseId) === 'graffiti');
        _UpdateOpeningCounter.ShowCounter();
        _UpdateOpeningCounter.UpdateCounter();
        _ShowHideLootList(false);
    }
    let _UpdateOpeningCounter;
    (function (_UpdateOpeningCounter) {
        let counterVal = 6;
        let elCountdown = $.GetContextPanel().FindChildInLayoutFile('DecodableCountdown');
        let elCountdownLabel = elCountdown.FindChildInLayoutFile('DecodableCountdownLabel');
        let elCountdownRadial = elCountdown.FindChildInLayoutFile('DecodableCountdownRadial');
        let timerHandle = null;
        let isGraffitiUnseal = false;
        function UpdateCounter() {
            timerHandle = null;
            counterVal = counterVal - 1;
            if (counterVal === 0) {
                elCountdown.AddClass('hidden');
                _ShowInspect();
            }
            else {
                $.DispatchEvent("CSGOPlaySoundEffect", "container_countdown", "MOUSE");
                elCountdownLabel.text = String(counterVal);
                if (!isGraffitiUnseal) {
                    elCountdownLabel.visible = true;
                    elCountdownLabel.RemoveClass('popup-countdown-anim');
                    elCountdownLabel.AddClass('popup-countdown-anim');
                }
                else {
                    elCountdownLabel.visible = false;
                }
                elCountdownRadial.RemoveClass('popup-countdown-timer-circle-anim');
                elCountdownRadial.AddClass('popup-countdown-timer-circle-anim');
                timerHandle = $.Schedule(1, UpdateCounter);
            }
        }
        _UpdateOpeningCounter.UpdateCounter = UpdateCounter;
        function ShowCounter() {
            elCountdown.RemoveClass('hidden');
        }
        _UpdateOpeningCounter.ShowCounter = ShowCounter;
        function CancelTimer() {
            if (timerHandle) {
                $.CancelScheduled(timerHandle);
                timerHandle = null;
            }
        }
        _UpdateOpeningCounter.CancelTimer = CancelTimer;
        function SetIsGraffiti(isGraffiti) {
            isGraffitiUnseal = isGraffiti;
        }
        _UpdateOpeningCounter.SetIsGraffiti = SetIsGraffiti;
    })(_UpdateOpeningCounter || (_UpdateOpeningCounter = {}));
    function _SetUpXrayPanel() {
        if (!m_caseId) {
            return;
        }
        let elActionsPanel = $.GetContextPanel().FindChildInLayoutFile('XrayItemsActionPanel');
        elActionsPanel.AddClass('hidden');
        if (!m_existingRewardFromXrayId) {
            elActionsPanel.RemoveClass('hidden');
            _SetCaseModelImage(m_caseId, 'PopUpXrayModelOrImage');
            let elBtn = $.GetContextPanel().FindChildInLayoutFile('ConfirmXray');
            elBtn.SetPanelEvent('onactivate', _OnActivateXray.bind(undefined, elBtn));
            $.GetContextPanel().FindChildInLayoutFile('PopUpXrayStatusLabel').text = $.Localize("#popup_xray_ready_for_use");
        }
        else if (m_existingRewardFromXrayId) {
            let elHeaderPanel = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectHeader');
            InspectHeader.Init(elHeaderPanel, m_existingRewardFromXrayId, _GetSettingCallback);
            $.GetContextPanel().FindChildInLayoutFile('XrayItemsActionPanelItemName').RemoveClass('hidden');
            let elImagePanel = $.GetContextPanel().FindChildInLayoutFile('PopUpXrayModelOrImageReveal');
            if (!elImagePanel.BHasClass('popup-xray-reverse-effect')) {
                elImagePanel.AddClass('no-anim');
                elImagePanel.AddClass('popup-xray-reverse-effect');
                $.GetContextPanel().FindChildInLayoutFile('PopUpXrayModelOrImage').AddClass('hide');
                _SetCaseModelImage(m_existingRewardFromXrayId, 'PopUpXrayModelOrImageReveal');
            }
            $.GetContextPanel().FindChildInLayoutFile('PopUpXrayStatusLabel').text = $.Localize("#popup_xray_already_in_use");
            $.GetContextPanel().FindChildInLayoutFile('PopUpXrayStatusDot').AddClass('in-use');
        }
        let elXrayPanel = $.GetContextPanel().FindChildInLayoutFile('XrayItemsPanel');
        elXrayPanel.RemoveClass('hidden');
        let aPanels = $.GetContextPanel().FindChildInLayoutFile('PopUpXrayBgSquares').Children();
        _AnimSquares(aPanels);
    }
    function _OnActivateXray(elBtn) {
        InventoryAPI.UseTool(m_caseId, m_caseId);
        elBtn.enabled = false;
        _XrayReveal();
        $.DispatchEvent('CSGOPlaySoundEffect', 'XrayStart', 'MOUSE');
    }
    function _XrayReveal() {
        let revealDelay = 3.5;
        m_showInspectScheduleHandle = $.Schedule(revealDelay, _ShowXrayReward);
        let oData = {
            clipValue: 0,
            lineValue: 100,
            clipPanel: $.GetContextPanel().FindChildInLayoutFile('PopUpXrayModelOrImage'),
            linePanel: $.GetContextPanel().FindChildInLayoutFile('PopUpXrayModelOrImageRevealLine')
        };
        oData.clipPanel.AddClass('popup-xray-inverse-effect');
        $.GetContextPanel().FindChildInLayoutFile('PopUpXrayModelOrImageReveal').AddClass('popup-xray-reverse-effect');
        $.Schedule(1, () => {
            oData.linePanel.visible = true;
            _AnimClip(oData);
        });
    }
    function _AnimClip(oData) {
        if (oData.clipValue <= 100) {
            oData.clipPanel.style.clip = 'rect( 0%, 100%, 100%, ' + oData.clipValue + '% );';
            oData.clipValue = oData.clipValue + 1;
            oData.linePanel.style.transform = 'translatex( -' + oData.lineValue + '%);';
            oData.lineValue = oData.lineValue - 1;
            $.Schedule(0.02, _AnimClip.bind(undefined, oData));
        }
        else {
            oData.linePanel.AddClass('hide');
            oData.clipPanel.AddClass('hide');
            _SetUpPanelElements();
        }
    }
    function _AnimSquares(aPanels) {
        if ($.GetContextPanel().FindChildInLayoutFile('XrayItemsPanel').visible) {
            for (let panel of aPanels) {
                panel.style.backgroundColor = 'rgba(255, 255, 255, 0.0' + Math.ceil(Math.random() * 10) + ');';
            }
            $.Schedule(1, _AnimSquares.bind(undefined, aPanels));
        }
    }
    function _ShowXrayReward() {
        m_showInspectScheduleHandle = null;
        if (m_existingRewardFromXrayId) {
            _SetUpPanelElements();
        }
        else {
            _TimeoutPopup();
        }
    }
    function _UpdateXrayRewardTile(itemId) {
        let oData = ItemInfo.GetItemsInXray();
        m_existingRewardFromXrayId = itemId === oData.reward ? oData.reward : '';
        _SetCaseModelImage(itemId, 'PopUpXrayModelOrImageReveal');
    }
    function _UpdateScrollResultTile(numericType, type, itemId) {
        if (type === "crate_unlock" ||
            type === 'graffity_unseal' ||
            type === 'xray_item_reveal' ||
            type === "xray_item_claim") {
            if (m_showXrayMachineUi) {
                let oData = ItemInfo.GetItemsInXray();
                if (oData.reward && type === 'xray_item_reveal') {
                    _UpdateXrayRewardTile(itemId);
                    return;
                }
                else if (type === 'xray_item_claim') {
                    m_itemFromContainer = itemId;
                    _ShowInspect();
                    return;
                }
            }
            else {
                m_itemFromContainer = itemId;
            }
            if ($.GetContextPanel().FindChildInLayoutFile('DecodableItemsScroll').BHasClass('hidden')) {
                if (type === 'graffity_unseal') {
                    _ShowInspect();
                }
                return;
            }
            else {
                for (let element of m_scrollListsPanelIds) {
                    let elScroll = $.GetContextPanel().FindChildInLayoutFile(element);
                    let elTile = elScroll.FindChildInLayoutFile('ItemFromContainer');
                    _UpdateScrollTile(element, elTile, itemId);
                }
            }
        }
        else if (type === "ticket_activated") {
            m_itemFromContainer = itemId;
            _ShowInspect();
        }
    }
    function _ItemAcquired(ItemId) {
        $.DispatchEvent("CSGOPlaySoundEffect", "rename_purchaseSuccess", "MOUSE");
        if (!m_keyId && m_keyToSellId) {
            let matchingKeyDefName = InventoryAPI.GetItemDefinitionName(m_keyToSellId);
            if (InventoryAPI.DoesItemMatchDefinitionByName(ItemId, matchingKeyDefName)) {
                m_keyToSellId = '';
                m_keyId = ItemId;
                $.DispatchEvent('HideStoreStatusPanel');
                _AcknowledgeMatchingKeys(matchingKeyDefName);
                _SetUpPanelElements();
            }
        }
        else if (m_storeItemId) {
            ClosePopUp();
            $.DispatchEvent('ShowAcknowledgePopup', '', ItemId);
            $.DispatchEvent('HideStoreStatusPanel');
        }
    }
    function _AcknowledgeMatchingKeys(matchingKeyDefName) {
        let bShouldAcknowledge = true;
        AcknowledgeItems.GetItemsByType([matchingKeyDefName], bShouldAcknowledge);
    }
    function _ShowUnlockAnimation() {
        let lootListCount = InventoryAPI.GetLootListItemsCount(m_caseId);
        if (lootListCount === undefined) {
            if (InventoryAPI.IsValidItemID(m_itemFromContainer)) {
                _ShowInspect();
            }
            else {
                _SetUpCaseOpeningCountdown();
            }
            return;
        }
        if (lootListCount <= 1) {
            _SetUpCaseOpeningCountdown();
        }
        else {
            _SetUpCaseOpeningScroll();
        }
        _PlayContainerSound(m_caseId, 'open');
        _PlayContainerSound(m_caseId, 'ticker');
    }
    function _PlayContainerSound(caseId, soundName) {
        $.DispatchEvent("CSGOPlaySoundEffect", "container_" + _GetContainerType(caseId) + "_" + soundName, "MOUSE");
    }
    function _GetContainerType(caseId) {
        let itemDefName = InventoryAPI.GetItemDefinitionName(m_caseId);
        if (itemDefName && (itemDefName.indexOf("spray") != -1 || itemDefName.indexOf("tournament_pass_") != -1))
            return 'graffiti';
        else if (itemDefName && itemDefName.indexOf("sticker") != -1)
            return 'sticker';
        else if (itemDefName && itemDefName.indexOf("coupon") == 0)
            return 'music';
        else
            return 'weapon';
    }
    let _m_handlerForHideEvent = null;
    function _HidePanelForLootlistItemPreview() {
        if (!m_InspectPanel.IsValid())
            return;
        if (!_m_handlerForHideEvent) {
            _m_handlerForHideEvent = $.RegisterEventHandler('PropertyTransitionEnd', m_InspectPanel, (panel, propertyName) => {
                if (m_InspectPanel.id === panel.id && propertyName === 'opacity') {
                    if (m_InspectPanel.visible === true && m_InspectPanel.BIsTransparent()) {
                        m_InspectPanel.visible = false;
                        return true;
                    }
                }
                return false;
            });
        }
        m_InspectPanel.SetHasClass('hide-for-lootlist', true);
    }
    function ClosePopUp() {
        InventoryAPI.StopItemPreviewMusic();
        if (m_InspectPanel.IsValid()) {
            if (m_showInspectScheduleHandle) {
                $.CancelScheduled(m_showInspectScheduleHandle);
                m_showInspectScheduleHandle = null;
            }
            let elRentalBar = m_InspectPanel.FindChildInLayoutFile('PopUpInspectRentalBar');
            let elAsyncActionBarPanel = m_InspectPanel.FindChildInLayoutFile('PopUpInspectAsyncBar');
            let elPurchase = m_InspectPanel.FindChildInLayoutFile('PopUpInspectPurchaseBar');
            if (!elRentalBar.BHasClass('hidden')) {
                InspectRentalBar.ClosePopup();
            }
            if (!elAsyncActionBarPanel.BHasClass('hidden')) {
                InspectAsyncActionBar.OnEventToClose();
            }
            else if (!elPurchase.BHasClass('hidden')) {
                InspectPurchaseBar.ClosePopup();
            }
        }
        _UpdateOpeningCounter.CancelTimer();
    }
    CapabilityDecodable.ClosePopUp = ClosePopUp;
    function _Refresh() {
        if (!m_caseId || !InventoryAPI.IsValidItemID(m_caseId)) {
            ClosePopUp();
            return;
        }
        _SetUpPanelElements();
    }
    function UpdateInspectMap() {
        InspectModelImage.SwitchMap($.GetContextPanel());
    }
    CapabilityDecodable.UpdateInspectMap = UpdateInspectMap;
    function _PlayOpenCaseAnimForRental() {
        _ShowHideLootList(false);
        _PlayContainerSound(m_caseId, 'open');
        m_elCaseModelImagePanel.TransitionToCamera('cam_case_open', 1.5);
        $.Schedule(0.75, () => { m_elCaseModelImagePanel?.SetAnimgraphBool('open', true); });
    }
    CapabilityDecodable._PlayOpenCaseAnimForRental = _PlayOpenCaseAnimForRental;
    $.RegisterForUnhandledEvent('PanoramaComponent_Inventory_ItemCustomizationNotification', _UpdateScrollResultTile);
    $.RegisterForUnhandledEvent('PanoramaComponent_Store_PurchaseCompleted', _ItemAcquired);
    $.RegisterForUnhandledEvent('StartDecodeableAnim', _ShowUnlockAnimation);
    $.RegisterForUnhandledEvent('StartRentalAnim', _PlayOpenCaseAnimForRental);
    $.RegisterForUnhandledEvent("CSGOInspectBackgroundMapChanged", UpdateInspectMap);
    $.RegisterForUnhandledEvent('CSGOShowMainMenu', _Refresh);
    $.RegisterForUnhandledEvent('PopulateLoadingScreen', ClosePopUp);
    $.RegisterForUnhandledEvent('OpenInventory', ClosePopUp);
})(CapabilityDecodable || (CapabilityDecodable = {}));
