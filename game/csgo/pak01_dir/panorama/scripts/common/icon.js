"use strict";
/// <reference path="../csgo.d.ts" />
var IconUtil;
(function (IconUtil) {
    function SetPNGImageFallback(mapIconDetails, icon_image_path) {
        if (mapIconDetails.m_type == 'svg') {
            mapIconDetails.m_type = 'png';
            mapIconDetails.m_icon.SetImage(icon_image_path + '.png');
        }
        else {
            mapIconDetails.m_icon.SetImage('file://{images}/map_icons/map_icon_NONE.png');
        }
    }
    function SetupFallbackMapIcon(elIconPanel, icon_image_path) {
        const mapIconDetails = { m_icon: elIconPanel, m_type: 'svg', m_handler: -1 };
        $.RegisterEventHandler('ImageFailedLoad', elIconPanel, () => SetPNGImageFallback(mapIconDetails, icon_image_path));
    }
    IconUtil.SetupFallbackMapIcon = SetupFallbackMapIcon;
})(IconUtil || (IconUtil = {}));
