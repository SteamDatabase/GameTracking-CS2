"use strict";
/// <reference path="..\csgo.d.ts" />
var LeaderboardNameLock;
(function (LeaderboardNameLock) {
    let m_timeoutHandler;
    function Init() {
        $.GetContextPanel().SetDialogVariable('profile-name', MyPersonaAPI.GetName());
    }
    LeaderboardNameLock.Init = Init;
    function Submit() {
        let entry = $('#TextEntry').text;
        LeaderboardsAPI.SetLocalPlayerLeaderboardSafeName(entry);
        m_timeoutHandler = $.Schedule(15, function () {
            UiToolkitAPI.ShowGenericPopup('Generic', $.Localize('#leaderboard_namelock_submission_timeout'), '');
            $.DispatchEvent('UIPopupButtonClicked', '');
        });
        $.GetContextPanel().FindChildrenWithClassTraverse('button').forEach(element => element.enabled = false);
        $.GetContextPanel().AddClass('submitted');
    }
    LeaderboardNameLock.Submit = Submit;
    function _Validate() {
        if ($('#submit') === null)
            return;
        let entry = $('#TextEntry').text;
        let bSuccess = LeaderboardsAPI.PrefilterLeaderboardSafeName(entry);
        $.GetContextPanel().SetHasClass('results-panel-valid', bSuccess);
    }
    function Cancel() {
        $.DispatchEvent('UIPopupButtonClicked', '');
    }
    LeaderboardNameLock.Cancel = Cancel;
    function Success() {
        if (m_timeoutHandler) {
            $.CancelScheduled(m_timeoutHandler);
        }
        UiToolkitAPI.ShowGenericPopup('Generic', $.Localize('#leaderboard_namelock_submission_success'), '');
        $.DispatchEvent('UIPopupButtonClicked', '');
    }
    LeaderboardNameLock.Success = Success;
    function OpenProfile() {
        SteamOverlayAPI.ShowUserProfilePage(MyPersonaAPI.GetXuid());
        $.DispatchEvent('ContextMenuEvent', '');
    }
    LeaderboardNameLock.OpenProfile = OpenProfile;
})(LeaderboardNameLock || (LeaderboardNameLock = {}));
(function () {
    $.RegisterForUnhandledEvent('PanoramaComponent_FriendsList_NameChanged', LeaderboardNameLock.Init);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_SetPlayerLeaderboardSafeName', LeaderboardNameLock.Success);
})();
