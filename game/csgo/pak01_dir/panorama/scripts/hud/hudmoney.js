"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../digitpanel.ts" />
var MoneyPanel;
(function (MoneyPanel) {
    $.RegisterEventHandler('UpdateHudMoney', $.GetContextPanel(), _UpdateMoney);
    function _UpdateMoney(amt, bInstant = false) {
        const elContainer = $('#jsRotaryMoney');
        if (elContainer) {
            if (!$('#DigitPanel'))
                DigitPanelFactory.MakeDigitPanel(elContainer, 6, '', 0.6, "#digitpanel_digits_hudmoney");
            DigitPanelFactory.SetDigitPanelString(elContainer, '$' + amt, bInstant);
        }
    }
})(MoneyPanel || (MoneyPanel = {}));
