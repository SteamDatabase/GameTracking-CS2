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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfbGVhZGVyYm9hcmRfbmFtZWxvY2suanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9wb3B1cHMvcG9wdXBfbGVhZGVyYm9hcmRfbmFtZWxvY2sudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUVyQyxJQUFVLG1CQUFtQixDQWtFNUI7QUFsRUQsV0FBVSxtQkFBbUI7SUFFNUIsSUFBSSxnQkFBeUIsQ0FBQztJQUU5QixTQUFnQixJQUFJO1FBSW5CLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxpQkFBaUIsQ0FBRSxjQUFjLEVBQUUsWUFBWSxDQUFDLE9BQU8sRUFBRSxDQUFFLENBQUE7SUFHaEYsQ0FBQztJQVBlLHdCQUFJLE9BT25CLENBQUE7SUFFRCxTQUFnQixNQUFNO1FBRXJCLElBQUksS0FBSyxHQUFLLENBQUMsQ0FBRSxZQUFZLENBQWUsQ0FBQyxJQUFJLENBQUM7UUFJbEQsZUFBZSxDQUFDLGlDQUFpQyxDQUFFLEtBQUssQ0FBRSxDQUFDO1FBRTNELGdCQUFnQixHQUFHLENBQUMsQ0FBQyxRQUFRLENBQUUsRUFBRSxFQUFFO1lBRWxDLFlBQVksQ0FBQyxnQkFBZ0IsQ0FBRSxTQUFTLEVBQUUsQ0FBQyxDQUFDLFFBQVEsQ0FBRSwwQ0FBMEMsQ0FBRSxFQUFFLEVBQUUsQ0FBRSxDQUFDO1lBQ3pHLENBQUMsQ0FBQyxhQUFhLENBQUUsc0JBQXNCLEVBQUUsRUFBRSxDQUFFLENBQUM7UUFDOUMsQ0FBQyxDQUFFLENBQUM7UUFFTCxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsNkJBQTZCLENBQUUsUUFBUSxDQUFFLENBQUMsT0FBTyxDQUFFLE9BQU8sQ0FBQyxFQUFFLENBQUMsT0FBTyxDQUFDLE9BQU8sR0FBRyxLQUFLLENBQUUsQ0FBQztRQUM1RyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsUUFBUSxDQUFFLFdBQVcsQ0FBRSxDQUFDO0lBQzdDLENBQUM7SUFoQmUsMEJBQU0sU0FnQnJCLENBQUE7SUFFRCxTQUFTLFNBQVM7UUFHakIsSUFBSSxDQUFDLENBQUMsU0FBUyxDQUFDLEtBQUssSUFBSTtZQUN4QixPQUFPO1FBRVIsSUFBSSxLQUFLLEdBQUksQ0FBQyxDQUFDLFlBQVksQ0FBYSxDQUFDLElBQUksQ0FBQztRQUM5QyxJQUFJLFFBQVEsR0FBRyxlQUFlLENBQUMsNEJBQTRCLENBQUMsS0FBSyxDQUFDLENBQUM7UUFFbkUsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLFdBQVcsQ0FBRSxxQkFBcUIsRUFBRSxRQUFRLENBQUUsQ0FBQztJQUNwRSxDQUFDO0lBRUQsU0FBZ0IsTUFBTTtRQUVyQixDQUFDLENBQUMsYUFBYSxDQUFFLHNCQUFzQixFQUFFLEVBQUUsQ0FBRSxDQUFDO0lBQy9DLENBQUM7SUFIZSwwQkFBTSxTQUdyQixDQUFBO0lBRUQsU0FBZ0IsT0FBTztRQUV0QixJQUFLLGdCQUFnQixFQUNyQjtZQUNDLENBQUMsQ0FBQyxlQUFlLENBQUUsZ0JBQWdCLENBQUUsQ0FBQztTQUN0QztRQUVELFlBQVksQ0FBQyxnQkFBZ0IsQ0FBRSxTQUFTLEVBQUUsQ0FBQyxDQUFDLFFBQVEsQ0FBQywwQ0FBMEMsQ0FBQyxFQUFFLEVBQUUsQ0FBRSxDQUFDO1FBRXZHLENBQUMsQ0FBQyxhQUFhLENBQUUsc0JBQXNCLEVBQUUsRUFBRSxDQUFFLENBQUM7SUFDL0MsQ0FBQztJQVZlLDJCQUFPLFVBVXRCLENBQUE7SUFFRCxTQUFnQixXQUFXO1FBRTFCLGVBQWUsQ0FBQyxtQkFBbUIsQ0FBRSxZQUFZLENBQUMsT0FBTyxFQUFFLENBQUUsQ0FBQztRQUM5RCxDQUFDLENBQUMsYUFBYSxDQUFFLGtCQUFrQixFQUFFLEVBQUUsQ0FBRSxDQUFDO0lBQzNDLENBQUM7SUFKZSwrQkFBVyxjQUkxQixDQUFBO0FBRUYsQ0FBQyxFQWxFUyxtQkFBbUIsS0FBbkIsbUJBQW1CLFFBa0U1QjtBQUtELENBQUU7SUFHRCxDQUFDLENBQUMseUJBQXlCLENBQUUsMkNBQTJDLEVBQUUsbUJBQW1CLENBQUMsSUFBSSxDQUFFLENBQUM7SUFDckcsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLDBEQUEwRCxFQUFFLG1CQUFtQixDQUFDLE9BQU8sQ0FBRSxDQUFDO0FBRXhILENBQUMsQ0FBRSxFQUFFLENBQUMifQ==