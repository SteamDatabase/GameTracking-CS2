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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY29udGV4dF9tZW51X21haW5tZW51X3Zhbml0eS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2NvbnRleHRfbWVudXMvY29udGV4dF9tZW51X21haW5tZW51X3Zhbml0eS50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBQ3JDLDhDQUE4QztBQUM5QyxvREFBb0Q7QUFFcEQsSUFBSSx5QkFBeUIsR0FBRyxDQUFFO0lBRWpDLFNBQVMsS0FBSztRQUViLElBQUksT0FBTyxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxrQkFBa0IsQ0FBRSxNQUFNLEVBQUUsRUFBRSxDQUFFLENBQUM7UUFDbkUsSUFBSSxJQUFJLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLGtCQUFrQixDQUFFLE1BQU0sRUFBRSxFQUFFLENBQUUsQ0FBQztRQUVoRSxJQUFLLE9BQU8sS0FBSyxVQUFVLEVBQzNCO1lBQ0MsV0FBVyxDQUFFLElBQUksQ0FBRSxDQUFDO1lBQ3BCLE9BQU87U0FDUDtRQUVELElBQUssT0FBTyxLQUFLLFNBQVMsRUFDMUI7WUFDQyxjQUFjLENBQUUsSUFBSSxDQUFFLENBQUM7WUFDdkIsT0FBTztTQUNQO1FBQ0QsV0FBVyxFQUFFLENBQUM7SUFDZixDQUFDO0lBR0QsU0FBUyx3QkFBd0IsQ0FBRyxRQUFlLEVBQUUsaUJBQXdCLEVBQUUsWUFBdUI7UUFFckcsSUFBSSx5QkFBeUIsR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsaUJBQWlCLENBQUUseUJBQXlCLENBQUUsQ0FBQztRQUNuRyxJQUFJLE1BQU0sR0FBRyxDQUFDLENBQUMsV0FBVyxDQUFFLFFBQVEsRUFBRSx5QkFBeUIsRUFBRSxRQUFRLENBQUUsQ0FBQztRQUM1RSxNQUFNLENBQUMsa0JBQWtCLENBQUUscUJBQXFCLENBQUUsQ0FBQztRQUNuRCxJQUFJLE9BQU8sR0FB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