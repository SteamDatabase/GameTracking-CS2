"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="settingsmenu_shared.ts" />
var SettingsMenuGameSettings;
(function (SettingsMenuGameSettings) {
    function _InitGameSettings() {
        if (GameInterfaceAPI.IsConsoleEnabledByCommandLine()) {
            $("#enableconsoledropdown-container").visible = false;
        }
        else {
            $("#enableconsoledropdowncmdline-container").visible = false;
        }
        if (!GameInterfaceAPI.ShowThreadPoolOptions()) {
            $("#ThreadPoolOptions").visible = false;
            $("#ThreadPoolOptionsQuit").visible = false;
            GameInterfaceAPI.SetSettingString('thread_pool_option', '3');
        }
        else {
            let option = parseInt(GameInterfaceAPI.GetSettingString('thread_pool_option'));
            if (option !== 0 && option !== 2 && option !== 3) {
                GameInterfaceAPI.SetSettingString('thread_pool_option', '3');
            }
        }
        _RefreshDatacentersList();
    }
    function _RefreshDatacentersList() {
        let elContainer = $('#DatacenterListContainer');
        elContainer.RemoveAndDeleteChildren();
        const dcs = LobbyAPI.GetReachableDatacenters();
        const samples = dcs.samples;
        let numSamplesAdded = 0;
        for (let k = 0; k < 10; ++k) {
            if (!samples || !samples.hasOwnProperty('sample' + k))
                break;
            const ss = samples['sample' + k];
            let elPanel = $.CreatePanel("Panel", elContainer, String(ss.ping));
            elPanel.BLoadLayoutSnippet("snippet_datacenter_entry");
            elPanel.SetDialogVariable('name', ss.name);
            elPanel.SetDialogVariableInt('ping', ss.ping);
            ++numSamplesAdded;
        }
        if (numSamplesAdded == 0) {
            let elPanel = $.CreatePanel("Panel", elContainer, '0');
            elPanel.BLoadLayoutSnippet("snippet_datacenter_entry");
            elPanel.SetDialogVariable('name', $.Localize("#SFUI_UserAlert_Unreachable"));
            elPanel.SetDialogVariableInt('ping', 0);
        }
        elContainer.SetHasClass('no-data-centers', numSamplesAdded == 0);
    }
    function _InitSteamClanTagsPanel() {
        let clanTagDropdown = $('#ClanTagsEnum');
        if (!clanTagDropdown || !clanTagDropdown.IsValid()) {
            return;
        }
        clanTagDropdown.RemoveAllOptions();
        let id = 'clantagoption_none';
        let optionLabel = $.CreatePanel('Label', clanTagDropdown, id);
        optionLabel.text = $.Localize("#SFUI_Settings_ClanTag_None");
        optionLabel.SetAttributeString('value', '0');
        clanTagDropdown.AddOption(optionLabel);
        let nNumClans = MyPersonaAPI.GetMyClanCount();
        for (let i = 0; i < nNumClans; i++) {
            let clanID = MyPersonaAPI.GetMyClanIdByIndex(i);
            let clanTag = MyPersonaAPI.GetMyClanTagByIdCensored(clanID);
            let clanIDForCvar = MyPersonaAPI.GetMyClanId32BitByIndex(i);
            id = 'clantagoption' + i.toString();
            optionLabel = $.CreatePanel('Label', clanTagDropdown, id, { text: '{s:clanTag}' });
            optionLabel.SetDialogVariable('clanTag', clanTag);
            optionLabel.SetAttributeString('value', clanIDForCvar.toString());
            clanTagDropdown.AddOption(optionLabel);
        }
        clanTagDropdown.RefreshDisplay();
    }
    function OnCrosshairStyleChange() {
        let nStyle = parseInt(GameInterfaceAPI.GetSettingString('cl_crosshairstyle'));
        let bEnableControls = nStyle !== 0 && nStyle !== 1;
        $("#XhairLength").visible = bEnableControls;
        $("#XhairThickness").visible = bEnableControls;
        $("#XhairGap").visible = bEnableControls;
        $("#XhairOutline").visible = bEnableControls;
        $("#XhairColorRed").visible = bEnableControls;
        $("#XhairColorGreen").visible = bEnableControls;
        $("#XhairColorBlue").visible = bEnableControls;
        $("#XhairAlpha").visible = bEnableControls;
        $("#XhairCenterDot").visible = bEnableControls;
        $("#XhairRecoil").visible = bEnableControls;
        $("#XhairTStyle").visible = bEnableControls;
        let bEnableSplitControls = nStyle === 2;
        $("#XhairSlitDist").visible = bEnableSplitControls;
        $("#XhairSplitInnerAlpha").visible = bEnableSplitControls;
        $("#XhairSplitOuterAlpha").visible = bEnableSplitControls;
        $("#XhairSplitRatio").visible = bEnableSplitControls;
        $("#XhairFixedGap").visible = (nStyle === 1);
        $("#CrosshairEditorPreview").SetHasClass("dynamic-crosshair", nStyle === 0 || nStyle === 2 || nStyle === 3);
        let obsCrosshairs = parseInt(GameInterfaceAPI.GetSettingString('cl_show_observer_crosshair'));
        $("#XhairObservedBotCrosshair").visible = (obsCrosshairs === 2);
    }
    SettingsMenuGameSettings.OnCrosshairStyleChange = OnCrosshairStyleChange;
    {
        _InitSteamClanTagsPanel();
        _InitGameSettings();
        OnCrosshairStyleChange();
        SettingsMenuShared.ChangeBackground(0);
        $.RegisterForUnhandledEvent('PanoramaComponent_Lobby_ReachableDatacentersUpdated', _RefreshDatacentersList);
    }
})(SettingsMenuGameSettings || (SettingsMenuGameSettings = {}));
