"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/formattext.ts" />
/// <reference path="common/iteminfo.ts" />
/// <reference path="itemtile_store.ts" />
var RankUpRedemptionStore;
(function (RankUpRedemptionStore) {
    let m_redeemableBalance = 0;
    let m_timeStamp = -1;
    let m_timeoutScheduleHandle;
    let m_profileCustomizationHandler;
    let m_profileUpdateHandler;
    let m_registered = false;
    let m_schTimer;
    function _msg(text) {
    }
    function RegisterForInventoryUpdate() {
        if (m_registered)
            return;
        m_registered = true;
        _UpdateStoreState();
        CheckForPopulateItems();
        m_profileUpdateHandler = $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', OnInventoryUpdated);
        m_profileCustomizationHandler = $.RegisterForUnhandledEvent('PanoramaComponent_Inventory_ItemCustomizationNotification', OnItemCustomization);
        $.GetContextPanel().RegisterForReadyEvents(true);
        $.RegisterEventHandler('ReadyForDisplay', $.GetContextPanel(), function () {
            _msg("READY FOR DISPLAY");
            _UpdateStoreState();
            CheckForPopulateItems(true);
            if (!m_profileUpdateHandler) {
                m_profileUpdateHandler = $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', OnInventoryUpdated);
            }
            if (!m_profileCustomizationHandler) {
                m_profileCustomizationHandler = $.RegisterForUnhandledEvent('PanoramaComponent_Inventory_ItemCustomizationNotification', OnItemCustomization);
            }
        });
        $.RegisterEventHandler('UnreadyForDisplay', $.GetContextPanel(), function () {
            _msg("UN-READY FOR DISPLAY");
            if (m_schTimer) {
                $.CancelScheduled(m_schTimer);
                m_schTimer = null;
            }
            if (m_profileUpdateHandler) {
                $.UnregisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', m_profileUpdateHandler);
                m_profileUpdateHandler = null;
            }
            if (m_profileCustomizationHandler) {
                $.UnregisterForUnhandledEvent('PanoramaComponent_Inventory_ItemCustomizationNotification', m_profileCustomizationHandler);
                m_profileCustomizationHandler = null;
            }
        });
    }
    RankUpRedemptionStore.RegisterForInventoryUpdate = RegisterForInventoryUpdate;
    ;
    function CheckForPopulateItems(bFirstTime = false, claimedItemId = '') {
        const objStore = InventoryAPI.GetCacheTypeElementJSOByIndex("PersonalStore", 0);
        const genTime = objStore ? objStore.generation_time : 0;
        if (genTime != m_timeStamp || claimedItemId) {
            if (genTime != m_timeStamp) {
                m_timeStamp = genTime;
                GameInterfaceAPI.SetSettingString('cl_redemption_reset_timestamp', genTime);
            }
            PopulateItems(bFirstTime, claimedItemId);
        }
    }
    RankUpRedemptionStore.CheckForPopulateItems = CheckForPopulateItems;
    function _CreateItemPanel(itemId, index, bFirstTime, claimedItemId = '') {
        let bNoDropsEarned = itemId === '-';
        if (itemId !== '-' && (!InventoryAPI.IsItemInfoValid(itemId) || !InventoryAPI.IsValidItemID(itemId))) {
            _msg('item ' + itemId + ' is invalid');
            return;
        }
        const elItemContainer = $.GetContextPanel().FindChildTraverse('jsRrsItemContainer');
        let elGhostItem = elItemContainer.FindChildInLayoutFile('itemdrop-' + itemId);
        elGhostItem = $.CreatePanel('Panel', elItemContainer, 'itemdrop-' + index + '-' + itemId);
        elGhostItem.BLoadLayout('file://{resources}/layout/itemtile_store.xml', false, false);
        _AddTileToBlurPanel(elGhostItem);
        let oItemData = {
            id: itemId,
            isDropItem: true,
            noDropsEarned: bNoDropsEarned,
        };
        ItemTileStore.Init(elGhostItem, oItemData);
        elGhostItem.Data().itemid = itemId;
        elGhostItem.Data().index = index;
        if (bNoDropsEarned)
            return;
        _OnGhostItemActivate(elGhostItem, itemId);
    }
    function _AddTileToBlurPanel(elGhostItem) {
        let parent = elGhostItem;
        let newParent;
        let count = 0;
        while (newParent = parent.GetParent()) {
            if (newParent.id === 'id-rewards-background') {
                let blurTarget = newParent.FindChildInLayoutFile('id-rewards-background-blur');
                blurTarget.AddBlurPanel(elGhostItem);
                break;
            }
            if (count > 5)
                break;
            parent = newParent;
            count++;
        }
    }
    function _OnGhostItemActivate(elGhostItem, itemId) {
        const bIsFauxItem = InventoryAPI.IsFauxItemID(itemId);
        if (!bIsFauxItem) {
            elGhostItem.SetPanelEvent('onactivate', () => _OnItemSelected(elGhostItem));
            const elInspect = elGhostItem.FindChildTraverse('id-itemtile-store-inspect-btn');
            elInspect.SetPanelEvent('onactivate', () => {
                if (ItemInfo.ItemHasCapability(itemId, 'decodable') && !ItemInfo.IsTool(itemId)) {
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + itemId, 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=' + '' + ',' + itemId +
                        '&' + 'extrapopupfullscreenstyle=solidbkgnd' +
                        '&' + 'asyncworkitemwarning=no' +
                        '&' + 'inspectonly=true' +
                        '&' + 'asyncworktype=decodeable' +
                        '&' + 'asyncworkbtnstyle=hidden' +
                        'none');
                }
                else {
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + itemId +
                        '&' + 'inspectonly=true' +
                        '&' + 'showequip=false' +
                        '&' + 'allowsave=false' +
                        'none');
                }
            });
        }
    }
    function PopulateItems(bFirstTime = false, claimedItemId = '') {
        _msg('PopulateItems');
        _msg('claimedItemId:' + claimedItemId);
        const objStore = InventoryAPI.GetCacheTypeElementJSOByIndex("PersonalStore", 0);
        $.GetContextPanel().RemoveClass('waiting');
        if (bFirstTime) {
            $.GetContextPanel().TriggerClass('reveal-store');
        }
        const elItemContainer = $.GetContextPanel().FindChildTraverse('jsRrsItemContainer');
        let aSelectedItems = [];
        elItemContainer.Children().forEach(element => {
            if (element.BHasClass('selected')) {
                aSelectedItems.push(element.Data().index);
            }
        });
        elItemContainer.RemoveAndDeleteChildren();
        const arrItemIds = objStore ? Object.values(objStore.items) : ['-', '-', '-', '-'];
        for (let i = 0; i < arrItemIds.length; i++) {
            _CreateItemPanel(arrItemIds[i], i, bFirstTime, claimedItemId);
        }
        elItemContainer.Children().forEach((element, idx) => {
            if (claimedItemId) {
                aSelectedItems.forEach(selectedIndex => {
                    if (idx === selectedIndex) {
                        element.TriggerClass('reveal-anim');
                        $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.gift_claim', '');
                    }
                });
            }
        });
    }
    RankUpRedemptionStore.PopulateItems = PopulateItems;
    function _UpdateTime() {
        let secRemaining = StoreAPI.GetSecondsUntilXpRollover();
        $.GetContextPanel().SetDialogVariable('time-to-week-rollover', (secRemaining > 0) ? FormatText.SecondsToSignificantTimeString(secRemaining) : '');
        const xpBonuses = MyPersonaAPI.GetActiveXpBonuses();
        const bEligibleForCarePackage = xpBonuses.split(',').includes('2');
        if (bEligibleForCarePackage) {
            $.GetContextPanel().SetDialogVariable('frame-desc-text', $.Localize('#rankup_redemption_store_refresh', $.GetContextPanel()));
        }
        else {
            $.GetContextPanel().SetDialogVariable('frame-desc-text', $.Localize('#rankup_redemption_store_rollover_wait', $.GetContextPanel()));
        }
        m_schTimer = $.Schedule(30, _UpdateTime);
    }
    function _UpdateStoreState() {
        const objStore = InventoryAPI.GetCacheTypeElementJSOByIndex("PersonalStore", 0);
        m_redeemableBalance = objStore ? objStore.redeemable_balance : 0;
        const elClaimButton = $.GetContextPanel().FindChildTraverse('jsRrsClaimButton');
        elClaimButton.enabled = m_redeemableBalance !== 0;
        elClaimButton.SetHasClass('hide', m_redeemableBalance === 0);
        if (m_redeemableBalance <= 0) {
            _CloseStore(objStore ? true : false);
        }
        else {
            _EnableStore();
        }
        _SetXpProgress();
        _UpdateTime();
    }
    function OnItemCustomization(numericType, type, itemid) {
        _msg('OnItemCustomization ' + numericType + ' ' + type + ' ' + itemid);
        if (type !== 'free_reward_redeemed')
            return;
        if (m_timeoutScheduleHandle) {
            $.CancelScheduled(m_timeoutScheduleHandle);
            m_timeoutScheduleHandle = null;
        }
        CheckForPopulateItems(false, itemid);
    }
    function OnInventoryUpdated() {
        _UpdateStoreState();
        _msg('OnInventoryUpdated ');
        CheckForPopulateItems();
    }
    function _GetSelectedItems() {
        let arrItems = [];
        const elItemContainer = $.GetContextPanel().FindChildTraverse('jsRrsItemContainer');
        elItemContainer.Children().forEach(function (panel) {
            if (panel.BHasClass('selected')) {
                arrItems.push(panel.Data().itemid);
            }
        });
        return arrItems;
    }
    function _OnItemSelected(elPanel) {
        const elItemContainer = $.GetContextPanel().FindChildTraverse('jsRrsItemContainer');
        let aItemIds = _GetSelectedItems();
        let nSelected = _GetSelectedItems().length;
        if (nSelected < m_redeemableBalance) {
            elPanel.SetHasClass('selected', !elPanel.BHasClass('selected'));
            if (!elPanel.BHasClass('selected')) {
                $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.gift_select', 'MOUSE');
            }
            else {
                $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.gift_deselect', 'MOUSE');
            }
        }
        else {
            if (aItemIds.find(element => element === elPanel.Data().itemid)) {
                elPanel.SetHasClass('selected', !elPanel.BHasClass('selected'));
                if (!elPanel.BHasClass('selected')) {
                    $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.gift_select', 'MOUSE');
                }
                else {
                    $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.gift_deselect', 'MOUSE');
                }
            }
        }
        nSelected = _GetSelectedItems().length;
        elItemContainer.Children().forEach(function (element) {
            if (!elPanel.BHasClass('selected') && nSelected >= m_redeemableBalance) {
                if (element.BHasClass('selected')) {
                    element.TriggerClass('pulse-me');
                    $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.buymenu_failure', 'MOUSE');
                }
            }
        });
    }
    function _CloseStore(bHasStore) {
        _EnableDisableStorePanels(false);
        $.GetContextPanel().AddClass('store-closed');
        if (bHasStore) {
            $.GetContextPanel().SetDialogVariable('frame-badge-text', $.Localize('#rankup_redemption_store_closed', $.GetContextPanel()));
        }
        else {
            $.GetContextPanel().SetDialogVariable('frame-badge-text', $.Localize('#rankup_redemption_store_earn_xp', $.GetContextPanel()));
        }
    }
    function _EnableStore() {
        _msg('_EnableStore ');
        $.GetContextPanel().RemoveClass('waiting');
        $.GetContextPanel().RemoveClass('store-closed');
        $.GetContextPanel().SetDialogVariableInt('redeemable_balance', m_redeemableBalance);
        $.GetContextPanel().SetDialogVariable('frame-badge-text', $.Localize('#rankup_redemption_store_directive', $.GetContextPanel()));
        _EnableDisableStorePanels(true);
    }
    function _EnableDisableStorePanels(enableStore) {
        _msg('_enableStore ' + enableStore);
        $.GetContextPanel().Children().forEach(elPanel => {
            elPanel.enabled = enableStore;
        });
        const elItemContainer = $.GetContextPanel().FindChildTraverse('jsRrsItemContainer');
        elItemContainer.Children().forEach(function (panel) {
            panel.hittest = enableStore;
            panel.hittestchildren = enableStore;
        });
    }
    function _PulseItems() {
        const elItemContainer = $.GetContextPanel().FindChildTraverse('jsRrsItemContainer');
        elItemContainer.Children().forEach(function (panel) {
            if (!panel.BHasClass('item-claimed')) {
                panel.TriggerClass('pulse-me');
                $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.buymenu_failure', 'MOUSE');
            }
        });
    }
    function OnRedeem() {
        if (_GetSelectedItems().length === 0) {
            _PulseItems();
            return;
        }
        let szItemList = _GetSelectedItems().join(',');
        StoreAPI.StoreRedeemFreeRewards(szItemList);
        $.GetContextPanel().AddClass('waiting');
        _EnableDisableStorePanels(true);
        m_timeoutScheduleHandle = $.Schedule(10, _RedemptionTimedOut);
    }
    RankUpRedemptionStore.OnRedeem = OnRedeem;
    function _RedemptionTimedOut() {
        UiToolkitAPI.ShowGenericPopup($.Localize('#rankup_redemption_store_timeout_title'), $.Localize('#rankup_redemption_store_timeout_desc'), '');
        _EnableStore();
    }
    function _SetXpProgress() {
        const currentPoints = FriendsListAPI.GetFriendXp(MyPersonaAPI.GetXuid());
        const pointsPerLevel = MyPersonaAPI.GetXpPerLevel();
        let elXpBarInner = $.GetContextPanel().FindChildInLayoutFile('JsPlayerXpBarInner');
        let percentComplete = (currentPoints / pointsPerLevel) * 100;
        elXpBarInner.style.width = percentComplete + '%';
        elXpBarInner.GetParent().visible = true;
        const xpBonuses = MyPersonaAPI.GetActiveXpBonuses();
        const bEligibleForCarePackage = xpBonuses.split(',').includes('2');
        $.GetContextPanel().SetHasClass('care-package-eligible', bEligibleForCarePackage);
        const currentLvl = FriendsListAPI.GetFriendLevel(MyPersonaAPI.GetXuid());
        let elRankIcon = $.GetContextPanel().FindChildInLayoutFile('JsPlayerXpIcon');
        elRankIcon.SetImage('file://{images}/icons/xp/level' + currentLvl + '.png');
        if (bEligibleForCarePackage) {
            $.GetContextPanel().SetDialogVariable('frame-desc-text', $.Localize('#rankup_redemption_store_refresh', $.GetContextPanel()));
        }
        else {
            $.GetContextPanel().SetDialogVariable('frame-desc-text', $.Localize('#rankup_redemption_store_rollover_wait', $.GetContextPanel()));
        }
    }
})(RankUpRedemptionStore || (RankUpRedemptionStore = {}));
(function () {
    $.GetContextPanel().RegisterForReadyEvents(true);
    RankUpRedemptionStore.RegisterForInventoryUpdate();
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicmFua3VwX3JlZGVtcHRpb25fc3RvcmUuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9yYW5rdXBfcmVkZW1wdGlvbl9zdG9yZS50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsa0NBQWtDO0FBQ2xDLDZDQUE2QztBQUM3QywyQ0FBMkM7QUFDM0MsMENBQTBDO0FBRTFDLElBQVUscUJBQXFCLENBdWY5QjtBQXZmRCxXQUFVLHFCQUFxQjtJQUU5QixJQUFJLG1CQUFtQixHQUFXLENBQUMsQ0FBQztJQUNwQyxJQUFJLFdBQVcsR0FBVyxDQUFDLENBQUMsQ0FBQztJQUM3QixJQUFJLHVCQUFzQyxDQUFDO0lBQzNDLElBQUksNkJBQTRDLENBQUM7SUFDakQsSUFBSSxzQkFBcUMsQ0FBQztJQUMxQyxJQUFJLFlBQVksR0FBRyxLQUFLLENBQUM7SUFDekIsSUFBSSxVQUF5QixDQUFDO0lBRTlCLFNBQVMsSUFBSSxDQUFHLElBQVk7SUFHNUIsQ0FBQztJQUVELFNBQWdCLDBCQUEwQjtRQUV6QyxJQUFLLFlBQVk7WUFDaEIsT0FBTztRQUVSLFlBQVksR0FBRyxJQUFJLENBQUM7UUFDcEIsaUJBQWlCLEVBQUUsQ0FBQztRQUNwQixxQkFBcUIsRUFBRSxDQUFDO1FBRXhCLHNCQUFzQixHQUFHLENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSw4Q0FBOEMsRUFBRSxrQkFBa0IsQ0FBRSxDQUFDO1FBQzNILDZCQUE2QixHQUFHLENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSwyREFBMkQsRUFBRSxtQkFBbUIsQ0FBRSxDQUFDO1FBQ2hKLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxzQkFBc0IsQ0FBRSxJQUFJLENBQUUsQ0FBQztRQUVuRCxDQUFDLENBQUMsb0JBQW9CLENBQUUsaUJBQWlCLEVBQUUsQ0FBQyxDQUFDLGVBQWUsRUFBRSxFQUFFO1lBRS9ELElBQUksQ0FBRSxtQkFBbUIsQ0FBRSxD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