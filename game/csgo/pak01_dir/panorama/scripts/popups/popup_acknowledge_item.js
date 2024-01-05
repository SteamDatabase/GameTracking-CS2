"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="popup_capability_can_sticker.ts" />
var AcknowledgeItems;
(function (AcknowledgeItems_1) {
    let m_isCapabliltyPopupOpen = false;
    let m_elEquipBtn = $('#EquipItemBtn');
    let m_focusedItemId = '';
    function OnLoad() {
        $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', AcknowledgeItems.Init);
        $.RegisterEventHandler("SetCarouselSelectedChild", $.GetContextPanel(), AcknowledgeItems.CarouselUpdated);
        $.RegisterForUnhandledEvent('CSGOShowMainMenu', AcknowledgeItems.OnMainMenuShow);
        $.RegisterForUnhandledEvent('PopulateLoadingScreen', AcknowledgeItems.AcknowledgeAllItems.OnCloseEvents);
        Init();
    }
    AcknowledgeItems_1.OnLoad = OnLoad;
    ;
    function Init() {
        const items = GetItems();
        if (items.length < 1) {
            $.DispatchEvent('UIPopupButtonClicked', '');
            return;
        }
        const numItems = items.length;
        AcknowledgeAllItems.SetItemsToSaveAsNew(items);
        const elParent = $.GetContextPanel().FindChildInLayoutFile('AcknowledgeItemsCarousel');
        elParent.RemoveAndDeleteChildren();
        for (let i = 0; i < items.length; i++) {
            const elDelayLoadPanel = $.CreatePanel('CSGODelayLoadPanel', elParent, 'carousel_delay_load_' + i, { class: 'Offscreen' });
            elDelayLoadPanel.SetLoadFunction(MakeItemPanel.bind(null, items[i], i, numItems));
            elDelayLoadPanel.ListenForClassRemoved('Offscreen');
        }
        $.Schedule(.25, () => {
            let aPanels = $.GetContextPanel().FindChildInLayoutFile('AcknowledgeItemsCarousel').Children();
            if (aPanels.length > 0) {
                for (let i = 0; i < aPanels.length; i++) {
                    if (aPanels[i].BHasClass('Focused')) {
                        ShowHideOpenItemInLayoutBtn(aPanels[i].Data().itemId);
                        if (m_elEquipBtn)
                            m_elEquipBtn.SetPanelEvent('onactivate', () => {
                                AcknowledgeAllItems.OnActivate();
                                $.DispatchEvent("ShowLoadoutForItem", m_focusedItemId);
                            });
                        break;
                    }
                }
            }
        });
        $.Schedule(1, SetFocusForNavButton);
    }
    AcknowledgeItems_1.Init = Init;
    ;
    function SetFocusForNavButton() {
        let elParent = $.GetContextPanel().FindChildInLayoutFile('AcknowledgeItemsCarouselNav');
        elParent.FindChildInLayoutFile('NextItemButton').SetPanelEvent('onmouseover', () => {
            elParent.FindChildInLayoutFile('NextItemButton').SetFocus();
        });
        elParent.FindChildInLayoutFile('PreviousItemButton').SetPanelEvent('onmouseover', () => {
            elParent.FindChildInLayoutFile('PreviousItemButton').SetFocus();
        });
    }
    ;
    function MakeItemPanel(item, index, numItems, elParent) {
        const elItemTile = $.CreatePanel('Panel', elParent, item.id);
        elItemTile.BLoadLayoutSnippet('Item');
        const modelPath = ShowModelOrItem(elItemTile, item.id, item.type);
        ResizeForVerticalItem(elItemTile, item.id);
        const rarityColor = ItemInfo.GetRarityColor(item.id);
        SetTitle(elItemTile, item, rarityColor);
        SetParticlesBg(elItemTile, rarityColor, modelPath, item.id);
        ColorRarityBar(elItemTile, rarityColor);
        SetItemName(elItemTile, item.id);
        ShowGiftPanel(elItemTile, item.id);
        ShowSetPanel(elItemTile, item.id);
        ItemCount(elItemTile, index, numItems);
        elParent.Data().itemId = item.id;
    }
    ;
    function ShowModelOrItem(elItemTile, id, type = "") {
        var elItemModelImagePanel = elItemTile.FindChildInLayoutFile('PopUpInspectModelOrImage');
        elItemModelImagePanel.Data().useAcknowledge = !(ItemInfo.IsSprayPaint(id) || ItemInfo.IsSpraySealed(id));
        return InspectModelImage.Init(elItemModelImagePanel, id);
    }
    ;
    function ResizeForVerticalItem(elItemTile, id) {
        if (ItemInfo.IsCharacter(id)) {
            var elPanel = elItemTile.FindChildInLayoutFile('AcknowledgeItemContainer');
            elPanel.AddClass('popup-acknowledge__item__model--vertical');
        }
    }
    ;
    function SetItemName(elItemTile, id) {
        const elLabel = elItemTile.FindChildInLayoutFile('AcknowledgeItemLabel');
        elLabel.text = ItemInfo.GetName(id);
    }
    ;
    function SetTitle(elItemTile, item, rarityColor) {
        const isOperationReward = item.pickuptype === 'quest_reward';
        const defName = InventoryAPI.GetItemDefinitionName(item.id);
        const elTitle = elItemTile.FindChildInLayoutFile('AcknowledgeItemTitle');
        const titleSuffex = isOperationReward ? 'quest_reward' : item.type;
        if (defName === 'casket' && item.type === 'nametag_add') {
            elTitle.text = $.Localize('#CSGO_Tool_Casket_Tag');
        }
        else {
            const idxOfExtraParams = titleSuffex.indexOf("[");
            const typeWithoutParams = (idxOfExtraParams > 0) ? titleSuffex.substring(0, idxOfExtraParams) : titleSuffex;
            elTitle.text = $.Localize('#popup_title_' + typeWithoutParams);
        }
        if (isOperationReward) {
            const tier = ItemInfo.GetRewardTier(item.id);
        }
        elTitle.style.washColor = rarityColor;
    }
    ;
    function SetParticlesBg(elItemTile, rarityColor, modelPath, itemId) {
        const oColor = HexColorToRgb(rarityColor);
        let elParticlePanel = elItemTile.FindChildInLayoutFile('popup-acknowledge__item__particle');
        elParticlePanel.visible = !modelPath;
        if (!modelPath) {
            elParticlePanel.SetParticleNameAndRefresh('particles/ui/ui_item_present_bokeh.vpcf');
            elParticlePanel.SetControlPoint(16, oColor.r, oColor.g, oColor.b);
            elParticlePanel.StartParticles();
            return;
        }
        elParticlePanel.StopParticlesImmediately(false);
    }
    ;
    function HexColorToRgb(hex) {
        const r = parseInt(hex.slice(1, 3), 16);
        const g = parseInt(hex.slice(3, 5), 16);
        const b = parseInt(hex.slice(5, 7), 16);
        return { r, g, b };
    }
    ;
    function ColorRarityBar(elItemTile, rarityColor) {
        const elBar = elItemTile.FindChildInLayoutFile('AcknowledgeBar');
        elBar.style.washColor = rarityColor;
    }
    ;
    function ShowGiftPanel(elItemTile, id) {
        const elPanel = elItemTile.FindChildInLayoutFile('AcknowledgeItemGift');
        const gifterId = ItemInfo.GetGifter(id);
        elPanel.SetHasClass('hidden', gifterId === '');
        const elLabel = elItemTile.FindChildInLayoutFile('AcknowledgeItemGiftLabel');
        elLabel.SetDialogVariable('name', FriendsListAPI.GetFriendName(gifterId));
        elLabel.text = $.Localize('#acknowledge_gifter', elLabel);
    }
    ;
    function ShowQuestPanel(elItemTile, id) {
        const elPanel = elItemTile.FindChildInLayoutFile('AcknowledgeItemQuest');
        elPanel.SetHasClass('hidden', 'quest_reward' !== ItemInfo.GetItemPickUpMethod(id));
        const nTierReward = ItemInfo.GetRewardTier(id);
        const bPremium = ItemInfo.BIsRewardPremium(id);
        elPanel.SetHasClass("tier-reward", nTierReward > 0);
        elPanel.SetHasClass("premium", bPremium);
        if (nTierReward > 0) {
            elPanel.SetDialogVariableInt("tier_num", nTierReward);
        }
    }
    ;
    function ShowSetPanel(elItemTile, id) {
        const elPanel = elItemTile.FindChildInLayoutFile('AcknowledgeItemSet');
        const strSetName = InventoryAPI.GetTag(id, 'ItemSet');
        if (!strSetName || strSetName === '0') {
            elPanel.SetHasClass('hide', true);
            return;
        }
        const setName = InventoryAPI.GetTagString(strSetName);
        if (!setName) {
            elPanel.SetHasClass('hide', true);
            return;
        }
        const elLabel = elItemTile.FindChildInLayoutFile('AcknowledgeItemSetLabel');
        elLabel.text = setName;
        const elImage = elItemTile.FindChildInLayoutFile('AcknowledgeItemSetImage');
        elImage.SetImage('file://{images}/econ/set_icons/' + strSetName + '_small.png');
        elPanel.SetHasClass('hide', false);
    }
    ;
    function ItemCount(elItemTile, index, numItems) {
        const elCountLabel = elItemTile.FindChildInLayoutFile('AcknowledgeItemCount');
        if (numItems < 2) {
            elCountLabel.visible = false;
            return;
        }
        elCountLabel.visible = true;
        elCountLabel.text = (index + 1) + ' / ' + numItems;
    }
    ;
    function GetItems() {
        const newItems = [];
        const itemCount = InventoryAPI.GetUnacknowledgeItemsCount();
        for (let i = 0; i < itemCount; i++) {
            const itemId = InventoryAPI.GetUnacknowledgeItemByIndex(i);
            const pickUpType = ItemInfo.GetItemPickUpMethod(itemId);
            if (ItemstoAcknowlegeRightAway(itemId))
                InventoryAPI.AcknowledgeNewItembyItemID(itemId);
            else
                newItems.unshift({ type: 'acknowledge', id: itemId, pickuptype: pickUpType });
        }
        const getUpdateItem = GetUpdatedItem();
        if (getUpdateItem && newItems.filter(item => item.id === getUpdateItem.id).length < 1) {
            newItems.push(getUpdateItem);
        }
        const rewardItems = newItems.filter(item => item.pickuptype === "quest_reward");
        const otherItems = newItems.filter(item => item.pickuptype !== "quest_reward");
        return rewardItems.concat(otherItems);
    }
    AcknowledgeItems_1.GetItems = GetItems;
    ;
    function GetItemsByType(afilters, bShouldAcknowledgeItems) {
        const aItems = GetItems();
        const filterByDefNames = function (oItem) {
            return afilters.includes(ItemInfo.GetItemDefinitionName(oItem.id));
        };
        const alist = aItems.filter(filterByDefNames);
        if (bShouldAcknowledgeItems) {
            AcknowledgeAllItems.SetItemsToSaveAsNew(alist);
            AcknowledgeAllItems.AcknowledgeItems();
        }
        return alist.map(item => item.id);
    }
    AcknowledgeItems_1.GetItemsByType = GetItemsByType;
    ;
    function GetUpdatedItem() {
        const itemidExplicitAcknowledge = $.GetContextPanel().GetAttributeString("ackitemid", '');
        if (itemidExplicitAcknowledge === '')
            return null;
        return {
            id: itemidExplicitAcknowledge,
            type: $.GetContextPanel().GetAttributeString("acktype", '')
        };
    }
    ;
    function ItemstoAcknowlegeRightAway(id) {
        const itemType = InventoryAPI.GetItemTypeFromEnum(id);
        return itemType === 'quest' || itemType === 'coupon_crate' || itemType === 'campaign';
    }
    ;
    function SetIsCapabilityPopUpOpen(isOpen) {
        m_isCapabliltyPopupOpen = isOpen;
    }
    AcknowledgeItems_1.SetIsCapabilityPopUpOpen = SetIsCapabilityPopUpOpen;
    ;
    function CarouselUpdated(elPanel) {
        $.Schedule(.15, () => {
            if (elPanel && elPanel.IsValid())
                ShowHideOpenItemInLayoutBtn(elPanel.Data().itemId);
        });
    }
    AcknowledgeItems_1.CarouselUpdated = CarouselUpdated;
    function ShowHideOpenItemInLayoutBtn(itemId) {
        m_focusedItemId = itemId;
        let category = InventoryAPI.GetLoadoutCategory(itemId);
        var isHidden = (ItemInfo.ItemHasCapability(itemId, 'decodable') || category == undefined || category == '' || category == null) ? true : false;
        if (m_elEquipBtn) {
            m_elEquipBtn.SetHasClass('hide', isHidden);
        }
    }
    function OnMainMenuShow() {
        AcknowledgeItems.Init();
    }
    AcknowledgeItems_1.OnMainMenuShow = OnMainMenuShow;
    let AcknowledgeAllItems;
    (function (AcknowledgeAllItems) {
        let itemsToSave = [];
        function SetItemsToSaveAsNew(items) {
            itemsToSave = items;
        }
        AcknowledgeAllItems.SetItemsToSaveAsNew = SetItemsToSaveAsNew;
        ;
        function AcknowledgeItems() {
            itemsToSave.forEach(function (item) {
                InventoryAPI.SetItemSessionPropertyValue(item.id, 'item_pickup_method', ItemInfo.GetItemPickUpMethod(item.id));
                if (item.type === 'acknowledge') {
                    InventoryAPI.SetItemSessionPropertyValue(item.id, 'recent', '1');
                    InventoryAPI.AcknowledgeNewItembyItemID(item.id);
                }
                else {
                    InventoryAPI.SetItemSessionPropertyValue(item.id, 'updated', '1');
                    $.DispatchEvent('RefreshActiveInventoryList');
                }
            });
        }
        AcknowledgeAllItems.AcknowledgeItems = AcknowledgeItems;
        ;
        function OnActivate() {
            AcknowledgeItems();
            InventoryAPI.AcknowledgeNewBaseItems();
            const callbackResetAcknowlegePopupHandle = $.GetContextPanel().GetAttributeInt("callback", -1);
            if (callbackResetAcknowlegePopupHandle != -1) {
                UiToolkitAPI.InvokeJSCallback(callbackResetAcknowlegePopupHandle);
            }
            OnCloseEvents();
        }
        AcknowledgeAllItems.OnActivate = OnActivate;
        ;
        function OnCloseEvents() {
            $.DispatchEvent('UIPopupButtonClicked', '');
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.inventory_new_item_accept', 'MOUSE');
        }
        AcknowledgeAllItems.OnCloseEvents = OnCloseEvents;
    })(AcknowledgeAllItems = AcknowledgeItems_1.AcknowledgeAllItems || (AcknowledgeItems_1.AcknowledgeAllItems = {}));
})(AcknowledgeItems || (AcknowledgeItems = {}));
(function () {
})();
