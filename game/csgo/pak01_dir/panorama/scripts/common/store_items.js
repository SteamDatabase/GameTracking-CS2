"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="iteminfo.ts" />
/// <reference path="../generated/items_event_current_generated_store.d.ts" />
/// <reference path="../generated/items_event_current_generated_store.ts" />
var StoreItems;
(function (StoreItems) {
    let m_oItemsByCategory = {
        coupon: [],
        tournament: [],
        prime: [],
        market: [],
        key: [],
        store: []
    };
    function MakeStoreItemList() {
        let count = StoreAPI.GetBannerEntryCount();
        if (!count || count < 1) {
            return;
        }
        m_oItemsByCategory = {
            coupon: [],
            tournament: [],
            prime: [],
            market: [],
            key: [],
            store: []
        };
        let isPerfectWorld = (MyPersonaAPI.GetLauncherType() === "perfectworld");
        let strBannerEntryCustomFormatString;
        for (var i = 0; i < count; i++) {
            let ItemId = StoreAPI.GetBannerEntryDefIdx(i);
            let FauxItemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(ItemId, 0);
            if (!isPerfectWorld &&
                InventoryAPI.IsTool(FauxItemId) &&
                (InventoryAPI.GetItemCapabilityByIndex(FauxItemId, 0) === 'decodable')) {
                m_oItemsByCategory.key.push({ id: FauxItemId });
            }
            else if (StoreAPI.IsBannerEntryMarketLink(i) === true) {
                m_oItemsByCategory.market.push({ id: FauxItemId, isMarketItem: true });
            }
            else if ((strBannerEntryCustomFormatString = StoreAPI.GetBannerEntryCustomFormatString(i)).startsWith("coupon")) {
                if (!AllowDisplayingItemInStore(FauxItemId))
                    continue;
                let sLinkedCoupon = StoreAPI.GetBannerEntryLinkedCoupon(i);
                if (sLinkedCoupon) {
                    let LinkedItemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(parseInt(sLinkedCoupon), 0);
                    m_oItemsByCategory.coupon.push({ id: FauxItemId, linkedid: LinkedItemId });
                }
                else if (strBannerEntryCustomFormatString === "coupon_new") {
                    m_oItemsByCategory.coupon.push({ id: FauxItemId, activationType: 'newstore', isNewRelease: true });
                }
                else {
                    m_oItemsByCategory.coupon.push({ id: FauxItemId });
                }
            }
            else {
                if (!AllowDisplayingItemInStore(FauxItemId))
                    continue;
                m_oItemsByCategory.store.push({ id: FauxItemId });
            }
        }
        GetTournamentItems();
    }
    StoreItems.MakeStoreItemList = MakeStoreItemList;
    function AllowDisplayingItemInStore(FauxItemId) {
        var idToCheckForRestrictions = FauxItemId;
        var bIsCouponCrate = InventoryAPI.IsCouponCrate(idToCheckForRestrictions);
        if (bIsCouponCrate && ItemInfo.GetLootListCount(idToCheckForRestrictions) > 0) {
            idToCheckForRestrictions = InventoryAPI.GetLootListItemIdByIndex(idToCheckForRestrictions, 0);
        }
        var sDefinitionName = InventoryAPI.GetItemDefinitionName(idToCheckForRestrictions);
        if (sDefinitionName === "crate_stattrak_swap_tool")
            return true;
        var bIsDecodable = ItemInfo.ItemHasCapability(idToCheckForRestrictions, 'decodable');
        var sRestriction = bIsDecodable ? InventoryAPI.GetDecodeableRestriction(idToCheckForRestrictions) : null;
        if (sRestriction === "restricted" || sRestriction === "xray") {
            return false;
        }
        return true;
    }
    function GetStoreItems() {
        return m_oItemsByCategory;
    }
    StoreItems.GetStoreItems = GetStoreItems;
    function GetStoreItemData(type, idx) {
        return m_oItemsByCategory[type][idx];
    }
    StoreItems.GetStoreItemData = GetStoreItemData;
    function GetTournamentItems() {
        var sRestriction = InventoryAPI.GetDecodeableRestriction("capsule");
        var bCanSellCapsules = (sRestriction !== "restricted" && sRestriction !== "xray");
        for (let i = 0; i < g_ActiveTournamentStoreLayout.length; i++) {
            if (!bCanSellCapsules && (i >= g_ActiveTournamentInfo.num_global_offerings)) {
                return;
            }
            let bContainsJustChampions = (typeof g_ActiveTournamentStoreLayout[i][1] === 'string');
            let FauxItemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(g_ActiveTournamentStoreLayout[i][0], 0);
            let GroupName = g_ActiveTournamentStoreLayout[i][2] ? g_ActiveTournamentStoreLayout[i][2] : '';
            let warning = warningTextTournamentItems(isPurchaseable(FauxItemId), FauxItemId);
            if (ItemInfo.GetStoreSalePrice(FauxItemId, 1)) {
                let storeItem = {
                    id: FauxItemId,
                    useTinyNames: true
                };
                if (isPurchaseable(FauxItemId)) {
                    storeItem.isNotReleased = true;
                }
                if (!bContainsJustChampions) {
                    storeItem.linkedid = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(g_ActiveTournamentStoreLayout[i][1], 0);
                }
                if (GroupName) {
                    storeItem.groupName != GroupName;
                }
                if (warning) {
                    storeItem.linkedWarning = warning;
                }
                m_oItemsByCategory.tournament?.push(storeItem);
            }
        }
    }
    function warningTextTournamentItems(isPurchaseable, itemid) {
        return !isPurchaseable ?
            '#tournament_items_not_released' : InventoryAPI.GetItemTypeFromEnum(itemid) === 'type_tool' ?
            '#tournament_items_notice' : '';
    }
    function isPurchaseable(itemid) {
        var schemaString = InventoryAPI.BuildItemSchemaDefJSON(itemid);
        if (!schemaString)
            return false;
        var itemSchemaDef = JSON.parse(schemaString);
        return itemSchemaDef["cannot_inspect"] === 1 ? false : true;
    }
    ;
})(StoreItems || (StoreItems = {}));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic3RvcmVfaXRlbXMuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9jb21tb24vc3RvcmVfaXRlbXMudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUNyQyxvQ0FBb0M7QUFDcEMsOEVBQThFO0FBQzlFLDRFQUE0RTtBQW9CNUUsSUFBVSxVQUFVLENBc01uQjtBQXRNRCxXQUFVLFVBQVU7SUFJbkIsSUFBSSxrQkFBa0IsR0FBc0I7UUFDM0MsTUFBTSxFQUFFLEVBQUU7UUFDVixVQUFVLEVBQUUsRUFBRTtRQUNkLEtBQUssRUFBRSxFQUFFO1FBQ1QsTUFBTSxFQUFFLEVBQUU7UUFDVixHQUFHLEVBQUUsRUFBRTtRQUNQLEtBQUssRUFBRSxFQUFFO0tBQ1QsQ0FBQztJQUVGLFNBQWdCLGlCQUFpQjtRQUVoQyxJQUFJLEtBQUssR0FBVyxRQUFRLENBQUMsbUJBQW1CLEVBQUUsQ0FBQztRQUVuRCxJQUFLLENBQUMsS0FBSyxJQUFJLEtBQUssR0FBRyxDQUFDLEVBQ3hCO1lBQ0MsT0FBTztTQUNQO1FBRUQsa0JBQWtCLEdBQUc7WUFDcEIsTUFBTSxFQUFFLEVBQUU7WUFDVixVQUFVLEVBQUUsRUFBRTtZQUNkLEtBQUssRUFBRSxFQUFFO1lBQ1QsTUFBTSxFQUFFLEVBQUU7WUFDVixHQUFHLEVBQUUsRUFBRTtZQUNQLEtBQUssRUFBRSxFQUFFO1NBQ1QsQ0FBQztRQUVGLElBQUksY0FBYyxHQUFHLENBQUUsWUFBWSxDQUFDLGVBQWUsRUFBRSxLQUFLLGNBQWMsQ0FBRSxDQUFDO1FBQzNFLElBQUksZ0NBQXdDLENBQUM7UUFFN0MsS0FBTSxJQUFJLENBQUMsR0FBRyxDQUFDLEVBQUUsQ0FBQyxHQUFHLEtBQUssRUFBRSxDQUFDLEVBQUUsRUFDL0I7WUFDQyxJQUFJLE1BQU0sR0FBRyxRQUFRLENBQUMsb0JBQW9CLENBQUUsQ0FBQyxDQUFFLENBQUM7WUFD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