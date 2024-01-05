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
