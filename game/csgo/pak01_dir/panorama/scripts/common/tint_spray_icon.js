"use strict";
/// <reference path="../csgo.d.ts" />
var TintSprayIcon = (function () {
    const _Tint = function (itemId, elImage) {
        if (InventoryAPI.DoesItemMatchDefinitionByName(itemId, 'spraypaint') || InventoryAPI.DoesItemMatchDefinitionByName(itemId, 'spray')) {
            const colorTint = InventoryAPI.GetSprayTintColorCode(itemId);
            if (colorTint) {
                elImage.style.washColor = colorTint.toString();
            }
            else {
                elImage.style.washColor = 'none';
            }
        }
        else {
            elImage.style.washColor = 'none';
        }
    };
    return {
        CheckIsSprayAndTint: _Tint
    };
})();
