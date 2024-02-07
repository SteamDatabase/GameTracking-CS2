"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/prime_button_action.ts" />
var PopupPrimeStatus;
(function (PopupPrimeStatus) {
    let m_btnPurchase = $('#PurchaseButton');
    function Init() {
        _SetStatusPanel(MyPersonaAPI.GetElevatedState());
    }
    PopupPrimeStatus.Init = Init;
    function _SetStatusPanel(strState) {
        if (strState !== "elevated") {
            m_btnPurchase.visible = true;
            PrimeButtonAction.SetUpPurchaseBtn(m_btnPurchase);
            return;
        }
        m_btnPurchase.visible = false;
    }
    function _UpdateEleveatedStatusPanel() {
        _SetStatusPanel(MyPersonaAPI.GetElevatedState());
    }
    $.RegisterForUnhandledEvent("PanoramaComponent_MyPersona_ElevatedStateUpdate", _UpdateEleveatedStatusPanel);
})(PopupPrimeStatus || (PopupPrimeStatus = {}));
