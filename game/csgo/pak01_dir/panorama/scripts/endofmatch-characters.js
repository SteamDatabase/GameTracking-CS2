"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="endofmatch.ts" />
/// <reference path="scoreboard.ts" />
/// <reference path="player_stats_card.ts" />
/// <reference path="mock_adapter.ts" />
var EOM_Characters = (function () {
    let _m_arrAllPlayersMatchDataJSO = [];
    let _m_localPlayer = null;
    let _m_teamToShow = null;
    const ACCOLADE_START_TIME = 1;
    const DELAY_PER_PLAYER = 0.5;
    let m_bNoGimmeAccolades = false;
    function _GetSnippetForMode(mode) {
        switch (mode) {
            case 'scrimcomp2v2':
                return 'snippet-eom-chars__layout--scrimcomp2v2';
            case 'competitive':
            case 'cooperative':
            case 'casual':
            case 'teamdm':
                return 'snippet-eom-chars__layout--classic';
            case 'training':
            case 'deathmatch':
            case 'ffadm':
                return 'snippet-eom-chars__layout--ffa';
            default:
                return 'snippet-eom-chars__layout--classic';
        }
    }
    function _SetTeamLogo(team) {
        let elRoot = $('#id-eom-characters-root');
        let teamLogoPath = 'file://{images}/icons/ui/' + (team == 'ct' ? 'ct_logo_1c.svg' : 't_logo_1c.svg');
        let elTeamLogo = elRoot.FindChildTraverse('id-eom-chars__layout__logo--' + team);
        if (elTeamLogo) {
            elTeamLogo.SetImage(teamLogoPath);
        }
    }
    function _SetupPanel(mode) {
        let elRoot = $('#id-eom-characters-root');
        let snippet = _GetSnippetForMode(mode);
        elRoot.RemoveAndDeleteChildren();
        elRoot.BLoadLayoutSnippet(snippet);
        _SetTeamLogo('t');
        _SetTeamLogo('ct');
    }
    function _CollectPlayersForMode(mode) {
        let arrPlayerList = [];
        switch (mode) {
            case 'deathmatch':
            case 'ffadm':
                {
                    let arrPlayerXuids = Scoreboard.GetFreeForAllTopThreePlayers();
                    if (MockAdapter.GetMockData() != undefined) {
                        arrPlayerXuids = ['1', '2', '3'];
                    }
                    arrPlayerList[0] = _m_arrAllPlayersMatchDataJSO.filter(o => o['xuid'] == arrPlayerXuids[0])[0];
                    arrPlayerList[1] = _m_arrAllPlayersMatchDataJSO.filter(o => o['xuid'] == arrPlayerXuids[1])[0];
                    arrPlayerList[2] = _m_arrAllPlayersMatchDataJSO.filter(o => o['xuid'] == arrPlayerXuids[2])[0];
                    m_bNoGimmeAccolades = true;
                    break;
                }
            case 'training':
            case 'scrimcomp2v2':
                {
                    let listCT = _CollectPlayersOfTeam('CT').slice(0, 2);
                    let listT = _CollectPlayersOfTeam('TERRORIST').slice(0, 2);
                    arrPlayerList = listCT.concat(listT);
                    m_bNoGimmeAccolades = false;
                    break;
                }
            case 'competitive':
            case 'casual':
            case 'cooperative':
            case 'teamdm':
            default:
                {
                    arrPlayerList = _CollectPlayersOfTeam(_m_teamToShow);
                    arrPlayerList = arrPlayerList.sort(_SortByScoreFn);
                    m_bNoGimmeAccolades = false;
                    if (_m_localPlayer) {
                        arrPlayerList = arrPlayerList.filter(player => player['xuid'] != _m_localPlayer['xuid']);
                        arrPlayerList.splice(0, 0, _m_localPlayer);
                    }
                    break;
                }
        }
        if (arrPlayerList)
            arrPlayerList = arrPlayerList.slice(0, _GetNumCharsToShowForMode(mode));
        return arrPlayerList;
    }
    function _CollectPlayersOfTeam(teamName) {
        let teamNum = 0;
        switch (teamName) {
            case 'TERRORIST':
                teamNum = 2;
                break;
            case 'CT':
                teamNum = 3;
                break;
        }
        return _m_arrAllPlayersMatchDataJSO.filter(o => o['teamnumber'] == teamNum);
    }
    function _GetNumCharsToShowForMode(mode) {
        switch (mode) {
            case 'scrimcomp2v2':
                return 4;
            case 'competitive':
                return 5;
            case 'casual':
            case 'teamdm':
                return 5;
            case 'cooperative':
                return 2;
            case 'deathmatch':
            case 'ffadm':
                return 3;
            case 'training':
                return 1;
            default:
                return 5;
        }
    }
    function _ShouldDisplayCommendsInMode(mode) {
        if (MyPersonaAPI.GetElevatedState() !== 'elevated') {
            return false;
        }
        switch (mode) {
            case 'scrimcomp2v2':
            case 'competitive':
            case 'casual':
            case 'cooperative':
            case 'teamdm':
                return true;
            case 'deathmatch':
            case 'ffadm':
            case 'training':
            default:
                return false;
        }
    }
    function _GetModeForEndOfMatchPurposes() {
        let mode = MockAdapter.GetGameModeInternalName(false);
        if (mode == 'deathmatch') {
            if (GameInterfaceAPI.GetSettingString('mp_teammates_are_enemies') !== '0') {
                mode = 'ffadm';
            }
            else if (GameInterfaceAPI.GetSettingString('mp_dm_teammode') !== '0') {
                mode = 'teamdm';
            }
        }
        return mode;
    }
    function _ShowWinningTeam(mode) {
        return false;
    }
    let _DisplayMe = function () {
        let data = MockAdapter.GetAllPlayersMatchDataJSO();
        if (data && data.allplayerdata && data.allplayerdata.length > 0) {
            _m_arrAllPlayersMatchDataJSO = data.allplayerdata;
        }
        else {
            // @ts-ignore Ignore until endofmatch.js is TypeScript
            EndOfMatch.ToggleBetweenScoreboardAndCharacters();
            return false;
        }
        // @ts-ignore Ignore until endofmatch.js is TypeScript
        EndOfMatch.EnableToggleBetweenScoreboardAndCharacters();
        let localPlayerSet = _m_arrAllPlayersMatchDataJSO.filter(oPlayer => oPlayer['xuid'] == MockAdapter.GetLocalPlayerXuid());
        let localPlayer = (localPlayerSet.length > 0) ? localPlayerSet[0] : undefined;
        let teamNumToShow = 3;
        let mode = _GetModeForEndOfMatchPurposes();
        if (localPlayer && !_ShowWinningTeam(mode)) {
            _m_localPlayer = localPlayer;
            teamNumToShow = _m_localPlayer['teamnumber'];
        }
        else {
            let oMatchEndData = MockAdapter.GetMatchEndWinDataJSO();
            if (oMatchEndData)
                teamNumToShow = oMatchEndData['winning_team_number'];
            if (!teamNumToShow && localPlayer) {
                _m_localPlayer = localPlayer;
                teamNumToShow = _m_localPlayer['teamnumber'];
            }
        }
        if (teamNumToShow == 2) {
            _m_teamToShow = 'TERRORIST';
        }
        else {
            _m_teamToShow = 'CT';
        }
        _SetupPanel(mode);
        let arrPlayerList = _CollectPlayersForMode(mode);
        arrPlayerList = _SortPlayers(mode, arrPlayerList);
        let mapCheers = {};
        if (_m_localPlayer) {
            let arrLocalPlayer = _m_localPlayer.hasOwnProperty('items') ? _m_localPlayer.items.filter(oItem => ItemInfo.IsCharacter(oItem.itemid)) : [];
            let localPlayerModel = arrLocalPlayer[0];
            let localPlayerCheer = localPlayerModel ? ItemInfo.GetDefaultCheer(localPlayerModel['itemid']) : '';
            mapCheers[localPlayerCheer] = 1;
        }
        let gapIndex = -1;
        if (mode == 'scrimcomp2v2' && arrPlayerList.length > 0) {
            let firstTeamNum = arrPlayerList[0].teamnumber;
            gapIndex = arrPlayerList.findIndex(player => player.teamnumber != firstTeamNum);
        }
        $.GetContextPanel().SetPlayerCount(arrPlayerList.length + (gapIndex >= 0 ? 1 : 0));
        arrPlayerList.forEach(function (oPlayer, index) {
            if (oPlayer) {
                if (index >= gapIndex && gapIndex >= 0)
                    index += 1;
                let sAgentItemId = '';
                let sGlovesItemId = '';
                let sWeaponItemId = '';
                let cheer = '';
                if ('items' in oPlayer) {
                    let agentItem = oPlayer['items'].filter(oItem => ItemInfo.IsCharacter(oItem['itemid']))[0];
                    if (agentItem) {
                        sAgentItemId = agentItem['itemid'];
                        cheer = ItemInfo.GetDefaultCheer(sAgentItemId);
                    }
                    let glovesItem = oPlayer['items'].filter(oItem => ItemInfo.IsGloves(oItem['itemid']))[0];
                    if (glovesItem) {
                        sGlovesItemId = glovesItem['itemid'];
                    }
                    let weaponItem = oPlayer['items'].filter(oItem => ItemInfo.IsWeapon(oItem['itemid']))[0];
                    if (weaponItem) {
                        sWeaponItemId = weaponItem['itemid'];
                    }
                }
                if (oPlayer != _m_localPlayer &&
                    mapCheers[cheer] == 1) {
                    cheer = '';
                }
                mapCheers[cheer] = 1;
                let label = oPlayer['xuid'];
                $.GetContextPanel().AddPlayer(index, label, sAgentItemId, sGlovesItemId, sWeaponItemId, cheer);
            }
        });
        _CreatePlayerStatCards(arrPlayerList, gapIndex, m_bNoGimmeAccolades);
        return true;
    };
    function _DisplayPlayerStatsCard(elCardContainer, index, nPlayerCount) {
        let elEndOfMatch = $.GetContextPanel();
        let w = elEndOfMatch.actuallayoutwidth;
        let h = elEndOfMatch.actuallayoutheight;
        let xMin = 1080 * (w / h) * 0.5 - 720;
        let x = xMin + 1440 * ((index + 1) / (nPlayerCount + 1));
        let charPos = { x: x, y: 540 };
        if (elCardContainer && elCardContainer.IsValid()) {
            elCardContainer.style.x = charPos.x + 'px;';
            let elCard = elCardContainer.FindChildTraverse('card');
            elCardContainer.AddClass('reveal');
            $.Schedule(0.3, function () {
                playerStatsCard.RevealStats(elCard);
            });
        }
        if (!$.GetContextPanel().BAscendantHasClass('scoreboard-visible')) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.stats_reveal', 'MOUSE');
        }
    }
    function _CreatePlayerStatCards(arrPlayerList, gapIndex, bNoGimmes) {
        if (!arrPlayerList || arrPlayerList.length == 0)
            return;
        let arrBestStats = [
            { stat: 'adr', value: null, elCard: null },
            { stat: 'hsp', value: null, elCard: null },
            { stat: 'enemiesflashed', value: null, elCard: null },
            { stat: 'utilitydamage', value: null, elCard: null }
        ];
        let nPlayerCount = arrPlayerList.length + (gapIndex >= 0 ? 1 : 0);
        let elRoot = $('#id-eom-characters-root');
        arrPlayerList.forEach(function (oPlayer) {
            if (!oPlayer)
                return;
            let oTitle = oPlayer.nomination;
            let index = arrPlayerList.indexOf(oPlayer);
            if (index >= gapIndex && gapIndex >= 0)
                index += 1;
            if (oTitle != undefined) {
                let xuid = oPlayer.xuid;
                let elCardContainer = $.CreatePanel('Panel', elRoot, 'cardcontainer-' + xuid);
                elCardContainer.AddClass('player-stats-card-container');
                elCardContainer.style.zIndex = (index * 10).toString();
                let elCard = playerStatsCard.Init(elCardContainer, xuid, index);
                let accName = GameStateAPI.GetAccoladeLocalizationString(Number(oTitle.eaccolade));
                let showAccolade = !(bNoGimmes && accName.includes('gimme_'));
                if (showAccolade) {
                    let accValue = oTitle.value.toString();
                    let accPosition = oTitle.position.toString();
                    playerStatsCard.SetAccolade(elCard, accValue, accName, accPosition);
                }
                playerStatsCard.SetStats(elCard, xuid, arrBestStats);
                playerStatsCard.SetFlair(elCard, xuid);
                playerStatsCard.SetSkillGroup(elCard, xuid);
                playerStatsCard.SetAvatar(elCard, xuid);
                playerStatsCard.SetTeammateColor(elCard, xuid);
                $.Schedule(ACCOLADE_START_TIME + (index * DELAY_PER_PLAYER), _DisplayPlayerStatsCard.bind(undefined, elCardContainer, index, nPlayerCount));
            }
            else {
            }
        });
        arrBestStats.forEach(function (oBest) {
            if (oBest.elCard)
                playerStatsCard.HighlightStat(oBest.elCard, oBest.stat);
        });
    }
    function _SortByTeamFn(a, b) {
        let team_a = Number(a['teamnumber']);
        let team_b = Number(b['teamnumber']);
        let index_a = Number(a['slot']);
        let index_b = Number(b['slot']);
        if (team_a != team_b) {
            return team_b - team_a;
        }
        else {
            return index_a - index_b;
        }
    }
    function _SortByScoreFn(a, b) {
        let score_a = MockAdapter.GetPlayerScore(a['xuid']);
        let score_b = MockAdapter.GetPlayerScore(b['xuid']);
        let index_a = Number(a['slot']);
        let index_b = Number(b['slot']);
        if (score_a != score_b) {
            return score_b - score_a;
        }
        else {
            return index_a - index_b;
        }
    }
    function _SortPlayers(mode, arrPlayerList) {
        let midpoint;
        let localPlayerPosition;
        switch (mode) {
            case 'scrimcomp2v2':
                arrPlayerList.sort(_SortByTeamFn);
                break;
            case 'no longer used but force local player to the middle':
                if (_m_localPlayer &&
                    _m_localPlayer.hasOwnProperty('xuid') &&
                    (arrPlayerList.filter(p => p.xuid == _m_localPlayer.xuid).length > 0)) {
                    midpoint = Math.floor(arrPlayerList.length / 2);
                    arrPlayerList = arrPlayerList.filter(player => player['xuid'] != _m_localPlayer['xuid']);
                    arrPlayerList.splice(midpoint, 0, _m_localPlayer);
                }
                break;
            case 'no longer used but force player to have a spot':
                if (_m_localPlayer && arrPlayerList.includes(_m_localPlayer)) {
                    localPlayerPosition = Math.min(arrPlayerList.indexOf(_m_localPlayer), 7);
                    arrPlayerList = arrPlayerList.filter(player => player['xuid'] != _m_localPlayer['xuid']);
                    arrPlayerList.splice(localPlayerPosition, 0, _m_localPlayer);
                }
                break;
            case 'deathmatch':
            case 'ffadm':
            case 'casual':
            case 'teamdm':
            default:
                break;
        }
        return arrPlayerList;
    }
    function _RankRevealAll() {
        let mode = _GetModeForEndOfMatchPurposes();
        let arrPlayerList = _CollectPlayersForMode(mode);
        arrPlayerList.forEach(function (oPlayer) {
            if (!oPlayer)
                return;
            let xuid = oPlayer.xuid;
            let elCardContainer = $.GetContextPanel().FindChildTraverse('cardcontainer-' + xuid);
            if (elCardContainer) {
                let elCard = playerStatsCard.GetCard(elCardContainer);
                playerStatsCard.SetSkillGroup(elCard, xuid);
            }
        });
    }
    function _Start() {
        _DisplayMe();
        $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.gameover_show', 'MOUSE');
    }
    function _Shutdown() {
        $('#id-eom-characters-root').FindChildrenWithClassTraverse('eom-chars__accolade').forEach(el => el.DeleteAsync(.0));
        $('#id-eom-characters-root').RemoveAndDeleteChildren();
    }
    return {
        Start: _Start,
        Shutdown: _Shutdown,
        GetModeForEndOfMatchPurposes: _GetModeForEndOfMatchPurposes,
        ShowWinningTeam: _ShowWinningTeam,
        RankRevealAll: _RankRevealAll,
    };
})();
(function () {
    $.RegisterForUnhandledEvent('GameState_RankRevealAll', EOM_Characters.RankRevealAll);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZW5kb2ZtYXRjaC1jaGFyYWN0ZXJzLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvZW5kb2ZtYXRjaC1jaGFyYWN0ZXJzLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFDbEMsc0NBQXNDO0FBQ3RDLHNDQUFzQztBQUN0Qyw2Q0FBNkM7QUFDN0Msd0NBQXdDO0FBR3hDLElBQUksY0FBYyxHQUFHLENBRXBCO0lBR0MsSUFBSSw0QkFBNEIsR0FBb0QsRUFBRSxDQUFDO0lBRXZGLElBQUksY0FBYyxHQUF5RCxJQUFJLENBQUM7SUFDaEYsSUFBSSxhQUFhLEdBQThCLElBQUksQ0FBQztJQUVwRCxNQUFNLG1CQUFtQixHQUFHLENBQUMsQ0FBQztJQUM5QixNQUFNLGdCQUFnQixHQUFHLEdBQUcsQ0FBQztJQUU3QixJQUFJLG1CQUFtQixHQUFHLEtBQUssQ0FBQztJQUVoQyxTQUFTLGtCQUFrQixDQUFHLElBQVk7UUFFekMsUUFBUyxJQUFJLEVBQ2I7WUFFQyxLQUFLLGNBQWM7Z0JBQ2xCLE9BQU8seUNBQXlDLENBQUM7WUFHbEQsS0FBSyxhQUFhLENBQUM7WUFDbkIsS0FBSyxhQUFhLENBQUM7WUFDbkIsS0FBSyxRQUFRLENBQUM7WUFDZCxLQUFLLFFBQVE7Z0JBQ1osT0FBTyxvQ0FBb0MsQ0FBQztZQUc3QyxLQUFLLFVBQVUsQ0FBQztZQUNoQixLQUFLLFlBQVksQ0FBQztZQUNsQixLQUFLLE9BQU87Z0JBQ1gsT0FBTyxnQ0FBZ0MsQ0FBQztZQUV6QztnQkFDQyxPQUFPLG9DQUFvQyxDQUFDO1NBQzdDO0lBQ0YsQ0FBQztJQUVELFNBQVMsWUFBWSxDQUFHLElBQWdCO1FBRXZDLElBQUksTUFBTSxHQUFHLENBQUMsQ0FBRSx5QkFBeUIsQ0FBRyxDQUFDO1FBRTdDLElBQUksWUFBWSxHQUFHLDJCQUEyQixHQUFHLENBQUUsSUFBSSxJQUFJLElBQUksQ0FB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