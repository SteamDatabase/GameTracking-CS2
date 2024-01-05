"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="iteminfo.ts" />
/// <reference path="../generated/items_event_current_generated_store.ts" />
var ItemContextEntires = (function () {
    const _FilterEntries = function (populateFilterText) {
        const bHasFilter = populateFilterText !== "(not found)";
        return _Entries.filter(function (entry) {
            if (entry.exclusiveFilter) {
                return entry.exclusiveFilter.includes(populateFilterText);
            }
            else if (bHasFilter && entry.populateFilter) {
                return entry.populateFilter.includes(populateFilterText);
            }
            return !bHasFilter;
        });
    };
    const _Entries = [
        {
            name: 'preview',
            populateFilter: ['lootlist', 'loadout', 'loadout_slot_t', 'loadout_slot_ct', 'tradeup_items', 'tradeup_ingredients'],
            style: function (id) {
                return '';
            },
            AvailableForItem: function (id) {
                const defName = InventoryAPI.GetItemDefinitionName(id);
                if (defName === 'casket')
                    return InventoryAPI.GetItemAttributeValue(id, 'modification date') ? true : false;
                return ItemInfo.IsPreviewable(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                const defName = InventoryAPI.GetItemDefinitionName(id);
                if (defName === 'casket') {
                    if (InventoryAPI.GetItemAttributeValue(id, 'items count')) {
                        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_casket_operation.xml', 'op=loadcontents' +
                            '&nextcapability=casketcontents' +
                            '&spinner=1' +
                            '&casket_item_id=' + id +
                            '&subject_item_id=' + id);
                    }
                    else {
                        UiToolkitAPI.ShowGenericPopupOk($.Localize('#popup_casket_title_error_casket_empty'), $.Localize('#popup_casket_message_error_casket_empty'), '', function () {
                        });
                    }
                    return;
                }
                $.DispatchEvent("InventoryItemPreview", id);
            }
        },
        {
            name: 'bulkretrieve',
            populateFilter: ['loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: function (id) {
                const defName = InventoryAPI.GetItemDefinitionName(id);
                return (defName === 'casket') && !!InventoryAPI.GetItemAttributeValue(id, 'modification date');
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                const defName = InventoryAPI.GetItemDefinitionName(id);
                if (defName === 'casket') {
                    if (InventoryAPI.GetItemAttributeValue(id, 'items count')) {
                        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_casket_operation.xml', 'op=loadcontents' +
                            '&nextcapability=casketretrieve' +
                            '&spinner=1' +
                            '&casket_item_id=' + id +
                            '&subject_item_id=' + id);
                    }
                    else {
                        UiToolkitAPI.ShowGenericPopupOk($.Localize('#popup_casket_title_error_casket_empty'), $.Localize('#popup_casket_message_error_casket_empty'), '', function () {
                        });
                    }
                    return;
                }
            }
        },
        {
            name: 'bulkstore',
            populateFilter: ['loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            style: function (id) {
                return 'BottomSeparator';
            },
            AvailableForItem: function (id) {
                const defName = InventoryAPI.GetItemDefinitionName(id);
                return (defName === 'casket') && !!InventoryAPI.GetItemAttributeValue(id, 'modification date');
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                const defName = InventoryAPI.GetItemDefinitionName(id);
                if (defName === 'casket') {
                    $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'casketstore', id, '');
                }
            }
        },
        {
            name: 'view_tournament_journal',
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            betatype: ['fullversion'],
            style: function (id) {
                return '';
            },
            AvailableForItem: function (id) {
                return false;
                return (ItemInfo.ItemDefinitionNameSubstrMatch(id, 'tournament_journal_') &&
                    g_ActiveTournamentInfo.eventid == InventoryAPI.GetItemAttributeValue(id, "tournament event id"));
            },
            OnSelected: function (id) {
                UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_tournament_journal.xml', 'journalid=' + id);
                $.DispatchEvent('ContextMenuEvent', '');
            }
        },
        {
            name: 'openloadout',
            style: function (id) {
                return 'TopSeparator';
            },
            AvailableForItem: function (id) {
                return !!InventoryAPI.GetRawDefinitionKey(id, 'flexible_loadout_group');
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                $.DispatchEvent("ShowLoadoutForItem", id);
            }
        },
        {
            name: 'swap_finish_both',
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            style: function (id) {
                return '';
            },
            AvailableForItem: function (id) {
                return _CanSwapFinish(id, 'ct') && _CanSwapFinish(id, 't');
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                EquipItem(id, ['ct', 't']);
            }
        },
        {
            name: 'swap_finish_ct',
            CustomName: function (id) {
                return _GetItemToReplaceName(id, 'ct');
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            style: function (id) {
                return '';
            },
            AvailableForItem: function (id) {
                return _CanSwapFinish(id, 'ct');
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                EquipItem(id, ['ct']);
            }
        },
        {
            name: 'swap_finish_t',
            CustomName: function (id) {
                return _GetItemToReplaceName(id, 't');
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            style: function (id) {
                return '';
            },
            AvailableForItem: function (id) {
                return _CanSwapFinish(id, 't');
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                EquipItem(id, ['t']);
            }
        },
        {
            name: 'flair',
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: function (id) {
                return ItemInfo.GetDefaultSlot(id) === 'flair0' && (!ItemInfo.IsEquippedForNoTeam(id) || (InventoryAPI.GetRawDefinitionKey(id, 'item_sub_position2') !== ''));
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                EquipItem(id, ['noteam']);
            }
        },
        {
            name: 'equip_spray',
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: function (id) {
                return (ItemInfo.ItemMatchDefName(id, 'spraypaint') && !ItemInfo.IsEquippedForNoTeam(id));
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                EquipItem(id, ['noteam'], 'spray0');
            }
        },
        {
            name: 'equip_tournament_spray',
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: function (id) {
                return (ItemInfo.ItemDefinitionNameSubstrMatch(id, 'tournament_journal_') && (InventoryAPI.GetRawDefinitionKey(id, 'item_sub_position2') === 'spray0'));
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_tournament_select_spray.xml', 'journalid=' + id);
            }
        },
        {
            name: 'equip_musickit',
            CustomName: function (id) {
                return _GetItemToReplaceName(id, 'noteam');
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            style: function (id) {
                return '';
            },
            AvailableForItem: function (id) {
                return ItemInfo.GetDefaultSlot(id) === 'musickit' && !ItemInfo.IsEquippedForNoTeam(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                const isMusicvolumeOn = InventoryAPI.TestMusicVolume();
                if (!isMusicvolumeOn) {
                    $.DispatchEvent('ShowResetMusicVolumePopup', '');
                }
                else {
                    $.DispatchEvent('CSGOPlaySoundEffect', 'equip_musickit', 'MOUSE');
                    EquipItem(id, ['noteam']);
                }
            }
        },
        {
            name: 'unequip',
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: (id) => {
                return ItemInfo.IsEquippedForNoTeam(id) && ['flair0', 'spray0'].includes(ItemInfo.GetDefaultSlot(id));
            },
            OnSelected: (id) => {
                $.DispatchEvent('ContextMenuEvent', '');
                LoadoutAPI.EquipItemInSlot('noteam', '0', ItemInfo.GetDefaultSlot(id));
            },
        },
        {
            name: 'open_watch_panel_pickem',
            AvailableForItem: function (id) {
                if (GameStateAPI.GetMapBSPName())
                    return false;
                return (ItemInfo.ItemDefinitionNameSubstrMatch(id, 'tournament_journal_') && (InventoryAPI.GetRawDefinitionKey(id, 'item_sub_position2') === 'spray0'));
            },
            OnSelected: function (id) {
                $.DispatchEvent('OpenWatchMenu');
                $.DispatchEvent('ShowActiveTournamentPage', '');
                $.DispatchEvent('ContextMenuEvent', '');
            }
        },
        {
            name: 'getprestige',
            AvailableForItem: function (id) {
                return (ItemInfo.ItemDefinitionNameSubstrMatch(id, 'xpgrant') &&
                    (FriendsListAPI.GetFriendLevel(MyPersonaAPI.GetXuid()) >= InventoryAPI.GetMaxLevel()));
            },
            OnSelected: function (id) {
                UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + '0' +
                    '&' + 'asyncworkitemwarning=no' +
                    '&' + 'asyncworktype=prestigecheck');
                $.DispatchEvent('ContextMenuEvent', '');
            }
        },
        {
            name: 'useitem',
            betatype: ['fullversion'],
            AvailableForItem: function (id) {
                if (ItemInfo.ItemDefinitionNameSubstrMatch(id, 'tournament_pass_'))
                    return true;
                if (ItemInfo.ItemDefinitionNameSubstrMatch(id, 'xpgrant')) {
                    return (FriendsListAPI.GetFriendLevel(MyPersonaAPI.GetXuid()) < InventoryAPI.GetMaxLevel());
                }
                if (!InventoryAPI.IsTool(id))
                    return false;
                const season = InventoryAPI.GetItemAttributeValue(id, 'season access');
                if (season != undefined)
                    return true;
                return false;
            },
            OnSelected: function (id) {
                if (ItemInfo.ItemDefinitionNameSubstrMatch(id, 'tournament_pass_')) {
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=,' + id +
                        '&' + 'asyncworktype=decodeable');
                }
                else {
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + id +
                        '&' + 'asyncworktype=useitem');
                }
                $.DispatchEvent('ContextMenuEvent', '');
            }
        },
        {
            name: 'usespray',
            populateFilter: ['inspect'],
            AvailableForItem: function (id) {
                return ItemInfo.ItemMatchDefName(id, 'spray');
            },
            OnSelected: function (id) {
                UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=,' + id +
                    '&' + 'asyncworktype=decodeable');
                $.DispatchEvent('ContextMenuEvent', '');
            }
        },
        {
            betatype: ['fullversion'],
            name: function (id) {
                return InventoryAPI.GetDecodeableRestriction(id) === 'xray' && !ItemInfo.IsTool(id) ? 'look_inside' : _IsKeyForXrayItem(id) !== '' ? 'goto_xray' : 'open_package';
            },
            AvailableForItem: function (id) {
                return ItemInfo.ItemHasCapability(id, 'decodable');
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                if (ItemInfo.GetChosenActionItemsCount(id, 'decodable') === 0) {
                    if (ItemInfo.IsTool(id)) {
                        $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'decodable', id, '');
                    }
                    else {
                        UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + id, 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=,' + id +
                            '&' + 'asyncworktype=decodeable');
                    }
                    $.DispatchEvent('ContextMenuEvent', '');
                    return;
                }
                if (ItemInfo.GetChosenActionItemsCount(id, 'decodable') > 0 && ItemInfo.IsTool(id) && InventoryAPI.GetDecodeableRestriction(id) === 'xray') {
                    const caseId = _IsKeyForXrayItem(id);
                    if (caseId) {
                        $.DispatchEvent("ShowXrayCasePopup", id, caseId, false);
                        $.DispatchEvent('ContextMenuEvent', '');
                        return;
                    }
                }
                if (!ItemInfo.IsTool(id) && InventoryAPI.GetDecodeableRestriction(id) === 'xray') {
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + id, 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=,' + id +
                        '&' + 'asyncworktype=decodeable');
                    return;
                }
                $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'decodable', id, '');
            }
        },
        {
            betatype: ['fullversion'],
            name: function (id) {
                const strActionName = 'nameable';
                const defName = InventoryAPI.GetItemDefinitionName(id);
                if (defName === 'casket') {
                    return InventoryAPI.GetItemAttributeValue(id, 'modification date') ? 'yourcasket' : 'newcasket';
                }
                return strActionName;
            },
            style: function (id) {
                const defName = InventoryAPI.GetItemDefinitionName(id);
                return (defName === 'casket' || defName === 'Name Tag') ? '' : 'TopSeparator';
            },
            AvailableForItem: function (id) {
                return ItemInfo.ItemHasCapability(id, 'nameable');
            },
            OnSelected: function (id) {
                const defName = InventoryAPI.GetItemDefinitionName(id);
                if (defName === 'casket') {
                    const fauxNameTag = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(1200, 0);
                    const noteText = InventoryAPI.GetItemAttributeValue(id, 'modification date') ? 'yourcasket' : 'newcasket';
                    $.DispatchEvent('ContextMenuEvent', '');
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_nameable.xml', 'nametag-and-itemtoname=' + fauxNameTag + ',' + id +
                        '&' + 'asyncworktype=nameable' +
                        '&' + 'asyncworkitemwarningtext=#popup_' + noteText + '_warning');
                }
                else if (_DoesNotHaveChosenActionItems(id, 'nameable')) {
                    const nameTagId = '', itemToNameId = id;
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_nameable.xml', 'nametag-and-itemtoname=' + nameTagId + ',' + itemToNameId +
                        '&' + 'asyncworktype=nameable');
                }
                else {
                    $.DispatchEvent('ContextMenuEvent', '');
                    $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'nameable', id, '');
                }
            }
        },
        {
            betatype: ['fullversion'],
            name: 'can_sticker',
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: function (id) {
                return ItemInfo.ItemMatchDefName(id, 'sticker') && ItemInfo.ItemHasCapability(id, 'can_sticker');
            },
            OnSelected: function (id) {
                $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_applySticker', 'MOUSE');
                $.DispatchEvent('ContextMenuEvent', '');
                $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'can_sticker', id, '');
            }
        },
        {
            betatype: ['fullversion'],
            name: 'can_sticker',
            AvailableForItem: function (id) {
                return ItemInfo.ItemHasCapability(id, 'can_sticker') &&
                    ItemInfo.GetStickerSlotCount(id) > ItemInfo.GetStickerCount(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_applySticker', 'MOUSE');
                $.DispatchEvent('ContextMenuEvent', '');
                $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'can_sticker', id, '');
            }
        },
        {
            betatype: ['fullversion'],
            name: 'remove_sticker',
            AvailableForItem: function (id) {
                return ItemInfo.ItemHasCapability(id, 'can_sticker') && ItemInfo.GetStickerCount(id) > 0;
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_can_sticker.xml', 'itemid=' + id +
                    '&' + 'asyncworktype=remove_sticker');
            }
        },
        {
            betatype: ['fullversion'],
            name: 'can_patch',
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: function (id) {
                return ItemInfo.ItemMatchDefName(id, 'patch') && ItemInfo.ItemHasCapability(id, 'can_patch');
            },
            OnSelected: function (id) {
                $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_applySticker', 'MOUSE');
                $.DispatchEvent('ContextMenuEvent', '');
                $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'can_patch', id, '');
            }
        },
        {
            betatype: ['fullversion'],
            name: 'can_patch',
            AvailableForItem: function (id) {
                return ItemInfo.ItemHasCapability(id, 'can_patch') &&
                    ItemInfo.GetStickerSlotCount(id) > ItemInfo.GetStickerCount(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('CSGOPlaySoundEffect', 'sticker_applySticker', 'MOUSE');
                $.DispatchEvent('ContextMenuEvent', '');
                $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'can_patch', id, '');
            }
        },
        {
            betatype: ['fullversion'],
            name: 'remove_patch',
            AvailableForItem: function (id) {
                return ItemInfo.ItemHasCapability(id, 'can_patch') && ItemInfo.GetStickerCount(id) > 0;
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_can_patch.xml', 'itemid=' + id +
                    '&' + 'asyncworktype=remove_patch');
            }
        },
        {
            name: 'recipe',
            AvailableForItem: function (id) {
                return ItemInfo.ItemMatchDefName(id, 'recipe');
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
            }
        },
        {
            betatype: ['fullversion'],
            name: 'can_stattrack_swap',
            AvailableForItem: function (id) {
                return ItemInfo.ItemHasCapability(id, 'can_stattrack_swap') && InventoryAPI.IsTool(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'can_stattrack_swap', id, '');
            }
        },
        {
            name: 'journal',
            AvailableForItem: function (id) {
                return false;
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
            }
        },
        {
            betatype: ['fullversion'],
            name: 'tradeup_add',
            populateFilter: ['tradeup_items'],
            AvailableForItem: function (id) {
                const slot = ItemInfo.GetDefaultSlot(id);
                return !!slot && slot !== "melee" && slot !== "c4" && slot !== "clothing_hands" && !ItemInfo.IsEquippalbleButNotAWeapon(id) &&
                    (InventoryAPI.CanTradeUp(id) || InventoryAPI.GetNumItemsNeededToTradeUp(id) > 0);
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.AddCraftIngredient(id);
            }
        },
        {
            betatype: ['fullversion'],
            name: 'tradeup_remove',
            exclusiveFilter: ['tradeup_ingredients'],
            AvailableForItem: function (id) {
                const slot = ItemInfo.GetDefaultSlot(id);
                return !!slot && slot !== "melee" && slot !== "c4" && slot !== "clothing_hands" && !ItemInfo.IsEquippalbleButNotAWeapon(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.RemoveCraftIngredient(id);
            }
        },
        {
            betatype: ['fullversion'],
            name: 'open_contract',
            AvailableForItem: function (id) {
                return ItemInfo.IsTradeUpContract(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('ShowTradeUpPanel');
                $.DispatchEvent('ContextMenuEvent', '');
            }
        },
        {
            betatype: ['fullversion'],
            name: 'usegift',
            AvailableForItem: function (id) {
                return ItemInfo.GetToolType(id) === 'gift';
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                const CapDisabledMessage = InventoryAPI.GetItemCapabilityDisabledMessageByIndex(id, 0);
                if (CapDisabledMessage === "") {
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + id +
                        '&' + 'asyncworkitemwarning=no' +
                        '&' + 'asyncworktype=usegift');
                }
                else {
                    const capDisabledMessage = InventoryAPI.GetItemCapabilityDisabledMessageByIndex(id, 0);
                    UiToolkitAPI.ShowGenericPopupOk($.Localize('#inv_context_usegift'), $.Localize(capDisabledMessage), '', function () {
                    });
                }
            }
        },
        {
            name: 'add_to_favorites_both',
            style: function (id) {
                return 'TopSeparator';
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: id => CanAddToFavorites(id, 't') && CanAddToFavorites(id, 'ct'),
            OnSelected: id => {
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.AddItemToFavorites('ct', id);
                InventoryAPI.AddItemToFavorites('t', id);
            },
        },
        {
            name: 'add_to_favorites_ct',
            style: function (id) {
                if (CanAddToFavorites(id, 't'))
                    return '';
                return 'TopSeparator';
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: id => CanAddToFavorites(id, 'ct'),
            OnSelected: id => {
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.AddItemToFavorites('ct', id);
            },
        },
        {
            name: 'remove_from_favorites_ct',
            style: function (id) {
                return 'TopSeparator';
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: id => InventoryAPI.ItemIsInFavorites('ct', id),
            OnSelected: id => {
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.RemoveItemFromFavorites('ct', id);
            },
        },
        {
            name: 'add_to_favorites_t',
            style: function (id) {
                if (CanAddToFavorites(id, 'ct') || InventoryAPI.ItemIsInFavorites('ct', id))
                    return '';
                return 'TopSeparator';
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: id => CanAddToFavorites(id, 't'),
            OnSelected: id => {
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.AddItemToFavorites('t', id);
            },
        },
        {
            name: 'remove_from_favorites_t',
            style: function (id) {
                if (CanAddToFavorites(id, 'ct') || InventoryAPI.ItemIsInFavorites('ct', id))
                    return '';
                return 'TopSeparator';
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: id => InventoryAPI.ItemIsInFavorites('t', id),
            OnSelected: id => {
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.RemoveItemFromFavorites('t', id);
            },
        },
        {
            name: 'add_to_favorites_noteam',
            style: function (id) {
                return 'TopSeparator';
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: id => CanAddToFavorites(id, 'noteam'),
            OnSelected: id => {
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.AddItemToFavorites('noteam', id);
            },
        },
        {
            name: 'remove_from_favorites_noteam',
            style: function (id) {
                return 'TopSeparator';
            },
            populateFilter: ['inspect', 'loadout', 'loadout_slot_t', 'loadout_slot_ct'],
            AvailableForItem: id => InventoryAPI.ItemIsInFavorites('noteam', id),
            OnSelected: id => {
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.RemoveItemFromFavorites('noteam', id);
            },
        },
        {
            name: 'enable_shuffle_slot',
            exclusiveFilter: ['loadout_slot_ct'],
            AvailableForItem: function (id) {
                const category = InventoryAPI.GetLoadoutCategory(id);
                return ['customplayer', 'clothing', 'melee', 'c4', 'musickit'].includes(category);
            },
            OnSelected: id => {
                const [team, slot] = _GetLoadoutSlot(id, 'ct');
                LoadoutAPI.SetShuffleEnabled(team, slot, true);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'enable_shuffle_slot',
            exclusiveFilter: ['loadout_slot_t'],
            AvailableForItem: function (id) {
                const category = InventoryAPI.GetLoadoutCategory(id);
                return ['customplayer', 'clothing', 'melee', 'c4', 'musickit'].includes(category);
            },
            OnSelected: id => {
                const [team, slot] = _GetLoadoutSlot(id, 't');
                LoadoutAPI.SetShuffleEnabled(team, slot, true);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'enable_weapon_shuffle',
            exclusiveFilter: ['loadout_slot_ct'],
            AvailableForItem: function (id) {
                const category = InventoryAPI.GetLoadoutCategory(id);
                if (category != 'secondary' && category != 'smg' && category != 'rifle')
                    return false;
                $.GetContextPanel().SetDialogVariable("weapon_type", $.Localize(InventoryAPI.GetItemBaseName(id)));
                return true;
            },
            OnSelected: id => {
                const [team, slot] = _GetLoadoutSlot(id, 'ct');
                LoadoutAPI.SetShuffleEnabled(team, slot, true);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'enable_weapon_shuffle',
            exclusiveFilter: ['loadout_slot_t'],
            AvailableForItem: function (id) {
                const category = InventoryAPI.GetLoadoutCategory(id);
                if (category != 'secondary' && category != 'smg' && category != 'rifle')
                    return false;
                $.GetContextPanel().SetDialogVariable("weapon_type", $.Localize(InventoryAPI.GetItemBaseName(id)));
                return true;
            },
            OnSelected: id => {
                const [team, slot] = _GetLoadoutSlot(id, 't');
                LoadoutAPI.SetShuffleEnabled(team, slot, true);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'disable_shuffle_slot',
            exclusiveFilter: ['shuffle_slot_ct'],
            AvailableForItem: function (id) {
                const category = InventoryAPI.GetLoadoutCategory(id);
                return ['customplayer', 'clothing', 'melee', 'c4', 'musickit'].includes(category);
            },
            OnSelected: id => {
                const [team, slot] = _GetLoadoutSlot(id, 'ct');
                LoadoutAPI.SetShuffleEnabled(team, slot, false);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'disable_shuffle_slot',
            exclusiveFilter: ['shuffle_slot_t'],
            AvailableForItem: function (id) {
                const category = InventoryAPI.GetLoadoutCategory(id);
                return ['customplayer', 'clothing', 'melee', 'c4', 'musickit'].includes(category);
            },
            OnSelected: id => {
                const [team, slot] = _GetLoadoutSlot(id, 't');
                LoadoutAPI.SetShuffleEnabled(team, slot, false);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'disable_weapon_shuffle',
            exclusiveFilter: ['shuffle_slot_ct'],
            AvailableForItem: function (id) {
                const category = InventoryAPI.GetLoadoutCategory(id);
                if (category != 'secondary' && category != 'smg' && category != 'rifle')
                    return false;
                $.GetContextPanel().SetDialogVariable("weapon_type", $.Localize(InventoryAPI.GetItemBaseName(id)));
                return true;
            },
            OnSelected: id => {
                const [team, slot] = _GetLoadoutSlot(id, 'ct');
                LoadoutAPI.SetShuffleEnabled(team, slot, false);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'disable_weapon_shuffle',
            exclusiveFilter: ['shuffle_slot_t'],
            AvailableForItem: function (id) {
                const category = InventoryAPI.GetLoadoutCategory(id);
                if (category != 'secondary' && category != 'smg' && category != 'rifle')
                    return false;
                $.GetContextPanel().SetDialogVariable("weapon_type", $.Localize(InventoryAPI.GetItemBaseName(id)));
                return true;
            },
            OnSelected: id => {
                const [team, slot] = _GetLoadoutSlot(id, 't');
                LoadoutAPI.SetShuffleEnabled(team, slot, false);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'intocasket',
            style: function (id) {
                return 'TopSeparator';
            },
            AvailableForItem: function (id) {
                return InventoryAPI.IsPotentiallyMarketable(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                if (ItemInfo.GetChosenActionItemsCount(id, 'can_collect') > 0) {
                    $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'can_collect', id, '');
                }
                else {
                    const fauxCasket = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(1201, 0);
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + fauxCasket
                        + '&' +
                        'inspectonly=false'
                        + '&' +
                        'asyncworkitemwarning=no'
                        + '&' +
                        'storeitemid=' + fauxCasket);
                }
            }
        },
        {
            name: 'sell',
            AvailableForItem: function (id) {
                return InventoryAPI.IsMarketable(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('CSGOPlaySoundEffect', 'inventory_inspect_sellOnMarket', 'MOUSE');
                $.DispatchEvent('ContextMenuEvent', '');
                InventoryAPI.SellItem(id);
            }
        },
        {
            name: 'delete',
            style: function (id) {
                return !InventoryAPI.IsMarketable(id) ? 'TopSeparator' : '';
            },
            AvailableForItem: function (id) {
                return InventoryAPI.IsDeletable(id);
            },
            OnSelected: function (id) {
                $.DispatchEvent('ContextMenuEvent', '');
                UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + id +
                    '&' + 'asyncworktype=delete' +
                    '&' + 'asyncworkbtnstyle=Negative');
            }
        },
        {
            name: 'loadout_slot_reset_t',
            exclusiveFilter: ['loadout_slot_t'],
            AvailableForItem: id => {
                let team = 't';
                let slot = InventoryAPI.GetDefaultSlot(id);
                if (slot == 'musickit')
                    team = 'noteam';
                else if (slot != 'customplayer' && slot != 'clothing_hands' && slot != 'melee')
                    return false;
                return id != LoadoutAPI.GetDefaultItem(team, slot);
            },
            OnSelected: id => {
                let team = 't';
                let slot = InventoryAPI.GetDefaultSlot(id);
                if (slot == 'musickit')
                    team = 'noteam';
                let defaultId = LoadoutAPI.GetDefaultItem(team, slot);
                LoadoutAPI.EquipItemInSlot(team, defaultId, slot);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'loadout_slot_reset_ct',
            exclusiveFilter: ['loadout_slot_ct'],
            AvailableForItem: id => {
                let team = 'ct';
                let slot = InventoryAPI.GetDefaultSlot(id);
                if (slot == 'musickit')
                    team = 'noteam';
                else if (slot != 'customplayer' && slot != 'clothing_hands' && slot != 'melee')
                    return false;
                return id != LoadoutAPI.GetDefaultItem(team, slot);
            },
            OnSelected: id => {
                let team = 'ct';
                let slot = InventoryAPI.GetDefaultSlot(id);
                if (slot == 'musickit')
                    team = 'noteam';
                let defaultId = LoadoutAPI.GetDefaultItem(team, slot);
                LoadoutAPI.EquipItemInSlot(team, defaultId, slot);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'loadout_slot_reset_weapon_t',
            exclusiveFilter: ['loadout_slot_t'],
            AvailableForItem: id => {
                let team = 't';
                let category = InventoryAPI.GetLoadoutCategory(id);
                if (category != 'secondary' && category != 'smg' && category != 'rifle')
                    return false;
                let defIndex = InventoryAPI.GetItemDefinitionIndex(id);
                let slot = LoadoutAPI.GetSlotEquippedWithDefIndex(team, defIndex);
                let defaultId = LoadoutAPI.GetDefaultItem(team, slot);
                let defaultDefIndex = InventoryAPI.GetItemDefinitionIndex(defaultId);
                return defIndex != defaultDefIndex;
            },
            OnSelected: id => {
                let team = 't';
                let defIndex = InventoryAPI.GetItemDefinitionIndex(id);
                let slot = LoadoutAPI.GetSlotEquippedWithDefIndex(team, defIndex);
                let defaultId = LoadoutAPI.GetDefaultItem(team, slot);
                let defaultDefIndex = InventoryAPI.GetItemDefinitionIndex(defaultId);
                let preferredId = LoadoutAPI.GetPreferredItemIdForItemDefIndex(team, defaultDefIndex);
                LoadoutAPI.EquipItemInSlot(team, preferredId, slot);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'loadout_slot_reset_weapon_ct',
            exclusiveFilter: ['loadout_slot_ct'],
            AvailableForItem: id => {
                let team = 'ct';
                let category = InventoryAPI.GetLoadoutCategory(id);
                if (category != 'secondary' && category != 'smg' && category != 'rifle')
                    return false;
                let defIndex = InventoryAPI.GetItemDefinitionIndex(id);
                let slot = LoadoutAPI.GetSlotEquippedWithDefIndex(team, defIndex);
                let defaultId = LoadoutAPI.GetDefaultItem(team, slot);
                let defaultDefIndex = InventoryAPI.GetItemDefinitionIndex(defaultId);
                return defIndex != defaultDefIndex;
            },
            OnSelected: id => {
                let team = 'ct';
                let defIndex = InventoryAPI.GetItemDefinitionIndex(id);
                let slot = LoadoutAPI.GetSlotEquippedWithDefIndex(team, defIndex);
                let defaultId = LoadoutAPI.GetDefaultItem(team, slot);
                let defaultDefIndex = InventoryAPI.GetItemDefinitionIndex(defaultId);
                let preferredId = LoadoutAPI.GetPreferredItemIdForItemDefIndex(team, defaultDefIndex);
                LoadoutAPI.EquipItemInSlot(team, preferredId, slot);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'loadout_slot_reset_finish_t',
            exclusiveFilter: ['loadout_slot_t'],
            AvailableForItem: id => {
                let category = InventoryAPI.GetLoadoutCategory(id);
                if (category == 'secondary' || category == 'smg' || category == 'rifle')
                    return !InventoryAPI.IsFauxItemID(id);
                else
                    return false;
            },
            OnSelected: id => {
                let team = 't';
                let defIndex = InventoryAPI.GetItemDefinitionIndex(id);
                let slot = LoadoutAPI.GetSlotEquippedWithDefIndex(team, defIndex);
                let fauxId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(defIndex, 0);
                LoadoutAPI.EquipItemInSlot(team, fauxId, slot);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
        {
            name: 'loadout_slot_reset_finish_ct',
            exclusiveFilter: ['loadout_slot_ct'],
            AvailableForItem: id => {
                let category = InventoryAPI.GetLoadoutCategory(id);
                if (category == 'secondary' || category == 'smg' || category == 'rifle')
                    return !InventoryAPI.IsFauxItemID(id);
                else
                    return false;
            },
            OnSelected: id => {
                let team = 'ct';
                let defIndex = InventoryAPI.GetItemDefinitionIndex(id);
                let slot = LoadoutAPI.GetSlotEquippedWithDefIndex(team, defIndex);
                let fauxId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(defIndex, 0);
                LoadoutAPI.EquipItemInSlot(team, fauxId, slot);
                $.DispatchEvent('ContextMenuEvent', '');
            },
        },
    ];
    const _GetItemToReplaceName = function (id, team, slot) {
        if (slot === null || slot === undefined || slot === '') {
            if (ItemInfo.IsWeapon(id) && !['melee', 'secondary0'].includes(ItemInfo.GetDefaultSlot(id))) {
                slot = ItemInfo.GetEquippedSlot(id, team);
            }
            else {
                slot = ItemInfo.GetDefaultSlot(id);
            }
        }
        const currentEquippedItem = ItemInfo.GetItemIdForItemEquippedInSlot(team, slot);
        if (currentEquippedItem && currentEquippedItem !== '0') {
            $.GetContextPanel().SetDialogVariable("item_name", _GetNameWithRarity(currentEquippedItem));
            if (team != 'noteam') {
                return $.Localize('#inv_context_equip_team', $.GetContextPanel());
            }
            else
                return $.Localize('#inv_context_equip', $.GetContextPanel());
        }
        return 'WRONG CONTEXT -_GetItemToReplaceName()' + id;
    };
    const _GetNameWithRarity = function (id) {
        const rarityColor = ItemInfo.GetRarityColor(id);
        return '<font color="' + rarityColor + '">' + ItemInfo.GetName(id) + '</font>';
    };
    const EquipItem = function (id, team, slot) {
        if (slot === null || slot === undefined || slot === '') {
            slot = ItemInfo.GetDefaultSlot(id);
            if (ItemInfo.IsWeapon(id) && !["melee", "secondary0"].includes(ItemInfo.GetDefaultSlot(id)))
                slot = ItemInfo.GetEquippedSlot(id, team[0]);
            else
                slot = ItemInfo.GetDefaultSlot(id);
        }
        const teamShownOnMainMenu = GameInterfaceAPI.GetSettingString('ui_vanitysetting_team');
        team.forEach(element => LoadoutAPI.EquipItemInSlot(element, id, slot));
        let bNeedToRestartMainMenuVanity = false;
        if (ItemInfo.IsCharacter(id)) {
            const teamOfCharacter = (ItemInfo.GetTeam(id).search('Team_T') === -1) ? 'ct' : 't';
            if (teamOfCharacter !== teamShownOnMainMenu) {
                GameInterfaceAPI.SetSettingString('ui_vanitysetting_team', teamOfCharacter);
            }
            bNeedToRestartMainMenuVanity = true;
        }
        else {
            team.filter(function (e) { return e === teamShownOnMainMenu; });
            if (team.length > 0) {
                if ((slot === 'clothing_hands') ||
                    (slot === GameInterfaceAPI.GetSettingString('ui_vanitysetting_loadoutslot_' + teamShownOnMainMenu))) {
                    bNeedToRestartMainMenuVanity = true;
                }
            }
        }
        if (bNeedToRestartMainMenuVanity) {
            $.DispatchEvent('ForceRestartVanity');
        }
    };
    const _DoesNotHaveChosenActionItems = function (id, capability) {
        return (ItemInfo.GetChosenActionItemsCount(id, capability) === 0 && !ItemInfo.IsTool(id));
    };
    const _DoesItemTeamMatchTeamRequired = function (team, id) {
        if (team === 't') {
            return ItemInfo.IsItemT(id) || ItemInfo.IsItemAnyTeam(id);
        }
        if (team === 'ct') {
            return ItemInfo.IsItemCt(id) || ItemInfo.IsItemAnyTeam(id);
        }
        if (team === 'noteam') {
            return ItemInfo.GetLoadoutCategory(id) == 'musickit';
        }
        return false;
    };
    const _CanEquipItem = function (itemID) {
        return !!ItemInfo.GetDefaultSlot(itemID) && !ItemInfo.IsEquippableThroughContextMenu(itemID) && LoadoutAPI.IsLoadoutAllowed();
    };
    const _IsKeyForXrayItem = function (id) {
        const oData = ItemInfo.GetItemsInXray();
        if (oData.case && oData.reward) {
            const numActionItems = ItemInfo.GetChosenActionItemsCount(oData.case, 'decodable');
            if (numActionItems > 0) {
                for (let i = 0; i < numActionItems; i++) {
                    if (id === ItemInfo.GetChosenActionItemIDByIndex(oData.case, 'decodable', i)) {
                        return oData.case;
                    }
                }
            }
        }
        return '';
    };
    function _CanSwapFinish(id, team) {
        if (!_DoesItemTeamMatchTeamRequired(team, id))
            return false;
        let slot;
        let group = InventoryAPI.GetRawDefinitionKey(id, 'flexible_loadout_group');
        switch (group) {
            case 'customplayer':
            case 'clothing_hands':
            case 'melee':
            case 'c4':
                {
                    slot = group;
                    break;
                }
            case 'secondary0':
            case 'secondary':
            case 'smg':
            case 'rifle':
                {
                    let itemDefIndex = InventoryAPI.GetItemDefinitionIndex(id);
                    slot = LoadoutAPI.GetSlotEquippedWithDefIndex(team, itemDefIndex);
                    if (!slot)
                        return false;
                    break;
                }
            default:
                {
                    return false;
                }
        }
        if (LoadoutAPI.GetItemID(team, slot) == id)
            return false;
        if (LoadoutAPI.IsShuffleEnabled(team, slot))
            return false;
        return _CanEquipItem(id);
    }
    function _GetLoadoutSlot(id, team) {
        let group = InventoryAPI.GetRawDefinitionKey(id, 'flexible_loadout_group');
        if (['secondary0', 'secondary', 'smg', 'rifle'].includes(group)) {
            let itemDefIndex = InventoryAPI.GetItemDefinitionIndex(id);
            return [team, LoadoutAPI.GetSlotEquippedWithDefIndex(team, itemDefIndex)];
        }
        else if (['musickit', 'flair0', 'spray0'].includes(group)) {
            return ['noteam', group];
        }
        else {
            return [team, group];
        }
    }
    function CanAddToFavorites(id, team) {
        const [_, slot] = _GetLoadoutSlot(id, team);
        if (!ItemInfo.IsWeapon(id) && slot != 'customplayer' && slot != 'clothing_hands' && slot != 'musickit')
            return false;
        if (slot == 'musickit' && team != 'noteam')
            return false;
        if (InventoryAPI.ItemIsInFavorites(team, id))
            return false;
        if (!_DoesItemTeamMatchTeamRequired(team, id))
            return false;
        return !!ItemInfo.GetDefaultSlot(id);
    }
    return {
        FilterEntries: _FilterEntries,
        EquipItem: EquipItem
    };
})();
