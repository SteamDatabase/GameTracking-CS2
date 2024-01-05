"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="iteminfo.ts" />
var CharacterAnims = (function () {
    function _NormalizeTeamName(team, bShort = false) {
        team = String(team).toLowerCase();
        switch (team) {
            case '2':
            case 't':
            case 'terrorist':
            case 'team_t':
                return bShort ? 't' : 'terrorist';
            case '3':
            case 'ct':
            case 'counter-terrorist':
            case 'team_ct':
                return 'ct';
            default:
                return '';
        }
    }
    function _TeamForEquip(team) {
        team = team.toLowerCase();
        switch (team) {
            case '2':
            case 't':
            case 'terrorist':
            case 'team_t':
                return 't';
            case '3':
            case 'ct':
            case 'counter-terrorist':
            case 'team_ct':
                return 'ct';
            default:
                return '';
        }
    }
    const _PlayAnimsOnPanel = function (importedSettings, bDontStompModel = false, makeDeepCopy = true) {
        if (importedSettings === null) {
            return;
        }
        const settings = makeDeepCopy ? ItemInfo.DeepCopyVanityCharacterSettings(importedSettings) : importedSettings;
        if (!settings.team || settings.team == "")
            settings.team = 'ct';
        settings.team = _NormalizeTeamName(settings.team);
        if (settings.modelOverride) {
            settings.model = settings.modelOverride;
        }
        else {
            settings.model = ItemInfo.GetModelPlayer(settings.charItemId);
            if (!settings.model) {
                if (settings.team == 'ct')
                    settings.model = "models/player/ctm_sas.vmdl";
                else
                    settings.model = "models/player/tm_phoenix.vmdl";
            }
        }
        const wid = settings.weaponItemId;
        const playerPanel = settings.panel;
        _CancelScheduledAnim(playerPanel);
        _ResetLastRandomAnimHandle(playerPanel);
        if (settings.manifest)
            playerPanel.SetScene(settings.manifest, settings.model, false);
        if (!bDontStompModel) {
            playerPanel.SetPlayerCharacterItemID(settings.charItemId);
            playerPanel.SetPlayerModel(settings.model);
        }
        playerPanel.EquipPlayerWithItem(wid);
        playerPanel.EquipPlayerWithItem(settings.glovesItemId);
        if (settings.cheer != null) {
            playerPanel.ApplyCheer(settings.cheer);
        }
        let cam = 1;
        if (settings.cameraPreset != null) {
            cam = settings.cameraPreset;
        }
    };
    const _CancelScheduledAnim = function (playerPanel) {
        if (playerPanel.Data().handle) {
            $.CancelScheduled(playerPanel.Data().handle);
            playerPanel.Data().handle = null;
        }
    };
    const _ResetLastRandomAnimHandle = function (playerPanel) {
        if (playerPanel.Data().lastRandomAnim !== -1) {
            playerPanel.Data().lastRandomAnim = -1;
        }
    };
    const _GetValidCharacterModels = function (bUniquePerTeamModelsOnly) {
        InventoryAPI.SetInventorySortAndFilters('inv_sort_rarity', false, 'customplayer', '', '');
        const count = InventoryAPI.GetInventoryCount();
        const itemsList = [];
        const uniqueTracker = {};
        for (let i = 0; i < count; i++) {
            const itemId = InventoryAPI.GetInventoryItemIDByIndex(i);
            const modelplayer = ItemInfo.GetModelPlayer(itemId);
            if (!modelplayer)
                continue;
            const team = (ItemInfo.GetTeam(itemId).search('Team_T') === -1) ? 'ct' : 't';
            if (bUniquePerTeamModelsOnly) {
                if (uniqueTracker.hasOwnProperty(team + modelplayer))
                    continue;
                uniqueTracker[team + modelplayer] = 1;
            }
            const label = ItemInfo.GetName(itemId);
            const entry = {
                label: label,
                team: team,
                itemId: itemId
            };
            itemsList.push(entry);
        }
        return itemsList;
    };
    return {
        PlayAnimsOnPanel: _PlayAnimsOnPanel,
        CancelScheduledAnim: _CancelScheduledAnim,
        GetValidCharacterModels: _GetValidCharacterModels,
        NormalizeTeamName: _NormalizeTeamName
    };
})();
