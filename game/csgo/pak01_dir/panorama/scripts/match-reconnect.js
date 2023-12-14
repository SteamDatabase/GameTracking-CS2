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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWF0Y2gtcmVjb25uZWN0LmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvbWF0Y2gtcmVjb25uZWN0LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFFbEMsSUFBVSxvQkFBb0IsQ0FtRTdCO0FBbkVELFdBQVUsb0JBQW9CO0lBRTdCLE1BQU0sZ0JBQWdCLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDO0lBQzdDLElBQUksa0JBQWtCLEdBQUcsS0FBSyxDQUFDO0lBQy9CLElBQUksdUJBQXVCLEdBQUcsS0FBSyxDQUFDO0lBRXBDLFNBQWdCLElBQUk7UUFFbkIsTUFBTSxZQUFZLEdBQUcsZ0JBQWdCLENBQUMscUJBQXFCLENBQUUsc0JBQXNCLENBQUUsQ0FBQztRQUN0RixZQUFZLENBQUMsYUFBYSxDQUFFLFlBQVksRUFBRTtZQUV6QyxtQkFBbUIsQ0FBQyw2QkFBNkIsRUFBRSxDQUFDO1lBQ3BELENBQUMsQ0FBQyxhQUFhLENBQUUscUJBQXFCLEVBQUUsaUNBQWlDLEVBQUUsT0FBTyxDQUFFLENBQUM7WUFDckYsV0FBVyxFQUFFLENBQUM7UUFDZixDQUFDLENBQUUsQ0FBQztRQUVKLE1BQU0sVUFBVSxHQUFHLGdCQUFnQixDQUFDLHFCQUFxQixDQUFFLG9CQUFvQixDQUFFLENBQUM7UUFDbEYsVUFBVSxDQUFDLGFBQWEsQ0FBRSxZQUFZLEVBQUU7WUFFdkMsbUJBQW1CLENBQUMseUJBQXlCLEVBQUUsQ0FBQztZQUNoRCxDQUFDLENBQUMsYUFBYSxDQUFFLHFCQUFxQixFQUFFLGlDQUFpQyxFQUFFLE9BQU8sQ0FBRSxDQUFDO1lBQ3JGLFdBQVcsRUFBRSxDQUFDO1FBQ2YsQ0FBQyxDQUFFLENBQUM7UUFFSixNQUFNLFNBQVMsR0FBRyxnQkFBZ0IsQ0FBQyxxQkFBcUIsQ0FBRSxtQkFBbUIsQ0FBRSxDQUFDO1FBQ2hGLFNBQVMsQ0FBQyxhQUFhLENBQUUsWUFBWSxFQUFFO1lBRXRDLFFBQVEsQ0FBQyxlQUFlLEVBQUUsQ0FBQztZQUMzQixDQUFDLENBQUMsYUFBYSxDQUFFLHFCQUFxQixFQUFFLGlDQUFpQyxFQUFFLE9BQU8sQ0FBRSxDQUFDO1lBQ3JGLFdBQVcsRUFBRSxDQUFDO1FBQ2YsQ0FBQyxDQUFFLENBQUM7UUFFSixXQUFXLEVBQUUsQ0FBQztJQUNmLENBQUM7SUEzQmUseUJBQUksT0EyQm5CLENBQUE7SUFFRCxTQUFnQixXQUFXO1FBRTFCLE1BQU0sZ0JBQWdCLEdBQUcsbUJBQW1CLENBQUMsZUFBZSxFQUFFLENBQUM7UUFDL0QsSUFBSyxDQUFDLGdCQUFnQixFQUN0QjtZQUNDLHVCQUF1QixHQUFHLEtBQUssQ0FBQztTQUNoQztRQUNELE1BQU0sYUFBYSxHQUFHLGdCQUFnQixJQUFJLENBQUMsdUJBQXVCLENBQUM7UUFFbkUsTUFBTSxlQUFlLEdBQUcsUUFBUSxDQUFDLGtCQUFrQixFQUFTLENBQUM7UUFDN0QsTUFBTSxlQUFlLEdBQUcsZUFBZSxFQUFFLElBQUksRUFBRSxZQUFZLEtBQUssV0FBVyxDQUFDO1FBRTVFLGdCQUFnQixDQUFDLFdBQVcsQ0FBRSxjQUFjLEVBQUUsYUFBYSxJQUFJLENBQUMsZUFBZSxJQUFJLENBQUMsa0JBQWtCLENBQUUsQ0FBQztRQUN6RyxnQkFBZ0IsQ0FBQyxXQUFXLENBQUUsYUFBYSxFQUFFLGFBQWEsSUFBSSxlQUFlLElBQUksQ0FBQyxrQkFBa0IsQ0FBRSxDQUFDO0lBQ3hHLENBQUM7SUFkZSxnQ0FBVyxjQWMxQixDQUFBO0lBRUQsU0FBZ0IsZUFBZSxDQUFHLFVBQW1CO1FBRXBELGtCQUFrQixHQUFHLFVBQVUsQ0FBQztRQUNoQyxXQUFXLEVBQUUsQ0FBQztJQUNmLENBQUM7SUFKZSxvQ0FBZSxrQkFJOUIsQ0FBQTtJQUVELFNBQWdCLGlCQUFpQixDQUFHLFVBQWtCO1FBRXJELHVCQUF1QixHQUFHLFVBQVUsS0FBSyxDQUFDLENBQUM7UUFDM0MsV0FBVyxFQUFFLENBQUM7SUFDZixDQUFDO0lBSmUsc0NBQWlCLG9CQUloQyxDQUFBO0lBRUQsU0FBZ0Isb0JBQW9CLENBQUcsWUFBcUI7UUFFM0QsZ0JBQWdCLENBQUMsV0FBVyxDQUFFLG1CQUFtQixFQUFFLFlBQVksQ0FBRSxDQUFDO0lBQ25FLENBQUM7SUFIZSx5Q0FBb0IsdUJBR25DLENBQUE7QUFDRixDQUFDLEVBbkVTLG9CQUFvQixLQUFwQixvQkFBb0IsUUFtRTdCO0FBRUQsQ0FBRTtJQUVELG9CQUFvQixDQUFDLElBQUksRUFBRSxDQUFDO0lBRTVCLENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSxrREFBa0QsRUFBRSxvQkFBb0IsQ0FBQyxXQUFXLENBQUUsQ0FBQztJQUdwSCxDQUFDLENBQUMseUJBQXlCLENBQUUsNEJBQTRCLEVBQUUsb0JBQW9CLENBQUMsV0FBVyxDQUFFLENBQUM7SUFFOUYsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLHlDQUF5QyxFQUFFLG9CQUFvQixDQUFDLGVBQWUsQ0FBRSxDQUFDO0lBQy9HLENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSw2QkFBNkIsRUFBRSxvQkFBb0IsQ0FBQyxpQkFBaUIsQ0FBRSxDQUFDO0lBQ3JHLENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSxvQkFBb0IsRUFBRSxvQkFBb0IsQ0FBQyxvQkFBb0IsQ0FBRSxDQUFDO0FBQ2hHLENBQUMsQ0FBRSxFQUFFLENBQUMifQ==