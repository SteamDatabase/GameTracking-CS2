"use strict";
/// <reference path="csgo.d.ts" />
var MatchmakingReconnect;
(function (MatchmakingReconnect) {
    const m_elOngoingMatch = $.GetContextPanel();
    let m_bAcceptIsShowing = false;
    let m_bOngoingMatchHasEnded = false;
    function Init() {
        const btnReconnect = m_elOngoingMatch.FindChildInLayoutFile('MatchmakingReconnect');
        btnReconnect.SetPanelEvent('onactivate', function () {
            CompetitiveMatchAPI.ActionReconnectToOngoingMatch();
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE');
            UpdateState();
        });
        const btnAbandon = m_elOngoingMatch.FindChildInLayoutFile('MatchmakingAbandon');
        btnAbandon.SetPanelEvent('onactivate', function () {
            CompetitiveMatchAPI.ActionAbandonOngoingMatch();
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE');
            UpdateState();
        });
        const btnCancel = m_elOngoingMatch.FindChildInLayoutFile('MatchmakingCancel');
        btnCancel.SetPanelEvent('onactivate', function () {
            LobbyAPI.StopMatchmaking();
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE');
            UpdateState();
        });
        UpdateState();
    }
    MatchmakingReconnect.Init = Init;
    function UpdateState() {
        const bHasOngoingMatch = CompetitiveMatchAPI.HasOngoingMatch();
        if (!bHasOngoingMatch) {
            m_bOngoingMatchHasEnded = false;
        }
        const bCanReconnect = bHasOngoingMatch && !m_bOngoingMatchHasEnded;
        const sessionSettings = LobbyAPI.GetSessionSettings();
        const bIsReconnecting = sessionSettings?.game?.mapgroupname === "reconnect";
        m_elOngoingMatch.SetHasClass('show-actions', bCanReconnect && !bIsReconnecting && !m_bAcceptIsShowing);
        m_elOngoingMatch.SetHasClass('show-cancel', bCanReconnect && bIsReconnecting && !m_bAcceptIsShowing);
    }
    MatchmakingReconnect.UpdateState = UpdateState;
    function ReadyUpForMatch(shouldShow) {
        m_bAcceptIsShowing = shouldShow;
        UpdateState();
    }
    MatchmakingReconnect.ReadyUpForMatch = ReadyUpForMatch;
    function OnGamePhaseChange(nGamePhase) {
        m_bOngoingMatchHasEnded = nGamePhase === 5;
        UpdateState();
    }
    MatchmakingReconnect.OnGamePhaseChange = OnGamePhaseChange;
    function OnSidebarIsCollapsed(bIsCollapsed) {
        m_elOngoingMatch.SetHasClass('sidebar-collapsed', bIsCollapsed);
    }
    MatchmakingReconnect.OnSidebarIsCollapsed = OnSidebarIsCollapsed;
})(MatchmakingReconnect || (MatchmakingReconnect = {}));
(function () {
    MatchmakingReconnect.Init();
    $.RegisterForUnhandledEvent("PanoramaComponent_Lobby_MatchmakingSessionUpdate", MatchmakingReconnect.UpdateState);
    $.RegisterForUnhandledEvent('PanoramaComponent_GC_Hello', MatchmakingReconnect.UpdateState);
    $.RegisterForUnhandledEvent('PanoramaComponent_Lobby_ReadyUpForMatch', MatchmakingReconnect.ReadyUpForMatch);
    $.RegisterForUnhandledEvent('GameState_OnGamePhaseChange', MatchmakingReconnect.OnGamePhaseChange);
    $.RegisterForUnhandledEvent('SidebarIsCollapsed', MatchmakingReconnect.OnSidebarIsCollapsed);
})();
