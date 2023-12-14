"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/iteminfo.ts" />
/// <reference path="rating_emblem.ts" />
var MockAdapter = (function () {
    const k_GetMatchEndWinDataJSO = "k_GetMatchEndWinDataJSO";
    const k_GetScoreDataJSO = "k_GetScoreDataJSO";
    const k_GetPlayerName = "k_GetPlayerName";
    const k_IsFakePlayer = "k_IsFakePlayer";
    const k_XpDataJSO = "k_XpDataJSO";
    const k_GetGameModeInternalName = "k_GetGameModeInternalName";
    const k_GetGameModeName = "k_GetGameModeName";
    const k_SkillgroupDataJSO = "k_SkillgroupDataJSO";
    const k_DropListJSO = "k_DropListJSO";
    const k_GetTimeDataJSO = "k_GetTimeDataJSO";
    const k_NextMatchVotingData = "k_NextMatchVotingData";
    const k_GetPlayerStatsJSO = "k_GetPlayerStatsJSO";
    const k_GetPlayerDataJSO = "k_GetPlayerDataJSO";
    const k_IsTournamentMatch = "k_IsTournamentMatch";
    const k_GetServerName = "k_GetServerName";
    const k_GetMapName = "k_GetMapName";
    const k_GetTournamentEventStage = "k_GetTournamentEventStage";
    const k_GetGameModeImagePath = "k_GetGameModeImagePath";
    const k_GetMapBSPName = "k_GetMapBSPName";
    const k_GetPlayerTeamName = "k_GetPlayerTeamName";
    const k_GetPlayerTeamNumber = "k_GetPlayerTeamNumber";
    const k_GetTeamNextRoundLossBonus = "k_GetTeamNextRoundLossBonus";
    const k_AreTeamsPlayingSwitchedSides = "k_AreTeamsPlayingSwitchedSides";
    const k_AreTeamsPlayingSwitchedSidesInRound = "k_AreTeamsPlayingSwitchedSidesInRound";
    const k_HasHalfTime = "k_HasHalfTime";
    const k_IsDemoOrHltv = "k_IsDemoOrHltv";
    const k_IsHLTVAutodirectorOn = "k_IsHLTVAutodirectorOn";
    const k_GetTeamLogoImagePath = "k_GetTeamLogoImagePath";
    const k_GetTeamLivingPlayerCount = "k_GetTeamLivingPlayerCount";
    const k_GetTeamTotalPlayerCount = "k_GetTeamTotalPlayerCount";
    const k_GetTeamClanName = "k_GetTeamClanName";
    const k_IsXuidValid = "k_IsXuidValid";
    const k_GetPlayerSlot = "k_GetPlayerSlot";
    const k_GetLocalPlayerXuid = "k_GetLocalPlayerXuid";
    const k_IsLocalPlayerHLTV = "k_IsLocalPlayerHLTV";
    const k_GetPlayerStatus = "k_GetPlayerStatus";
    const k_GetPlayerCommendsLeader = "k_GetPlayerCommendsLeader";
    const k_GetPlayerCommendsFriendly = "k_GetPlayerCommendsFriendly";
    const k_GetPlayerCommendsTeacher = "k_GetPlayerCommendsTeacher";
    const k_GetPlayerCompetitiveRanking = "k_GetPlayerCompetitiveRanking";
    const k_GetPlayerCompetitiveWins = "k_GetPlayerCompetitiveWins";
    const k_GetPlayerXpLevel = "k_GetPlayerXpLevel";
    const k_GetPlayerScore = "k_GetPlayerScore";
    const k_GetPlayerMVPs = "k_GetPlayerMVPs";
    const k_GetPlayerKills = "k_GetPlayerKills";
    const k_GetPlayerAssists = "k_GetPlayerAssists";
    const k_GetPlayerDeaths = "k_GetPlayerDeaths";
    const k_GetPlayerPing = "k_GetPlayerPing";
    const k_GetPlayerColor = "k_GetPlayerColor";
    const k_HasCommunicationAbuseMute = "k_HasCommunicationAbuseMute";
    const k_IsSelectedPlayerMuted = "IsSelectedPlayerMuted";
    const k_IsPlayerConnected = "k_IsPlayerConnected";
    const k_ArePlayersEnemies = "k_ArePlayersEnemies";
    const k_GetPlayerClanTag = "k_GetPlayerClanTag";
    const k_GetPlayerMoney = "k_GetPlayerMoney";
    const k_GetPlayerActiveWeaponItemId = "k_GetPlayerActiveWeaponItemId";
    const k_GetPlayerModel = "k_GetPlayerModel";
    const k_GetPlayerItemCT = "k_GetPlayerItemCT";
    const k_GetPlayerItemTerrorist = "k_GetPlayerItemTerrorist";
    const k_AccoladesJSO = "k_AccoladesJSO";
    const k_GetCharacterDefaultCheerByXuid = "k_GetCharacterDefaultCheerByXuid";
    const k_GetCooperativePlayerTeamName = "k_GetCooperativePlayerTeamName";
    const k_GetAllPlayersMatchDataJSO = "k_GetAllPlayersMatchDataJSO";
    const k_GetPlayerCharacterItemID = "k_GetPlayerCharacterItemID";
    const k_GetFauxItemIDFromDefAndPaintIndex = "k_GetFauxItemIDFromDefAndPaintIndex";
    const k_GetPlayerCompetitiveRankType = "k_GetPlayerCompetitiveRankType";
    const k_bSkillgroupDataReady = "k_bSkillgroupDataReady";
    const k_GetPipRankCount = "k_GetPipRankCount";
    const k_GetPlayerPremierRankStatsObject = "k_GetPlayerPremierRankStatsObject";
    const k_bXpDataReady = "k_bXpDataReady";
    var _m_mockData = _GetMockData();
    function _msg(msg) {
    }
    function _GetRootPanel() {
        let parent = $.GetContextPanel().GetParent();
        let newParent;
        while (newParent = parent.GetParent())
            parent = newParent;
        return parent;
    }
    function _SetMockData(dummydata) {
        let elRoot = _GetRootPanel();
        elRoot.Data().m_mockData = dummydata;
    }
    function _GetMockData() {
        let elRoot = _GetRootPanel();
        if (!elRoot.Data().hasOwnProperty('m_mockData'))
            return undefined;
        else
            return elRoot.Data().m_mockData;
    }
    function _GetMockTables() {
        let elRoot = _GetRootPanel();
        if (!elRoot.Data().hasOwnProperty('m_mockTables'))
            return undefined;
        else
            return elRoot.Data().m_mockTables;
    }
    function _AddTable(name, table) {
        let elRoot = _GetRootPanel();
        if (!elRoot.Data().hasOwnProperty('m_mockTables'))
            elRoot.Data().m_mockTables = {};
        elRoot.Data().m_mockTables[name] = table;
    }
    function FindMockTable(key) {
        const arrTablesInUse = _m_mockData.split(',');
        for (let group of arrTablesInUse) {
            let mockTables = _GetMockTables();
            if (mockTables && mockTables.hasOwnProperty(group) && mockTables[group].hasOwnProperty(key)) {
                return mockTables[group];
            }
        }
        return undefined;
    }
    function _APIAccessor(val, key, xuid = -1) {
        if (!_m_mockData) {
            return val;
        }
        const table = FindMockTable(key);
        if (!table) {
            return val;
        }
        let tableVal;
        if (xuid !== -1 && table[key].hasOwnProperty(xuid)) {
            tableVal = table[key][xuid];
        }
        else if (xuid !== -1 && !table[key].hasOwnProperty(xuid)) {
            tableVal = table[key][0];
        }
        else {
            tableVal = table[key];
        }
        if (tableVal && typeof tableVal === "function") {
            return tableVal(xuid);
        }
        else {
            return tableVal;
        }
    }
    const _getLoadoutWeapons = function (team) {
        const list = [];
        const slotStrings = LoadoutAPI.GetLoadoutSlotNames(false);
        const slots = JSON.parse(slotStrings);
        slots.forEach(slot => {
            const itemId = LoadoutAPI.GetItemID(team, slot);
            const bIsWeapon = ItemInfo.IsWeapon(itemId);
            if (bIsWeapon) {
                list.push(itemId);
            }
        });
        return list;
    };
    function _GetRandomWeaponFromLoadout() {
        const team = (_m_mockData.search('team_ct') !== -1) ? 'ct' : 't';
        const list = _getLoadoutWeapons(team);
        return list[_r(0, list.length)];
    }
    function _GetRandomPlayerStatsJSO(xuid) {
        const oPlayerStats = { "damage": 0, "kills": 0, "assists": 0, "deaths": 0, "adr": 0, "kdr": 0, "3k": 0, "4k": 0, "5k": 0, "headshotkills": 0, "hsp": 0, "worth": 0, "killreward": 0, "cashearned": 99, "livetime": 0, "objective": 0, "utilitydamage": 0, "enemiesflashed": 0 };
        Object.keys(oPlayerStats).forEach(stat => {
            oPlayerStats[stat] = _r();
        });
        return oPlayerStats;
    }
    function _r(min = 0, max = 100) {
        return Math.round(Math.random() * ((max - min) + min) + 0.5);
    }
    ;
    function _GetRandomXP() {
        const ret = {
            "xp_earned": {
                "2": _r(0, 1000),
                "6": _r(0, 1000),
            },
            "current_level": _r(0, 39),
            "current_xp": _r(0, 4999),
        };
        return ret;
    }
    function _GetRandomSkillGroup() {
        const oldrank = _r(1, 18);
        const newrank = oldrank + _r(-1, 1);
        const ret = {
            "old_rank": oldrank,
            "new_rank": newrank,
            "num_wins": _r(10, 1000),
            "rank_change": newrank - oldrank,
            "rank_type": "Premier"
        };
        return ret;
    }
    function _GetRandomPlayerModel(team) {
        const PlayerModels = {
            "ct": [
                "characters/models/ctm_fbi/ctm_fbi.vmdl",
                "characters/models/ctm_fbi/ctm_fbi_constianta.vmdl",
                "characters/models/ctm_fbi/ctm_fbi_constiantb.vmdl",
                "characters/models/ctm_fbi/ctm_fbi_constiantc.vmdl",
                "characters/models/ctm_fbi/ctm_fbi_constiantd.vmdl",
                "characters/models/ctm_fbi/ctm_fbi_constiante.vmdl",
                "characters/models/ctm_fbi/ctm_fbi_constianth.vmdl",
                "characters/models/ctm_fbi/ctm_fbi_constiantf.vmdl",
                "characters/models/ctm_fbi/ctm_fbi_constiantg.vmdl",
                "characters/models/ctm_st6.vmdl",
                "characters/models/ctm_st6_constianta.vmdl",
                "characters/models/ctm_st6_constiantb.vmdl",
                "characters/models/ctm_st6_constiantc.vmdl",
                "characters/models/ctm_st6_constiantd.vmdl",
                "characters/models/ctm_st6_constianti.vmdl",
                "characters/models/ctm_st6_constiantm.vmdl",
                "characters/models/ctm_st6_constiantg.vmdl",
                "characters/models/ctm_st6_constiantk.vmdl",
                "characters/models/ctm_st6_constiante.vmdl",
                "characters/models/ctm_gign/ctm_gign.vmdl",
                "characters/models/ctm_gign/ctm_gign_constianta.vmdl",
                "characters/models/ctm_gign/ctm_gign_constiantb.vmdl",
                "characters/models/ctm_gign/ctm_gign_constiantc.vmdl",
                "characters/models/ctm_gign/ctm_gign_constiantd.vmdl",
                "characters/models/ctm_gsg9.vmdl",
                "characters/models/ctm_gsg9_constianta.vmdl",
                "characters/models/ctm_gsg9_constiantb.vmdl",
                "characters/models/ctm_gsg9_constiantc.vmdl",
                "characters/models/ctm_gsg9_constiantd.vmdl",
                "characters/models/ctm_idf/ctm_idf.vmdl",
                "characters/models/ctm_idf/ctm_idf_constiantb.vmdl",
                "characters/models/ctm_idf/ctm_idf_constiantc.vmdl",
                "characters/models/ctm_idf/ctm_idf_constiantd.vmdl",
                "characters/models/ctm_idf/ctm_idf_constiante.vmdl",
                "characters/models/ctm_idf/ctm_idf_constiantf.vmdl",
                "characters/models/ctm_sas/ctm_sas.vmdl",
                "characters/models/ctm_sas/ctm_sas_constiantf.vmdl",
                "characters/models/ctm_swat/ctm_swat.vmdl",
                "characters/models/ctm_swat/ctm_swat_constianta.vmdl",
                "characters/models/ctm_swat/ctm_swat_constiantb.vmdl",
                "characters/models/ctm_swat/ctm_swat_constiantc.vmdl",
                "characters/models/ctm_swat/ctm_swat_constiantd.vmdl",
                "characters/models/ctm_heavy/ctm_heavy.vmdl",
            ],
            "t": [
                "characters/models/tm_balkan/tm_balkan_constiante.vmdl",
                "characters/models/tm_balkan/tm_balkan_constianta.vmdl",
                "characters/models/tm_balkan/tm_balkan_constiantb.vmdl",
                "characters/models/tm_balkan/tm_balkan_constiantc.vmdl",
                "characters/models/tm_balkan/tm_balkan_constiantd.vmdl",
                "characters/models/tm_balkan/tm_balkan_constiantf.vmdl",
                "characters/models/tm_balkan/tm_balkan_constiantg.vmdl",
                "characters/models/tm_balkan/tm_balkan_constianth.vmdl",
                "characters/models/tm_balkan/tm_balkan_constianti.vmdl",
                "characters/models/tm_balkan/tm_balkan_constiantj.vmdl",
                "characters/models/tm_leet/tm_leet_constiante.vmdl",
                "characters/models/tm_leet/tm_leet_constianta.vmdl",
                "characters/models/tm_leet/tm_leet_constiantb.vmdl",
                "characters/models/tm_leet/tm_leet_constiantc.vmdl",
                "characters/models/tm_leet/tm_leet_constiantd.vmdl",
                "characters/models/tm_leet/tm_leet_constiantf.vmdl",
                "characters/models/tm_leet/tm_leet_constianth.vmdl",
                "characters/models/tm_leet/tm_leet_constiantg.vmdl",
                "characters/models/tm_leet/tm_leet_constianti.vmdl",
                "characters/models/tm_anarchist/tm_anarchist.vmdl",
                "characters/models/tm_anarchist/tm_anarchist_constianta.vmdl",
                "characters/models/tm_anarchist/tm_anarchist_constiantb.vmdl",
                "characters/models/tm_anarchist/tm_anarchist_constiantc.vmdl",
                "characters/models/tm_anarchist/tm_anarchist_constiantd.vmdl",
                "characters/models/tm_phoenix/tm_phoenix.vmdl",
                "characters/models/tm_phoenix/tm_phoenix_constianta.vmdl",
                "characters/models/tm_phoenix/tm_phoenix_constiantb.vmdl",
                "characters/models/tm_phoenix/tm_phoenix_constiantc.vmdl",
                "characters/models/tm_phoenix/tm_phoenix_constiantd.vmdl",
                "characters/models/tm_pirate/tm_pirate.vmdl",
                "characters/models/tm_pirate/tm_pirate_constianta.vmdl",
                "characters/models/tm_pirate/tm_pirate_constiantb.vmdl",
                "characters/models/tm_pirate/tm_pirate_constiantc.vmdl",
                "characters/models/tm_pirate/tm_pirate_constiantd.vmdl",
                "characters/models/tm_professional/tm_professional.vmdl",
                "characters/models/tm_professional_const1.vmdl",
                "characters/models/tm_professional_const2.vmdl",
                "characters/models/tm_professional_const3.vmdl",
                "characters/models/tm_professional_const4.vmdl",
                "characters/models/tm_separatist/tm_separatist.vmdl",
                "characters/models/tm_separatist/tm_separatist_constianta.vmdl",
                "characters/models/tm_separatist/tm_separatist_constiantb.vmdl",
                "characters/models/tm_separatist/tm_separatist_constiantc.vmdl",
                "characters/models/tm_separatist/tm_separatist_constiantd.vmdl",
                "characters/models/tm_phoenix/tm_phoenix_constiantg.vmdl",
                "characters/models/tm_phoenix/tm_phoenix_constiante.vmdl",
                "characters/models/tm_phoenix/tm_phoenix_constiantf.vmdl",
                "characters/models/tm_phoenix_heavy/tm_phoenix_heavy.vmdl",
            ]
        };
        return PlayerModels[team][Math.floor(Math.random() * PlayerModels[team].length)];
    }
    function _GetRandomAccolades() {
        function _GetRandomAccoladeTitle() {
            const titles = [
                "kills",
                "damage",
                "adr",
                "mvps",
                "assists",
                "hsp",
                "3k",
                "4k",
                "5k",
                "headshotkills",
                "killreward",
                "utilitydamage",
                "enemiesflashed",
                "objective",
                "worth",
                "score",
                "livetime",
                "deaths",
                "nopurchasewins",
                "clutchkills",
                "footsteps",
                "pistolkills",
                "firstkills",
                "sniperkills",
                "roundssurvived",
                "chickenskilled",
                "killswhileblind",
                "bombcarrierkills",
                "burndamage",
                "cashspent",
                "uniqueweaponkills",
                "gimme_01",
                "gimme_02",
                "gimme_03",
                "gimme_04",
                "gimme_05",
                "gimme_06",
            ];
            return titles[Math.floor(Math.random() * titles.length)];
        }
        function _GetRandomAccolade(xuid) {
            const name = _GetRandomAccoladeTitle();
            const pos = name.includes("gimme_") ? 1 : 1 + Math.floor(Math.random() * 2);
            const accolade = {
                accolade: name,
                value: Math.floor(Math.random() * 1000),
                xuid: xuid,
                position: pos
            };
            return accolade;
        }
        const oAccolades = {
            titles: [
                _GetRandomAccolade(1),
                _GetRandomAccolade(3),
                _GetRandomAccolade(5),
                _GetRandomAccolade(7),
                _GetRandomAccolade(9),
                _GetRandomAccolade(2),
                _GetRandomAccolade(4),
                _GetRandomAccolade(6),
                _GetRandomAccolade(8),
                _GetRandomAccolade(10),
                _GetRandomAccolade(11),
                _GetRandomAccolade(13),
                _GetRandomAccolade(15),
                _GetRandomAccolade(17),
                _GetRandomAccolade(19),
                _GetRandomAccolade(12),
                _GetRandomAccolade(14),
                _GetRandomAccolade(16),
                _GetRandomAccolade(18),
                _GetRandomAccolade(20),
            ]
        };
        return oAccolades;
    }
    function _InternalGetFauxItemId(defid, paintid) {
        return String(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(defid, paintid));
    }
    function _GetRandomModelDefIndex(teamnum) {
        const models = [
            [],
            [],
            [
                4780,
                4777,
                4774,
            ],
            [
                4771,
                4757,
                4751
            ],
        ];
        const random = _r(0, 2);
        return (models[teamnum][random]);
    }
    let MOCK_TABLE = {};
    return {
        AddTable: _AddTable,
        GetMatchEndWinDataJSO: function _APIGetMatchEndWinDataJSO() { return _APIAccessor(GameStateAPI.GetMatchEndWinDataJSO(), k_GetMatchEndWinDataJSO); },
        GetScoreDataJSO: function _GetScoreDataJSO() { return _APIAccessor(GameStateAPI.GetScoreDataJSO(), k_GetScoreDataJSO); },
        GetPlayerName: function _GetPlayerName(xuid) { return _APIAccessor(GameStateAPI.GetPlayerName(xuid), k_GetPlayerName, xuid); },
        GetPlayerNameWithNoHTMLEscapes: function GetPlayerNameWithNoHTMLEscapes(xuid) { return _APIAccessor(GameStateAPI.GetPlayerNameWithNoHTMLEscapes(xuid), k_GetPlayerName, xuid); },
        IsFakePlayer: function _IsFakePlayer(xuid) { return _APIAccessor(GameStateAPI.IsFakePlayer(xuid), k_IsFakePlayer); },
        XPDataJSO: function _XPDataJSO(panel) { return _APIAccessor(panel.XpDataJSO, k_XpDataJSO); },
        GetGameModeInternalName: function _GetGameModeInternalName(bUseSkirmishName) { return _APIAccessor(GameStateAPI.GetGameModeInternalName(bUseSkirmishName), k_GetGameModeInternalName); },
        GetGameModeName: function _GetGameModeName(bUseSkirmishName) { return _APIAccessor(GameStateAPI.GetGameModeName(bUseSkirmishName), k_GetGameModeName); },
        SkillgroupDataJSO: function _SkillgroupDataJSO(panel) { return _APIAccessor(panel.SkillgroupDataJSO, k_SkillgroupDataJSO); },
        DropListJSO: function _DropListJSO(panel) { return _APIAccessor(panel.DropListJSO, k_DropListJSO); },
        GetTimeDataJSO: function _GetTimeDataJSO() { return _APIAccessor(GameStateAPI.GetTimeDataJSO(), k_GetTimeDataJSO); },
        NextMatchVotingData: function _NextMatchVotingData(panel) { return _APIAccessor(panel.NextMatchVotingData, k_NextMatchVotingData); },
        GetPlayerStatsJSO: function _GetPlayerStatsJSO(xuid) { return _APIAccessor(MatchStatsAPI.GetPlayerStatsJSO(xuid), k_GetPlayerStatsJSO, xuid); },
        GetPlayerDataJSO: function _GetPlayerDataJSO() { return _APIAccessor(GameStateAPI.GetPlayerDataJSO(), k_GetPlayerDataJSO); },
        IsTournamentMatch: function _IsTournamentMatch() { return _APIAccessor(MatchStatsAPI.IsTournamentMatch(), k_IsTournamentMatch); },
        GetServerName: function _GetServerName() { return _APIAccessor(GameStateAPI.GetServerName(), k_GetServerName); },
        GetMapName: function _GetMapName() { return _APIAccessor(GameStateAPI.GetMapName(), k_GetMapName); },
        GetTournamentEventStage: function _GetTournamentEventStage() { return _APIAccessor(GameStateAPI.GetTournamentEventStage(), k_GetTournamentEventStage); },
        GetGameModeImagePath: function _GetGameModeImagePath() {
            const path = GameStateAPI.GetGameModeImagePath();
            const modPath = _APIAccessor(path, k_GetGameModeImagePath);
            if (typeof modPath === 'string') {
                return modPath;
            }
            return path;
        },
        GetMapBSPName: function _GetMapBSPName() { return _APIAccessor(GameStateAPI.GetMapBSPName(), k_GetMapBSPName); },
        GetPlayerTeamName: function _GetPlayerTeamName(xuid) { return _APIAccessor(GameStateAPI.GetPlayerTeamName(xuid), k_GetPlayerTeamName, xuid); },
        GetPlayerTeamNumber: function _GetPlayerTeamNumber(xuid) { return _APIAccessor(GameStateAPI.GetPlayerTeamNumber(xuid), k_GetPlayerTeamNumber, xuid); },
        GetTeamNextRoundLossBonus: function _GetTeamNextRoundLossBonus(team) { return _APIAccessor(GameStateAPI.GetTeamNextRoundLossBonus(team), k_GetTeamNextRoundLossBonus); },
        AreTeamsPlayingSwitchedSides: function _AreTeamsPlayingSwitchedSides() { return _APIAccessor(GameStateAPI.AreTeamsPlayingSwitchedSides(), k_AreTeamsPlayingSwitchedSides); },
        AreTeamsPlayingSwitchedSidesInRound: function _AreTeamsPlayingSwitchedSidesInRound(rnd) { return _APIAccessor(GameStateAPI.AreTeamsPlayingSwitchedSidesInRound(rnd), k_AreTeamsPlayingSwitchedSidesInRound); },
        HasHalfTime: function _HasHalfTime() { return _APIAccessor(GameStateAPI.HasHalfTime(), k_HasHalfTime); },
        IsDemoOrHltv: function _IsDemoOrHltv() { return _APIAccessor(GameStateAPI.IsDemoOrHltv(), k_IsDemoOrHltv); },
        IsHLTVAutodirectorOn: function _IsHLTVAutodirectorOn() { return _APIAccessor(GameStateAPI.IsHLTVAutodirectorOn(), k_IsHLTVAutodirectorOn); },
        GetTeamLogoImagePath: function _GetTeamLogoImagePath(team) { return _APIAccessor(GameStateAPI.GetTeamLogoImagePath(team), k_GetTeamLogoImagePath); },
        GetTeamLivingPlayerCount: function _GetTeamLivingPlayerCount(team) { return _APIAccessor(GameStateAPI.GetTeamLivingPlayerCount(team), k_GetTeamLivingPlayerCount); },
        GetTeamTotalPlayerCount: function _GetTeamTotalPlayerCount(team) { return _APIAccessor(GameStateAPI.GetTeamTotalPlayerCount(team), k_GetTeamTotalPlayerCount); },
        GetTeamClanName: function _GetTeamClanName(team) { return _APIAccessor(GameStateAPI.GetTeamClanName(team), k_GetTeamClanName, team); },
        IsXuidValid: function _IsXuidValid(xuid) { return _APIAccessor(GameStateAPI.IsXuidValid(xuid), k_IsXuidValid); },
        GetPlayerSlot: function _GetPlayerSlot(xuid) { return _APIAccessor(GameStateAPI.GetPlayerSlot(xuid), k_GetPlayerSlot, xuid); },
        GetLocalPlayerXuid: function _GetLocalPlayerXuid() { return _APIAccessor(GameStateAPI.GetLocalPlayerXuid(), k_GetLocalPlayerXuid); },
        IsLocalPlayerHLTV: function _IsLocalPlayerHLTV() { return _APIAccessor(GameStateAPI.IsLocalPlayerHLTV(), k_IsLocalPlayerHLTV); },
        GetPlayerStatus: function _GetPlayerStatus(xuid) { return _APIAccessor(GameStateAPI.GetPlayerStatus(xuid), k_GetPlayerStatus); },
        GetPlayerCommendsLeader: function _GetPlayerCommendsLeader(xuid) { return _APIAccessor(GameStateAPI.GetPlayerCommendsLeader(xuid), k_GetPlayerCommendsLeader); },
        GetPlayerCommendsFriendly: function _GetPlayerCommendsFriendly(xuid) { return _APIAccessor(GameStateAPI.GetPlayerCommendsFriendly(xuid), k_GetPlayerCommendsFriendly); },
        GetPlayerCommendsTeacher: function _GetPlayerCommendsTeacher(xuid) { return _APIAccessor(GameStateAPI.GetPlayerCommendsTeacher(xuid), k_GetPlayerCommendsTeacher); },
        GetPlayerCompetitiveRanking: function _GetPlayerCompetitiveRanking(xuid) { return _APIAccessor(GameStateAPI.GetPlayerCompetitiveRanking(xuid), k_GetPlayerCompetitiveRanking); },
        GetPlayerCompetitiveWins: function _GetPlayerCompetitiveWins(xuid) { return _APIAccessor(GameStateAPI.GetPlayerCompetitiveWins(xuid), k_GetPlayerCompetitiveWins); },
        GetPlayerXpLevel: function _GetPlayerXpLevel(xuid) { return _APIAccessor(GameStateAPI.GetPlayerXpLevel(xuid), k_GetPlayerXpLevel, xuid); },
        GetPlayerScore: function _GetPlayerScore(xuid) { return _APIAccessor(GameStateAPI.GetPlayerScore(xuid), k_GetPlayerScore, xuid); },
        GetPlayerMVPs: function _GetPlayerMVPs(xuid) { return _APIAccessor(GameStateAPI.GetPlayerMVPs(xuid), k_GetPlayerMVPs, xuid); },
        GetPlayerKills: function _GetPlayerKills(xuid) { return _APIAccessor(GameStateAPI.GetPlayerKills(xuid), k_GetPlayerKills, xuid); },
        GetPlayerAssists: function _GetPlayerAssists(xuid) { return _APIAccessor(GameStateAPI.GetPlayerAssists(xuid), k_GetPlayerAssists, xuid); },
        GetPlayerDeaths: function _GetPlayerDeaths(xuid) { return _APIAccessor(GameStateAPI.GetPlayerDeaths(xuid), k_GetPlayerDeaths, xuid); },
        GetPlayerPing: function _GetPlayerPing(xuid) { return _APIAccessor(GameStateAPI.GetPlayerPing(xuid), k_GetPlayerPing, xuid); },
        GetPlayerColor: function _GetPlayerColor(xuid) { return _APIAccessor(GameStateAPI.GetPlayerColor(xuid), k_GetPlayerColor, xuid); },
        HasCommunicationAbuseMute: function _HasCommunicationAbuseMute(xuid) { return _APIAccessor(GameStateAPI.HasCommunicationAbuseMute(xuid), k_HasCommunicationAbuseMute); },
        IsSelectedPlayerMuted: function _IsSelectedPlayerMuted(xuid) { return _APIAccessor(GameStateAPI.IsSelectedPlayerMuted(xuid), k_IsSelectedPlayerMuted); },
        IsPlayerConnected: function _IsPlayerConnected(xuid) { return _APIAccessor(GameStateAPI.IsPlayerConnected(xuid), k_IsPlayerConnected); },
        ArePlayersEnemies: function _ArePlayersEnemies(xuid1, xuid2) { return _APIAccessor(GameStateAPI.ArePlayersEnemies(xuid1, xuid2), k_ArePlayersEnemies); },
        GetPlayerClanTag: function _GetPlayerClanTag(xuid) { return _APIAccessor(GameStateAPI.GetPlayerClanTag(xuid), k_GetPlayerClanTag); },
        GetPlayerMoney: function _GetPlayerMoney(xuid) { return _APIAccessor(GameStateAPI.GetPlayerMoney(xuid), k_GetPlayerMoney); },
        GetPlayerActiveWeaponItemId: function _GetPlayerActiveWeaponItemId(xuid) { return _APIAccessor(GameStateAPI.GetPlayerActiveWeaponItemId(xuid), k_GetPlayerActiveWeaponItemId, xuid); },
        GetPlayerModel: function _GetPlayerModel(xuid) { return _APIAccessor(GameStateAPI.GetPlayerModel(xuid), k_GetPlayerModel, xuid); },
        GetPlayerItemCT: function _GetPlayerItemCT(panel) { return _APIAccessor(panel.GetPlayerItemCT(), k_GetPlayerItemCT); },
        GetPlayerItemTerrorist: function _GetPlayerItemTerrorist(panel) { return _APIAccessor(panel.GetPlayerItemTerrorist(), k_GetPlayerItemTerrorist); },
        GetCharacterDefaultCheerByXuid: function _GetCharacterDefaultCheerByXuid(xuid) { return _APIAccessor(GameStateAPI.GetCharacterDefaultCheerByXuid(xuid), k_GetCharacterDefaultCheerByXuid, xuid); },
        GetCooperativePlayerTeamName: function _GetCooperativePlayerTeamName() { return _APIAccessor(GameStateAPI.GetCooperativePlayerTeamName(), k_GetCooperativePlayerTeamName); },
        GetAllPlayersMatchDataJSO: function _GetAllPlayersMatchDataJSO() { return _APIAccessor(GameStateAPI.GetAllPlayersMatchDataJSO(), k_GetAllPlayersMatchDataJSO); },
        GetPlayerCharacterItemID: function _GetPlayerCharacterItemID(xuid) { return _APIAccessor(GameStateAPI.GetPlayerCharacterItemID(xuid), k_GetPlayerCharacterItemID); },
        GetFauxItemIDFromDefAndPaintIndex: function _GetFauxItemIDFromDefAndPaintIndex(defindex, paintid) { return _APIAccessor(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(defindex, paintid), k_GetFauxItemIDFromDefAndPaintIndex); },
        GetPlayerCompetitiveRankType: function _GetPlayerCompetitiveRankType(xuid) { return _APIAccessor(GameStateAPI.GetPlayerCompetitiveRankType(xuid), k_GetPlayerCompetitiveRankType, xuid); },
        bSkillgroupDataReady: function _bSkillgroupDataReady(panel) { return _APIAccessor(panel.bSkillgroupDataReady, k_bSkillgroupDataReady); },
        bXpDataReady: function _bXpDataReady(panel) { return _APIAccessor(panel.bXpDataReady, k_bXpDataReady); },
        GetPipRankCount: function _GetPipRankCount(type) { return _APIAccessor(MyPersonaAPI.GetPipRankCount(type), k_GetPipRankCount); },
        GetPlayerPremierRankStatsObject: function (xuid) { return _APIAccessor(GameStateAPI.GetPlayerPremierRankStatsObject(xuid), k_GetPlayerPremierRankStatsObject, xuid); },
        SetMockData: _SetMockData,
        GetMockData: _GetMockData,
    };
})();
(function () {
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibW9ja19hZGFwdGVyLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvbW9ja19hZGFwdGVyLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFDbEMsMkNBQTJDO0FBQzNDLHlDQUF5QztBQUl6QyxJQUFJLFdBQVcsR0FBRyxDQUFFO0lBR25CLE1BQU0sdUJBQXVCLEdBQUcseUJBQXlCLENBQUM7SUFDMUQsTUFBTSxpQkFBaUIsR0FBRyxtQkFBbUIsQ0FBQztJQUM5QyxNQUFNLGVBQWUsR0FBRyxpQkFBaUIsQ0FBQztJQUMxQyxNQUFNLGNBQWMsR0FBRyxnQkFBZ0IsQ0FBQztJQUN4QyxNQUFNLFdBQVcsR0FBRyxhQUFhLENBQUM7SUFDbEMsTUFBTSx5QkFBeUIsR0FBRywyQkFBMkIsQ0FBQztJQUM5RCxNQUFNLGlCQUFpQixHQUFHLG1CQUFtQixDQUFDO0lBQzlDLE1BQU0sbUJBQW1CLEdBQUcscUJBQXFCLENBQUM7SUFDbEQsTUFBTSxhQUFhLEdBQUcsZUFBZSxDQUFDO0lBQ3RDLE1BQU0sZ0JBQWdCLEdBQUcsa0JBQWtCLENBQUM7SUFDNUMsTUFBTSxxQkFBcUIsR0FBRyx1QkFBdUIsQ0FBQztJQUN0RCxNQUFNLG1CQUFtQixHQUFHLHFCQUFxQixDQUFDO0lBQ2xELE1BQU0sa0JBQWtCLEdBQUcsb0JBQW9CLENBQUM7SUFDaEQsTUFBTSxtQkFBbUIsR0FBRyxxQkFBcUIsQ0FBQztJQUNsRCxNQUFNLGVBQWUsR0FBRyxpQkFBaUIsQ0FBQztJQUMxQyxNQUFNLFlBQVksR0FBRyxjQUFjLENBQUM7SUFDcEMsTUFBTSx5QkFBeUIsR0FBRywyQkFBMkIsQ0FBQztJQUM5RCxNQUFNLHNCQUFzQixHQUFHLHdCQUF3QixDQUFDO0lBQ3hELE1BQU0sZUFBZSxHQUFHLGlCQUFpQixDQUFDO0lBQzFDLE1BQU0sbUJBQW1CLEdBQUcscUJBQXFCLENBQUM7SUFDbEQs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