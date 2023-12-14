"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/async.ts" />
/// <reference path="rating_emblem.ts" />
/// <reference path="mock_adapter.ts" />
var playerStatsCard;
(function (playerStatsCard) {
    const CARD_ID = 'card';
    function Init(elParent, xuid, index) {
        $.RegisterForUnhandledEvent("EndOfMatch_SkillGroupUpdated", _UpdateSkillGroup);
        let elCard = $.CreatePanel('Panel', elParent, CARD_ID);
        elCard.BLoadLayout("file://{resources}/layout/player_stats_card.xml", false, false);
        elCard.SetDialogVariableInt('playerslot', Number(MockAdapter.GetPlayerSlot(xuid)));
        elCard.SetDialogVariableInt('xuid', Number(xuid));
        elCard.SetHasClass('localplayer', xuid === MockAdapter.GetLocalPlayerXuid());
        let snippet = '';
        switch (MockAdapter.GetGameModeInternalName(false)) {
            case 'training':
            case 'deathmatch':
                snippet = 'snippet-banner-dm';
                break;
            default:
                snippet = 'snippet-banner-classic';
                break;
        }
        elCard.FindChildTraverse('JsBanner').BLoadLayoutSnippet(snippet);
        let elBannerBG = elCard.FindChildTraverse('JsBannerBG');
        elBannerBG.SetImage('file://{images}/stats_cards/stats_card_banner_' + index + '.png');
        let elCardBG = elCard.FindChildTraverse('JsCardBG');
        let maxCoord = 100;
        let minCoord = -100;
        let randX = Math.floor(Math.random() * (maxCoord - minCoord) + minCoord);
        let randY = Math.floor(Math.random() * (maxCoord - minCoord) + minCoord);
        elCardBG.style.backgroundPosition = randX + '% ' + randY + '%';
        return elCard;
    }
    playerStatsCard.Init = Init;
    function GetCard(elParent) {
        return elParent.FindChildTraverse(CARD_ID);
    }
    playerStatsCard.GetCard = GetCard;
    function SetAccolade(elCard, accValue, accName, accPosition) {
        if (!isNaN(Number(accValue))) {
            accValue = String(Math.floor(Number(accValue)));
        }
        elCard.SetDialogVariable('accolade-value-string', accValue);
        elCard.SetDialogVariableTime('accolade-value-time', Number(accValue));
        elCard.SetDialogVariableInt('accolade-value-int', Number(accValue));
        let secondPlaceSuffix = (accPosition != '1') ? '_2' : '';
        elCard.SetDialogVariable('accolade-the-title', $.Localize('#accolade_' + accName + secondPlaceSuffix));
        elCard.SetDialogVariable('accolade-desc', $.Localize('#accolade_' + accName + '_desc' + secondPlaceSuffix, elCard));
        let valueToken = '#accolade_' + accName + '_value';
        let valueLocalized = $.Localize('#accolade_' + accName + '_value', elCard);
        if (valueToken == valueLocalized)
            valueLocalized = '';
        elCard.SetDialogVariable('accolade-value', valueLocalized);
        elCard.SetHasClass('show-accolade', true);
    }
    playerStatsCard.SetAccolade = SetAccolade;
    function SetAvatar(elCard, xuid) {
        let elAvatarImage = elCard.FindChildTraverse('jsAvatar');
        elAvatarImage.PopulateFromPlayerSlot(MockAdapter.GetPlayerSlot(xuid));
        let team = MockAdapter.GetPlayerTeamName(xuid);
        elAvatarImage.SwitchClass('teamstyle', 'team--' + team);
    }
    playerStatsCard.SetAvatar = SetAvatar;
    function SetRank(elCard, xuid) {
        let rankLvl = MockAdapter.GetPlayerXpLevel(xuid);
        let elRankImage = elCard.FindChildTraverse('jsRankImage');
        elRankImage.SetImage("file://{images}/icons/xp/level" + rankLvl + ".png");
        elCard.SetDialogVariable('name', $.Localize('#SFUI_XP_RankName_' + rankLvl));
        elCard.SetDialogVariableInt('level', rankLvl);
        elCard.SetHasClass('show-rank', rankLvl >= 0);
    }
    playerStatsCard.SetRank = SetRank;
    function SetFlair(elCard, xuid) {
        let flairItemId = InventoryAPI.GetFlairItemId(xuid);
        if (flairItemId === "0" || !flairItemId) {
            const flairDefIdx = FriendsListAPI.GetFriendDisplayItemDefFeatured(xuid);
            flairItemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(flairDefIdx, 0);
            if (flairItemId === "0" || !flairItemId || flairDefIdx == 65535)
                return false;
        }
        const imagePath = InventoryAPI.GetItemInventoryImage(flairItemId);
        let elFlairImage = elCard.FindChildTraverse('jsFlairImage');
        elFlairImage.SetImage('file://{images}' + imagePath + '_small.png');
        elCard.SetHasClass('show-flair', true);
    }
    playerStatsCard.SetFlair = SetFlair;
    function _UpdateSkillGroup(strSkillgroupData) {
        const oSkillgroupData = JSON.parse(strSkillgroupData);
        Object.keys(oSkillgroupData).forEach(function (xuid, i) {
            const cardId = 'cardcontainer-' + xuid;
            const elCard = $.GetContextPanel().FindChildTraverse(cardId);
            if (elCard) {
                const newPlayerData = oSkillgroupData[xuid];
                if (newPlayerData && newPlayerData.hasOwnProperty('new_rank') && newPlayerData.hasOwnProperty('rank_type')) {
                    const options = {
                        root_panel: elCard.FindChildTraverse('jsRatingEmblem'),
                        xuid: xuid,
                        do_fx: true,
                        full_details: false,
                        leaderboard_details: { score: newPlayerData.new_rank },
                        rating_type: newPlayerData.rank_type,
                    };
                    $.Schedule(1.0 + 0.5 * i, () => {
                        if (elCard && elCard.IsValid()) {
                            RatingEmblem.SetXuid(options);
                            elCard.TriggerClass('skillgroup-update');
                        }
                    });
                }
            }
        });
    }
    function SetSkillGroup(elCard, xuid) {
        if (!elCard.FindChildTraverse('jsRatingEmblem'))
            return;
        let options = {
            root_panel: elCard.FindChildTraverse('jsRatingEmblem'),
            xuid: xuid,
            api: 'gamestate',
            do_fx: true,
            full_details: true,
        };
        const bShowSkillGroup = RatingEmblem.SetXuid(options);
        if (bShowSkillGroup) {
            elCard.RemoveClass('show-skillgroup');
            $.Schedule(0, () => elCard && elCard.IsValid() ? elCard.AddClass('show-skillgroup') : '');
        }
        else {
            elCard.RemoveClass('show-skillgroup');
        }
    }
    playerStatsCard.SetSkillGroup = SetSkillGroup;
    function SetStats(elCard, xuid, arrBestStats = null) {
        let oStats = MockAdapter.GetPlayerStatsJSO(xuid);
        let score = MockAdapter.GetPlayerScore(xuid);
        if (arrBestStats) {
            arrBestStats.forEach(function (oBest) {
                let stat = oBest.stat;
                if (oStats[stat] > 0 && (!oBest.value || oStats[stat] > oBest.value)) {
                    oBest.value = oStats[stat];
                    oBest.elCard = elCard;
                }
            });
        }
        elCard.SetDialogVariableInt('playercardstats-kills', Number(oStats.kills));
        elCard.SetDialogVariableInt('playercardstats-deaths', Number(oStats.deaths));
        elCard.SetDialogVariableInt('playercardstats-assists', Number(oStats.assists));
        elCard.SetDialogVariableInt('playercardstats-adr', Number(oStats.adr));
        elCard.SetDialogVariableInt('playercardstats-hsp', Number(oStats.hsp));
        elCard.SetDialogVariableInt('playercardstats-ef', Number(oStats.enemiesflashed));
        elCard.SetDialogVariableInt('playercardstats-ud', Number(oStats.utilitydamage));
        elCard.SetDialogVariableInt('playercardstats-score', Number(score));
        elCard.SetHasClass('show-stats', true);
    }
    playerStatsCard.SetStats = SetStats;
    function SetTeammateColor(elCard, xuid) {
        elCard.FindChildrenWithClassTraverse('colorize-teammate-color').forEach(function (elPlayerColor) {
            let teammateColor = MockAdapter.GetPlayerColor(xuid);
            let teamName = MockAdapter.GetPlayerTeamName(xuid);
            let teamColor = teammateColor ? teammateColor : teamName == 'CT' ? '#5ab8f4' : '#f0c941';
            elPlayerColor.style.washColor = (teamColor !== '') ? teamColor : 'black';
        });
    }
    playerStatsCard.SetTeammateColor = SetTeammateColor;
    async function RevealStats(elCard) {
        const DELAY_DELTA = 0.1;
        for (const elPanel of elCard.FindChildrenWithClassTraverse('sliding-panel')) {
            await Async.Delay(DELAY_DELTA);
            elPanel.AddClass('slide');
        }
    }
    playerStatsCard.RevealStats = RevealStats;
    function HighlightStat(elCard, stat) {
        elCard.AddClass('highlight-' + stat);
    }
    playerStatsCard.HighlightStat = HighlightStat;
})(playerStatsCard || (playerStatsCard = {}));
(function () {
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicGxheWVyX3N0YXRzX2NhcmQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9wbGF5ZXJfc3RhdHNfY2FyZC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsa0NBQWtDO0FBQ2xDLHdDQUF3QztBQUN4Qyx5Q0FBeUM7QUFDekMsd0NBQXdDO0FBRXhDLElBQVUsZUFBZSxDQXVReEI7QUF2UUQsV0FBVSxlQUFlO0lBRXhCLE1BQU0sT0FBTyxHQUFHLE1BQU0sQ0FBQztJQUV2QixTQUFnQixJQUFJLENBQUcsUUFBaUIsRUFBRSxJQUFZLEVBQUUsS0FBYTtRQUdwRSxDQUFDLENBQUMseUJBQXlCLENBQUUsOEJBQThCLEVBQUUsaUJBQWlCLENBQUUsQ0FBQztRQUdqRixJQUFJLE1BQU0sR0FBRyxDQUFDLENBQUMsV0FBVyxDQUFFLE9BQU8sRUFBRSxRQUFRLEVBQUUsT0FBTyxDQUFFLENBQUM7UUFDekQsTUFBTSxDQUFDLFdBQVcsQ0FBRSxpREFBaUQsRUFBRSxLQUFLLEVBQUUsS0FBSyxDQUFFLENBQUM7UUFDdEYsTUFBTSxDQUFDLG9CQUFvQixDQUFFLFlBQVksRUFBRSxNQUFNLENBQUUsV0FBVyxDQUFDLGFBQWEsQ0FBRSxJQUFJLENBQUUsQ0FBRSxDQUFFLENBQUM7UUFDekYsTUFBTSxDQUFDLG9CQUFvQixDQUFFLE1BQU0sRUFBRSxNQUFNLENBQUUsSUFBSSxDQUFFLENBQUUsQ0FBQztRQUV0RCxNQUFNLENBQUMsV0FBVyxDQUFFLGFBQWEsRUFBRSxJQUFJLEtBQUssV0FBVyxDQUFDLGtCQUFrQixFQUFFLENBQUUsQ0FBQztRQUUvRSxJQUFJLE9BQU8sR0FBRyxFQUFFLENBQUM7UUFFakIsUUFBUyxXQUFXLENBQUMsdUJBQXVCLENBQUUsS0FBSyxDQUFFLEVBQ3JEO1lBRUMsS0FBSyxVQUFVLENBQUM7WUFDaEIsS0FBSyxZQUFZO2dCQUNoQixPQUFPLEdBQUcsbUJB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