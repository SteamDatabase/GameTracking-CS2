"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="settingsmenu_shared.ts" />
var SettingsMenuVideo;
(function (SettingsMenuVideo) {
    function SelectSimpleVideoSettings() {
        SettingsMenuShared.VideoSettingsDiscardChanges();
        SettingsMenuShared.SetVis('video_settings', true);
        SettingsMenuShared.SetVis('advanced_video', false);
        $('#SimpleVideoSettingsRadio').checked = true;
        $('#AdvancedVideoSettingsRadio').checked = false;
    }
    SettingsMenuVideo.SelectSimpleVideoSettings = SelectSimpleVideoSettings;
    function SelectAdvancedVideoSettings() {
        SettingsMenuShared.VideoSettingsDiscardChanges();
        SettingsMenuShared.SetVis('video_settings', false);
        SettingsMenuShared.SetVis('advanced_video', true);
        $('#SimpleVideoSettingsRadio').checked = false;
        $('#AdvancedVideoSettingsRadio').checked = true;
    }
    SettingsMenuVideo.SelectAdvancedVideoSettings = SelectAdvancedVideoSettings;
    function Init() {
        let elMainMenuBkgSetting = $('#MainMenuBkgSettingContainer');
        let cvarInfo = GameInterfaceAPI.GetSettingInfo("ui_mainmenu_bkgnd_movie");
        let aMaps = cvarInfo.allowed_values;
        for (let map of aMaps) {
            let p = $.CreatePanel("Label", elMainMenuBkgSetting, "ui_mainmenu_bkgnd_movie_" + map, {
                text: "#SFUI_Map_" + map,
                value: map
            });
            elMainMenuBkgSetting.AddOption(p);
        }
        elMainMenuBkgSetting.RefreshDisplay();
        let elInspectBkgSetting = $('#InspectBackgroundMapDropDown');
        elInspectBkgSetting.SetDialogVariableLocString("mainmenu_bkgnd", "#SFUI_Map_" + GameInterfaceAPI.GetSettingString("ui_mainmenu_bkgnd_movie"));
        $.RegisterForUnhandledEvent("CSGOMainInitBackgroundMovie", () => {
            elInspectBkgSetting.SetDialogVariableLocString("mainmenu_bkgnd", "#SFUI_Map_" + GameInterfaceAPI.GetSettingString("ui_mainmenu_bkgnd_movie"));
        });
        cvarInfo = GameInterfaceAPI.GetSettingInfo("ui_inspect_bkgnd_map");
        aMaps = cvarInfo.allowed_values;
        for (let map of aMaps) {
            let p = $.CreatePanel("Label", elInspectBkgSetting, "ui_inspect_bkgnd_map_" + map, {
                text: "#SFUI_Map_" + map,
                value: map
            });
            elInspectBkgSetting.AddOption(p);
        }
        elInspectBkgSetting.RefreshDisplay();
    }
    function ShowHudEdgePositions() {
        UiToolkitAPI.ShowCustomLayoutPopupWithCancelCallback('', 'file://{resources}/layout/popups/popup_hud_edge_positions.xml', () => { });
    }
    SettingsMenuVideo.ShowHudEdgePositions = ShowHudEdgePositions;
    {
        SelectSimpleVideoSettings();
        Init();
    }
})(SettingsMenuVideo || (SettingsMenuVideo = {}));
