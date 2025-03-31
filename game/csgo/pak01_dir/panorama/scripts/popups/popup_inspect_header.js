"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/icon.ts" />
/// <reference path="../common/iteminfo.ts" />
var InspectHeader;
(function (InspectHeader) {
    let m_showXrayMachineUi = false;
    function Init(elPanel, itemId, funcGetSettingCallback) {
        m_showXrayMachineUi = (funcGetSettingCallback("showXrayMachineUi", "no") === 'yes') ? true : false;
        if (funcGetSettingCallback('inspectonly', 'false') === 'false' && !m_showXrayMachineUi)
            return;
        elPanel.RemoveClass('hidden');
        _SetName(elPanel, itemId, funcGetSettingCallback);
        _SetRarity(elPanel, itemId);
        _SetCollectionInfo(elPanel, itemId);
        _SetRentalTime(elPanel, itemId);
    }
    InspectHeader.Init = Init;
    function _SetName(elPanel, ItemId, funcGetSettingCallback) {
        let strViewFunc = funcGetSettingCallback ? funcGetSettingCallback('viewfunc', '') : '';
        if (ItemInfo.ItemDefinitionNameSubstrMatch(ItemId, 'tournament_journal_'))
            ItemId = (strViewFunc === 'primary') ? ItemId : ItemInfo.GetFauxReplacementItemID(ItemId, 'graffiti');
        elPanel.SetDialogVariable('item_name', InventoryAPI.GetItemNameUncustomized(ItemId));
        elPanel.SetDialogVariable('item_custom_name', InventoryAPI.GetItemNameCustomized(ItemId));
        const bShowCustomName = InventoryAPI.HasCustomName(ItemId);
        elPanel.FindChildInLayoutFile('InspectCustomName').visible = bShowCustomName;
        elPanel.FindChildInLayoutFile('InspectName').SetHasClass('text-align-left', ItemInfo.GetSet(ItemId) !== '');
    }
    function _SetRentalTime(elPanel, ItemId) {
        let elLabel = elPanel.FindChildInLayoutFile('ItemRentalTime');
        const expirationDate = InventoryAPI.IsRental(ItemId) ? InventoryAPI.GetExpirationDate(ItemId) : 0;
        const bHasExpirationDate = (expirationDate > 0);
        if (bHasExpirationDate) {
            let oLocData = FormatText.FormatRentalTime(expirationDate);
            elPanel.SetDialogVariable('time-remaining', oLocData.time);
            elLabel.RemoveClass('hide');
        }
        elLabel.SetHasClass('hide', !bHasExpirationDate);
    }
    function _SetRarity(elPanel, itemId) {
        let rarityColor = InventoryAPI.GetItemRarityColor(itemId);
        if (rarityColor) {
            elPanel.FindChildInLayoutFile('InspectBar').style.washColor = rarityColor;
        }
    }
    function _SetCollectionInfo(elPanel, itemId) {
        let setName = ItemInfo.GetSet(itemId);
        let elImage = elPanel.FindChildInLayoutFile('InspectSetImage');
        let elLabel = elPanel.FindChildInLayoutFile('InspectCollection');
        if (InventoryAPI.DoesItemMatchDefinitionByName(itemId, "Remove Keychain Tool")) {
            elImage.SetImage('file://{images}/icons/ui/keychain_removal.svg');
            elImage.visible = true;
            let numKeychainRemoveToolChargesRemaining = InventoryAPI.GetCacheTypeElementFieldByIndex('KeychainRemoveToolCharges', 0, 'charges');
            elLabel.SetDialogVariableInt('item_count', numKeychainRemoveToolChargesRemaining);
            elLabel.text = $.Localize('#Attrib_KeychainRemoveTool_Charges', elLabel);
            elLabel.visible = true;
            return;
        }
        if (setName === '') {
            elImage.visible = false;
            elLabel.visible = false;
            return;
        }
        elLabel.text = $.Localize('#CSGO_' + setName);
        elLabel.visible = true;
        IconUtil.SetupFallbackItemSetIcon(elImage, setName);
        IconUtil.SetItemSetSVGImage(elImage, setName);
        elImage.visible = true;
    }
})(InspectHeader || (InspectHeader = {}));
