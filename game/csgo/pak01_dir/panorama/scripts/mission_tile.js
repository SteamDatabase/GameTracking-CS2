"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/formattext.ts" />
var MissionTile;
(function (MissionTile) {
    let m_oMissionData = {};
    let m_livePointsCache = 0;
    function IsTheInGamePanel() {
        return ($.GetContextPanel().id === 'HudMissionPanel');
    }
    function IsThePauseMenuPanel() {
        return ($.GetContextPanel().id === 'id-pausemenu-mission-panel');
    }
    function Init(srcText) {
        function _msg(text) {
        }
        _msg("Init");
        m_oMissionData = MissionsAPI.GetRecurringMission(!IsTheInGamePanel());
        if (IsThePauseMenuPanel()) {
            if (MissionsAPI.GetRecurringMission(false)) {
                m_oMissionData = MissionsAPI.GetRecurringMission(false);
            }
        }
        if (!m_oMissionData) {
            _msg("no GetRecurringMissions()");
            $.GetContextPanel().AddClass('hidden');
            return;
        }
        if (IsTheInGamePanel()) {
            if (FriendsListAPI.IsGameInWarmup()) {
                _msg("warmup");
                $.GetContextPanel().AddClass('hidden');
                return;
            }
            if (GameStateAPI.GetMapBSPName() === 'lobby_mapveto') {
                _msg("lobby_mapveto");
                $.GetContextPanel().AddClass('hidden');
                return;
            }
            if (!GameStateAPI.GetActiveQuestID()) {
                _msg("NO QUEST ID");
                $.GetContextPanel().AddClass('hidden');
                return;
            }
            $.GetContextPanel().SetHasClass('stop-anims', m_oMissionData.progress_saved + m_livePointsCache >= m_oMissionData.goal_points.slice(-1)[0]);
            $.GetContextPanel().SetHasClass('COMPLETE', m_oMissionData.progress_saved + (m_oMissionData.progress_this_match ? m_oMissionData.progress_this_match : 0) >= m_oMissionData.goal_points.slice(-1)[0]);
        }
        else if (!IsTheInGamePanel()) {
            if (!MyPersonaAPI.IsConnectedToGC()) {
                _msg("no gc");
                $.GetContextPanel().AddClass('hidden');
                return;
            }
            let imagePath = 'undefined';
            if (m_oMissionData.hasOwnProperty('mapgroup') && m_oMissionData.mapgroup != '') {
                const cfg = GameTypesAPI.GetConfig();
                const mg = cfg.mapgroups[m_oMissionData['mapgroup']];
                const keysList = Object.keys(mg.maps);
                imagePath = keysList[0];
            }
            else if (m_oMissionData.hasOwnProperty('map') && m_oMissionData.map && m_oMissionData.map != '') {
                imagePath = m_oMissionData.map;
            }
            const elBgArt = $.GetContextPanel().FindChildTraverse('missionArtBG');
            if (elBgArt) {
                elBgArt.style.backgroundImage = 'url("file://{images}/map_icons/screenshots/720p/' + (imagePath) + '.png")';
            }
            SetButtonPlayMission();
            SessionUpdate();
            $.GetContextPanel().SetHasClass('COMPLETE', m_oMissionData.progress_saved >= m_oMissionData.goal_points.slice(-1)[0]);
        }
        if (IsTheInGamePanel() || IsThePauseMenuPanel()) {
            if (m_oMissionData.progress_this_match && m_oMissionData.progress_this_match > m_livePointsCache) {
                $.GetContextPanel().TriggerClass('progress-pulse');
                m_livePointsCache = m_oMissionData.progress_this_match;
                $.DispatchEvent('CSGOPlaySoundEffect', 'UI.Mission.QuotaUp', 'MOUSE');
                _msg('progress new ' + m_oMissionData.progress_this_match + " saved ts  " + m_livePointsCache);
                _msg('PULSE');
            }
        }
        $.GetContextPanel().RemoveClass('hidden');
        ConstructMissionStrings($.GetContextPanel());
        UpdateProgressBar();
    }
    MissionTile.Init = Init;
    function SetButtonPlayMission() {
        if (!GetButtonPanel())
            return;
        GetButtonPanel().SetPanelEvent("onactivate", () => PlayMission());
    }
    function SetButtonCancelSearch() {
        if (!GetButtonPanel())
            return;
        GetButtonPanel().SetPanelEvent("onactivate", () => LobbyAPI.StopMatchmaking());
    }
    function SetButtonEnabled(enabled) {
        if (!GetButtonPanel())
            return;
        GetButtonPanel().enabled = enabled;
        GetButtonPanel().SetHasClass('DISABLED', !enabled);
    }
    function GetButtonPanel() {
        return $.GetContextPanel().FindChildTraverse('missionButton');
    }
    function GetToolTip(elPanel) {
        return elPanel.Data().missionText;
    }
    MissionTile.GetToolTip = GetToolTip;
    function ConstructMissionStrings(elPanel) {
        if (IsTheInGamePanel() || IsThePauseMenuPanel()) {
            let total = m_oMissionData.progress_saved + (m_oMissionData.progress_this_match ? m_oMissionData.progress_this_match : 0);
            total = Math.min(total, m_oMissionData.goal_points.slice(-1)[0]);
            elPanel.SetDialogVariableInt("mission-progress", total);
        }
        else {
            elPanel.SetDialogVariableInt("mission-progress", m_oMissionData.progress_saved);
        }
        elPanel.SetDialogVariableInt("mission-points", m_oMissionData.goal_points.slice(-1)[0]);
        elPanel.SetDialogVariableInt("mission-xp", Number(m_oMissionData.xp_reward.slice(-1)[0]));
        const timeRemaining = FormatText.SecondsToSignificantTimeString(m_oMissionData.seconds_remaining);
        elPanel.SetDialogVariable('mission-time-remaining', timeRemaining);
        elPanel.SetHasClass('hide-time', m_oMissionData.seconds_remaining <= 0);
        ExtractStringTokens(elPanel, m_oMissionData.string_tokens);
        const desc = $.Localize(m_oMissionData.loc_description, elPanel);
        elPanel.SetDialogVariable('mission_desc', desc);
        const partialToken = m_oMissionData.loc_description.replace("desc", "partial");
        const partial = $.Localize(partialToken, elPanel);
        elPanel.SetDialogVariable('mission_partial', partial);
        const ingameToken = m_oMissionData.loc_description.replace("desc", "ingame");
        const ingame = $.Localize(ingameToken, elPanel);
        elPanel.SetDialogVariable('mission_ingame', ingame);
    }
    function ExtractStringTokens(elPanel, strings) {
        for (const k in strings) {
            if (typeof strings[k] === 'object' && !Array.isArray(strings[k]) && strings[k] !== null) {
                ExtractStringTokens(elPanel, strings[k]);
            }
            else {
                let val = strings[k];
                val = $.Localize(val);
                switch (k) {
                    case 'gamemode':
                    case 'location':
                    case 'actions':
                    case 'action':
                        val = val.toUpperCase();
                }
                elPanel.SetDialogVariable(k, val);
            }
        }
    }
    function UpdateProgressBar() {
        function _msg(text) {
        }
        const elProg = $.GetContextPanel().FindChildTraverse('mission-progress');
        if (!elProg)
            return;
        const saved = m_oMissionData.progress_saved / m_oMissionData.goal_points.slice(-1)[0];
        elProg.min = 0;
        elProg.max = 1.0;
        elProg.value = saved;
        if (IsTheInGamePanel() || IsThePauseMenuPanel()) {
            const elProgLive = $.GetContextPanel().FindChildTraverse('mission-progress--live');
            if (!elProgLive)
                return;
            elProgLive.min = 0;
            elProgLive.max = 1.0;
            elProgLive.value = m_oMissionData.progress_this_match ? (saved + m_oMissionData.progress_this_match / m_oMissionData.goal_points.slice(-1)[0]) : 0;
        }
        _msg(m_oMissionData.progress_saved + ' ' + m_oMissionData.progress_this_match);
    }
    function GetSearchStatus() {
        return LobbyAPI.GetMatchmakingStatusString();
    }
    ;
    function IsSearching() {
        let StatusString = GetSearchStatus();
        return (StatusString !== '' && StatusString !== null) ? true : false;
    }
    function SessionUpdate() {
        if (IsTheInGamePanel() || IsThePauseMenuPanel())
            return;
        if (!m_oMissionData || !m_oMissionData.gamemode) {
            m_oMissionData = MissionsAPI.GetRecurringMission();
        }
        if (!m_oMissionData) {
            $.GetContextPanel().AddClass('hidden');
            return;
        }
        const xuid = MyPersonaAPI.GetXuid();
        const inParty = PartyListAPI.GetCount() > 1;
        const isLobbyLeader = LobbyAPI.GetHostSteamID() === xuid;
        let isSearchingForMission = false;
        const lobbySettings = LobbyAPI.GetSessionSettings();
        if (IsSearching() && lobbySettings && lobbySettings.game) {
            isSearchingForMission = lobbySettings.game.mode == m_oMissionData.gamemode &&
                (lobbySettings.game.mapgroupname == m_oMissionData.mapgroup ||
                    lobbySettings.game.map == m_oMissionData.map);
        }
        GetButtonPanel().SetHasClass('LOBBY_SUB', inParty && !isLobbyLeader);
        $.GetContextPanel().SetHasClass('SEARCHING', IsSearching());
        $.GetContextPanel().SetHasClass('SEARCHING_FOR_MISSION', isSearchingForMission);
        SetButtonEnabled((!inParty || (inParty && isLobbyLeader)) && !(IsSearching() && !isSearchingForMission));
        if (isSearchingForMission) {
            SetButtonCancelSearch();
        }
        else {
            SetButtonPlayMission();
        }
    }
    function PlayMission() {
        $.DispatchEvent('PlayMenu_SwitchGameModeTab', m_oMissionData.gamemode);
        LobbyAPI.CreateSession();
        const gameMode = m_oMissionData.gamemode;
        let gameType = "classic";
        let gmFlags = 0;
        if (gameMode === "deathmatch") {
            gameType = "gungame";
            gmFlags = 32;
        }
        let mg = m_oMissionData.mapgroup;
        if (gameMode == "competitive") {
            mg = "mg_" + m_oMissionData.map;
            gmFlags = 16;
        }
        var settings = {
            update: {
                Options: {
                    action: "custommatch",
                    server: "official"
                },
                Game: {
                    mode: gameMode,
                    type: gameType,
                    mapgroupname: mg,
                    map: m_oMissionData.map ? m_oMissionData.map : "",
                    questid: 0,
                    gamemodeflags: gmFlags,
                },
            },
            delete: {
                Options: {
                    challengekey: 1
                }
            }
        };
        LobbyAPI.UpdateSessionSettings(settings);
        LobbyAPI.StartMatchmaking('', '', '', '');
    }
    function OnRecurringMissionsReceived() { Init('OnRecurringMissionsReceived'); }
    function OnRecurringMissionsChanged() { Init('OnRecurringMissionsChanged'); }
    function PanoramaComponent_MyPersona_UpdateConnectionToGC() { Init('PanoramaComponent_MyPersona_UpdateConnectionToGC'); }
    function PanoramaComponent_MyPersona_GcLogonNotificationReceived() { Init('PanoramaComponent_MyPersona_GcLogonNotificationReceived'); }
    function OnQuestProgressMade() { Init('OnQuestProgressMade'); }
    function GameState_OnMatchStart() { Init('GameState_OnMatchStart'); }
    {
        $.RegisterForUnhandledEvent('OnRecurringMissionsReceived', OnRecurringMissionsReceived);
        $.RegisterForUnhandledEvent('OnRecurringMissionsChanged', OnRecurringMissionsChanged);
        $.RegisterForUnhandledEvent("GameState_OnMatchStart", GameState_OnMatchStart);
        $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_UpdateConnectionToGC', PanoramaComponent_MyPersona_UpdateConnectionToGC);
        $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_GcLogonNotificationReceived', PanoramaComponent_MyPersona_GcLogonNotificationReceived);
        $.RegisterForUnhandledEvent("CSGOShowPauseMenu", Init.bind(null, "CSGOShowPauseMenu"));
        $.RegisterForUnhandledEvent('OnQuestProgressMade', OnQuestProgressMade);
        $.RegisterForUnhandledEvent('PanoramaComponent_Lobby_MatchmakingSessionUpdate', SessionUpdate);
    }
})(MissionTile || (MissionTile = {}));
