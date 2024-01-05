"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../common/characteranims.ts" />
var MainMenuVanityContextMenu = (function () {
    function _Init() {
        let strType = $.GetContextPanel().GetAttributeString("type", "");
        let team = $.GetContextPanel().GetAttributeString("team", "");
        if (strType === 'catagory') {
            MakeCatBtns(team);
            return;
        }
        if (strType === 'weapons') {
            MakeWeaponBtns(team);
            return;
        }
        MakeMapBtns();
    }
    function fnAddVanityPopupMenuItem(idString, strItemNameString, fnOnActivate) {
        let elContextMenuBodyNoScroll = $.GetContextPanel().FindChildTraverse('ContextMenuBodyNoScroll');
        let elItem = $.CreatePanel('Button', elContextMenuBodyNoScroll, idString);
        elItem.BLoadLayoutSnippet('snippet-vanity-item');
        let elLabel = elItem.FindChildTraverse('id-vanity-item__label');
        elLabel.text = $.Localize(strItemNameString);
        elItem.SetPanelEvent('onactivate', fnOnActivate);
        return elItem;
    }
    ;
    function MakeCatBtns(team) {
        let elContextMenuBodyNoScroll = $.GetContextPanel().FindChildTraverse('ContextMenuBodyNoScroll');
        elContextMenuBodyNoScroll.RemoveAndDeleteChildren();
        fnAddVanityPopupMenuItem('ChangeVanityMap', '#mainmenu_change_vanity_map', function () {
            const elVanityContextMenu = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('id-vanity-contextmenu-maps', '', 'file://{resources}/layout/context_menus/context_menu_mainmenu_vanity.xml', 'type=maps', function () { $.DispatchEvent('ContextMenuEvent', ''); });
            elVanityContextMenu.AddClass('ContextMenu_NoArrow');
        }).SetFocus();
        fnAddVanityPopupMenuItem('ChangeWeapon', '#mainmenu_change_vanity_weapon', function () {
            const elVanityContextMenu = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('id-vanity-contextmenu-weapons', '', 'file://{resources}/layout/context_menus/context_menu_mainmenu_vanity.xml', 'type=weapons' +
                '&' + 'team=' + team, function () { $.DispatchEvent('ContextMenuEvent', ''); });
            elVanityContextMenu.AddClass('ContextMenu_NoArrow');
        });
        let strOtherTeamToPrecache = ((team == '2') ? 'ct' : 't');
        fnAddVanityPopupMenuItem('switchTo_' + strOtherTeamToPrecache, '#mainmenu_switch_vanity_to_' + strOtherTeamToPrecache, function () {
            $.DispatchEvent("MainMenuSwitchVanity", strOtherTeamToPrecache);
            $.DispatchEvent('ContextMenuEvent', '');
        }).AddClass('BottomSeparator');
        fnAddVanityPopupMenuItem('GoToLoadout', '#mainmenu_go_to_character_loadout', function () {
            $.DispatchEvent("MainMenuGoToCharacterLoadout", team);
            $.DispatchEvent('ContextMenuEvent', '');
        });
        let otherTeamCharacterItemID = LoadoutAPI.GetItemID(strOtherTeamToPrecache, 'customplayer');
        let settingsForOtherTeam = ItemInfo.GetOrUpdateVanityCharacterSettings(otherTeamCharacterItemID);
        ItemInfo.PrecacheVanityCharacterSettings(settingsForOtherTeam);
    }
    ;
    function MakeWeaponBtns(team) {
        let elContextMenuBodyWeapons = $.GetContextPanel().FindChildTraverse('ContextMenuBodyWeapons');
        elContextMenuBodyWeapons.RemoveAndDeleteChildren();
        let list = ItemInfo.GetLoadoutWeapons(team);
        if (list && list.length > 0) {
            list.forEach(function ([loadoutSubSlot, weaponItemId]) {
                let elItem = $.CreatePanel('Button', elContextMenuBodyWeapons, weaponItemId);
                elItem.BLoadLayoutSnippet('snippet-vanity-item');
                elItem.AddClass('vanity-item--weapon');
                let elLabel = elItem.FindChildTraverse('id-vanity-item__label');
                elLabel.text = ItemInfo.GetName(weaponItemId);
                let elRarity = elItem.FindChildTraverse('id-vanity-item__rarity');
                let rarityColor = ItemInfo.GetRarityColor(weaponItemId);
                elRarity.style.backgroundColor = "gradient( linear, 0% 0%, 100% 0%, from(" + rarityColor + " ),  color-stop( 0.0125, #00000000 ), to( #00000000 ) );";
                elItem.SetPanelEvent('onactivate', function () {
                    let shortTeam = CharacterAnims.NormalizeTeamName(team, true);
                    GameInterfaceAPI.SetSettingString('ui_vanitysetting_loadoutslot_' + shortTeam, loadoutSubSlot);
                    $.DispatchEvent('ForceRestartVanity');
                    $.DispatchEvent('ContextMenuEvent', '');
                });
            });
        }
    }
    function MakeMapBtns() {
        let cvarInfo = GameInterfaceAPI.GetSettingInfo("ui_mainmenu_bkgnd_movie");
        let aMaps = cvarInfo.allowed_values;
        var elContextMenuBodyNoScroll = $.GetContextPanel().FindChildTraverse('ContextMenuBodyNoScroll');
        elContextMenuBodyNoScroll.RemoveAndDeleteChildren();
        aMaps.forEach(function (map) {
            fnAddVanityPopupMenuItem('context-menu-vanity-' + map, '#SFUI_Map_' + map, function () {
                GameInterfaceAPI.SetSettingString('ui_mainmenu_bkgnd_movie', map);
                $.DispatchEvent('ContextMenuEvent', '');
            });
        });
    }
    return {
        Init: _Init,
    };
})();
(function () {
})();
