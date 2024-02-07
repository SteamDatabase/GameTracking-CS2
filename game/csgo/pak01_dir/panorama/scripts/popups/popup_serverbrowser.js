"use strict";
/// <reference path="..\csgo.d.ts" />
var PopupServerBrowser;
(function (PopupServerBrowser) {
    function OnOpen() {
        UpdateNeverShowAgainSetting();
        if (MyPersonaAPI.GetLauncherType() === "perfectworld") {
            SteamOverlayAPI.OpenURL('https://csgo.wanmei.com/communityserver');
        }
        else {
            SteamOverlayAPI.OpenUrlInOverlayOrExternalBrowser('steam://open/servers');
        }
        $.DispatchEvent('UIPopupButtonClicked', '');
    }
    PopupServerBrowser.OnOpen = OnOpen;
    function Close() {
        UpdateNeverShowAgainSetting();
        $.DispatchEvent('UIPopupButtonClicked', '');
    }
    PopupServerBrowser.Close = Close;
    function UpdateNeverShowAgainSetting() {
        var elToggle = $.GetContextPanel().FindChildInLayoutFile('NeverShowToggle');
        if (elToggle.checked)
            GameInterfaceAPI.SetSettingString('player_nevershow_communityservermessage', '1');
    }
})(PopupServerBrowser || (PopupServerBrowser = {}));
