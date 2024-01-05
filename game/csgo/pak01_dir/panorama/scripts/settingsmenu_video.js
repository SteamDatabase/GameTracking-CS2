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
        let parent = $('#MainMenuBkgSettingContainer');
        let cvarInfo = GameInterfaceAPI.GetSettingInfo("ui_mainmenu_bkgnd_movie");
        let aMaps = cvarInfo.allowed_values;
        aMaps.forEach(map => {
            let p = $.CreatePanel("Label", parent, "ui_mainmenu_bkgnd_movie_" + map, {
                text: "#SFUI_Map_" + map,
                value: map
            });
            parent.AddOption(p);
        });
        parent.RefreshDisplay();
    }
    SettingsMenuVideo.Init = Init;
    function ShowHudEdgePositions() {
        UiToolkitAPI.ShowCustomLayoutPopupWithCancelCallback('', 'file://{resources}/layout/popups/popup_hud_edge_positions.xml', () => { });
    }
    SettingsMenuVideo.ShowHudEdgePositions = ShowHudEdgePositions;
})(SettingsMenuVideo || (SettingsMenuVideo = {}));
SettingsMenuVideo.SelectSimpleVideoSettings();
SettingsMenuVideo.Init();
