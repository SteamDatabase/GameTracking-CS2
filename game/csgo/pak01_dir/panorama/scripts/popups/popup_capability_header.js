"use strict";
/// <reference path="../csgo.d.ts" />
var CapabilityHeader;
(function (CapabilityHeader) {
    let m_bShowWarning = true;
    let m_strWarningText = '';
    let m_worktype = '';
    let m_storeItemid = '';
    let m_itemid = '';
    let m_itemtype = '';
    let m_ToolId = '';
    let m_showXrayMachineUi = false;
    let m_allowXrayClaim = false;
    let m_allowXrayPurchase = false;
    let m_inspectOnly = false;
    let m_allowRental = false;
    function Init(elPanel, itemId, funcGetSettingCallback) {
        m_itemid = itemId;
        m_worktype = funcGetSettingCallback("asyncworktype", "");
        m_storeItemid = funcGetSettingCallback("storeitemid", "");
        m_ToolId = funcGetSettingCallback("toolid", "");
        m_showXrayMachineUi = (funcGetSettingCallback("showXrayMachineUi", "no") === 'yes');
        m_allowXrayPurchase = (funcGetSettingCallback("allowxraypurchase", "no") === 'yes');
        m_allowXrayClaim = (funcGetSettingCallback("allowxrayclaim", "no") === 'yes');
        m_inspectOnly = (funcGetSettingCallback('inspectonly', 'false') === 'true');
        m_allowRental = (funcGetSettingCallback('allow-rent', 'no') === 'yes');
        if (!m_worktype && !m_storeItemid)
            return;
        if (m_itemid != undefined && m_itemid != null && m_itemid !== '') {
            let itemDefName = InventoryAPI.GetItemDefinitionName(m_itemid);
            if (m_worktype === 'decodeable') {
                if (itemDefName && itemDefName.indexOf("spray") != -1)
                    m_itemtype = "_graffiti";
                else if (itemDefName && itemDefName.indexOf("tournament_pass_") != -1)
                    m_itemtype = "_fantoken";
            }
            else if (m_worktype === 'useitem') {
                if (itemDefName && itemDefName.startsWith('Remove Keychain Tool'))
                    m_itemtype = "_getkeychaincharges";
            }
        }
        m_bShowWarning = (funcGetSettingCallback("asyncworkitemwarning", "yes") !== 'no');
        m_strWarningText = funcGetSettingCallback("asyncworkitemwarningtext", '');
        elPanel.RemoveClass('hidden');
        _SetDialogVariables(elPanel, itemId);
        _SetUpHeaders(elPanel);
    }
    CapabilityHeader.Init = Init;
    function _SetDialogVariables(elPanel, itemId) {
        elPanel.SetDialogVariable("itemname", InventoryAPI.GetItemNameUncustomized(itemId));
    }
    function _SetUpHeaders(elPanel) {
        _SetUpTitle(elPanel);
        _SetUpWarning(elPanel);
        _SetUpDesc(elPanel);
    }
    function _SetUpTitle(elPanel) {
        let elTitle = elPanel.FindChildInLayoutFile('CapabilityTitle');
        m_worktype = m_storeItemid ? 'purchase' : m_worktype;
        if (m_inspectOnly && m_worktype === 'decodeable') {
            elTitle.text = '#popup_cartpreview_title';
        }
        else if (m_showXrayMachineUi) {
            if (m_allowXrayPurchase || m_allowXrayClaim) {
                elTitle.text = "#popup_xray_claim_title";
            }
            else {
                elTitle.text = "#popup_xray_title";
            }
        }
        else if (m_worktype === 'decodeable' && InventoryAPI.GetDecodeableRestriction(m_itemid) === 'xray') {
            elTitle.text = '#popup_' + m_worktype + '_xray_title';
        }
        else if (!m_ToolId && m_worktype === 'decodeable') {
            elTitle.text = '#popup_totool_' + m_worktype + '_header' + m_itemtype;
        }
        else {
            let defName = InventoryAPI.GetItemDefinitionName(m_itemid);
            if (defName === 'casket' && m_worktype === 'nameable')
                elTitle.text = '#popup_newcasket_title';
            else
                elTitle.text = '#popup_' + m_worktype + '_title' + m_itemtype;
        }
    }
    function _SetUpWarning(elPanel) {
        let elWarn = elPanel.FindChildInLayoutFile('CapabilityWarning');
        let sWarnLocString = '';
        if (m_bShowWarning) {
            sWarnLocString = '#popup_' + m_worktype + '_warning' + m_itemtype;
        }
        if (m_worktype === 'decodeable') {
            let sRestriction = m_storeItemid ? '' : InventoryAPI.GetDecodeableRestriction(m_itemid);
            if ((sRestriction === 'restricted' && !m_allowRental) || (sRestriction === 'xray' && m_showXrayMachineUi)) {
                sWarnLocString = '#popup_' + m_worktype + '_err_' + sRestriction;
                elWarn.AddClass('popup-capability__error');
            }
        }
        if (m_strWarningText) {
            sWarnLocString = m_strWarningText;
        }
        elWarn.SetHasClass('hidden', sWarnLocString ? false : true);
        if (sWarnLocString) {
            let elWarnLabel = elWarn.FindChildInLayoutFile('CapabilityWarningLabel');
            elWarnLabel.text = sWarnLocString;
        }
    }
    function _SetUpDesc(elPanel) {
        let sDescString = '';
        if (m_worktype === 'decodeable' && m_inspectOnly) {
            sDescString = "#popup_preview_desc";
        }
        else if (m_showXrayMachineUi) {
            if (m_allowXrayClaim || m_allowXrayPurchase) {
                sDescString = "#popup_xray_claim_desc";
            }
            else {
                sDescString = '#popup_xray_desc';
            }
        }
        else if ((m_worktype === 'decodeable') && (InventoryAPI.GetDecodeableRestriction(m_itemid) === 'xray')) {
            sDescString = '#popup_' + m_worktype + '_xray_desc';
        }
        else {
            sDescString = '#popup_' + m_worktype + '_desc' + m_itemtype;
        }
        elPanel.FindChildInLayoutFile('CapabilityDesc').text = sDescString;
    }
})(CapabilityHeader || (CapabilityHeader = {}));
