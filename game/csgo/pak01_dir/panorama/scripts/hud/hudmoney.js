"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../digitpanel.ts" />
var MoneyPanel;
(function (MoneyPanel) {
    $.RegisterEventHandler('UpdateHudMoney', $.GetContextPanel(), _UpdateMoney);
    function _UpdateMoney(amt, bInstant = false) {
        const elContainer = $('#jsRotaryMoney');
        if (elContainer) {
            if (!$('#DigitPanel')) {
                $.GetContextPanel().SetDialogVariableInt("money", 16000);
                const maxLen = $.Localize("#buymenu_money", $.GetContextPanel());
                DigitPanelFactory.MakeDigitPanel(elContainer, maxLen.length, '', 0.6, "#buymenu_money_digitpanel_digits");
            }
            $.GetContextPanel().SetDialogVariableInt("money", amt);
            const digitString = $.Localize("#buymenu_money", $.GetContextPanel());
            DigitPanelFactory.SetDigitPanelString(elContainer, digitString, bInstant);
        }
    }
})(MoneyPanel || (MoneyPanel = {}));
