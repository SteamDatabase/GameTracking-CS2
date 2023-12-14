"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/formattext.ts" />
/// <reference path="common/iteminfo.ts" />
/// <reference path="common/store_items.ts" />
/// <reference path="common/prime_button_action.ts" />
/// <reference path="itemtile_store.ts" />
/// <reference path="generated/items_event_current_generated_store.d.ts" />
var MainMenuStore;
(function (MainMenuStore) {
    const _m_cp = $.GetContextPanel();
    let _m_activePanelId = '';
    let _m_pagePrefix = 'id-store-page-';
    let _m_inventoryUpdatedHandler;
    function ReadyForDisplay() {
        if (!ConnectedToGcCheck()) {
            return;
        }
        _m_inventoryUpdatedHandler = $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', MainMenuStore.ShowPrimePanelOnHomePage);
        if (_m_activePanelId === '' || !_m_activePanelId) {
            StoreItems.MakeStoreItemList();
            SetDefaultTab();
        }
        else if (StoreItems.GetStoreItems().coupon && StoreItems.GetStoreItems().coupon.length < 1) {
            StoreItems.MakeStoreItemList();
        }
        ShowPrimePanelOnHomePage();
        MakeTabsBtnsFromStoreData();
        NavigateToTab(_m_activePanelId);
        AccountWalletUpdated();
    }
    MainMenuStore.ReadyForDisplay = ReadyForDisplay;
    function UnreadyForDisplay() {
        if (_m_inventoryUpdatedHandler) {
            $.UnregisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', _m_inventoryUpdatedHandler);
            _m_inventoryUpdatedHandler = null;
        }
    }
    MainMenuStore.UnreadyForDisplay = UnreadyForDisplay;
    function ConnectedToGcCheck() {
        if (!MyPersonaAPI.IsInventoryValid() || !MyPersonaAPI.IsConnectedToGC()) {
            UiToolkitAPI.ShowGenericPopupOk($.Localize('#SFUI_SteamConnectionErrorTitle'), $.Localize('#SFUI_Steam_Error_LinkUnexpected'), '', function () {
                $.DispatchEvent('HideContentPanel');
            });
            return false;
        }
        return true;
    }
    function ShowPrimePanelOnHomePage() {
        let bHasPrime = FriendsListAPI.GetFriendPrimeEligible(MyPersonaAPI.GetXuid());
        let elUpsellPanel = $.GetContextPanel().FindChildInLayoutFile('id-prime-background');
        elUpsellPanel.SetHasClass('hidden', bHasPrime);
        if (!bHasPrime) {
            PrimeButtonAction.SetUpPurchaseBtn(_m_cp.FindChildInLayoutFile('id-store-buy-prime'));
        }
        $.GetContextPanel().FindChildInLayoutFile('id-rewards-background').SetHasClass('hidden', !bHasPrime);
    }
    MainMenuStore.ShowPrimePanelOnHomePage = ShowPrimePanelOnHomePage;
    function SetDefaultTab() {
        let navBtn = _m_cp.FindChildInLayoutFile('id-store-nav-home');
        $.DispatchEvent("Activated", navBtn, "mouse");
        navBtn.checked = true;
    }
    function NavigateToTab(panelId, keyType = '') {
        if (keyType) {
            panelId = _m_pagePrefix + keyType;
        }
        if (_m_activePanelId !== panelId) {
            if (panelId === 'id-store-page-home') {
                UpdateItemsInHomeSection('coupon', 'id-store-popular-items', 6);
                UpdateItemsInHomeSection('tournament', 'id-store-tournament-items', 4);
            }
            else {
                MakePageFromStoreData(keyType);
            }
            if (_m_activePanelId) {
                _m_cp.FindChildInLayoutFile(_m_activePanelId).SetHasClass('Active', false);
            }
            _m_activePanelId = panelId;
            let activePanel = _m_cp.FindChildInLayoutFile(panelId);
            activePanel.SetHasClass('Active', true);
        }
    }
    MainMenuStore.NavigateToTab = NavigateToTab;
    ;
    function UpdateItemsInHomeSection(catagory, parentId, numItemsToShow) {
        let elPanel = _m_cp.FindChildInLayoutFile(parentId);
        let elParent = _m_cp.FindChildInLayoutFile('id-store-home-section-' + catagory);
        elParent.style.backgroundImage = 'url("file://{images}/backgrounds/store_home_' + catagory + '.psd")';
        elParent.style.backgroundPosition = '50% 50%';
        elParent.style.backgroundSize = 'cover';
        let oItemsByCategory = StoreItems.GetStoreItems();
        let aItemsList = oItemsByCategory[catagory];
        if (aItemsList.length < 1) {
            elParent.visible = false;
            return;
        }
        elParent.visible = true;
        for (let i = 0; i < numItemsToShow; i++) {
            let elTile = elPanel.FindChildInLayoutFile('home-' + catagory + '-' + i);
            if (!elTile) {
                elTile = $.CreatePanel("Button", elPanel, 'home-' + catagory + '-' + i);
                elTile.BLoadLayout('file://{resources}/layout/itemtile_store.xml', false, false);
            }
            UpdateItem(elTile, catagory, i);
        }
    }
    function MakeTabsBtnsFromStoreData() {
        let elParent = _m_cp.FindChildInLayoutFile('id-store-lister-tabs');
        let oItemsByCategory = StoreItems.GetStoreItems();
        Object.entries(oItemsByCategory).forEach(([key, value]) => {
            let panelIdString = 'id-store-nav-' + key;
            let elButton = elParent.FindChildInLayoutFile(panelIdString);
            if (value.length > 0 && !elButton) {
                elButton = $.CreatePanel('RadioButton', elParent, panelIdString, {
                    group: 'store-top-nav',
                    class: 'content-navbar__tabs__btn'
                });
                let btnString = key === 'tournament' ?
                    // @ts-ignore 
                    $.Localize('#store_nav_' + key + '_' + g_ActiveTournamentInfo.eventid) :
                    $.Localize('#store_nav_' + key);
                $.CreatePanel('Label', elButton, '', {
                    text: btnString
                });
                elButton.SetPanelEvent('onactivate', () => {
                    MainMenuStore.NavigateToTab(_m_pagePrefix + key, key);
                });
            }
        });
    }
    function MakePageFromStoreData(typeKey) {
        let panelIdString = _m_pagePrefix + typeKey;
        let elParent = _m_cp.FindChildInLayoutFile('id-store-pages');
        let elPanel = elParent.FindChildInLayoutFile(panelIdString);
        if (!elPanel) {
            elPanel = $.CreatePanel('JSDelayLoadList', elParent, panelIdString, {
                class: 'store-dynamic-lister',
                itemwidth: "178px",
                itemheight: "280px",
                spacersize: "4px",
                spacerperiod: "4px"
            });
            UpdateDynamicLister(elPanel, typeKey);
        }
    }
    MainMenuStore.MakePageFromStoreData = MakePageFromStoreData;
    function UpdateDynamicLister(elList, typeKey) {
        let oItemsByCategory = StoreItems.GetStoreItems();
        let aItemsList = oItemsByCategory[typeKey];
        elList.SetLoadListItemFunction(function (parent, nPanelIdx, reusePanel) {
            if (!reusePanel || !reusePanel.IsValid()) {
                reusePanel = $.CreatePanel("Button", elList, aItemsList[nPanelIdx].id);
                reusePanel.BLoadLayout('file://{resources}/layout/itemtile_store.xml', false, false);
            }
            UpdateItem(reusePanel, typeKey, nPanelIdx);
            return reusePanel;
        });
        elList.UpdateListItems(aItemsList.length);
    }
    function UpdateItem(elPanel, typeKey, idx) {
        let oItemData = StoreItems.GetStoreItemData(typeKey, idx);
        ItemTileStore.Init(elPanel, oItemData);
    }
    function GotoStorePage(location) {
        let navBtn = _m_cp.FindChildInLayoutFile(location);
        $.DispatchEvent("Activated", navBtn, "mouse");
        navBtn.checked = true;
    }
    MainMenuStore.GotoStorePage = GotoStorePage;
    function AccountWalletUpdated() {
        var elBalance = _m_cp.FindChildInLayoutFile('id-store-nav-wallet');
        if ((MyPersonaAPI.GetLauncherType() === 'perfectworld') && (MyPersonaAPI.GetSteamType() !== 'china')) {
            elBalance.RemoveClass('hidden');
            elBalance.text = '#Store_SteamChina_Wallet';
            return;
        }
        var balance = (MyPersonaAPI.GetLauncherType() === 'perfectworld') ? StoreAPI.GetAccountWalletBalance() : '';
        if (balance === '' || balance === undefined || balance === null) {
            elBalance.AddClass('hidden');
        }
        else {
            elBalance.SetDialogVariable('balance', balance);
            elBalance.RemoveClass('hidden');
        }
    }
    MainMenuStore.AccountWalletUpdated = AccountWalletUpdated;
    ;
})(MainMenuStore || (MainMenuStore = {}));
(function () {
    MainMenuStore.ReadyForDisplay();
    let elJsStore = $('#JsMainMenuStore');
    $.RegisterEventHandler('ReadyForDisplay', elJsStore, MainMenuStore.ReadyForDisplay);
    $.RegisterEventHandler('UnreadyForDisplay', elJsStore, MainMenuStore.UnreadyForDisplay);
    $.RegisterForUnhandledEvent('PanoramaComponent_Store_AccountWalletUpdated', MainMenuStore.AccountWalletUpdated);
    $.RegisterForUnhandledEvent('PanoramaComponent_Store_PriceSheetChanged', MainMenuStore.ReadyForDisplay);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWFpbm1lbnVfc3RvcmVfZnVsbHNjcmVlbi5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL21haW5tZW51X3N0b3JlX2Z1bGxzY3JlZW4udHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUNsQyw2Q0FBNkM7QUFDN0MsMkNBQTJDO0FBQzNDLDhDQUE4QztBQUM5QyxzREFBc0Q7QUFDdEQsMENBQTBDO0FBQzFDLDJFQUEyRTtBQUUzRSxJQUFVLGFBQWEsQ0FvUXRCO0FBcFFELFdBQVUsYUFBYTtJQUV0QixNQUFNLEtBQUssR0FBWSxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUM7SUFDM0MsSUFBSSxnQkFBZ0IsR0FBVyxFQUFFLENBQUM7SUFDbEMsSUFBSSxhQUFhLEdBQUcsZ0JBQWdCLENBQUM7SUFDckMsSUFBSSwwQkFBeUMsQ0FBQztJQUU5QyxTQUFnQixlQUFlO1FBRzlCLElBQUssQ0FBQyxrQkFBa0IsRUFBRSxFQUMxQjtZQUNDLE9BQU87U0FDUDtRQUVELDBCQUEwQixHQUFHLENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSw4Q0FBOEMsRUFBRSxhQUFhLENBQUMsd0JBQXdCLENBQUUsQ0FBQztRQUVuSixJQUFLLGdCQUFnQixLQUFLLEVBQUUsSUFBSSxDQUFDLGdCQUFnQixFQUNqRDtZQUNDLFVBQVUsQ0FBQyxpQkFBaUIsRUFBRSxDQUFDO1lBQy9CLGFBQWEsRUFBRSxDQUFDO1NBQ2hCO2FBQ0ksSUFBSyxVQUFVLENBQUMsYUFBYSxFQUFFLENBQUMsTUFBTSxJQUFJLFVBQVUsQ0FBQyxhQUFhLEVBQUUsQ0FBQyxNQUFPLENBQUMsTUFBTSxHQUFHLENBQUMsRUFDNUY7WUFDQyxVQUFVLENBQUMsaUJBQWlCLEVBQUUsQ0FBQztTQUMvQjtRQUlELHdCQUF3QixFQUFFLENBQUE7UUFDMUIseUJBQXlCLEVBQUUsQ0FBQztRQUM1QixhQUFhLENBQUUsZ0JBQWdC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