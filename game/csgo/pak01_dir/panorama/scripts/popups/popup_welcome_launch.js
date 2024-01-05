"use strict";
/// <reference path="../csgo.d.ts" />
var WelcomeLaunch = (function () {
    function _OnOKPressed() {
        var strGoalVersion = $.GetContextPanel().GetAttributeString("uisettingversion", '');
        GameInterfaceAPI.SetSettingString('ui_popup_weaponupdate_version', strGoalVersion);
        $.DispatchEvent('UIPopupButtonClicked', '');
    }
    function _OnCancelPressed() {
        _OnOKPressed();
    }
    return {
        OnOKPressed: _OnOKPressed,
        OnCancelPressed: _OnCancelPressed
    };
})();
