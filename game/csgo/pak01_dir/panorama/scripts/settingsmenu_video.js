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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2V0dGluZ3NtZW51X3ZpZGVvLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvc2V0dGluZ3NtZW51X3ZpZGVvLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFDbEMsK0NBQStDO0FBRS9DLElBQVUsaUJBQWlCLENBd0MxQjtBQXhDRCxXQUFVLGlCQUFpQjtJQUV2QixTQUFnQix5QkFBeUI7UUFFckMsa0JBQWtCLENBQUMsMkJBQTJCLEVBQUUsQ0FBQztRQUNqRCxrQkFBa0IsQ0FBQyxNQUFNLENBQUUsZ0JBQWdCLEVBQUUsSUFBSSxDQUFFLENBQUM7UUFDcEQsa0JBQWtCLENBQUMsTUFBTSxDQUFFLGdCQUFnQixFQUFFLEtBQUssQ0FBRSxDQUFDO1FBQ3JELENBQUMsQ0FBRSwyQkFBMkIsQ0FBRyxDQUFDLE9BQU8sR0FBRyxJQUFJLENBQUM7UUFDakQsQ0FBQyxDQUFFLDZCQUE2QixDQUFHLENBQUMsT0FBTyxHQUFHLEtBQUssQ0FBQztJQUN4RCxDQUFDO0lBUGUsMkNBQXlCLDRCQU94QyxDQUFBO0lBRUQsU0FBZ0IsMkJBQTJCO1FBRXZDLGtCQUFrQixDQUFDLDJCQUEyQixFQUFFLENBQUM7UUFDakQsa0JBQWtCLENBQUMsTUFBTSxDQUFFLGdCQUFnQixFQUFFLEtBQUssQ0FBRSxDQUFDO1FBQ3JELGtCQUFrQixDQUFDLE1BQU0sQ0FBRSxnQkFBZ0IsRUFBRSxJQUFJLENBQUUsQ0FBQztRQUNwRCxDQUFDLENBQUUsMkJBQTJCLENBQUcsQ0FBQyxPQUFPLEdBQUcsS0FBSyxDQUFDO1FBQ2xELENBQUMsQ0FBRSw2QkFBNkIsQ0FBRyxDQUFDLE9BQU8sR0FBRyxJQUFJLENBQUM7SUFDdkQsQ0FBQztJQVBlLDZDQUEyQiw4QkFPMUMsQ0FBQTtJQUVELFNBQWdCLElBQUk7UUFFaEIsSUFBSSxNQUFNLEdBQUcsQ0FBQyxDQUFFLDhCQUE4QixDQUFnQyxDQUFDO1FBQy9FLElBQUksUUFBUSxHQUFHLGdCQUFnQixDQUFDLGNBQWMsQ0FBRSx5QkFBeUIsQ0FBRSxDQUFDO1FBQzVFLElBQUksS0FBSyxHQUFHLFFBQVEsQ0FBQyxjQUFjLENBQUM7UUFDcEMsS0FBSyxDQUFDLE9BQU8sQ0FBRSxHQUFHLENBQUMsRUFBRTtZQUVqQixJQUFJLENBQUMsR0FBRyxDQUFDLENBQUMsV0FBVyxDQUFFLE9BQU8sRUFBRSxNQUFNLEVBQUUsMEJBQTBCLEdBQUcsR0FBRyxFQUFFO2dCQUN0RSxJQUFJLEVBQUUsWUFBWSxHQUFHLEdBQUc7Z0JBQ3hCLEtBQUssRUFBRSxHQUFHO2FBQ2IsQ0FBRSxDQUFDO1lBQ0osTUFBTSxDQUFDLFNBQVMsQ0FBRSxDQUFDLENBQUUsQ0FBQztRQUMxQixDQUFDLENBQUUsQ0FBQztRQUNKLE1BQU0sQ0FBQyxjQUFjLEVBQUUsQ0FBQztJQUM1QixDQUFDO0lBZGUsc0JBQUksT0FjbkIsQ0FBQTtJQUVELFNBQWdCLG9CQUFvQjtRQUVoQyxZQUFZLENBQUMsdUNBQXVDLENBQUUsRUFBRSxFQUFFLCtEQUErRCxFQUFFLEdBQUcsRUFBRSxHQUFHLENBQUMsQ0FBRSxDQUFDO0lBQzNJLENBQUM7SUFIZSxzQ0FBb0IsdUJBR25DLENBQUE7QUFDTCxDQUFDLEVBeENTLGlCQUFpQixLQUFqQixpQkFBaUIsUUF3QzFCO0FBRUQsaUJBQWlCLENBQUMseUJBQXlCLEVBQUUsQ0FBQztBQUM5QyxpQkFBaUIsQ0FBQyxJQUFJLEVBQUUsQ0FBQyJ9