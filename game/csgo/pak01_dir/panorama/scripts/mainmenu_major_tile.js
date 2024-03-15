"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/licenseutil.ts" />
/// <reference path="generated/items_event_current_generated_store.d.ts" />
/// <reference path="generated/items_event_current_generated_store.ts" />
var MainMenuMajorTile;
(function (MainMenuMajorTile) {
    const _m_cp = $.GetContextPanel();
    function _Init() {
        if (!MyPersonaAPI.IsConnectedToGC()) {
            _m_cp.SetHasClass('hidden', true);
            return;
        }
        let restrictions = LicenseUtil.GetCurrentLicenseRestrictions();
        if (restrictions) {
            _m_cp.SetHasClass('hidden', true);
            return;
        }
        _m_cp.SetHasClass('hidden', false);
        _m_cp.FindChildInLayoutFile('id-btn-open-major-hub').SetPanelEvent('onactivate', OpenMajorHub);
        _m_cp.FindChildInLayoutFile('id-img-open-major-hub').SetImage('file://{images}/tournaments/backgrounds/pickem_mainmenu_promo_' + g_ActiveTournamentInfo.eventid + '.png');
    }
    function OpenMajorHub() {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('id-popup-major-hub', 'file://{resources}/layout/popups/popup_major_hub.xml', 'eventid=' + g_ActiveTournamentInfo.eventid);
    }
    {
        _Init();
        $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_GcLogonNotificationReceived', _Init);
        $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_UpdateConnectionToGC', _Init);
    }
})(MainMenuMajorTile || (MainMenuMajorTile = {}));
