"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../generated/items_event_current_generated_store.d.ts" />
/// <reference path="../generated/items_event_current_generated_store.ts" />
var PopupTournamentTeamsList;
(function (PopupTournamentTeamsList) {
    function Init() {
        let journalId = $.GetContextPanel().GetAttributeString("journalid", '');
        let graffitis = [];
        g_ActiveTournamentTeams.forEach(team => { graffitis.push(team.stickerid_graffiti); });
        graffitis.push(g_ActiveTournamentInfo.stickerid_graffiti);
        graffitis.forEach(stickerid => {
            let itemid = ItemInfo.GetFauxItemIdForGraffiti(stickerid);
            let elTeam = $.CreatePanel("ItemImage", $.GetContextPanel().FindChildInLayoutFile('id-popup-tournament-teams'), 'graffiti_' + stickerid, {
                itemid: itemid,
                class: 'popup-tournament-select-spray-team'
            });
            elTeam.SetPanelEvent('onactivate', () => {
                InventoryAPI.SetItemAttributeValueAsync(journalId, "sticker slot 0 id", stickerid);
                LoadoutAPI.EquipItemInSlot('noteam', journalId, 'spray0');
                $.DispatchEvent('UIPopupButtonClicked', '');
            });
        });
    }
    PopupTournamentTeamsList.Init = Init;
    ;
})(PopupTournamentTeamsList || (PopupTournamentTeamsList = {}));
