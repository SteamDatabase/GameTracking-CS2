"use strict";
/// <reference path="csgo.d.ts" /> 
var PlayMenu_Workshop = (function () {
    function _Init() {
        WorkshopAPI.QueryUGCItemSubscriptions();
    }
    return {
        Init: _Init,
    };
})();
(function () {
    PlayMenu_Workshop.Init();
})();
