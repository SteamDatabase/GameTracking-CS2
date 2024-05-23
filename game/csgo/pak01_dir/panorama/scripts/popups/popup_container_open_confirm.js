"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/formattext.ts" />
var PopupContainerOpenConfirm;
(function (PopupContainerOpenConfirm) {
    function Init() {
        let itemId = $.GetContextPanel().GetAttributeString('case', '');
        let actionType = $.GetContextPanel().GetAttributeString('action-type', '');
        SetImage(itemId);
        SetWarningText(actionType);
        $.GetContextPanel().SetHasClass('open-container', actionType === 'open');
        $.GetContextPanel().SetDialogVariable('name', InventoryAPI.GetItemName(itemId));
        $.GetContextPanel().SetDialogVariable('title', $.Localize("#popup_container_confirm_title_" + actionType, $.GetContextPanel()));
        let msg_override = $.GetContextPanel().GetAttributeString('msg_override', '');
        $.GetContextPanel().SetDialogVariable('body', msg_override ? msg_override : $.Localize("#popup_container_confirm_body_" + actionType, $.GetContextPanel()));
        let actionBtn = $.GetContextPanel().FindChildInLayoutFile('id-open-confirm-btn');
        let closeBtn = $.GetContextPanel().FindChildInLayoutFile('id-close-confirm-btn');
        var callbackHandle = $.GetContextPanel().GetAttributeInt("callback", -1);
        if (actionType === 'expire') {
            closeBtn.text = "#UI_OK";
            closeBtn.SetPanelEvent('onactivate', () => {
                if (callbackHandle != -1) {
                    UiToolkitAPI.InvokeJSCallback(callbackHandle, '');
                }
                $.DispatchEvent('UIPopupButtonClicked', '');
                $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.mainmenu_press_quit', 'MOUSE');
            });
            actionBtn.visible = false;
            return;
        }
        closeBtn.text = "#UI_Cancel";
        closeBtn.SetPanelEvent('onactivate', () => {
            $.DispatchEvent('UIPopupButtonClicked', '');
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.mainmenu_press_quit', 'MOUSE');
        });
        actionBtn.SwitchClass('action-type', actionType === 'open' ? 'Positive' : 'Blue');
        actionBtn.text = actionType === 'open' ? '#popup_decodable_open_case' : '#popup_decodable_rent_weapons';
        actionBtn.SetPanelEvent('onactivate', () => {
            if (callbackHandle != -1) {
                UiToolkitAPI.InvokeJSCallback(callbackHandle, actionType);
            }
            $.DispatchEvent('UIPopupButtonClicked', '');
        });
    }
    PopupContainerOpenConfirm.Init = Init;
    function SetImage(itemId) {
        $.GetContextPanel().FindChildInLayoutFile('id-confirm-item-image').itemid = itemId;
        let reflection = $.GetContextPanel().FindChildInLayoutFile('id-confirm-item-image-ref');
        $.Schedule(.1, () => reflection.SetImageFromPanel($.GetContextPanel().FindChildInLayoutFile('id-confirm-item-image'), false));
    }
    function SetWarningText(actionType) {
        $.GetContextPanel().FindChildInLayoutFile('id-warning-label').visible = actionType === 'rent';
        if (actionType === 'rent') {
            $.GetContextPanel().SetDialogVariable('warning', $.Localize("#popup_container_confirm_warning_" + actionType));
        }
    }
})(PopupContainerOpenConfirm || (PopupContainerOpenConfirm = {}));
