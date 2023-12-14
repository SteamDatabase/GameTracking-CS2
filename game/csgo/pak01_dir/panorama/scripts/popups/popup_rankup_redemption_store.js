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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfcmFua3VwX3JlZGVtcHRpb25fc3RvcmUuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9wb3B1cHMvcG9wdXBfcmFua3VwX3JlZGVtcHRpb25fc3RvcmUudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUVyQyxJQUFVLDBCQUEwQixDQXVCbkM7QUF2QkQsV0FBVSwwQkFBMEI7SUFFbkMsU0FBUyxJQUFJLENBQUcsSUFBWTtJQUc1QixDQUFDO0lBRUQsU0FBZ0IsSUFBSTtRQUVuQixJQUFJLENBQUUsTUFBTSxDQUFFLENBQUM7SUFDaEIsQ0FBQztJQUhlLCtCQUFJLE9BR25CLENBQUE7SUFFRCxTQUFnQixPQUFPO1FBRXRCLE1BQU0sY0FBYyxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxlQUFlLENBQUUsVUFBVSxFQUFFLENBQUMsQ0FBQyxDQUFFLENBQUM7UUFDN0UsSUFBSyxjQUFjLElBQUksQ0FBQyxDQUFDLEVBQ3pCO1lBQ0MsWUFBWSxDQUFDLGdCQUFnQixDQUFFLGNBQWMsQ0FBRSxDQUFDO1NBQ2hEO1FBRUQsQ0FBQyxDQUFDLGFBQWEsQ0FBRSxzQkFBc0IsRUFBRSxFQUFFLENBQUUsQ0FBQztRQUM5QyxDQUFDLENBQUMsYUFBYSxDQUFFLHFCQUFxQixFQUFFLHNDQUFzQyxFQUFFLE9BQU8sQ0FBRSxDQUFDO0lBQzNGLENBQUM7SUFWZSxrQ0FBTyxVQVV0QixDQUFBO0FBQ0YsQ0FBQyxFQXZCUywwQkFBMEIsS0FBMUIsMEJBQTBCLFFBdUJuQztBQUFBLENBQUM7QUFLRixDQUFFO0FBRUYsQ0FBQyxDQUFFLEVBQUUsQ0FBQyJ9