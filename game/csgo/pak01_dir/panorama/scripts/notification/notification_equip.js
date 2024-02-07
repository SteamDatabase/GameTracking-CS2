"use strict";
/// <reference path="../csgo.d.ts" />
var EquipNotification;
(function (EquipNotification) {
    function ShowEquipNotification(elPanel, slot, itemId) {
        if (!elPanel || !InventoryAPI.IsItemInfoValid(itemId))
            return;
        if (elPanel.BHasClass('show')) {
            elPanel.RemoveClass('show');
        }
        if (itemId === '0') {
            DisplayNotification(elPanel, itemId, '');
            return;
        }
        let team = '';
        let teamsList = ['ct', 't', 'noteam'];
        for (let i = 0; i < teamsList.length; i++) {
            itemId = (itemId === '0') ? LoadoutAPI.GetDefaultItem(teamsList[i], slot) : itemId;
            let teamsEquippedList = WhatTeamIsDefaultItemEquippedFor(itemId, teamsList);
            if (teamsEquippedList.length > 0) {
                team = (teamsEquippedList.length > 1) ? 'bothteams' : teamsEquippedList[0];
                break;
            }
        }
        DisplayNotification(elPanel, itemId, team);
    }
    EquipNotification.ShowEquipNotification = ShowEquipNotification;
    function DisplayNotification(elPanel, itemId, team) {
        let descText = '';
        if (itemId === '0') {
            descText = $.Localize('#inv_unequipp_item');
        }
        else {
            descText = MakeDescString(elPanel, itemId, team);
        }
        let elLabel = elPanel.FindChildInLayoutFile('InvNotificationLabel');
        elLabel.text = descText;
        elPanel.AddClass('show');
    }
    function WhatTeamIsDefaultItemEquippedFor(itemId, teamsList) {
        return teamsList.filter(team => InventoryAPI.IsEquipped(itemId, team));
    }
    function MakeDescString(elPanel, id, team) {
        let rarityColor = InventoryAPI.GetItemRarityColor(id);
        let itemName = '<font color="' + rarityColor + '">' + InventoryAPI.GetItemName(id) + '</font>';
        elPanel.SetDialogVariable('name', itemName);
        if (team === 'noteam') {
            return $.Localize('#inv_equipped_item_noteam', elPanel);
        }
        else {
            let hintString = '';
            if (team === 'bothteams') {
                hintString = '#inv_team_both';
            }
            else {
                hintString = '#SFUI_InvUse_Equipped_' + team;
            }
            elPanel.SetDialogVariable('team', $.Localize(hintString));
            return $.Localize('#inv_equipped_item', elPanel);
        }
    }
})(EquipNotification || (EquipNotification = {}));
