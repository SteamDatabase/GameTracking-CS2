"use strict";
/// <reference path="../csgo.d.ts" />
var InspectShared;
(function (InspectShared) {
    function GetPopupSetting(key, contextPanel = null) {
        let cp = !contextPanel ? $.GetContextPanel() : contextPanel;
        let oSettings = cp.Data().oSettings;
        if (oSettings) {
            const value = oSettings[key];
            return value === undefined ? false : value;
        }
        return false;
    }
    InspectShared.GetPopupSetting = GetPopupSetting;
    function SetPopupSetting(setting, value, contextPanel = null) {
        let cp = !contextPanel ? $.GetContextPanel() : contextPanel;
        let oSettings = cp.Data().oSettings;
        if (oSettings) {
            oSettings[setting] = value;
        }
    }
    InspectShared.SetPopupSetting = SetPopupSetting;
})(InspectShared || (InspectShared = {}));
