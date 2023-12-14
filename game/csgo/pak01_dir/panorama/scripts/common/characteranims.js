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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY2hhcmFjdGVyYW5pbXMuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9jb21tb24vY2hhcmFjdGVyYW5pbXMudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUNyQyxvQ0FBb0M7QUFvQnBDLElBQUksY0FBYyxHQUFHLENBQUU7SUFJdEIsU0FBUyxrQkFBa0IsQ0FBRyxJQUFxQixFQUFFLFNBQWtCLEtBQUs7UUFFM0UsSUFBSSxHQUFHLE1BQU0sQ0FBRSxJQUFJLENBQUUsQ0FBQyxXQUFXLEVBQUUsQ0FBQztRQUVwQyxRQUFTLElBQUksRUFDYjtZQUNDLEtBQUssR0FBRyxDQUFDO1lBQ1QsS0FBSyxHQUFHLENBQUM7WUFDVCxLQUFLLFdBQVcsQ0FBQztZQUNqQixLQUFLLFFBQVE7Z0JBRVosT0FBTyxNQUFNLENBQUMsQ0FBQyxDQUFDLEdBQUcsQ0FBQyxDQUFDLENBQUMsV0FBVyxDQUFDO1lBRW5DLEtBQUssR0FBRyxDQUFDO1lBQ1QsS0FBSyxJQUFJLENBQUM7WUFDVixLQUFLLG1CQUFtQixDQUFDO1lBQ3pCLEtBQUssU0FBUztnQkFDYixPQUFPLElBQUksQ0FBQztZQUViO2dCQUNDLE9BQU8sRUFBRSxDQUFDO1NBQ1g7SUFDRixDQUFDO0lBRUQsU0FBUyxhQUFhLENBQUcsSUFBWTtRQUVwQyxJQUFJLEdBQUcsSUFBSSxDQUFDLFdBQVcsRUFBRSxDQUFDO1FBRTFCLFFBQVMsSUFBSSxFQUNiO1lBQ0MsS0FBSyxHQUFHLENBQUM7WUFDVCxLQUFLLEdBQUcsQ0FBQztZQUNULEtBQUssV0FBVyxDQUFDO1lBQ2pCLEtBQUssUUFBUTtnQkFFWixPQUFPLEdBQUcsQ0FBQztZQUVaLEtBQUssR0FBRyxDQUFDO1lBQ1QsS0FBSyxJQUFJLENBQUM7WUFDVixLQUFLLG1CQUFtQixDQUFDO1lBQ3pCLEtBQUssU0FBUztnQkFDYixPQUFPLElBQUksQ0FBQztZ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