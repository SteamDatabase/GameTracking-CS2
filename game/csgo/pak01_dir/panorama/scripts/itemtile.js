"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/iteminfo.ts" />
/// <reference path="mainmenu_inventory.ts" />
/// <reference path="common/formattext.ts" />
var ItemTile;
(function (ItemTile) {
    function _OnTileUpdated() {
        let id = $.GetContextPanel().GetAttributeString('itemid', '0');
        if (id === '0')
            return;
        let idForDisplay = id;
        if ($.GetContextPanel().GetAttributeString('filter_category', '') === 'inv_graphic_art') {
            idForDisplay = ItemInfo.GetFauxReplacementItemID(id, 'graffiti');
        }
        _SetItemName(idForDisplay);
        _SetItemRarity(id);
        _SetEquippedState(id);
        _SetStickers(id);
        _SetRecentLabel(id);
        _TintSprayImage(id);
        _DisableTile(id);
        _SetBackground(id);
        _SetMultiSelect(id);
        _SetRentalTime(id);
        _SetIsRentable(id);
        let loadImage = $.GetContextPanel().GetAttributeString('loadimage', '');
        if (loadImage) {
            _SetImage(id);
        }
    }
    ;
    function _SetItemName(id) {
        let fmtName = ItemInfo.GetFormattedName(id);
        fmtName.SetOnLabel($('#JsItemName'));
    }
    ;
    function _SetBackground(id) {
        let elTeamTile = $.GetContextPanel().FindChildInLayoutFile('ItemTileTeam');
        let subSlot = InventoryAPI.GetDefaultSlot(id);
        if (subSlot == 'customplayer') {
            elTeamTile.visible = true;
            let isCT = ItemInfo.IsItemCt(id);
            if (isCT) {
                elTeamTile.SetImage("file://{images}/icons/ui/ct_logo_1c.svg");
                elTeamTile.style.washColor = '#B5D4EE';
            }
            else {
                elTeamTile.SetImage("file://{images}/icons/ui/t_logo_1c.svg");
                elTeamTile.style.washColor = '#EAD18A';
            }
        }
        else {
            elTeamTile.visible = false;
        }
    }
    function _SetMultiSelect(id) {
        let bSelectedInMultiSelect = ($.GetContextPanel().GetParent() &&
            $.GetContextPanel().GetParent().GetAttributeInt("capability_multistatus_selected", 0) != 0 &&
            InventoryPanel.GetCapabilityInfo().multiselectItemIds &&
            InventoryPanel.GetCapabilityInfo().multiselectItemIds.hasOwnProperty(id));
        $.GetContextPanel().SetHasClass('capability_multistatus_selected', bSelectedInMultiSelect);
    }
    ;
    function _UpdatePopUpCapabilityList() {
        InventoryPanel.UpdateItemListCallback();
    }
    function _SetImage(id) {
        $.GetContextPanel().FindChildInLayoutFile('ItemImage').itemid = id;
    }
    ;
    function _SetItemRarity(id) {
        let color = InventoryAPI.GetItemRarityColor(id);
        if (!color)
            return;
        $.GetContextPanel().FindChildInLayoutFile('JsRarity').style.backgroundColor = color;
    }
    ;
    function _SetEquippedState(id) {
        let elNoteamDot = $.GetContextPanel().FindChildInLayoutFile('ItemEquipped-noteam');
        let elCtDot = $.GetContextPanel().FindChildInLayoutFile('ItemEquipped-ct');
        let elTDot = $.GetContextPanel().FindChildInLayoutFile('ItemEquipped-t');
        let elFavoriteIconNoteam = $.GetContextPanel().FindChildInLayoutFile('FavoriteIcon-noteam');
        let elFavoriteIconCt = $.GetContextPanel().FindChildInLayoutFile('FavoriteIcon-ct');
        let elFavoriteIconT = $.GetContextPanel().FindChildInLayoutFile('FavoriteIcon-t');
        elTDot.AddClass('hidden');
        elCtDot.AddClass('hidden');
        elNoteamDot.AddClass('hidden');
        elTDot.RemoveClass('item-tile__equipped__radiodot--filled');
        elCtDot.RemoveClass('item-tile__equipped__radiodot--filled');
        elNoteamDot.RemoveClass('item-tile__equipped__radiodot--filled');
        elFavoriteIconNoteam.SetHasClass('hidden', !InventoryAPI.ItemIsInFavorites('noteam', id));
        elFavoriteIconCt.SetHasClass('hidden', !InventoryAPI.ItemIsInFavorites('ct', id));
        elFavoriteIconT.SetHasClass('hidden', !InventoryAPI.ItemIsInFavorites('t', id));
        for (let team of ['t', 'ct', 'noteam']) {
            if (_ItemIsInShuffle(id, team)) {
                _SetEquipIcon(true, team);
            }
            else if (InventoryAPI.IsEquipped(id, team)) {
                _SetEquipIcon(false, team);
            }
        }
    }
    ;
    function _ItemIsInShuffle(id, team) {
        let slot = InventoryAPI.GetRawDefinitionKey(id, 'flexible_loadout_group');
        if (['secondary0', 'secondary', 'smg', 'rifle'].includes(slot)) {
            let itemDefIndex = InventoryAPI.GetItemDefinitionIndex(id);
            slot = LoadoutAPI.GetSlotEquippedWithDefIndex(team, itemDefIndex);
        }
        return LoadoutAPI.IsShuffleEnabled(team, slot) && InventoryAPI.ItemIsInFavorites(team, id);
    }
    ;
    function _SetEquipIcon(isShuffle, team) {
        let elCtDot = $.GetContextPanel().FindChildInLayoutFile('ItemEquipped-' + team);
        elCtDot.RemoveClass('hidden');
        elCtDot.AddClass('item-tile__equipped__radiodot--filled');
        elCtDot.SetHasClass('shuffle', isShuffle);
    }
    ;
    function _SetStickers(id) {
        let elParentStickers = $.GetContextPanel().FindChildInLayoutFile('StickersOnWeapon');
        elParentStickers.RemoveAndDeleteChildren();
        let elParentKeychains = $.GetContextPanel().FindChildInLayoutFile('KeychainsOnWeapon');
        elParentKeychains.RemoveAndDeleteChildren();
        let listStickers = ItemInfo.GetitemStickerList(id);
        for (let entry of listStickers) {
            $.CreatePanel('Image', elParentStickers, 'ItemImage' + entry.image, {
                src: 'file://{images}' + entry.image + '.png',
                scaling: 'stretch-to-fit-preserve-aspect',
                class: 'item-tile__stickers__image'
            });
        }
        let listKeychains = ItemInfo.GetitemKeychainList(id);
        for (let entry of listKeychains) {
            $.CreatePanel('Image', elParentKeychains, 'ItemImage' + entry.image, {
                src: 'file://{images}' + entry.image + '.png',
                scaling: 'stretch-to-fit-preserve-aspect',
                class: 'item-tile__stickers__image'
            });
        }
    }
    ;
    function _SetRecentLabel(id) {
        let isRecentValue = InventoryAPI.GetItemSessionPropertyValue(id, 'recent');
        let isUpdatedValue = InventoryAPI.GetItemSessionPropertyValue(id, 'updated');
        let elLabel = $.GetContextPanel().FindChildInLayoutFile('JsRecent');
        if (isUpdatedValue === '1' || isRecentValue === '1') {
            let locString = 'recent';
            if (isRecentValue === '1') {
                let strItemPickupMethod = InventoryAPI.GetItemSessionPropertyValue(id, 'item_pickup_method');
                if (strItemPickupMethod && ['xpshopredeem', 'quest_reward'].includes(strItemPickupMethod)) {
                    locString = strItemPickupMethod;
                }
            }
            else {
                locString = 'updated';
            }
            elLabel.RemoveClass('hidden');
            elLabel.text = $.Localize('#inv_session_prop_' + locString);
            return;
        }
        elLabel.AddClass('hidden');
    }
    ;
    function _TintSprayImage(id) {
        let elImage = $.GetContextPanel().FindChildInLayoutFile('ItemImage');
        TintSprayIcon.CheckIsSprayAndTint(id, elImage);
    }
    ;
    function _DisableTile(id) {
        let capabilityInfo = _GetPopUpCapability();
        if (capabilityInfo && capabilityInfo.capability === 'can_sticker' && !ItemInfo.IsSticker(id)) {
            $.GetContextPanel().enabled = (InventoryAPI.GetItemStickerSlotCount(id) > InventoryAPI.GetItemStickerCount(id));
        }
        else if (capabilityInfo && capabilityInfo.capability === 'can_patch' && !ItemInfo.IsPatch(id)) {
            $.GetContextPanel().enabled = (InventoryAPI.GetItemStickerSlotCount(id) > InventoryAPI.GetItemStickerCount(id));
        }
        else if (capabilityInfo && capabilityInfo.capability === 'can_keychain' && !ItemInfo.IsKeychain(id)) {
            $.GetContextPanel().enabled = (InventoryAPI.GetItemKeychainSlotCount(id) > InventoryAPI.GetItemKeychainCount(id));
        }
    }
    ;
    function _SetRentalTime(id) {
        let elLabel = $.GetContextPanel().FindChildInLayoutFile('JsItemRental');
        let bHide = !InventoryAPI.IsRental(id);
        if (bHide) {
            elLabel.AddClass('hidden');
            return;
        }
        let expirationDate = InventoryAPI.GetExpirationDate(id);
        if (expirationDate <= 0) {
            elLabel.AddClass('hidden');
            return;
        }
        let oLocData = FormatText.FormatRentalTime(expirationDate);
        elLabel.SetHasClass('item-expired', oLocData.isExpired);
        elLabel.SetDialogVariable('time-remaining', oLocData.time);
        elLabel.text = $.Localize(oLocData.locString, elLabel);
        elLabel.RemoveClass('hidden');
    }
    function _SetIsRentable(id) {
        let elLabel = $.GetContextPanel().FindChildInLayoutFile('JsCanRentItem');
        if (!InventoryAPI.CanOpenForRental(id)) {
            elLabel.AddClass('hidden');
            return;
        }
        elLabel.text = $.Localize('#item-can-rent');
        elLabel.RemoveClass('hidden');
    }
    ItemTile._SetIsRentable = _SetIsRentable;
    function OnActivate() {
        HideTooltip();
        let id = $.GetContextPanel().GetAttributeString('itemid', '0');
        if ($.GetContextPanel().FindAncestor("Inspect_SelectItem") != null) {
            $.DispatchEvent("OnItemTileActivated", $.GetContextPanel(), id);
            return;
        }
        let capabilityInfo = _GetPopUpCapability();
        if (capabilityInfo) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'inventory_item_select', 'MOUSE');
            InventoryAPI.PrecacheCustomMaterials(id);
            if (capabilityInfo.capability === 'nameable') {
                _CapabilityNameableAction(SortIdsIntoToolAndItemID(id, capabilityInfo.initialItemId));
            }
            else if (capabilityInfo.capability === 'can_sticker') {
                _CapabilityCanStickerAction(SortIdsIntoToolAndItemID(id, capabilityInfo.initialItemId), capabilityInfo.bWorkshopItemPreview);
            }
            else if (capabilityInfo.capability === 'can_keychain') {
                _CapabilityCanKeychainAction(SortIdsIntoToolAndItemID(id, capabilityInfo.initialItemId), capabilityInfo.bWorkshopItemPreview);
            }
            else if (capabilityInfo.capability === 'remove_keychain') {
                _CapabilityRemoveKeychainAction(SortIdsIntoToolAndItemID(id, capabilityInfo.initialItemId));
            }
            else if (capabilityInfo.capability === 'can_patch') {
                _CapabilityCanPatchAction(SortIdsIntoToolAndItemID(id, capabilityInfo.initialItemId));
            }
            else if (capabilityInfo.capability === 'decodable') {
                _CapabilityDecodableAction(SortIdsIntoToolAndItemID(id, capabilityInfo.initialItemId));
            }
            else if (capabilityInfo.capability === 'can_stattrack_swap') {
                _CapabilityStatTrakSwapAction(capabilityInfo, id);
            }
            else if (capabilityInfo.capability === 'can_collect') {
                _CapabilityPutIntoCasketAction(id, capabilityInfo.initialItemId);
            }
            else if (capabilityInfo.capability === 'casketcontents') {
                _CapabilityItemInsideCasketAction(capabilityInfo.initialItemId, id);
            }
            else if (capabilityInfo.capability === 'casketretrieve') {
                $.GetContextPanel().ToggleClass('capability_multistatus_selected');
                $.DispatchEvent('UpdateSelectItemForCapabilityPopup', capabilityInfo.capability, id, $.GetContextPanel().BHasClass('capability_multistatus_selected'));
            }
            else if (capabilityInfo.capability === 'casketstore') {
                $.GetContextPanel().ToggleClass('capability_multistatus_selected');
                $.DispatchEvent('UpdateSelectItemForCapabilityPopup', capabilityInfo.capability, id, $.GetContextPanel().BHasClass('capability_multistatus_selected'));
            }
            return;
        }
        let filterValue = $.GetContextPanel().GetAttributeString('context_menu_filter', '');
        let filterForContextMenuEntries = filterValue ? '&populatefiltertext=' + filterValue : '';
        let contextmenuparam = '';
        if ($.GetContextPanel().GetAttributeString('filter_category', '') === 'inv_graphic_art')
            contextmenuparam = '&contextmenuparam=graffiti';
        let contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('popup-inspect-' + id, '', 'file://{resources}/layout/context_menus/context_menu_inventory_item.xml', 'itemid=' + id + filterForContextMenuEntries + contextmenuparam, () => { });
        contextMenuPanel.AddClass("ContextMenu_NoArrow");
    }
    ItemTile.OnActivate = OnActivate;
    ;
    function OnActivateInspectButtonFropmTile() {
        let id = $.GetContextPanel().GetAttributeString('itemid', '0');
        let capabilityInfo = _GetPopUpCapability();
        _CapabilityItemInsideCasketAction(capabilityInfo.initialItemId, id);
    }
    ItemTile.OnActivateInspectButtonFropmTile = OnActivateInspectButtonFropmTile;
    function _GetPopUpCapability() {
        if (typeof InventoryPanel === "object") {
            let capInfo = InventoryPanel.GetCapabilityInfo();
            if (capInfo.popupVisible) {
                return capInfo;
            }
        }
        return null;
    }
    ;
    function SortIdsIntoToolAndItemID(id, initalId) {
        let bIdIsTool = InventoryAPI.IsTool(id);
        let toolId = bIdIsTool ? id : initalId;
        let itemID = bIdIsTool ? initalId : id;
        return {
            tool: toolId,
            item: itemID
        };
    }
    ;
    function _CapabilityNameableAction(idsToUse) {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + idsToUse.item, 'file://{resources}/layout/popups/popup_capability_nameable.xml', 'nametag-and-itemtoname=' + idsToUse.tool + ',' + idsToUse.item +
            '&' + 'asyncworktype=nameable');
    }
    ;
    function _CapabilityCanStickerAction(idsToUse, bWorkshopItemPreview) {
        const workshopPreview = bWorkshopItemPreview ? 'true' : 'false';
        UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + idsToUse.item, 'file://{resources}/layout/popups/popup_capability_can_sticker.xml', 'toolid-and-itemid=' + idsToUse.tool + ',' + idsToUse.item +
            '&' + 'asyncworktype=can_sticker' +
            '&' + 'workshopPreview=' + workshopPreview);
    }
    ;
    function _CapabilityCanKeychainAction(idsToUse, bWorkshopItemPreview) {
        const workshopPreview = bWorkshopItemPreview ? 'true' : 'false';
        UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + idsToUse.item, 'file://{resources}/layout/popups/popup_capability_can_keychain.xml', 'toolid-and-itemid=' + idsToUse.tool + ',' + idsToUse.item +
            '&' + 'asyncworktype=can_keychain' +
            '&' + 'workshopPreview=' + workshopPreview);
    }
    ;
    function _CapabilityRemoveKeychainAction(idsToUse) {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + idsToUse.item, 'file://{resources}/layout/popups/popup_capability_can_keychain.xml', 'itemid=' + idsToUse.item +
            '&' + 'asyncworktype=remove_keychain');
    }
    ;
    function _CapabilityCanPatchAction(idsToUse) {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + idsToUse.item, 'file://{resources}/layout/popups/popup_capability_can_patch.xml', 'toolid-and-itemid=' + idsToUse.tool + ',' + idsToUse.item +
            '&' + 'asyncworktype=can_patch');
    }
    ;
    function _CapabilityDecodableAction(idsToUse) {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + idsToUse.item, 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=' + idsToUse.tool + ',' + idsToUse.item +
            '&' + 'asyncworktype=decodeable');
    }
    ;
    function _CapabilityPutIntoCasketAction(idCasket, idItem, cap) {
        $.DispatchEvent('ContextMenuEvent', '');
        if (!cap) {
            $.DispatchEvent('HideSelectItemForCapabilityPopup');
            $.DispatchEvent('UIPopupButtonClicked', '');
            $.DispatchEvent('CapabilityPopupIsOpen', false);
        }
        if (InventoryAPI.GetItemAttributeValue(idCasket, 'modification date')) {
            UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_casket_operation.xml', 'op=add' +
                (cap ? '&nextcapability=' + cap : '') +
                '&spinner=1' +
                '&casket_item_id=' + idCasket +
                '&subject_item_id=' + idItem);
        }
        else {
            let fauxNameTag = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(1200, 0);
            UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_nameable.xml', 'nametag-and-itemtoname=' + fauxNameTag + ',' + idCasket +
                '&' + 'asyncworktype=nameable' +
                '&' + 'asyncworkitemwarningtext=#popup_newcasket_warning');
        }
    }
    ;
    let jsUpdateItemListCallback = UiToolkitAPI.RegisterJSCallback(_UpdatePopUpCapabilityList);
    function _CapabilityItemInsideCasketAction(idCasket, idItem) {
        let capabilityInfo = _GetPopUpCapability();
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + idItem +
            '&' + 'inspectonly=true' +
            '&' + 'insidecasketid=' + idCasket +
            '&' + 'capability=' + capabilityInfo.capability +
            '&' + 'showallitemactions=false' +
            '&' + 'allowsave=false' +
            '&' + 'isselected=' + $.GetContextPanel().BHasClass('capability_multistatus_selected') +
            '&' + 'callback=' + jsUpdateItemListCallback);
    }
    function _CapabilityStatTrakSwapAction(capInfo, id) {
        if (InventoryAPI.IsTool(capInfo.initialItemId)) {
            $.DispatchEvent("ShowSelectItemForCapabilityPopup", 'can_stattrack_swap', id, capInfo.initialItemId);
        }
        else {
            UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_can_stattrack_swap.xml', 'swaptool=' + capInfo.secondaryItemId +
                '&' + 'swapitem1=' + capInfo.initialItemId +
                '&' + 'swapitem2=' + id);
        }
    }
    ;
    let jsTooltipDelayHandle = null;
    function ShowTooltip() {
        jsTooltipDelayHandle = $.Schedule(.4, ShowToolTipOnDelay);
    }
    ItemTile.ShowTooltip = ShowTooltip;
    function ShowToolTipOnDelay() {
        let id = $.GetContextPanel().GetAttributeString('itemid', '0');
        jsTooltipDelayHandle = null;
        if (!InventoryAPI.IsItemInfoValid(id)) {
            return;
        }
        UiToolkitAPI.ShowCustomLayoutParametersTooltip('ItemImage', 'JsItemTooltip', 'file://{resources}/layout/tooltips/tooltip_inventory_item.xml', 'itemid=' + id);
    }
    ;
    function HideTooltip() {
        UiToolkitAPI.HideCustomLayoutTooltip('JsItemTooltip');
        if (jsTooltipDelayHandle) {
            $.CancelScheduled(jsTooltipDelayHandle);
            jsTooltipDelayHandle = null;
        }
    }
    ItemTile.HideTooltip = HideTooltip;
    ;
    {
        $.RegisterEventHandler('CSGOInventoryItemLoaded', $.GetContextPanel(), _OnTileUpdated);
        $.RegisterEventHandler('UpdateItemTile', $.GetContextPanel(), _OnTileUpdated);
        $.RegisterEventHandler('CSGOInventoryHideTooltip', $.GetContextPanel(), HideTooltip);
    }
})(ItemTile || (ItemTile = {}));
