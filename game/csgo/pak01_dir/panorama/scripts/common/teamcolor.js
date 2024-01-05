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
