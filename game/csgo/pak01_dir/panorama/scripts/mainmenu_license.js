"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/licenseutil.ts" />
var MainMenulicense;
(function (MainMenulicense) {
    const _m_licensePanel = $.GetContextPanel();
    function Init() {
        CheckLicense();
    }
    MainMenulicense.Init = Init;
    function CheckLicense() {
        var restrictions = LicenseUtil.GetCurrentLicenseRestrictions();
        if (restrictions) {
            _m_licensePanel.SetDialogVariable('restriction', $.Localize(restrictions.license_msg));
            _m_licensePanel.SetDialogVariable('restriction_act', $.Localize(restrictions.license_act));
        }
        _m_licensePanel.SetHasClass('hidden', !restrictions);
        SetStyleOnRootPanel(restrictions);
    }
    function ActionBuyLicense() {
        var restrictions = LicenseUtil.GetCurrentLicenseRestrictions();
        LicenseUtil.BuyLicenseForRestrictions(restrictions);
    }
    MainMenulicense.ActionBuyLicense = ActionBuyLicense;
    ;
    function SetStyleOnRootPanel(restrictions) {
        var elMainMenuInput = _m_licensePanel;
        while (elMainMenuInput) {
            elMainMenuInput = elMainMenuInput.GetParent();
            if (elMainMenuInput.id === 'MainMenuInput')
                break;
        }
        if (elMainMenuInput) {
            elMainMenuInput.SetHasClass('steam-license-restricted', restrictions !== false);
        }
    }
})(MainMenulicense || (MainMenulicense = {}));
(function () {
    MainMenulicense.Init();
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_GcLogonNotificationReceived', MainMenulicense.Init);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_UpdateConnectionToGC', MainMenulicense.Init);
})();
