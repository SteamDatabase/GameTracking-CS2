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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2V0dGluZ3NtZW51X3NoYXJlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL3NldHRpbmdzbWVudV9zaGFyZWQudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUVsQyxJQUFJLGtCQUFrQixHQUFHLENBQUU7SUFHMUIsSUFBSSx1QkFBdUIsR0FBRyxVQUFVLEtBQWM7UUFFckQsSUFBSyxLQUFLLElBQUksSUFBSSxFQUNsQjtZQUNDLE9BQU87U0FDUDtRQUVELElBQUksS0FBSyxDQUFDLGFBQWEsSUFBSSxTQUFTLEVBQ3BDO1lBRUMsT0FBTztTQUNQO1FBRUQsSUFBSSxLQUFLLENBQUMsU0FBUyxJQUFJLG9CQUFvQixJQUFJLEtBQUssQ0FBQyxTQUFTLElBQUksMEJBQTBCLEVBQzVGO1lBQ0UsS0FBMkQsQ0FBQyxrQkFBa0IsRUFBRSxDQUFDO1NBQ2xGO2FBQ0ksSUFBSSxLQUFLLENBQUMsU0FBUyxJQUFJLGtCQUFrQixJQUFJLEtBQUssQ0FBQyxTQUFTLElBQUksd0JBQXdCLEVBQzdGO1lBQ0MsK0VBQStFO1lBQzVFLEtBQUssQ0FBQyxvQkFBb0IsRUFBRSxDQUFDO1NBQ2hDO2FBQ0ksSUFBSyxLQUFLLENBQUMsU0FBUyxJQUFJLHVCQUF1QixFQUNwRDtZQUVFLEtBQWlDLENBQUMsTUFBTSxFQUFFLENBQUM7U0FDNUM7YUFFRDtZQUNDLElBQUksTUFBTSxHQUFHLEtBQUssQ0FBQyxhQUFhLEVBQUUsQ0FBQztZQUNuQyxLQUFNLElBQUksQ0FBQyxHQUFHLENBQUMsRUFBRSxDQUFDLEdBQUcsTUFBTSxFQUFFLENBQUMsRUFBRSxFQUNoQztnQkFDQyxJQUFJLEtBQUssR0FBRyxLQUFLLENBQUMsUUFBUSxDQUFDLENBQUMsQ0FBQyxDQUFDO2dCQUM5Qix1QkFBdUIsQ0FBRSxLQUFLLENBQUUsQ0FBQzthQUNqQztTQUNEO0lBQ0YsQ0FBQyxDQUFDO0lB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