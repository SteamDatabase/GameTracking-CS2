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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfYWNrbm93bGVkZ2VfaXRlbS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL3BvcHVwcy9wb3B1cF9hY2tub3dsZWRnZV9pdGVtLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUFDckMsOENBQThDO0FBQzlDLHdEQUF3RDtBQUV4RCxJQUFVLGdCQUFnQixDQXFiekI7QUFyYkQsV0FBVSxrQkFBZ0I7SUFTekIsSUFBSSx1QkFBdUIsR0FBRyxLQUFLLENBQUM7SUFDcEMsSUFBSSxZQUFZLEdBQUcsQ0FBQyxDQUFFLGVBQWUsQ0FBa0IsQ0FBQztJQUN4RCxJQUFJLGVBQWUsR0FBRyxFQUFFLENBQUM7SUFFekIsU0FBZ0IsTUFBTTtRQUVyQixDQUFDLENBQUMseUJBQXlCLENBQUUsOENBQThDLEVBQUUsZ0JBQWdCLENBQUMsSUFBSSxDQUFFLENBQUM7UUFDckcsQ0FBQyxDQUFDLG9CQUFvQixDQUFFLDBCQUEwQixFQUFFLENBQUMsQ0FBQyxlQUFlLEVBQUUsRUFBRSxnQkFBZ0IsQ0FBQyxlQUFlLENBQUUsQ0FBQztRQUM1RyxDQUFDLENBQUMseUJBQXlCLENBQUUsa0JBQWtCLEVBQUUsZ0JBQWdCLENBQUMsY0FBYyxDQUFFLENBQUM7UUFDbkYsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLHVCQUF1QixFQUFFLGdCQUFnQixDQUFDLG1CQUFtQixDQUFDLGFBQWEsQ0FBRSxDQUFDO1FBQzNHLElBQUksRUFBRSxDQUFDO0lBQ1IsQ0FBQztJQVBlLHlCQUFNLFNBT3JCLENBQUE7SUFBQSxDQUFDO0lBRUYsU0FBZ0IsSUFBSTtRQUVuQixNQUFNLEtBQUssR0FBRyxRQUFRLEVBQUUsQ0FBQztRQUV6QixJQUFLLEtBQUssQ0FBQyxNQUFNLEdBQUcsQ0FBQyxFQUNyQjtZQUNDLENBQUMsQ0FBQyxhQUFhLENBQUUsc0JBQXNCLEVBQUUsRUFBRSxDQUFFLENB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