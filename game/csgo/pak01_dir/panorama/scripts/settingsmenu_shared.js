"use strict";
/// <reference path="csgo.d.ts" />
var SettingsMenuShared = (function () {
    var _ResetControlsRecursive = function (panel) {
        if (panel == null) {
            return;
        }
        if (panel.GetChildCount == undefined) {
            return;
        }
        if (panel.paneltype == 'CSGOSettingsSlider' || panel.paneltype == 'CSGOSettingsEnumDropDown') {
            panel.RestoreCVarDefault();
        }
        else if (panel.paneltype == 'CSGOConfigSlider' || panel.paneltype == 'CSGOConfigEnumDropDown') {
            // @ts-ignore Property 'RestoreConfigDefault' does not exist on type 'Panel_t'.
            panel.RestoreConfigDefault();
        }
        else if (panel.paneltype == 'CSGOSettingsKeyBinder') {
            panel.OnShow();
        }
        else {
            var nCount = panel.GetChildCount();
            for (var i = 0; i < nCount; i++) {
                var child = panel.GetChild(i);
                _ResetControlsRecursive(child);
            }
        }
    };
    var _ResetControls = function () {
        _ResetControlsRecursive($.GetContextPanel());
        InventoryAPI.StopItemPreviewMusic();
    };
    var _ResetKeybdMouseDefaults = function () {
        // @ts-ignore Cannot find name 'OptionsMenuAPI'.
        OptionsMenuAPI.RestoreKeybdMouseBindingDefaults();
        _ResetControls();
    };
    var _ResetAudioSettings = function () {
        $.DispatchEvent("CSGOAudioSettingsResetDefault");
        _ResetControls();
    };
    var _ResetVideoSettings = function () {
        $.DispatchEvent("CSGOVideoSettingsResetDefault");
        _ResetControls();
        _VideoSettingsOnUserInputSubmit();
    };
    var _ResetVideoSettingsAdvanced = function () {
        $.DispatchEvent("CSGOVideoSettingsResetDefaultAdvanced");
        _VideoSettingEnableDiscard;
    };
    var _RefreshControls = function () {
        _RefreshControlsRecursive($.GetContextPanel());
    };
    var _RefreshControlsRecursive = function (panel) {
        if (panel == null) {
            return;
        }
        if ('OnShow' in panel) {
            panel.OnShow();
        }
        if (panel.GetChildCount == undefined) {
            return;
        }
        else {
            var nCount = panel.GetChildCount();
            for (var i = 0; i < nCount; i++) {
                var child = panel.GetChild(i);
                _RefreshControlsRecursive(child);
            }
        }
    };
    var _ShowConfirmReset = function (resetCall, locText) {
        UiToolkitAPI.ShowGenericPopupOneOptionCustomCancelBgStyle('#settings_reset_confirm_title', locText, '', '#settings_reset', function () {
            resetCall();
        }, '#settings_return', function () {
        }, 'dim');
    };
    var _ShowConfirmDiscard = function (discardCall) {
        UiToolkitAPI.ShowGenericPopupOneOptionCustomCancelBgStyle('#settings_discard_confirm_title', '#settings_discard_confirm_video_desc', '', '#settings_discard', function () {
            discardCall();
        }, '#settings_return', function () {
        }, 'dim');
    };
    var _ScrollToId = function (locationId) {
        var elLocationPanel = $.GetContextPanel().FindChildTraverse(locationId);
        if (elLocationPanel != null) {
            $.GetContextPanel().Data().bScrollingToId = true;
            elLocationPanel.ScrollParentToMakePanelFit(1, false);
            elLocationPanel.TriggerClass('Highlight');
        }
    };
    var _SetVis = function (locationId, vis) {
        var panel = $.GetContextPanel().FindChildTraverse(locationId);
        if (panel != null) {
            panel.visible = vis;
        }
    };
    var gBtnApplyVideoSettingsButton = null;
    var gBtnDiscardVideoSettingChanges = null;
    var gBtnDiscardVideoSettingChanges2 = null;
    var _VideoSettingsOnUserInputSubmit = function () {
        if (gBtnApplyVideoSettingsButton != null) {
            gBtnApplyVideoSettingsButton.enabled = true;
        }
        if (gBtnDiscardVideoSettingChanges != null) {
            gBtnDiscardVideoSettingChanges.enabled = true;
        }
    };
    var _VideoSettingEnableDiscard = function () {
        if (gBtnDiscardVideoSettingChanges2 != null) {
            gBtnDiscardVideoSettingChanges2.enabled = true;
        }
    };
    var _VideoSettingsResetUserInput = function () {
        if (gBtnApplyVideoSettingsButton != null) {
            gBtnApplyVideoSettingsButton.enabled = false;
        }
        if (gBtnDiscardVideoSettingChanges != null) {
            gBtnDiscardVideoSettingChanges.enabled = false;
        }
        if (gBtnDiscardVideoSettingChanges2 != null) {
            gBtnDiscardVideoSettingChanges2.enabled = false;
        }
    };
    var _VideoSettingsDiscardChanges = function () {
        $.DispatchEvent("CSGOVideoSettingsInit");
        _VideoSettingsResetUserInput();
    };
    var _VideoSettingsDiscardAdvanced = function () {
        $.DispatchEvent("CSGOVideoSettingsDiscardAdvanced");
        _VideoSettingsResetUserInput();
    };
    var _VideoSettingsApplyChanges = function () {
        $.DispatchEvent("CSGOApplyVideoSettings");
        _VideoSettingsResetUserInput();
    };
    var _NewTabOpened = function (newTab) {
        var videoSettingsStr = 'VideoSettings';
        if (newTab == videoSettingsStr) {
            var videoSettingsPanel = $.GetContextPanel().FindChildInLayoutFile(videoSettingsStr);
            gBtnApplyVideoSettingsButton = videoSettingsPanel.FindChildInLayoutFile("BtnApplyVideoSettings");
            gBtnDiscardVideoSettingChanges = videoSettingsPanel.FindChildInLayoutFile("BtnDiscardVideoSettingChanges");
            gBtnDiscardVideoSettingChanges2 = videoSettingsPanel.FindChildInLayoutFile("BtnDiscardVideoSettingChanges2");
            gBtnApplyVideoSettingsButton.enabled = false;
            gBtnDiscardVideoSettingChanges.enabled = false;
            gBtnDiscardVideoSettingChanges2.enabled = false;
            $.DispatchEvent("CSGOVideoSettingsInit");
        }
        var newTabPanel = $.GetContextPanel().FindChildInLayoutFile(newTab);
        _RefreshControlsRecursive(newTabPanel);
        GameInterfaceAPI.ConsoleCommand("host_writeconfig");
        InventoryAPI.StopItemPreviewMusic();
    };
    var _ChangeBackground = function (delta) {
        let elBkg = $("#XhairBkg");
        if (elBkg) {
            let nBkgIdx = elBkg.GetAttributeInt("bkg-id", 0);
            let arrBkgs = ["bkg-dust2", "bkg-aztec", "bkg-mirage", "bkg-office"];
            nBkgIdx = (arrBkgs.length + nBkgIdx + delta) % arrBkgs.length;
            elBkg.SwitchClass("bkg-style", arrBkgs[nBkgIdx]);
            elBkg.SetAttributeInt("bkg-id", nBkgIdx);
        }
    };
    return {
        ResetControlsRecursivepanel: _ResetControlsRecursive,
        ResetControls: _ResetControls,
        ResetKeybdMouseDefaults: _ResetKeybdMouseDefaults,
        ResetAudioSettings: _ResetAudioSettings,
        ResetVideoSettings: _ResetVideoSettings,
        ResetVideoSettingsAdvanced: _ResetVideoSettingsAdvanced,
        ScrollToId: _ScrollToId,
        SetVis: _SetVis,
        ShowConfirmReset: _ShowConfirmReset,
        ShowConfirmDiscard: _ShowConfirmDiscard,
        VideoSettingsEnableDiscard: _VideoSettingEnableDiscard,
        VideoSettingsOnUserInputSubmit: _VideoSettingsOnUserInputSubmit,
        VideoSettingsDiscardAdvanced: _VideoSettingsDiscardAdvanced,
        VideoSettingsDiscardChanges: _VideoSettingsDiscardChanges,
        VideoSettingsApplyChanges: _VideoSettingsApplyChanges,
        NewTabOpened: _NewTabOpened,
        ChangeBackground: _ChangeBackground,
        RefreshControls: _RefreshControls,
    };
})();
(() => {
    $.RegisterForUnhandledEvent('CSGOCrosshairSettingsChanged', SettingsMenuShared.RefreshControls);
})();
