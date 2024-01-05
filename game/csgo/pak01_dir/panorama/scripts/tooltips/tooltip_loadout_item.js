"use strict";
/// <reference path="../csgo.d.ts" />
function SetupTooltip() {
    var ctx = $.GetContextPanel();
    var id = ctx.GetAttributeString("itemid", "");
    var slot = ctx.GetAttributeString("slot", "");
    var team = ctx.GetAttributeString("team", "");
    var nameOnly = ctx.GetAttributeString("nameonly", "");
    ctx.SetDialogVariable('name', InventoryAPI.GetItemName(id));
    var color = InventoryAPI.GetItemRarityColor(id);
    if (color) {
        $.GetContextPanel().FindChildInLayoutFile('id-tooltip-layout-name').style.color = color;
    }
    else {
        $.GetContextPanel().FindChildInLayoutFile('id-tooltip-layout-name').style.color = 'white';
    }
    $.GetContextPanel().FindChildInLayoutFile('id-tooltip-layout-desc').visible = nameOnly === 'true';
    $.GetContextPanel().FindChildInLayoutFile('id-tooltip-layout-seperator').visible = nameOnly === 'true';
    if (nameOnly === 'true') {
        let defName = InventoryAPI.GetItemDefinitionName(id);
        defName = defName ? defName?.replace('weapon_', '') : '';
        ctx.SetDialogVariable('desc', $.Localize('#csgo_item_usage_desc_' + defName));
    }
}
