"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="formattext.ts" />
/// <reference path="characteranims.ts" />
var ItemInfo = (function () {
    const _GetRarityColor = function (id) {
        return InventoryAPI.GetItemRarityColor(id);
    };
    const _GetFormattedName = function (id) {
        const strName = _GetName(id);
        if (InventoryAPI.HasCustomName(id)) {
            return new CFormattedText('#CSGO_ItemName_Custom', { item_name: strName });
        }
        else {
            const splitLoc = strName.indexOf('|');
            if (splitLoc >= 0) {
                const strWeaponName = strName.substring(0, splitLoc).trim();
                const strPaintName = strName.substring(splitLoc + 1).trim();
                return new CFormattedText('#CSGO_ItemName_Painted', { item_name: strWeaponName, paintkit_name: strPaintName });
            }
            return new CFormattedText('#CSGO_ItemName_Base', { item_name: strName });
        }
    };
    const _GetName = function (id) {
        return InventoryAPI.GetItemName(id);
    };
    const _GetNameWithRarity = function (id) {
        if (!ItemInfo.IsStockItem(id)) {
            const rarityColor = _GetRarityColor(id);
            return '<font color="' + rarityColor + '">' + _GetName(id) + '</font>';
        }
        else {
            return _GetName(id);
        }
    };
    const _IsEquippedForCT = function (id) {
        return InventoryAPI.IsEquipped(id, 'ct');
    };
    const _IsEquippedForT = function (id) {
        return InventoryAPI.IsEquipped(id, 't');
    };
    const _IsEquippedForNoTeam = function (id) {
        return InventoryAPI.IsEquipped(id, "noteam");
    };
    const _IsStockItem = function (id) {
        return LoadoutAPI.IsStockItem(id);
    };
    const _IsEquipped = function (id, team) {
        return InventoryAPI.IsEquipped(id, team);
    };
    const _CanEquipItemInSlot = function (szTeam, szItemID, szSlot) {
        return LoadoutAPI.IsLoadoutAllowed() && LoadoutAPI.CanEquipItemInSlot(szTeam, szItemID, szSlot);
    };
    const _GetLoadoutCategory = function (id) {
        return InventoryAPI.GetLoadoutCategory(id);
    };
    const _GetDefaultSlot = function (id) {
        return InventoryAPI.GetDefaultSlot(id);
    };
    const _GetEquippedSlot = function (id, szTeam) {
        let defIndex = InventoryAPI.GetItemDefinitionIndex(id);
        return LoadoutAPI.GetSlotEquippedWithDefIndex(szTeam, defIndex);
    };
    const _GetEquippedItemIdForDefIndex = function (defIndex, szTeam) {
        let slot = LoadoutAPI.GetSlotEquippedWithDefIndex(szTeam, defIndex);
        return _GetItemIdForItemEquippedInSlot(szTeam, slot);
    };
    const _GetTeam = function (id) {
        return InventoryAPI.GetItemTeam(id);
    };
    const _IsSpraySealed = function (id) {
        return InventoryAPI.DoesItemMatchDefinitionByName(id, 'spray');
    };
    const _IsSprayPaint = function (id) {
        return InventoryAPI.DoesItemMatchDefinitionByName(id, 'spraypaint');
    };
    const _IsTradeUpContract = function (id) {
        return InventoryAPI.DoesItemMatchDefinitionByName(id, 'Recipe Trade Up');
    };
    const _GetSprayTintColor = function (id) {
        return InventoryAPI.GetSprayTintColorCode(id);
    };
    const _IsTool = function (id) {
        return InventoryAPI.IsTool(id);
    };
    const _GetCapabilitybyIndex = function (id, index) {
        return InventoryAPI.GetItemCapabilityByIndex(id, index);
    };
    const _GetCapabilityCount = function (id) {
        return InventoryAPI.GetItemCapabilitiesCount(id);
    };
    const _ItemHasCapability = function (id, capName) {
        const caps = [];
        const capCount = _GetCapabilityCount(id);
        for (let i = 0; i < capCount; i++) {
            caps.push(_GetCapabilitybyIndex(id, i));
        }
        return caps.includes(capName);
    };
    const _GetChosenActionItemsCount = function (id, capability) {
        return InventoryAPI.GetChosenActionItemsCount(id, capability);
    };
    const _GetChosenActionItemIDByIndex = function (id, capability, index) {
        return InventoryAPI.GetChosenActionItemIDByIndex(id, capability, index);
    };
    const _GetKeyForCaseInXray = function (caseId) {
        const numActionItems = _GetChosenActionItemsCount(caseId, 'decodable');
        if (numActionItems > 0) {
            const aKeyIds = [];
            for (let i = 0; i < numActionItems; i++) {
                aKeyIds.push(_GetChosenActionItemIDByIndex(caseId, 'decodable', i));
            }
            aKeyIds.sort();
            return aKeyIds[0];
        }
        return '';
    };
    const _GetItemsInXray = function () {
        InventoryAPI.SetInventorySortAndFilters('inv_sort_age', false, 'xraymachine', '', '');
        const count = InventoryAPI.GetInventoryCount();
        if (count === 0) {
            return {};
        }
        let xrayCaseId = '';
        let xrayRewardId = '';
        for (let i = 0; i < count; i++) {
            const id = InventoryAPI.GetInventoryItemIDByIndex(i);
            xrayRewardId = i === 0 ? id : xrayRewardId;
            xrayCaseId = i === 1 ? id : xrayCaseId;
        }
        return { case: xrayCaseId, reward: xrayRewardId };
    };
    const _GetLoadoutWeapons = function (team) {
        let teamName = CharacterAnims.NormalizeTeamName(team, true);
        const list = [];
        const slotStrings = LoadoutAPI.GetLoadoutSlotNames(false);
        const slots = JSON.parse(slotStrings);
        slots.forEach(slot => {
            const weaponItemId = LoadoutAPI.GetItemID(teamName, slot);
            const bIsWeapon = ItemInfo.IsWeapon(weaponItemId);
            if (bIsWeapon) {
                list.push([slot, weaponItemId]);
            }
        });
        return list;
    };
    const _DeepCopyVanityCharacterSettings = function (inVanityCharacterSettings) {
        const modelRenderSettingsOneOffTempCopy = JSON.parse(JSON.stringify(inVanityCharacterSettings));
        modelRenderSettingsOneOffTempCopy.panel = inVanityCharacterSettings.panel;
        return modelRenderSettingsOneOffTempCopy;
    };
    const _PrecacheVanityCharacterSettings = function (inVanityCharacterSettings) {
        if (inVanityCharacterSettings.weaponItemId)
            InventoryAPI.PrecacheCustomMaterials(inVanityCharacterSettings.weaponItemId);
        if (inVanityCharacterSettings.glovesItemId)
            InventoryAPI.PrecacheCustomMaterials(inVanityCharacterSettings.glovesItemId);
    };
    const _GetOrUpdateVanityCharacterSettings = function (optionalCharacterItemId, optionalState) {
        const oSettings = {
            panel: undefined,
            team: undefined,
            charItemId: undefined,
            loadoutSlot: undefined,
            weaponItemId: undefined,
            glovesItemId: undefined,
            cameraPreset: undefined
        };
        if (optionalCharacterItemId && InventoryAPI.IsValidItemID(optionalCharacterItemId)) {
            const charTeam = ItemInfo.GetTeam(optionalCharacterItemId);
            if (charTeam.search('Team_CT') !== -1)
                oSettings.team = 'ct';
            else if (charTeam.search('Team_T') !== -1)
                oSettings.team = 't';
            if (oSettings.team)
                oSettings.charItemId = optionalCharacterItemId;
        }
        if (!oSettings.team) {
            oSettings.team = GameInterfaceAPI.GetSettingString('ui_vanitysetting_team');
            if (oSettings.team !== 'ct' && oSettings.team !== 't') {
                oSettings.team = (Math.round(Math.random()) > 0) ? 'ct' : 't';
                GameInterfaceAPI.SetSettingString('ui_vanitysetting_team', oSettings.team);
            }
        }
        const _fnRollRandomLoadoutSlotAndWeapon = function (strTeam) {
            const myResult = {
                loadoutSlot: '',
                weaponItemId: ''
            };
            const slots = JSON.parse(LoadoutAPI.GetLoadoutSlotNames(false));
            while (slots.length > 0) {
                slots.splice(slots.indexOf('heavy3'), 1);
                slots.splice(slots.indexOf('heavy4'), 1);
                const nRandomSlotIndex = Math.floor(Math.random() * slots.length);
                myResult.loadoutSlot = slots.splice(nRandomSlotIndex, 1)[0];
                myResult.weaponItemId = LoadoutAPI.GetItemID(strTeam, myResult.loadoutSlot);
                if (ItemInfo.IsWeapon(myResult.weaponItemId))
                    break;
            }
            return myResult;
        };
        oSettings.loadoutSlot = GameInterfaceAPI.GetSettingString('ui_vanitysetting_loadoutslot_' + oSettings.team);
        oSettings.weaponItemId = LoadoutAPI.GetItemID(oSettings.team, oSettings.loadoutSlot);
        if (!ItemInfo.IsWeapon(oSettings.weaponItemId)) {
            const randomResult = _fnRollRandomLoadoutSlotAndWeapon(oSettings.team);
            oSettings.loadoutSlot = randomResult.loadoutSlot;
            oSettings.weaponItemId = randomResult.weaponItemId;
            GameInterfaceAPI.SetSettingString('ui_vanitysetting_loadoutslot_' + oSettings.team, oSettings.loadoutSlot);
        }
        oSettings.glovesItemId = LoadoutAPI.GetItemID(oSettings.team, 'clothing_hands');
        if (!oSettings.charItemId)
            oSettings.charItemId = LoadoutAPI.GetItemID(oSettings.team, 'customplayer');
        if (optionalState && optionalState === 'unowned') {
            const randomResult = _fnRollRandomLoadoutSlotAndWeapon(oSettings.team);
            oSettings.loadoutSlot = randomResult.loadoutSlot;
            oSettings.weaponItemId = LoadoutAPI.GetDefaultItem(oSettings.team, oSettings.loadoutSlot);
            oSettings.glovesItemId = LoadoutAPI.GetDefaultItem(oSettings.team, 'clothing_hands');
        }
        return oSettings;
    };
    const _GetStickerSlotCount = function (id) {
        return InventoryAPI.GetItemStickerSlotCount(id);
    };
    const _GetStickerCount = function (id) {
        return InventoryAPI.GetItemStickerCount(id);
    };
    const _GetitemStickerList = function (id) {
        const count = _GetStickerCount(id);
        const stickerList = [];
        for (let i = 0; i < count; i++) {
            const image = _GetStickerImageByIndex(id, i);
            const oStickerInfo = {
                image: _GetStickerImageByIndex(id, i),
                name: _GetStickerNameByIndex(id, i)
            };
            stickerList.push(oStickerInfo);
        }
        return stickerList;
    };
    const _GetStickerImageByIndex = function (id, index) {
        return InventoryAPI.GetItemStickerImageByIndex(id, index);
    };
    const _GetStickerNameByIndex = function (id, index) {
        return InventoryAPI.GetItemStickerNameByIndex(id, index);
    };
    const _GetItemPickUpMethod = function (id) {
        return InventoryAPI.GetItemPickupMethod(id);
    };
    const _GetLoadoutPrice = function (id, subposition) {
        const team = _IsEquippedForCT(id) ? 'ct' : 't';
        return LoadoutAPI.GetItemGamePrice(team, _GetDefaultSlot(id).toString());
    };
    const _GetStoreOriginalPrice = function (id, count, rules) {
        return StoreAPI.GetStoreItemOriginalPrice(id, count, rules ? rules : '');
    };
    const _GetStoreSalePrice = function (id, count, rules) {
        return StoreAPI.GetStoreItemSalePrice(id, count, rules ? rules : '');
    };
    const _GetStoreSalePercentReduction = function (id) {
        return StoreAPI.GetStoreItemPercentReduction(id);
    };
    const _ItemPurchase = function (id) {
        StoreAPI.StoreItemPurchase(id);
    };
    const _IsStatTrak = function (id) {
        const numIsStatTrak = InventoryAPI.GetRawDefinitionKey(id, "will_produce_stattrak");
        return (Number(numIsStatTrak) === 1) ? true : false;
    };
    const _IsEquippalbleButNotAWeapon = function (id) {
        const subSlot = _GetDefaultSlot(id);
        return (subSlot === "flair0" || subSlot === "musickit" || subSlot === "spray0" || subSlot === "customplayer" || subSlot === "pet");
    };
    const _IsEquippableThroughContextMenu = function (id) {
        const subSlot = _GetDefaultSlot(id);
        return (subSlot === "flair0" || subSlot === "musickit" || subSlot === "spray0");
    };
    const _IsWeapon = function (id) {
        const schemaString = InventoryAPI.BuildItemSchemaDefJSON(id);
        if (!schemaString)
            return false;
        const itemSchemaDef = JSON.parse(schemaString);
        return (itemSchemaDef["craft_class"] === "weapon");
    };
    const _IsCase = function (id) {
        return ItemInfo.ItemHasCapability(id, 'decodable') &&
            InventoryAPI.GetAssociatedItemsCount(id) > 0 ?
            true :
            false;
    };
    const _IsCharacter = function (id) {
        return (_GetDefaultSlot(id) === "customplayer");
    };
    const _IsGloves = function (id) {
        return (_GetDefaultSlot(id) === "clothing_hands");
    };
    const _IsPet = function (id) {
        return (_GetDefaultSlot(id) === "pet");
    };
    const _IsItemCt = function (id) {
        return _GetTeam(id) === '#CSGO_Inventory_Team_CT';
    };
    const _IsItemT = function (id) {
        return _GetTeam(id) === '#CSGO_Inventory_Team_T';
    };
    const _IsItemAnyTeam = function (id) {
        return _GetTeam(id) === '#CSGO_Inventory_Team_Any';
    };
    const _GetItemDefinitionName = function (id) {
        return InventoryAPI.GetItemDefinitionName(id);
    };
    const _ItemMatchDefName = function (id, defName) {
        return InventoryAPI.DoesItemMatchDefinitionByName(id, defName);
    };
    const _ItemDefinitionNameSubstrMatch = function (id, defSubstr) {
        const itemDefName = InventoryAPI.GetItemDefinitionName(id);
        return (!!itemDefName && (itemDefName.indexOf(defSubstr) != -1));
    };
    const _GetFauxReplacementItemID = function (id, purpose) {
        if (purpose === 'graffiti') {
            if (_ItemDefinitionNameSubstrMatch(id, 'tournament_journal_')) {
                return _GetFauxItemIdForGraffiti(parseInt(InventoryAPI.GetItemAttributeValue(id, 'sticker slot 0 id')));
            }
        }
        return id;
    };
    const _GetFauxItemIdForGraffiti = function (stickestickerid_graffiti) {
        return InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(1349, stickestickerid_graffiti);
    };
    const _GetItemIdForItemEquippedInSlot = function (team, slot) {
        return LoadoutAPI.GetItemID(team, slot);
    };
    const _ItemsNeededToTradeUp = function (id) {
        return InventoryAPI.GetNumItemsNeededToTradeUp(id);
    };
    const _GetGifter = function (id) {
        const xuid = InventoryAPI.GetItemGifterXuid(id);
        return xuid !== undefined ? xuid : '';
    };
    const _GetSet = function (id) {
        const setName = InventoryAPI.GetSet(id);
        return setName !== undefined ? setName : '';
    };
    const _GetModelPath = function (id, itemSchemaDef) {
        const isMusicKit = _ItemMatchDefName(id, 'musickit');
        const issMusicKitDefault = _ItemMatchDefName(id, 'musickit_default');
        const isSpray = itemSchemaDef.name === 'spraypaint';
        const isSprayPaint = itemSchemaDef.name === 'spray';
        const isFanTokenOrShieldItem = itemSchemaDef.name && itemSchemaDef.name.indexOf('tournament_journal_') != -1;
        const isPet = itemSchemaDef.name === itemSchemaDef.name && itemSchemaDef.name.indexOf('pet_') != -1;
        if (isSpray || isSprayPaint || isFanTokenOrShieldItem)
            return 'vmt://spraypreview_' + id;
        else if (_IsSticker(id) || _IsPatch(id))
            return 'vmt://stickerpreview_' + id;
        else if (itemSchemaDef.hasOwnProperty("model_player") || isMusicKit || issMusicKitDefault || isPet)
            return 'img://inventory_' + id;
    };
    const _GetModelPlayer = function (id) {
        const schemaString = InventoryAPI.BuildItemSchemaDefJSON(id);
        if (!schemaString)
            return "";
        const itemSchemaDef = JSON.parse(schemaString);
        const modelPlayer = itemSchemaDef["model_player"];
        return modelPlayer;
    };
    function _IsSticker(itemId) {
        return _ItemMatchDefName(itemId, 'sticker');
    }
    function _IsDisplayItem(itemId) {
        return _GetDefaultSlot(itemId) == 'flair0';
    }
    function _IsPatch(itemId) {
        return _ItemMatchDefName(itemId, 'patch');
    }
    const _GetDefaultCheer = function (id) {
        const schemaString = InventoryAPI.BuildItemSchemaDefJSON(id);
        const itemSchemaDef = JSON.parse(schemaString);
        if (itemSchemaDef["default_cheer"])
            return itemSchemaDef["default_cheer"];
        else
            return "";
    };
    const _GetVoPrefix = function (id) {
        const schemaString = InventoryAPI.BuildItemSchemaDefJSON(id);
        const itemSchemaDef = JSON.parse(schemaString);
        return itemSchemaDef["vo_prefix"];
    };
    const _GetModelPathFromJSONOrAPI = function (id) {
        if (id === '' || id === undefined || id === null) {
            return '';
        }
        let pedistalModel = '';
        const schemaString = InventoryAPI.BuildItemSchemaDefJSON(id);
        const itemSchemaDef = JSON.parse(schemaString);
        if (_GetDefaultSlot(id) === "flair0") {
            pedistalModel = itemSchemaDef.hasOwnProperty('attributes') ? itemSchemaDef.attributes["pedestal display model"] : '';
        }
        else if (_ItemHasCapability(id, 'decodable')) {
            pedistalModel = itemSchemaDef.hasOwnProperty("model_player") ? itemSchemaDef.model_player : '';
        }
        return (pedistalModel === '') ? _GetModelPath(id, itemSchemaDef) : pedistalModel;
    };
    const _GetLootListCount = function (id) {
        return InventoryAPI.GetLootListItemsCount(id);
    };
    const _GetLootListItemByIndex = function (id, index) {
        return InventoryAPI.GetLootListItemIdByIndex(id, index);
    };
    const _GetMarketLinkForLootlistItem = function (id) {
        const appID = SteamOverlayAPI.GetAppID();
        const communityUrl = SteamOverlayAPI.GetSteamCommunityURL();
        const strName = _GetName(id);
        return communityUrl + "/market/search?appid=" + appID + "&lock_appid=" + appID + "&q=" + strName;
    };
    const _GetToolType = function (id) {
        return InventoryAPI.GetToolType(id);
    };
    function _FindAnyUserOwnedCharacterItemID() {
        InventoryAPI.SetInventorySortAndFilters('inv_sort_rarity', false, 'customplayer,not_base_item', '', '');
        const count = InventoryAPI.GetInventoryCount();
        return (count > 0) ? InventoryAPI.GetInventoryItemIDByIndex(0) : '';
    }
    function _IsDefaultCharacter(id) {
        const defaultTItem = LoadoutAPI.GetDefaultItem('t', 'customplayer');
        const defaultCTItem = LoadoutAPI.GetDefaultItem('ct', 'customplayer');
        return id == defaultTItem || id == defaultCTItem;
    }
    function _IsPreviewable(id) {
        return (!!ItemInfo.GetDefaultSlot(id) || ItemInfo.ItemMatchDefName(id, 'sticker') || ItemInfo.ItemMatchDefName(id, 'patch') || ItemInfo.ItemMatchDefName(id, 'spray'));
    }
    return {
        BIsRewardPremium: function (id) { return InventoryAPI.BIsRewardPremium(id); },
        DeepCopyVanityCharacterSettings: _DeepCopyVanityCharacterSettings,
        FindAnyUserOwnedCharacterItemID: _FindAnyUserOwnedCharacterItemID,
        GetCapabilitybyIndex: _GetCapabilitybyIndex,
        GetCapabilityCount: _GetCapabilityCount,
        GetChosenActionItemIDByIndex: _GetChosenActionItemIDByIndex,
        GetChosenActionItemsCount: _GetChosenActionItemsCount,
        GetDefaultCheer: _GetDefaultCheer,
        GetFauxItemIdForGraffiti: _GetFauxItemIdForGraffiti,
        GetFauxReplacementItemID: _GetFauxReplacementItemID,
        GetFormattedName: _GetFormattedName,
        GetGifter: _GetGifter,
        GetItemDefinitionName: _GetItemDefinitionName,
        GetItemIdForItemEquippedInSlot: _GetItemIdForItemEquippedInSlot,
        GetEquippedSlot: _GetEquippedSlot,
        GetEquippedItemIdForDefIndex: _GetEquippedItemIdForDefIndex,
        GetItemPickUpMethod: _GetItemPickUpMethod,
        GetItemsInXray: _GetItemsInXray,
        GetitemStickerList: _GetitemStickerList,
        GetKeyForCaseInXray: _GetKeyForCaseInXray,
        GetLoadoutPrice: _GetLoadoutPrice,
        GetLoadoutWeapons: _GetLoadoutWeapons,
        GetLootListCount: _GetLootListCount,
        GetLootListItemByIndex: _GetLootListItemByIndex,
        GetMarketLinkForLootlistItem: _GetMarketLinkForLootlistItem,
        GetModelPath: _GetModelPath,
        GetModelPathFromJSONOrAPI: _GetModelPathFromJSONOrAPI,
        GetModelPlayer: _GetModelPlayer,
        GetName: _GetName,
        GetNameWithRarity: _GetNameWithRarity,
        GetOrUpdateVanityCharacterSettings: _GetOrUpdateVanityCharacterSettings,
        GetRarityColor: _GetRarityColor,
        GetRewardTier: function (id) { return InventoryAPI.GetRewardTier(id); },
        GetSet: _GetSet,
        GetLoadoutCategory: _GetLoadoutCategory,
        GetDefaultSlot: _GetDefaultSlot,
        GetSprayTintColor: _GetSprayTintColor,
        GetStickerCount: _GetStickerCount,
        GetStickerSlotCount: _GetStickerSlotCount,
        GetStoreOriginalPrice: _GetStoreOriginalPrice,
        GetStoreSalePercentReduction: _GetStoreSalePercentReduction,
        GetStoreSalePrice: _GetStoreSalePrice,
        GetTeam: _GetTeam,
        GetToolType: _GetToolType,
        GetVoPrefix: _GetVoPrefix,
        IsCase: _IsCase,
        IsCharacter: _IsCharacter,
        IsGloves: _IsGloves,
        IsDefaultCharacter: _IsDefaultCharacter,
        IsDisplayItem: _IsDisplayItem,
        IsEquippableThroughContextMenu: _IsEquippableThroughContextMenu,
        IsEquippalbleButNotAWeapon: _IsEquippalbleButNotAWeapon,
        IsEquipped: _IsEquipped,
        IsEquippedForCT: _IsEquippedForCT,
        IsEquippedForNoTeam: _IsEquippedForNoTeam,
        IsEquippedForT: _IsEquippedForT,
        CanEquipItemInSlot: _CanEquipItemInSlot,
        IsItemAnyTeam: _IsItemAnyTeam,
        IsItemCt: _IsItemCt,
        IsItemT: _IsItemT,
        IsPatch: _IsPatch,
        IsPet: _IsPet,
        IsPreviewable: _IsPreviewable,
        IsSprayPaint: _IsSprayPaint,
        IsSpraySealed: _IsSpraySealed,
        IsStatTrak: _IsStatTrak,
        IsSticker: _IsSticker,
        IsTool: _IsTool,
        IsTradeUpContract: _IsTradeUpContract,
        IsWeapon: _IsWeapon,
        ItemDefinitionNameSubstrMatch: _ItemDefinitionNameSubstrMatch,
        ItemHasCapability: _ItemHasCapability,
        ItemMatchDefName: _ItemMatchDefName,
        ItemPurchase: _ItemPurchase,
        ItemsNeededToTradeUp: _ItemsNeededToTradeUp,
        PrecacheVanityCharacterSettings: _PrecacheVanityCharacterSettings,
        IsStockItem: _IsStockItem,
    };
})();
