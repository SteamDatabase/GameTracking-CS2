"use strict";
/// <reference path="../csgo.d.ts" />
var IconUtil = (function () {
    const _SetPNGImageFallback = function (mapIconDetails, icon_image_path) {
        if (mapIconDetails.m_type == 'svg') {
            mapIconDetails.m_type = 'png';
            mapIconDetails.m_icon.SetImage(icon_image_path + '.png');
        }
        else {
            mapIconDetails.m_icon.SetImage('file://{images}/map_icons/map_icon_NONE.png');
        }
    };
    const _SetupFallbackMapIcon = function (elIconPanel, icon_image_path) {
        const mapIconDetails = { m_icon: elIconPanel, m_type: 'svg', m_handler: -1 };
        $.RegisterEventHandler('ImageFailedLoad', elIconPanel, () => _SetPNGImageFallback(mapIconDetails, icon_image_path));
    };
    return {
        SetupFallbackMapIcon: _SetupFallbackMapIcon
    };
})();
