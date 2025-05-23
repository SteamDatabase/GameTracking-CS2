"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/licenseutil.ts" />
/// <reference path="generated/items_event_current_generated_store.d.ts" />
/// <reference path="generated/items_event_current_generated_store.ts" />
var MainMenuMajorTile;
(function (MainMenuMajorTile) {
    const _m_cp = $.GetContextPanel();
    function _Init() {
        let bVisible = true;
        if (!MyPersonaAPI.IsConnectedToGC())
            bVisible = false;
        else if (LicenseUtil.GetCurrentLicenseRestrictions())
            bVisible = false;
        else if (!StoreAPI.GetStoreItemSalePrice(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(g_ActiveTournamentStoreLayout[1][0], 0), 1, ''))
            bVisible = false;
        _m_cp.SetHasClass('hidden', !bVisible);
        if (!bVisible)
            return;
        _m_cp.FindChildInLayoutFile('id-btn-open-major-hub').SetPanelEvent('onactivate', OpenMajorHub);
        _m_cp.SetHasClass('major-' + g_ActiveTournamentInfo.eventid.toString(), true);
        _m_cp.FindChildInLayoutFile('id-img-open-major-hub').SetImage('file://{images}/tournaments/backgrounds/pickem_mainmenu_promo_' + g_ActiveTournamentInfo.eventid + '.png');
        let sRestriction = InventoryAPI.GetDecodeableRestriction("capsule");
        let bCanSellCapsules = (sRestriction !== "restricted" && sRestriction !== "xray");
        let bHasActualCapsulesForPurchase = false;
        _m_cp.SetHasClass('has-reduction', false);
        let tournamentEventId = NewsAPI.GetActiveTournamentEventID();
        let itemIdForStickerCapsule = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(g_ActiveTournamentStoreLayout[1][0], 0);
        if (bCanSellCapsules && (tournamentEventId !== 0) && ('' !== StoreAPI.GetStoreItemSalePrice(itemIdForStickerCapsule, 1, ''))) {
            _m_cp.FindChildInLayoutFile('id-open-major-item-image').itemid = itemIdForStickerCapsule;
            bHasActualCapsulesForPurchase = true;
            let reduction = StoreAPI.GetStoreItemPercentReduction(itemIdForStickerCapsule);
            _m_cp.SetHasClass('has-reduction', reduction !== '' && reduction !== undefined);
            _m_cp.FindChildInLayoutFile('id-items-banner').SetDialogVariable('items-text', reduction ? $.Localize('#store_sale') : $.Localize('#mainmenu_major_hub_items'));
        }
        let itemIdForChampions = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(g_ActiveTournamentStoreLayout[4][0], 0);
        if (bCanSellCapsules && (tournamentEventId !== 0) && ('' !== StoreAPI.GetStoreItemSalePrice(itemIdForChampions, 1, ''))) {
            _m_cp.FindChildInLayoutFile('id-open-major-item-image').itemid = itemIdForChampions;
        }
        _m_cp.SetDialogVariable('hub-title-bar-caption', $.Localize(bHasActualCapsulesForPurchase ? '#mainmenu_major_hub' : '#mainmenu_major_hub_no_items'));
        _m_cp.SetHasClass('can-sell-items', bHasActualCapsulesForPurchase);
    }
    function OpenMajorHub() {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('id-popup-major-hub', 'file://{resources}/layout/popups/popup_major_hub.xml', 'eventid=' + (g_ActiveTournamentInfo.eventid));
    }
    {
        _Init();
        $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_GcLogonNotificationReceived', _Init);
        $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_UpdateConnectionToGC', _Init);
        $.RegisterForUnhandledEvent('PanoramaComponent_Store_PriceSheetChanged', _Init);
    }
})(MainMenuMajorTile || (MainMenuMajorTile = {}));
