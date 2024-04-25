"use strict";
/// <reference path="../csgo.d.ts" />
var TooltipInventoryItem;
(function (TooltipInventoryItem) {
    function SetupTooltip() {
        let ctx = $.GetContextPanel();
        let id = ctx.GetAttributeString("itemid", "0");
        let bThisIsFauxItemID = InventoryAPI.IsFauxItemID(id);
        ctx.SetDialogVariable('name', InventoryAPI.GetItemNameUncustomized(id));
        const elCustomName = ctx.FindChildInLayoutFile('jsCustomName');
        if (elCustomName) {
            elCustomName.visible = InventoryAPI.HasCustomName(id);
            ctx.SetDialogVariable('custom-name', '"' + InventoryAPI.GetItemNameCustomized(id) + '"');
        }
        let strDesc = InventoryAPI.GetItemDescription(id, '');
        if (strDesc.endsWith('<br>')) {
            strDesc = strDesc.slice(0, -4);
        }
        ctx.SetDialogVariable('description', strDesc);
        let strSetName = InventoryAPI.GetTag(id, 'ItemSet');
        let elCollectionLogo = $('#CollectionLogo');
        if (strSetName && strSetName != '0') {
            ctx.AddClass('tooltip-inventory-item__has-set');
            elCollectionLogo.SetImage('file://{images}/econ/set_icons/' + strSetName + '_small.png');
            ctx.SetDialogVariable('collection', InventoryAPI.GetTagString(strSetName));
        }
        else {
            ctx.RemoveClass('tooltip-inventory-item__has-set');
            elCollectionLogo.SetImage('');
            ctx.SetDialogVariable('collection', '');
        }
        let rarity = InventoryAPI.GetItemRarity(id);
        let rarityName = InventoryAPI.GetItemType(id);
        if (rarityName) {
            ctx.AddClass('tooltip-inventory-item__has-rarity');
            ctx.SwitchClass('tooltip-rarity', 'tooltip-inventory-item__rarity-' + rarity);
            ctx.SetDialogVariable('rarity', rarityName);
        }
        else {
            ctx.RemoveClass('tooltip-inventory-item__has-rarity');
            ctx.SetDialogVariable('rarity', '');
        }
        let numWear = bThisIsFauxItemID ? undefined : InventoryAPI.GetWear(id);
        if (numWear != undefined && numWear >= 0) {
            ctx.AddClass('tooltip-inventory-item__has-grade');
            ctx.SetDialogVariable('grade', $.Localize('#SFUI_InvTooltip_Wear_Amount_' + numWear));
        }
        else {
            ctx.RemoveClass('tooltip-inventory-item__has-grade');
            ctx.SetDialogVariable('grade', '');
        }
        let strTeam = InventoryAPI.GetItemTeam(id);
        let strCategory = InventoryAPI.GetLoadoutCategory(id);
        if (!strCategory || strCategory === 'flair0' || strCategory === 'musickit' || strCategory === 'spray0') {
            strTeam = undefined;
        }
        if (strTeam) {
            ctx.AddClass('tooltip-inventory-item__has-team');
            ctx.SetDialogVariable('team', $.Localize(strTeam));
            let bAny = (strTeam == '#CSGO_Inventory_Team_Any');
            let bCT = bAny || (strTeam == '#CSGO_Inventory_Team_CT');
            let bT = bAny || (strTeam == '#CSGO_Inventory_Team_T');
            ctx.SetHasClass('tooltip-inventory-item__team-ct', bCT);
            ctx.SetHasClass('tooltip-inventory-item__team-t', bT);
        }
        else {
            ctx.RemoveClass('tooltip-inventory-item__has-team');
            ctx.RemoveClass('tooltip-inventory-item__team-ct');
            ctx.RemoveClass('tooltip-inventory-item__team-t');
        }
        if (GameInterfaceAPI.GetSettingString("cl_inventory_debug_tooltip") == "1") {
            let debugOutput = "<br />";
            function Print(string) {
                debugOutput += string + "<br />";
            }
            Print("--------------------------------------");
            Print("itemID: " + id);
            Print("--------------------------------------");
            let oTags = InventoryAPI.BuildItemTagsObject(id);
            for (let key of Object.keys(oTags)) {
                // @ts-ignore
                let tag = oTags[key];
                let cat = Object.keys(tag)[0];
                let val = tag[Object.keys(tag)[0]];
                Print(cat + ": " + val);
            }
            ctx.SetDialogVariable('description', debugOutput);
        }
    }
    TooltipInventoryItem.SetupTooltip = SetupTooltip;
})(TooltipInventoryItem || (TooltipInventoryItem = {}));
