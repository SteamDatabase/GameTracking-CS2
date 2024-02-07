"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/formattext.ts" />
var TooltipPlayerXp;
(function (TooltipPlayerXp) {
    function Init() {
        let xuid = $.GetContextPanel().GetAttributeString("xuid", "not-found");
        let rawBonuses = MyPersonaAPI.GetActiveXpBonuses();
        let bonusesArray = rawBonuses.split(",");
        let maxLevel = InventoryAPI.GetMaxLevel();
        let currentPoints = FriendsListAPI.GetFriendXp(xuid);
        let pointsPerLevel = MyPersonaAPI.GetXpPerLevel();
        let currentLvl = FriendsListAPI.GetFriendLevel(xuid);
        let isDueServiceMedal = currentLvl >= maxLevel;
        $.GetContextPanel().SetDialogVariable("xpcurrent", String(currentPoints));
        $.GetContextPanel().SetDialogVariable("xptonext", String(pointsPerLevel - currentPoints));
        $("#JsTooltip_Xp_Current").text = isDueServiceMedal ? "#tooltip_xp_have_max_current" : "#tooltip_xp_current";
        $("#JsTooltip_Xp_Needed").text = isDueServiceMedal ? "#tooltip_xp_have_max_rank" : "#tooltip_xp_for_next_rank";
        if (bonusesArray.length > 0) {
            if (isDueServiceMedal) {
                for (let i = 0; i < bonusesArray.length; i++) {
                    if (bonusesArray[i] === '2')
                        bonusesArray.splice(i, 1);
                }
            }
        }
        let numBonusesAdded = 0;
        if (bonusesArray.length > 0) {
            $('#JsTooltipXpSection').RemoveClass('hidden');
            $("#JsTooltipXpBonuses").RemoveAndDeleteChildren();
            for (let i = 0; i < bonusesArray.length; i++) {
                if (!bonusesArray[i])
                    continue;
                ++numBonusesAdded;
                let newTile = $.CreatePanel("Label", $("#JsTooltipXpBonuses"), 'JsTooltipBonus' + i, { html: true });
                let secRemaining = StoreAPI.GetSecondsUntilXpRollover();
                newTile.SetDialogVariable('time-to-week-rollover', (secRemaining > 0) ? FormatText.SecondsToSignificantTimeString(secRemaining) : '');
                newTile.AddClass('tooltip-player-xp__subtitle');
                newTile.text = $.Localize("#tooltip_xp_bonus_" + bonusesArray[i], newTile);
            }
            let xpTrailTimeRemaining = MyPersonaAPI.GetXpTrailTimeRemaining();
            if (xpTrailTimeRemaining > 0) {
                ++numBonusesAdded;
                let newTile = $.CreatePanel("Label", $("#JsTooltipXpBonuses"), 'JsTooltipBonus_xptrail', { html: true });
                newTile.SetDialogVariable('xptrail-time-remaining', FormatText.SecondsToSignificantTimeString(xpTrailTimeRemaining));
                newTile.AddClass('tooltip-player-xp__subtitle');
                newTile.text = $.Localize("#tooltip_xp_bonus_xptrail", newTile);
            }
        }
        if (!numBonusesAdded) {
            $('#JsTooltipXpSection').AddClass('hidden');
        }
    }
    TooltipPlayerXp.Init = Init;
})(TooltipPlayerXp || (TooltipPlayerXp = {}));
