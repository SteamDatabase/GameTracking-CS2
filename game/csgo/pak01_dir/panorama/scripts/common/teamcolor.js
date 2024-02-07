"use strict";
/// <reference path="../csgo.d.ts" />
var TeamColor;
(function (TeamColor) {
    function GetColorString(color) {
        const list = color.split(' ');
        return list.join(',');
    }
    const colorRGB = [
        '100,100,100',
        GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_1")),
        GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_2")),
        GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_3")),
        GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_4")),
        GetColorString(GameInterfaceAPI.GetSettingString("cl_teammate_color_5"))
    ];
    function GetTeamColor(teamColorInx) {
        if (teamColorInx >= 0 && teamColorInx <= 4) {
            return colorRGB[teamColorInx + 1];
        }
        return colorRGB[0];
    }
    TeamColor.GetTeamColor = GetTeamColor;
})(TeamColor || (TeamColor = {}));
