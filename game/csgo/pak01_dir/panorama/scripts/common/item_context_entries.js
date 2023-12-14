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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaXRlbV9jb250ZXh0X2VudHJpZXMuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9jb21tb24vaXRlbV9jb250ZXh0X2VudHJpZXMudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUNyQyxvQ0FBb0M7QUFDcEMsNEVBQTRFO0FBYzVFLElBQUksa0JBQWtCLEdBQUcsQ0FBRTtJQUUxQixNQUFNLGNBQWMsR0FBRyxVQUFXLGtCQUEwQjtRQUUzRCxNQUFNLFVBQVUsR0FBRyxrQkFBa0IsS0FBSyxhQUFhLENBQUM7UUFFeEQsT0FBTyxRQUFRLENBQUMsTUFBTSxDQUFFLFVBQVcsS0FBSztZQUd2QyxJQUFLLEtBQUssQ0FBQyxlQUFlLEVBQzFCO2dCQUNDLE9BQU8sS0FBSyxDQUFDLGVBQWUsQ0FBQyxRQUFRLENBQUUsa0JBQWtCLENBQUUsQ0FBQzthQUM1RDtpQkFFSSxJQUFLLFVBQVUsSUFBSSxLQUFLLENBQUMsY0FBYyxFQUM1QztnQkFDQyxPQUFPLEtBQUssQ0FBQyxjQUFjLENBQUMsUUFBUSxDQUFFLGtCQUFrQixDQUFFLENBQUM7YUFDM0Q7WUFHRCxPQUFPLENBQUMsVUFBVSxDQUFDO1FBQ3BCLENBQUMsQ0FBRSxDQUFDO0lBQ0wsQ0FBQyxDQUFDO0lBT0YsTUFBTSxRQUFRLEdBQXlCO1FBOEJ0QztZQUNDLElBQUksRUFBRSxTQUFTO1lBQ2YsY0FBYyxFQUFFLENBQUUsVUFBVSxFQUFFLFNBQVMsRUFBRSxnQkFBZ0IsRUFBRSxpQkFBaUIsRUFBRSxlQUFlLEVBQUUscUJBQXFCLENBQUU7WUFDdEgsS0FBSyxFQUFFLFVBQVcsRUFBRTtnQkFFbkIsT0FBTyxFQUFFLENBQUM7WUFDWCxDQUFDO1lBQ0QsZ0JBQWdCLEVBQUUsVUFBVyxFQUFFO2dCQUc5QixNQUFNLE9BQU8sR0FBRyxZQUFZLENBQUMscUJBQXFCLENBQUUsRUFBRSxDQUFFLENBQUM7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