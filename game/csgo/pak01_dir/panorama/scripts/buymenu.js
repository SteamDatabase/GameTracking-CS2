"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="mock_adapter.ts" />
var BuyMenu;
(function (BuyMenu) {
    let m_oldWeaponItemId;
    let _UpdateCharacter = function (team, weaponItemId, charItemId, bForceRefresh, bResetAgentAngles) {
        if ((weaponItemId == m_oldWeaponItemId) && !bForceRefresh) {
            return;
        }
        let elPreviewPanel = $.GetContextPanel().FindChildTraverse("id-buymenu-agent");
        if (!elPreviewPanel)
            return;
        if (!weaponItemId) {
            weaponItemId = MockAdapter.GetPlayerActiveWeaponItemId(MockAdapter.GetLocalPlayerXuid());
        }
        if (!team) {
            team = MockAdapter.GetPlayerTeamName(MockAdapter.GetLocalPlayerXuid());
        }
        let teamstring = CharacterAnims.NormalizeTeamName(team, true);
        let settings = ItemInfo.GetOrUpdateVanityCharacterSettings(LoadoutAPI.GetItemID(teamstring, 'customplayer'));
        settings.panel = elPreviewPanel;
        settings.team = teamstring;
        settings.cameraPreset = 18;
        settings.weaponItemId = weaponItemId;
        settings.charItemId = charItemId;
        if (settings.charItemId == '0' || settings.charItemId === LoadoutAPI.GetDefaultItem(teamstring, 'customplayer')) {
            settings.modelOverride = MockAdapter.GetPlayerModel(MockAdapter.GetLocalPlayerXuid());
        }
        CharacterAnims.PlayAnimsOnPanel(settings);
        m_oldWeaponItemId = weaponItemId;
    };
    $.RegisterForUnhandledEvent("BuyMenu_UpdateCharacter", _UpdateCharacter);
})(BuyMenu || (BuyMenu = {}));
