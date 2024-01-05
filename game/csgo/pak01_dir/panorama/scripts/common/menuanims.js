"use strict";
/// <reference path="../csgo.d.ts" />
function UpdateNavContentSelectionBar(btn, elSelectionBar) {
    const selectedBtn = $('#' + btn);
    const elContentNavBar = elSelectionBar.FindChildTraverse('JsContentNavBar');
    if (!selectedBtn) {
        elContentNavBar.style.position = '0px 0px 0px';
        return;
    }
    elContentNavBar.style.position = selectedBtn.actualxoffset + 'px 0px 0px';
    elContentNavBar.style.width = selectedBtn.contentwidth + 'px';
}
