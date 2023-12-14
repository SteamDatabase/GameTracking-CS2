"use strict";
/// <reference path="../csgo.d.ts" />
var WelcomeLaunch = (function () {
    function _OnOKPressed() {
        var strGoalVersion = $.GetContextPanel().GetAttributeString("uisettingversion", '');
        GameInterfaceAPI.SetSettingString('ui_popup_weaponupdate_version', strGoalVersion);
        $.DispatchEvent('UIPopupButtonClicked', '');
    }
    function _OnCancelPressed() {
        _OnOKPressed();
    }
    return {
        OnOKPressed: _OnOKPressed,
        OnCancelPressed: _OnCancelPressed
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfd2VsY29tZV9sYXVuY2guanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9wb3B1cHMvcG9wdXBfd2VsY29tZV9sYXVuY2gudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUVyQyxJQUFJLGFBQWEsR0FBRyxDQUFFO0lBRWxCLFNBQVMsWUFBWTtRQUVqQixJQUFJLGNBQWMsR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsa0JBQWtCLENBQUUsa0JBQWtCLEVBQUUsRUFBRSxDQUFFLENBQUM7UUFDdEYsZ0JBQWdCLENBQUMsZ0JBQWdCLENBQUUsK0JBQStCLEVBQUUsY0FBYyxDQUFFLENBQUM7UUFDckYsQ0FBQyxDQUFDLGFBQWEsQ0FBRSxzQkFBc0IsRUFBRSxFQUFFLENBQUUsQ0FBQztJQUNsRCxDQUFDO0lBRUQsU0FBUyxnQkFBZ0I7UUFFckIsWUFBWSxFQUFFLENBQUM7SUFDbkIsQ0FBQztJQUVELE9BQU87UUFFSCxXQUFXLEVBQUUsWUFBWTtRQUN6QixlQUFlLEVBQUUsZ0JBQWdCO0tBQ3BDLENBQUE7QUFFTCxDQUFDLENBQUUsRUFBRSxDQUFDIn0=