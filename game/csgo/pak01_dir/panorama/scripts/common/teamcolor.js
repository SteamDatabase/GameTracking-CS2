"use strict";
/// <reference path="../csgo.d.ts" />
var TeamColor = (function () {
    const _GetColorString = function (color) {
        const list = color.split(' ');
        return list.join(',');
    };
    const colorRGB = [
        '100,100,100',
        _GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_1")),
        _GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_2")),
        _GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_3")),
        _GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_4")),
        _GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_5"))
    ];
    const _GetTeamColor = function (teamColorInx) {
        if (teamColorInx >= 0 && teamColorInx <= 4) {
            return colorRGB[teamColorInx + 1];
        }
        return colorRGB[0];
    };
    const _GetTeamColorLetter = function (teamColorInx) {
        if (teamColorInx == -1)
            return "";
        else if (teamColorInx == 0)
            return "B";
        else if (teamColorInx == 1)
            return "G";
        else if (teamColorInx == 2)
            return "Y";
        else if (teamColorInx == 3)
            return "O";
        else if (teamColorInx == 4)
            return "M";
        else if (teamColorInx == 10)
            return "<img src='target_skull.png' height='8'/>";
        return "";
    };
    return {
        GetTeamColor: _GetTeamColor,
        GetTeamColorLetter: _GetTeamColorLetter
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoidGVhbWNvbG9yLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvY29tbW9uL3RlYW1jb2xvci50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBRXJDLElBQUksU0FBUyxHQUFHLENBQUM7SUFFaEIsTUFBTSxlQUFlLEdBQUcsVUFBVyxLQUFhO1FBRS9DLE1BQU0sSUFBSSxHQUFHLEtBQUssQ0FBQyxLQUFLLENBQUMsR0FBRyxDQUFDLENBQUM7UUFDOUIsT0FBTyxJQUFJLENBQUMsSUFBSSxDQUFDLEdBQUcsQ0FBQyxDQUFDO0lBQ3ZCLENBQUMsQ0FBQTtJQUVELE1BQU0sUUFBUSxHQUFHO1FBQ2hCLGFBQWE7UUFDYixlQUFlLENBQUUsZ0JBQWdCLENBQUMsZ0JBQWdCLENBQUUscUJBQXFCLENBQUUsQ0FBQztRQUM1RSxlQUFlLENBQUUsZ0JBQWdCLENBQUMsZ0JBQWdCLENBQUUscUJBQXFCLENBQUUsQ0FBQztRQUM1RSxlQUFlLENBQUUsZ0JBQWdCLENBQUMsZ0JBQWdCLENBQUUscUJBQXFCLENBQUUsQ0FBQztRQUM1RSxlQUFlLENBQUUsZ0JBQWdCLENBQUMsZ0JBQWdCLENBQUUscUJBQXFCLENBQUUsQ0FBQztRQUM1RSxlQUFlLENBQUUsZ0JBQWdCLENBQUMsZ0JBQWdCLENBQUUscUJBQXFCLENBQUUsQ0FBQztLQUM1RSxDQUFBO0lBRUQsTUFBTSxhQUFhLEdBQUcsVUFBVyxZQUFvQjtRQUVwRCxJQUFLLFlBQVksSUFBSSxDQUFDLElBQUksWUFBWSxJQUFJLENBQUMsRUFDM0M7WUFDQyxPQUFPLFFBQVEsQ0FBRSxZQUFZLEdBQUcsQ0FBQyxDQUFFLENBQUM7U0FDcEM7UUFFRCxPQUFPLFFBQVEsQ0FBQyxDQUFDLENBQUMsQ0FBQztJQUNwQixDQUFDLENBQUE7SUFFRCxNQUFNLG1CQUFtQixHQUFHLFVBQVcsWUFBb0I7UUFFMUQsSUFBSyxZQUFZLElBQUksQ0FBQyxDQUFDO1lBQ3RCLE9BQU8sRUFBRSxDQUFDO2FBQ04sSUFBSyxZQUFZLElBQUksQ0FBQztZQUMxQixPQUFPLEdBQUcsQ0FBQzthQUNQLElBQUssWUFBWSxJQUFJLENBQUM7WUFDMUIsT0FBTyxHQUFHLENBQUM7YUFDUCxJQUFLLFlBQVksSUFBSSxDQUFDO1lBQzFCLE9BQU8sR0FBRyxDQUFDO2FBQ1AsSUFBSyxZQUFZLElBQUksQ0FBQztZQUMxQixPQUFPLEdBQUcsQ0FBQzthQUNQLElBQUssWUFBWSxJQUFJLENBQUM7WUFDMUIsT0FBTyxHQUFHLENBQUM7YUFDUCxJQUFLLFlBQVksSUFBSSxFQUFFO1lBQzNCLE9BQU8sMENBQTBDLENBQUM7UUFFbkQsT0FBTyxFQUFFLENBQUM7SUFtQ1gsQ0FBQyxDQUFBO0lBRUQsT0FBTztRQUNOLFlBQVksRUFBVSxhQUFhO1FBQ25DLGtCQUFrQixFQUFJLG1CQUFtQjtLQUN6QyxDQUFBO0FBQ0YsQ0FBQyxDQUFDLEVBQUUsQ0FBQSJ9