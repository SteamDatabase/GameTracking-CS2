"use strict";
/// <reference path="..\csgo.d.ts" />
var PopupRankUpRedemptionStore;
(function (PopupRankUpRedemptionStore) {
    function _msg(text) {
    }
    function Init() {
        _msg('Init');
    }
    PopupRankUpRedemptionStore.Init = Init;
    function OnClose() {
        const callbackHandle = $.GetContextPanel().GetAttributeInt("callback", -1);
        if (callbackHandle != -1) {
            UiToolkitAPI.InvokeJSCallback(callbackHandle);
        }
        $.DispatchEvent('UIPopupButtonClicked', '');
        $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.inventory_new_item_accept', 'MOUSE');
    }
    PopupRankUpRedemptionStore.OnClose = OnClose;
})(PopupRankUpRedemptionStore || (PopupRankUpRedemptionStore = {}));
;
(function () {
})();
