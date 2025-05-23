"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/formattext.ts" />
/// <reference path="common/iteminfo.ts" />
/// <reference path="common/store_items.ts" />
/// <reference path="common/prime_button_action.ts" />
/// <reference path="itemtile_store.ts" />
/// <reference path="xpshop.ts" />
/// <reference path="generated/items_event_current_generated_store.d.ts" />
/// <reference path="popups/popup_acknowledge_item.ts" />
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
        _m_inventoryUpdatedHandler = $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', InventoryUpdated);
        if (_m_activePanelId === '' ||
            !_m_activePanelId ||
            (StoreItems.GetStoreItems().coupon && StoreItems.GetStoreItems().coupon.length < 1)) {
            StoreItems.MakeStoreItemList();
        }
        ShowPrimePanelOnHomePage();
        MakeTabsBtnsFromStoreData();
        let openToSection = _m_cp.GetAttributeString('set-active-section', '');
        if (_m_activePanelId === '' || !_m_activePanelId || openToSection !== '') {
            SetDefaultTab(openToSection);
        }
        else {
            NavigateToTab(_m_activePanelId);
        }
        AccountWalletUpdated();
    }
    let jsAcknowledgeDelayHandle = null;
    function InventoryUpdated() {
        const aNewItems = AcknowledgeItems.GetItems().filter(item => (item.pickuptype
            && ['xpshopredeem', 'quest_reward'].includes(item.pickuptype)));
        if (aNewItems.length > 0) {
            jsAcknowledgeDelayHandle = null;
            jsAcknowledgeDelayHandle = $.Schedule(1.5, () => {
                $.DispatchEvent('ShowAcknowledgePopup', '', '');
                $.DispatchEvent('UpdateXpShop');
            });
        }
        else {
            $.DispatchEvent('UpdateXpShop');
        }
        ShowPrimePanelOnHomePage();
    }
    function UnreadyForDisplay() {
        if (jsAcknowledgeDelayHandle) {
            $.CancelScheduled(jsAcknowledgeDelayHandle);
            jsAcknowledgeDelayHandle = null;
        }
        $.DispatchEvent('UpdateXpShop');
        if (_m_inventoryUpdatedHandler) {
            $.UnregisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', _m_inventoryUpdatedHandler);
            _m_inventoryUpdatedHandler = null;
        }
    }
    function ConnectedToGcCheck() {
        if (!MyPersonaAPI.IsInventoryValid() || !MyPersonaAPI.IsConnectedToGC()) {
            UiToolkitAPI.ShowGenericPopupOk($.Localize('#SFUI_SteamConnectionErrorTitle'), $.Localize('#SFUI_Steam_Error_LinkUnexpected'), '', () => $.DispatchEvent('HideContentPanel'));
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
    function SetDefaultTab(openToSection) {
        let navBtn = null;
        if (openToSection !== '') {
            navBtn = _m_cp.FindChildInLayoutFile(openToSection);
            _m_cp.SetAttributeString('set-active-section', '');
        }
        else if (_m_activePanelId === '' || !_m_activePanelId) {
            navBtn = _m_cp.FindChildInLayoutFile('id-store-nav-home');
        }
        if (navBtn) {
            $.DispatchEvent("Activated", navBtn, "mouse");
        }
    }
    function NavigateToTab(panelId, keyType = '') {
        if (keyType) {
            panelId = _m_pagePrefix + keyType;
        }
        if (_m_activePanelId !== panelId) {
            if (panelId === _m_pagePrefix + 'home') {
                UpdateItemsInHomeSection('coupon', 'id-store-popular-items', 6);
                UpdateItemsInHomeSection('tournament', 'id-store-tournament-items', 4);
            }
            else {
                MakePageFromStoreData(keyType);
                if (panelId === _m_pagePrefix + 'xpshop') {
                    $.DispatchEvent('UpdateXpShop');
                }
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
    function UpdateItemsInHomeSection(catagory, parentId, numItemsToShow) {
        let elPanel = _m_cp.FindChildInLayoutFile(parentId);
        let elParent = _m_cp.FindChildInLayoutFile('id-store-home-section-' + catagory);
        elParent.style.backgroundImage = 'url("file://{images}/backgrounds/store_home_' + catagory + '.psd")';
        elParent.style.backgroundPosition = '50% 50%';
        elParent.style.backgroundSize = 'cover';
        if (catagory === 'tournament') {
            elParent.SetDialogVariable('tournament-name', $.Localize("#store_nav_tournament_" + g_ActiveTournamentInfo.eventid));
        }
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
        for (let [key, value] of Object.entries(oItemsByCategory)) {
            let panelIdString = 'id-store-nav-' + key;
            let elButton = elParent.FindChildInLayoutFile(panelIdString);
            if (value.length > 0 && !elButton) {
                elButton = $.CreatePanel('RadioButton', elParent, panelIdString, {
                    group: 'store-top-nav',
                    class: 'content-navbar__tabs__btn'
                });
                let btnString = key === 'tournament' ?
                    `#store_nav_${key}_${g_ActiveTournamentInfo.eventid}` :
                    `#store_nav_${key}`;
                $.CreatePanel('Label', elButton, '', {
                    text: btnString
                });
                elButton.SetPanelEvent('onactivate', () => {
                    NavigateToTab(_m_pagePrefix + key, key);
                });
            }
        }
        let elButton = elParent.FindChildInLayoutFile('id-store-nav-xpshop');
        if (!elButton) {
            let nTrack = MissionsAPI.GetSeasonalOperationXpShopIndex();
            let nNewItemCount = 0;
            if (nTrack > 0) {
                let nCount = MissionsAPI.GetSeasonalOperationRedeemableGoodsCount(nTrack);
                for (let i = 0; i < nCount; i++) {
                    if (nNewItemCount > 0) {
                        break;
                    }
                    let ShopEntry = {
                        item_name: "",
                        ui_show_new_tag: ""
                    };
                    ShopEntry.ui_show_new_tag = MissionsAPI.GetSeasonalOperationRedeemableGoodsSchema(nTrack, i, 'ui_show_new_tag');
                    if (XpShop.ShouldShowNewTagForShopEntry(ShopEntry)) {
                        nNewItemCount++;
                    }
                }
            }
            elButton = $.CreatePanel('RadioButton', elParent, 'id-store-nav-xpshop', {
                group: 'store-top-nav',
                class: 'content-navbar__tabs__btn'
            });
            $.CreatePanel('Label', elButton, '', {
                text: '#store_tab_xpshop'
            });
            if (nNewItemCount > 0) {
                $.CreatePanel('Label', elButton, '', {
                    class: 'content-navbar__tabs__btn-new', text: '#xpshop_new_items'
                });
            }
            elButton.SetPanelEvent('onactivate', () => {
                NavigateToTab(_m_pagePrefix + 'xpshop', 'xpshop');
            });
        }
    }
    function MakePageFromStoreData(typeKey) {
        let panelIdString = _m_pagePrefix + typeKey;
        let elParent = _m_cp.FindChildInLayoutFile('id-store-pages');
        let elPanel = elParent.FindChildInLayoutFile(panelIdString);
        if (!elPanel) {
            if (typeKey === 'xpshop') {
                elPanel = $.CreatePanel('Panel', elParent, panelIdString, {});
                elPanel.BLoadLayout("file://{resources}/layout/xpshop.xml", false, false);
            }
            else {
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
    }
    function UpdateDynamicLister(elList, typeKey) {
        let oItemsByCategory = StoreItems.GetStoreItems();
        let aItemsList = oItemsByCategory[typeKey];
        elList.SetLoadListItemFunction((parent, nPanelIdx, reusePanel) => {
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
    {
        ReadyForDisplay();
        let elJsStore = $('#JsMainMenuStore');
        $.RegisterEventHandler('ReadyForDisplay', elJsStore, ReadyForDisplay);
        $.RegisterEventHandler('UnreadyForDisplay', elJsStore, UnreadyForDisplay);
        $.RegisterForUnhandledEvent('PanoramaComponent_Store_AccountWalletUpdated', AccountWalletUpdated);
        $.RegisterForUnhandledEvent('PanoramaComponent_Store_PriceSheetChanged', ReadyForDisplay);
    }
})(MainMenuStore || (MainMenuStore = {}));
