"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/iteminfo.ts" />
var CanApplyHeader;
(function (CanApplyHeader) {
    let m_cP = $.GetContextPanel();
    function Init(oTitleSettings) {
        oTitleSettings.headerPanel.RemoveClass('hidden');
        _SetTitle(oTitleSettings);
        _SetUpDesc(oTitleSettings);
        _SetUpWarning(oTitleSettings);
    }
    CanApplyHeader.Init = Init;
    function _SetTitle(oTitleSettings) {
        if (oTitleSettings.type === 'sticker' && !oTitleSettings.isRemove) {
            let listStickers = ItemInfo.GetitemStickerList(oTitleSettings.itemId);
            m_cP.SetDialogVariableInt("sticker_count", listStickers.length + 1);
            m_cP.SetDialogVariableInt("max_stickers", 5);
            m_cP.SetDialogVariable("CanApplyTitle", $.Localize('#popup_can_sticker_button', m_cP));
            return;
        }
        let title = oTitleSettings.isRemove ? '#SFUI_InvContextMenu_can_stick_Wear_full_' + oTitleSettings.type : '#SFUI_InvContextMenu_stick_use_' + oTitleSettings.type;
        m_cP.SetDialogVariable("CanApplyTitle", $.Localize(title, m_cP));
    }
    function _SetUpDesc(oTitleSettings) {
        let currentName = InventoryAPI.GetItemNameUncustomized(oTitleSettings.itemId);
        m_cP.SetDialogVariable('tool_target_name', currentName);
        let desc = oTitleSettings.isRemove ? '#popup_can_stick_scrape_full_' + oTitleSettings.type : '#popup_can_stick_desc';
        m_cP.SetDialogVariable("CanApplyDesc", $.Localize(desc, m_cP));
    }
    function _SetUpWarning(oTitleSettings) {
        let elLabel = m_cP.FindChildInLayoutFile('id-can-apply-warning');
        if (oTitleSettings.isRemove && oTitleSettings.worktype == 'remove_keychain') {
            elLabel.visible = true;
            let numKeychainRemoveToolChargesRemaining = InventoryAPI.GetCacheTypeElementFieldByIndex('KeychainRemoveToolCharges', 0, 'charges');
            elLabel.SetDialogVariableInt('item_count', numKeychainRemoveToolChargesRemaining);
            elLabel.FindChildInLayoutFile('id-can-apply-warning-text').SetLocString('#Notify_KeychainRemoveTool_ChargesUseToRemove');
            return;
        }
        elLabel.visible = !oTitleSettings.isRemove;
        if (oTitleSettings.isRemove) {
            return;
        }
        let warningText = _GetWarningTradeRestricted(oTitleSettings.type, oTitleSettings.toolId, oTitleSettings.itemId);
        warningText = !warningText ? '#SFUI_InvUse_Warning_use_can_stick_' + oTitleSettings.type : warningText;
        if ((oTitleSettings.toolId && oTitleSettings.toolId.length == 19
            && oTitleSettings.toolId.startsWith('922323129721890'))
            || InventoryAPI.IsFauxItemID(oTitleSettings.toolId)) {
            warningText = '#SFUI_InvUse_Warning_use_can_stick_previewonly_' + oTitleSettings.type;
            let bPhantomDisplayItemCannotApply = true;
            m_cP.GetParent().SetHasClass('can_apply_previewonly_phantom_display', bPhantomDisplayItemCannotApply);
        }
        warningText = $.Localize(warningText, elLabel);
        m_cP.SetDialogVariable("CanApplyWarning", warningText);
    }
    function _GetWarningTradeRestricted(type, toolId, itemId) {
        let strSpecialWarning = '';
        let strSpecialParam = null;
        let bIsPerfectWorld = MyPersonaAPI.GetLauncherType() === "perfectworld" ? true : false;
        if (!bIsPerfectWorld) {
            if (InventoryAPI.IsMarketable(itemId)) {
                if (!InventoryAPI.IsPotentiallyMarketable(toolId)) {
                    strSpecialParam = String(InventoryAPI.GetItemAttributeValue(toolId, "tradable after date"));
                    if (strSpecialParam !== undefined && strSpecialParam !== null) {
                        strSpecialWarning = _GetSpecialWarningString(type, strSpecialParam, "marketrestricted");
                    }
                }
                else {
                    strSpecialWarning = _GetStickerMarketDateGreater(type, toolId, itemId);
                }
            }
        }
        else {
            strSpecialWarning = _GetStickerMarketDateGreater(type, toolId, itemId);
        }
        return strSpecialWarning;
    }
    function _GetStickerMarketDateGreater(type, toolId, itemId) {
        let rtTradableAfterSticker = InventoryAPI.GetItemAttributeValue(toolId, "{uint32}tradable after date");
        let rtTradableAfterWeapon = InventoryAPI.GetItemAttributeValue(itemId, "{uint32}tradable after date");
        if (rtTradableAfterSticker != undefined && rtTradableAfterSticker != null &&
            (rtTradableAfterWeapon == undefined || rtTradableAfterWeapon == null || rtTradableAfterSticker > rtTradableAfterWeapon)) {
            let strSpecialParam = null;
            strSpecialParam = String(InventoryAPI.GetItemAttributeValue(toolId, "tradable after date"));
            if (strSpecialParam != undefined && strSpecialParam != null) {
                return _GetSpecialWarningString(type, strSpecialParam, "traderestricted");
            }
        }
        return '';
    }
    function _GetSpecialWarningString(type, strSpecialParam, warningText) {
        let elLabel = m_cP.FindChildInLayoutFile('id-can-apply-warning');
        elLabel.SetDialogVariable('date', strSpecialParam);
        return "#popup_can_stick_warning_" + warningText + "_" + type;
    }
})(CanApplyHeader || (CanApplyHeader = {}));
