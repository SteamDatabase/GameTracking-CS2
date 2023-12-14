"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="mock_adapter.ts" />
/// <reference path="common/gamerules_constants.ts" />
/// <reference path="common/formattext.ts" />
/// <reference path="rating_emblem.ts" />
/// <reference path="match_stakes.ts" />
var Scoreboard = (function () {
    function _msg(text) {
    }
    const _m_cP = $.GetContextPanel();
    let _m_LocalPlayerID = '';
    function GetLocalPlayerId() {
        if (_m_LocalPlayerID === '')
            _m_LocalPlayerID = GameStateAPI.GetLocalPlayerXuid();
        return _m_LocalPlayerID;
    }
    class Team_t {
        m_CommendLeaderboards = {
            'leader': [],
            'teacher': [],
            'friendly': [],
        };
        m_teamName;
        constructor(teamName) {
            this.m_teamName = teamName;
        }
        CalculateAllCommends() {
            ['leader', 'teacher', 'friendly'].forEach(stat => {
                this._SortCommendLeaderboard(stat);
                this._ChangeCommendDisplay(_m_TopCommends[stat], stat, false);
                _m_TopCommends[stat] = this._GetCommendBestXuid(stat);
                this._ChangeCommendDisplay(_m_TopCommends[stat], stat, true);
            });
        }
        UpdateCommendForPlayer(xuid, stat, value) {
            if (value == 0)
                return;
            let playerCommend = this.m_CommendLeaderboards[stat].find(p => p.m_xuid === xuid);
            if (!playerCommend) {
                this.m_CommendLeaderboards[stat].push({ m_xuid: xuid, m_value: value });
            }
            else {
                playerCommend.m_value = value;
            }
        }
        DeletePlayerFromCommendsLeaderboards(xuid) {
            ['leader', 'teacher', 'friendly'].forEach(stat => {
                let index = this.m_CommendLeaderboards[stat].findIndex(p => p.m_xuid === xuid);
                if (index != -1) {
                    this.m_CommendLeaderboards[stat].splice(index, 1);
                }
            });
        }
        _ChangeCommendDisplay(xuid, stat, turnon) {
            let oPlayer = _m_oPlayers.GetPlayerByXuid(xuid);
            if (!oPlayer)
                return;
            let elPlayer = oPlayer.m_elPlayer;
            if (!elPlayer || !elPlayer.IsValid())
                return;
            let elCommendationImage = elPlayer.FindChildTraverse('id-sb-name__commendations__' + stat);
            if (!elCommendationImage || !elCommendationImage.IsValid())
                return;
            elCommendationImage.SetHasClass('hidden', !turnon);
        }
        _SortCommendLeaderboard(stat) {
            this.m_CommendLeaderboards[stat].sort(function (a, b) { return b.m_value - a.m_value; });
        }
        _GetCommendBestXuid(stat) {
            switch (stat) {
                case 'leader': return this._GetCommendTopLeaderXuid();
                case 'teacher': return this._GetCommendTopTeacherXuid();
                case 'friendly': return this._GetCommendTopFriendlyXuid();
                default: return "0";
            }
        }
        _GetCommendTopLeaderXuid() {
            let clb = this.m_CommendLeaderboards['leader'];
            return clb[0] ? clb[0].m_xuid : "0";
        }
        _GetCommendTopTeacherXuid() {
            let clb = this.m_CommendLeaderboards['teacher'];
            let teacher0 = clb[0] ? clb[0].m_xuid : "0";
            let teacher1 = clb[1] ? clb[1].m_xuid : "0";
            if (teacher0 != this._GetCommendTopLeaderXuid())
                return teacher0;
            else
                return teacher1;
        }
        _GetCommendTopFriendlyXuid() {
            let clb = this.m_CommendLeaderboards['friendly'];
            let friendly0 = clb[0] ? clb[0].m_xuid : "0";
            let friendly1 = clb[1] ? clb[1].m_xuid : "0";
            let friendly2 = clb[2] ? clb[2].m_xuid : "0";
            if (friendly0 != this._GetCommendTopLeaderXuid() && friendly0 != this._GetCommendTopTeacherXuid())
                return friendly0;
            else if (friendly1 != this._GetCommendTopLeaderXuid() && friendly1 != this._GetCommendTopTeacherXuid())
                return friendly1;
            else
                return friendly2;
        }
    }
    class Player_t {
        m_xuid;
        m_elPlayer = undefined;
        m_elTeam = undefined;
        m_oStats = {};
        m_oElStats = {};
        m_isMuted = false;
        m_oMatchStats = undefined;
        constructor(xuid) {
            this.m_xuid = xuid;
        }
        GetStatNum(stat, dflt = 0) {
            const val = this.m_oStats[stat];
            return typeof val === "number" && isFinite(val) ? val : dflt;
        }
        GetStatText(stat, dflt = "") {
            const val = this.m_oStats[stat];
            return typeof val === "string" ? val : val != null ? val.toString() : dflt;
        }
    }
    class AllPlayers_t {
        m_arrPlayers = [];
        AddPlayer(xuid) {
            let newPlayer = new Player_t(xuid);
            let teamName = GameStateAPI.GetPlayerTeamName(xuid);
            if (IsTeamASpecTeam(teamName))
                teamName = 'Spectator';
            let elTeam = _m_cP.FindChildInLayoutFile('players-table-' + teamName);
            if (!elTeam || !elTeam.IsValid()) {
                elTeam = _m_cP.FindChildInLayoutFile('players-table-ANY');
            }
            newPlayer.m_elTeam = elTeam;
            this.m_arrPlayers.push(newPlayer);
            return newPlayer;
        }
        GetPlayerByIndex(i) {
            return this.m_arrPlayers[i];
        }
        GetPlayerByXuid(xuid) {
            return this.m_arrPlayers.find(p => p.m_xuid === xuid);
        }
        GetPlayerIndexByPlayerSlot(slot) {
            let xuid = GameStateAPI.GetPlayerXuidStringFromPlayerSlot(slot);
            return this.GetPlayerIndexByXuid(xuid);
        }
        GetPlayerIndexByXuid(xuid) {
            return this.m_arrPlayers.findIndex(p => p.m_xuid === xuid);
        }
        GetCount() {
            return this.m_arrPlayers.length;
        }
        DeletePlayerByXuid(xuid) {
            let oPlayer = this.GetPlayerByXuid(xuid);
            const teamName = oPlayer?.m_oStats?.teamname;
            if (teamName && _m_oTeams[teamName]) {
                _m_oTeams[teamName].DeletePlayerFromCommendsLeaderboards(xuid);
            }
            let i = this.GetPlayerIndexByXuid(xuid);
            if (this.m_arrPlayers[i].m_elPlayer && this.m_arrPlayers[i].m_elPlayer.IsValid()) {
                this.m_arrPlayers[i].m_elPlayer.DeleteAsync(.0);
            }
            this.m_arrPlayers.splice(i, 1);
        }
        DeleteMissingPlayers(oPlayerList) {
            const players = Object.values(oPlayerList).flatMap(team => Object.values(team ?? {}));
            const sXuids = new Set(players.filter(xuid => !!xuid));
            for (const player of this.m_arrPlayers) {
                if (!sXuids.has(player.m_xuid)) {
                    this.DeletePlayerByXuid(player.m_xuid);
                }
            }
        }
    }
    let _m_bInit = false;
    let _m_oUpdateStatFns = {};
    let _m_updatePlayerIndex = 0;
    let _m_oTeams = {};
    let _m_arrSortingPausedRefGetCounter = 0;
    let _m_hDenyInputToGame = null;
    let _m_dataSetCurrent = 0;
    let _m_dataSetGetCount = 0;
    let _m_areTeamsSwapped = false;
    let _m_maxRounds = 0;
    let _m_oPlayers;
    let _m_RoundUpdated = {};
    let _m_TopCommends = {
        'leader': "0",
        'teacher': "0",
        'friendly': "0",
    };
    let _m_overtime = 0;
    let _m_updatePlayerHandler = null;
    let _m_haveViewers = false;
    let FAKEMODE = '';
    const sortOrder_default = {
        'dc': 0,
        'score': 0,
        'risc': 0,
        'mvps': 0,
        'kills': 0,
        'assists': 0,
        'deaths': -1,
        'leader': 0,
        'teacher': 0,
        'friendly': 0,
        'rank': 0,
        'idx': -1,
        'damage': 0,
        'avgrisc': 0,
        'money': 0,
        'hsp': 0,
        'kdr': 0,
        'adr': 0,
        'utilitydamage': 0,
        'enemiesflashed': 0,
    };
    const sortOrder_reverse = {
        'dc': 0,
        'score': -1,
        'risc': -1,
        'mvps': -1,
        'kills': -1,
        'assists': -1,
        'deaths': 0,
        'leader': -1,
        'teacher': -1,
        'friendly': -1,
        'rank': -1,
        'idx': 0,
        'damage': 0,
        'avgrisc': 0,
        'money': 0,
        'hsp': 0,
        'kdr': 0,
        'adr': 0,
        'utilitydamage': 0,
        'enemiesflashed': 0,
    };
    const sortOrder_dm = {
        'dc': 0,
        'score': 0,
        'kills': 0,
        'kdr': 0,
        'damage': 0,
        'hsp': 0,
        'idx': -1,
        'assists': 0,
        'deaths': -1,
    };
    const sortOrder_tmm = {
        'dc': 0,
        'damage': 0,
        'kills': 0,
        'risc': 0,
        'mvps': 0,
        'assists': 0,
        'deaths': -1,
        'leader': 0,
        'teacher': 0,
        'friendly': 0,
        'rank': 0,
        'idx': -1,
        'score': 0,
        'avgrisc': 0,
        'money': 0,
        'hsp': 0,
        'kdr': 0,
        'adr': 0,
        'utilitydamage': 0,
        'enemiesflashed': 0,
    };
    let _m_sortOrder = sortOrder_default;
    _Reset();
    function _Reset() {
        _m_bInit = false;
        _m_oPlayers = new AllPlayers_t();
        _m_oUpdateStatFns = {};
        _m_updatePlayerIndex = 0;
        _m_oTeams = {};
        _m_arrSortingPausedRefGetCounter = 0;
        _m_hDenyInputToGame = null;
        _m_dataSetCurrent = 0;
        _m_dataSetGetCount = 0;
        _m_areTeamsSwapped = false;
        _m_maxRounds = 0;
        _m_sortOrder = sortOrder_default;
        _m_overtime = 0;
        _m_RoundUpdated = {};
        _m_TopCommends = {
            'leader': "0",
            'teacher': "0",
            'friendly': "0",
        };
        _m_cP.RemoveAndDeleteChildren();
        _m_cP.m_bSnippetLoaded = false;
    }
    function _Helper_LoadSnippet(element, snippet) {
        if (element && !element.m_bSnippetLoaded) {
            element.BLoadLayoutSnippet(snippet);
            element.m_bSnippetLoaded = true;
        }
    }
    function _PopulatePlayerList() {
        const playerData = GameStateAPI.GetPlayerDataJSO();
        const teamNames = Object.keys(playerData);
        if (teamNames.length === 0)
            return;
        _m_oPlayers.DeleteMissingPlayers(playerData);
        for (const teamName of teamNames) {
            if (!ShouldCreateTeamForMode(teamName))
                continue;
            CreateTeam(teamName);
            for (const xuid of Object.values(playerData[teamName])) {
                if (xuid == null || xuid === "0")
                    continue;
                const oPlayer = _m_oPlayers.GetPlayerByXuid(xuid);
                if (!oPlayer) {
                    _CreateNewPlayer(xuid);
                }
                else if (oPlayer.m_oStats['teamname'] != teamName) {
                    _ChangeTeams(oPlayer, teamName);
                }
            }
        }
        if (ShouldCreateTeamForMode('CT'))
            CreateTeam('CT');
        if (ShouldCreateTeamForMode('TERRORIST'))
            CreateTeam('TERRORIST');
        function CreateTeam(teamName) {
            if (!_m_oTeams[teamName])
                _m_oTeams[teamName] = new Team_t(teamName);
        }
        function ShouldCreateTeamForMode(team) {
            let mode = GameStateAPI.GetGameModeInternalName(false);
            if (mode == 'cooperative' || mode == 'coopmission') {
                return team.toUpperCase() === GameStateAPI.GetCooperativePlayerTeamName().toUpperCase();
            }
            return true;
        }
    }
    function _ChangeTeams(oPlayer, newTeam) {
        if (oPlayer.m_oStats['teamname'] == newTeam)
            return;
        let xuid = oPlayer.m_xuid;
        let oldTeam = oPlayer.m_oStats['teamname'];
        let elPlayer = oPlayer.m_elPlayer;
        oPlayer.m_oStats['teamname'] = newTeam;
        if (oldTeam in _m_oTeams) {
            _m_oTeams[oldTeam].DeletePlayerFromCommendsLeaderboards(xuid);
        }
        oPlayer.m_oStats['leader'] = -1;
        oPlayer.m_oStats['teacher'] = -1;
        oPlayer.m_oStats['friendly'] = -1;
        if (!elPlayer || !elPlayer.IsValid())
            return;
        if (oldTeam)
            elPlayer.RemoveClass('sb-team--' + oldTeam);
        elPlayer.AddClass('sb-team--' + newTeam);
        if (IsTeamASpecTeam(newTeam) && MatchStatsAPI.IsTournamentMatch()) {
            elPlayer.AddClass('hidden');
            return;
        }
        let elTeam = _m_cP.FindChildInLayoutFile('players-table-' + newTeam);
        if (!elTeam && !IsTeamASpecTeam(newTeam)) {
            elTeam = _m_cP.FindChildInLayoutFile('players-table-ANY');
        }
        if (elTeam && elTeam.IsValid()) {
            oPlayer.m_elTeam = elTeam;
            elPlayer.SetParent(elTeam);
            elPlayer.RemoveClass('hidden');
        }
        else {
            elPlayer.AddClass('hidden');
        }
        let idx = _m_oPlayers.GetPlayerIndexByXuid(xuid);
        _UpdateAllStatsForPlayer(idx, true);
        _SortPlayer(idx);
    }
    function _CreateNewPlayer(xuid) {
        let oPlayer = _m_oPlayers.AddPlayer(xuid);
        _NewPlayerPanel(oPlayer);
        let idx = _m_oPlayers.GetPlayerIndexByXuid(xuid);
        _UpdateAllStatsForPlayer(idx, true);
        _SortPlayer(idx);
        let sortOrder = Object.keys(_m_sortOrder)[1];
        _HighlightSortStatLabel(sortOrder);
    }
    function _UpdateNextPlayer() {
        _m_oPlayers.DeleteMissingPlayers(GameStateAPI.GetPlayerDataJSO());
        if (_m_updatePlayerIndex >= _m_oPlayers.GetCount()) {
            _PopulatePlayerList();
            _m_updatePlayerIndex = 0;
        }
        _UpdatePlayer(_m_updatePlayerIndex);
        _m_updatePlayerIndex++;
    }
    function _UpdateAllPlayers_delayed(bSilent = false) {
        $.Schedule(0.01, () => _UpdateAllPlayers(bSilent));
    }
    function _UpdateAllPlayers(bSilent) {
        if (!_m_bInit)
            return;
        _PopulatePlayerList();
        _m_updatePlayerIndex = 0;
        for (let i = 0; i < _m_oPlayers.GetCount(); i++) {
            let elPlayer = _m_oPlayers.GetPlayerByIndex(i).m_elPlayer;
            if (elPlayer && elPlayer.IsValid())
                elPlayer.RemoveClass('sb-row--transition');
        }
        for (let i = 0; i < _m_oPlayers.GetCount(); i++) {
            _UpdatePlayer(i, bSilent);
        }
        for (let i = 0; i < _m_oPlayers.GetCount(); i++) {
            let elPlayer = _m_oPlayers.GetPlayerByIndex(i).m_elPlayer;
            if (elPlayer && elPlayer.IsValid())
                elPlayer.AddClass('sb-row--transition');
        }
    }
    function _Pulse(el) {
        el.RemoveClass('sb-pulse-highlight');
        el.AddClass('sb-pulse-highlight');
    }
    function _UpdatePlayerByPlayerSlot(slot) {
        let index = _m_oPlayers.GetPlayerIndexByPlayerSlot(slot);
        _UpdatePlayer(index, true);
    }
    function _UpdatePlayerByPlayerSlot_delayed(slot) {
        $.Schedule(0.01, () => _UpdatePlayerByPlayerSlot(slot));
    }
    function _UpdatePlayer(idx, bSilent = false) {
        let oPlayer = _m_oPlayers.GetPlayerByIndex(idx);
        if (!oPlayer)
            return;
        bSilent = bSilent && _m_cP.visible;
        let xuid = oPlayer.m_xuid;
        oPlayer.m_oMatchStats = MatchStatsAPI.GetPlayerStatsJSO(xuid);
        _UpdateAllStatsForPlayer(idx, bSilent);
        _SortPlayer(idx);
    }
    function _UpdateSpectatorButtons() {
        let elButtonPanel = $('#spec-button-group');
        if (!elButtonPanel || !elButtonPanel.IsValid())
            return;
        let nCameraMan = parseInt(GameInterfaceAPI.GetSettingString('spec_autodirector_cameraman'));
        let bQ = (GameStateAPI.IsLocalPlayerHLTV() && nCameraMan > -1);
        if (bQ) {
            elButtonPanel.visible = true;
            UpdateCasterButtons();
        }
        else {
            elButtonPanel.visible = false;
        }
    }
    function _lessthan(x, y) {
        x = Number(x);
        y = Number(y);
        if (isNaN(x))
            return (!isNaN(y));
        if (isNaN(y))
            return false;
        return (x < y);
    }
    function _SortPlayer(idx) {
        if (_m_arrSortingPausedRefGetCounter != 0)
            return;
        let oPlayer = _m_oPlayers.GetPlayerByIndex(idx);
        let elTeam = oPlayer.m_elTeam;
        if (!elTeam || !elTeam.IsValid())
            return;
        let elPlayer = oPlayer.m_elPlayer;
        if (!elPlayer || !elPlayer.IsValid())
            return;
        let children = elTeam.Children();
        for (let i = 0; i < children.length; i++) {
            if (oPlayer.m_xuid === children[i].m_xuid)
                continue;
            let oCompareTargetPlayer = _m_oPlayers.GetPlayerByXuid(children[i].m_xuid);
            if (!oCompareTargetPlayer)
                continue;
            for (let stat in _m_sortOrder) {
                let p1stat = oPlayer.m_oStats[stat];
                let p2stat = oCompareTargetPlayer.m_oStats[stat];
                if (_m_sortOrder[stat] === -1) {
                    let tmp = p1stat;
                    p1stat = p2stat;
                    p2stat = tmp;
                }
                if (_lessthan(p2stat, p1stat)) {
                    if (children[i - 1] != elPlayer) {
                        elTeam.MoveChildBefore(elPlayer, children[i]);
                    }
                    return;
                }
                else if (_lessthan(p1stat, p2stat)) {
                    break;
                }
            }
        }
    }
    function IsTeamASpecTeam(teamname) {
        return (teamname === 'Spectator' ||
            teamname === 'Unassigned' ||
            teamname === 'Unknown' ||
            teamname === 'UNKNOWN TEAM' ||
            teamname === '');
    }
    function _UpdateAllStatsForPlayer(idx, bSilent = false) {
        let oPlayer = _m_oPlayers.GetPlayerByIndex(idx);
        for (let stat in _m_oUpdateStatFns) {
            if (typeof (_m_oUpdateStatFns[stat]) === 'function') {
                _m_oUpdateStatFns[stat](oPlayer, bSilent);
            }
        }
    }
    function _GenericUpdateStat(oPlayer, stat, fnGetStat, bSilent = false) {
        let elPanel = oPlayer.m_oElStats[stat];
        if (!elPanel || !elPanel.IsValid())
            return;
        let elLabel = elPanel.FindChildTraverse('label');
        let newStatValue = fnGetStat(oPlayer.m_xuid);
        if (newStatValue !== oPlayer.m_oStats[stat]) {
            if (!bSilent) {
                if (elLabel && elLabel.IsValid()) {
                    _Pulse(elLabel);
                }
            }
            oPlayer.m_oStats[stat] = newStatValue;
            if (elLabel && elLabel.IsValid()) {
                elLabel.text = newStatValue.toString();
            }
        }
    }
    function _GetMatchStatFn(stat) {
        function _fn(xuid) {
            let oPlayer = _m_oPlayers.GetPlayerByXuid(xuid);
            let allstats = oPlayer.m_oMatchStats;
            if (allstats)
                return (allstats[stat] == -1) ? '-' : allstats[stat];
            return '-';
        }
        return _fn;
    }
    function _CreateStatUpdateFn(stat) {
        let fn;
        switch (stat) {
            case 'musickit':
                fn = oPlayer => {
                    if (MockAdapter.IsFakePlayer(oPlayer.m_xuid))
                        return;
                    let ownerXuid = oPlayer.m_xuid;
                    let isLocalPlayer = oPlayer.m_xuid == GetLocalPlayerId();
                    let isBorrowed = false;
                    let borrowedXuid = "0";
                    let borrowedPlayerSlot = parseInt(GameInterfaceAPI.GetSettingString('cl_borrow_music_from_player_slot'));
                    if (borrowedPlayerSlot >= 0 && isLocalPlayer) {
                        borrowedXuid = GameStateAPI.GetPlayerXuidStringFromPlayerSlot(borrowedPlayerSlot);
                        if (MockAdapter.IsPlayerConnected(borrowedXuid)) {
                            ownerXuid = borrowedXuid;
                            isBorrowed = true;
                        }
                    }
                    let newStatValue = InventoryAPI.GetMusicIDForPlayer(ownerXuid);
                    if (newStatValue !== oPlayer.m_oStats[stat]) {
                        oPlayer.m_oStats[stat] = newStatValue;
                        if (isLocalPlayer) {
                            let elMusicKit = $('#id-sb-meta__musickit');
                            if (!elMusicKit || !elMusicKit.IsValid())
                                return;
                            let isValidMusicKit = newStatValue > 0;
                            elMusicKit.SetHasClass('hidden', !isValidMusicKit);
                            if (isValidMusicKit) {
                                _m_cP.FindChildTraverse('id-sb-meta__musickit-unborrow').SetHasClass('hidden', !isBorrowed);
                                let imagepath = 'file://{images}/' + InventoryAPI.GetItemInventoryImageFromMusicID(newStatValue) + '.png';
                                $('#id-sb-meta__musickit-image').SetImage(imagepath);
                                $('#id-sb-meta__musickit-name').text = $.Localize(InventoryAPI.GetMusicNameFromMusicID(newStatValue));
                            }
                        }
                    }
                    let elPlayer = oPlayer.m_elPlayer;
                    if (elPlayer && elPlayer.IsValid()) {
                        let elMusicKitIcon = elPlayer.FindChildTraverse('id-sb-name__musickit');
                        if (elMusicKitIcon && elMusicKitIcon.IsValid()) {
                            elMusicKitIcon.SetHasClass('hidden', newStatValue <= 1);
                        }
                    }
                };
                break;
            case 'teamname':
                fn = oPlayer => {
                    let newStatValue = MockAdapter.GetPlayerTeamName(oPlayer.m_xuid);
                    _ChangeTeams(oPlayer, newStatValue);
                };
                break;
            case 'ping':
                fn = oPlayer => {
                    let elPlayer = oPlayer.m_elPlayer;
                    if (!elPlayer || !elPlayer.IsValid())
                        return;
                    let elPanel = oPlayer.m_oElStats[stat];
                    if (!elPanel || !elPanel.IsValid())
                        return;
                    let elLabel = elPanel.FindChildTraverse('label');
                    if (!elLabel)
                        return;
                    let szCustomLabel = _GetCustomStatTextValue('ping', oPlayer.m_xuid);
                    elLabel.SetHasClass('sb-row__cell--ping__label--bot', !!szCustomLabel);
                    if (szCustomLabel) {
                        elLabel.text = $.Localize(szCustomLabel);
                        oPlayer.m_oStats[stat] = szCustomLabel;
                    }
                    else {
                        _GenericUpdateStat(oPlayer, stat, MockAdapter.GetPlayerPing, true);
                    }
                };
                break;
            case 'kills':
                fn = function (oPlayer, bSilent = false) {
                    _GenericUpdateStat(oPlayer, stat, MockAdapter.GetPlayerKills, bSilent);
                };
                break;
            case 'assists':
                fn = function (oPlayer, bSilent = false) {
                    _GenericUpdateStat(oPlayer, stat, MockAdapter.GetPlayerAssists, bSilent);
                };
                break;
            case 'deaths':
                fn = function (oPlayer, bSilent = false) {
                    _GenericUpdateStat(oPlayer, stat, MockAdapter.GetPlayerDeaths, bSilent);
                };
                break;
            case '3k':
            case '4k':
            case '5k':
            case 'adr':
            case 'hsp':
            case 'utilitydamage':
            case 'enemiesflashed':
            case 'damage':
                fn = function (oPlayer, bSilent = false) {
                    _GenericUpdateStat(oPlayer, stat, _GetMatchStatFn(stat), bSilent);
                };
                break;
            case 'kdr':
                fn = function (oPlayer, bSilent = false) {
                    let kdr;
                    if (_m_overtime == 0) {
                        let kdrFn = _GetMatchStatFn('kdr');
                        kdr = kdrFn(oPlayer.m_xuid);
                        if (typeof kdr == 'number' && kdr > 0) {
                            kdr = kdr / 100.0;
                        }
                    }
                    else {
                        let denom = oPlayer.GetStatNum('deaths') || 1;
                        kdr = oPlayer.GetStatNum('kills') / denom;
                    }
                    if (typeof kdr == 'number') {
                        kdr = kdr.toFixed(2);
                    }
                    _GenericUpdateStat(oPlayer, stat, () => { return kdr; }, bSilent);
                };
                break;
            case 'mvps':
                fn = function (oPlayer, bSilent = false) {
                    let newStatValue = MockAdapter.GetPlayerMVPs(oPlayer.m_xuid);
                    if (newStatValue !== oPlayer.m_oStats[stat]) {
                        let elMVPPanel = oPlayer.m_oElStats[stat];
                        if (!elMVPPanel || !elMVPPanel.IsValid())
                            return;
                        let elMVPStarImage = elMVPPanel.FindChildTraverse('star-image');
                        if (!elMVPStarImage || !elMVPStarImage.IsValid())
                            return;
                        let elMVPStarNumberLabel = elMVPPanel.FindChildTraverse('star-count');
                        if (!elMVPStarNumberLabel || !elMVPStarNumberLabel.IsValid())
                            return;
                        oPlayer.m_oStats[stat] = newStatValue;
                        elMVPStarImage.SetHasClass('hidden', newStatValue == 0);
                        elMVPStarNumberLabel.SetHasClass('hidden', newStatValue == 0);
                        elMVPStarNumberLabel.text = newStatValue.toString();
                        if (!bSilent) {
                            _Pulse(elMVPStarImage);
                            _Pulse(elMVPStarNumberLabel);
                        }
                    }
                };
                break;
            case 'status':
                fn = oPlayer => {
                    let newStatValue = MockAdapter.GetPlayerStatus(oPlayer.m_xuid);
                    if (newStatValue !== oPlayer.m_oStats[stat]) {
                        oPlayer.m_oStats[stat] = newStatValue;
                        let elPlayer = oPlayer.m_elPlayer;
                        if (!elPlayer || !elPlayer.IsValid())
                            return;
                        elPlayer.SetHasClass('sb-player-status-dead', newStatValue === 1);
                        elPlayer.SetHasClass('sb-player-status-disconnected', newStatValue === 15);
                        oPlayer.m_oStats['dc'] = newStatValue === 15 ? 0 : 1;
                        let elPanel = oPlayer.m_oElStats[stat];
                        if (!elPanel || !elPanel.IsValid())
                            return;
                        let elStatusImage = elPanel.FindChildTraverse('image');
                        if (!elStatusImage || !elStatusImage.IsValid())
                            return;
                        elStatusImage.SetImage(dictPlayerStatusImage[newStatValue]);
                    }
                };
                break;
            case 'score':
                fn = oPlayer => {
                    _GenericUpdateStat(oPlayer, stat, MockAdapter.GetPlayerScore);
                };
                break;
            case 'money':
                fn = oPlayer => {
                    let elPanel = oPlayer.m_oElStats[stat];
                    if (!elPanel || !elPanel.IsValid())
                        return;
                    let elLabel = elPanel.FindChildTraverse('label');
                    if (!elLabel || !elLabel.IsValid())
                        return;
                    let newStatValue = MockAdapter.GetPlayerMoney(oPlayer.m_xuid);
                    if (newStatValue !== oPlayer.m_oStats[stat]) {
                        if (newStatValue >= 0) {
                            elLabel.SetHasClass('hidden', false);
                            elLabel.SetDialogVariableInt('stat_d_money', newStatValue);
                        }
                        else {
                            elLabel.SetHasClass('hidden', true);
                        }
                    }
                    oPlayer.m_oStats[stat] = newStatValue;
                };
                break;
            case 'name':
                fn = oPlayer => {
                    if (!oPlayer.m_elPlayer || !oPlayer.m_elPlayer.IsValid())
                        return;
                    oPlayer.m_elPlayer.SetHasClass('sb-row--localplayer', oPlayer.m_xuid === GetLocalPlayerId());
                    let elPanel = oPlayer.m_oElStats[stat];
                    if (!elPanel || !elPanel.IsValid())
                        return;
                    oPlayer.m_elPlayer.SetDialogVariableInt('player_slot', GameStateAPI.GetPlayerSlot(oPlayer.m_xuid));
                };
                break;
            case 'leader':
            case 'teacher':
            case 'friendly':
                fn = oPlayer => {
                    let newStatValue;
                    if (GameStateAPI.IsDemoOrHltv() || IsTeamASpecTeam(GameStateAPI.GetPlayerTeamName(GetLocalPlayerId())))
                        return;
                    if (!GameStateAPI.IsXuidValid(oPlayer.m_xuid)) {
                        return;
                    }
                    else {
                        switch (stat) {
                            case 'leader':
                                newStatValue = GameStateAPI.GetPlayerCommendsLeader(oPlayer.m_xuid);
                                break;
                            case 'teacher':
                                newStatValue = GameStateAPI.GetPlayerCommendsTeacher(oPlayer.m_xuid);
                                break;
                            case 'friendly':
                                newStatValue = GameStateAPI.GetPlayerCommendsFriendly(oPlayer.m_xuid);
                                break;
                        }
                    }
                    if (oPlayer.m_oStats[stat] != newStatValue) {
                        oPlayer.m_oStats[stat] = newStatValue;
                        let oTeam = _m_oTeams[oPlayer.GetStatText('teamname')];
                        if (oTeam)
                            oTeam.UpdateCommendForPlayer(oPlayer.m_xuid, stat, newStatValue);
                    }
                };
                break;
            case 'flair':
                fn = oPlayer => {
                    if (GameStateAPI.IsLatched())
                        return;
                    let newStatValue = InventoryAPI.GetFlairItemId(oPlayer.m_xuid);
                    if (oPlayer.m_oStats[stat] !== newStatValue) {
                        oPlayer.m_oStats[stat] = newStatValue;
                        let elPanel = oPlayer.m_oElStats[stat];
                        if (!elPanel || !elPanel.IsValid())
                            return;
                        let elFlairImage = elPanel.FindChildTraverse('image');
                        if (!elFlairImage || !elFlairImage.IsValid())
                            return;
                        let imagepath = InventoryAPI.GetFlairItemImage(oPlayer.m_xuid);
                        elFlairImage.SetImage('file://{images}' + imagepath + '_small.png');
                    }
                };
                break;
            case 'avatar':
                fn = oPlayer => {
                    let elPanel = oPlayer.m_oElStats[stat];
                    if (!elPanel || !elPanel.IsValid())
                        return;
                    let elAvatarImage = elPanel.FindChildTraverse('image');
                    if (!elAvatarImage || !elAvatarImage.IsValid())
                        return;
                    elAvatarImage.PopulateFromPlayerSlot(GameStateAPI.GetPlayerSlot(oPlayer.m_xuid));
                    let team = GameStateAPI.GetPlayerTeamName(oPlayer.m_xuid);
                    elAvatarImage.SwitchClass('teamstyle', 'team--' + team);
                    let elPlayerColor = elAvatarImage.FindChildTraverse('player-color');
                    if (elPlayerColor && elPlayerColor.IsValid()) {
                        let teamColor = GameStateAPI.GetPlayerColor(oPlayer.m_xuid);
                        if (teamColor !== '') {
                            elPlayerColor.style.washColor = teamColor;
                            elPlayerColor.RemoveClass('hidden');
                        }
                        else {
                            elPlayerColor.AddClass('hidden');
                        }
                    }
                    let isMuted = GameStateAPI.IsSelectedPlayerMuted(oPlayer.m_xuid);
                    oPlayer.m_isMuted = isMuted;
                    let isEnemyTeamMuted = GameInterfaceAPI.GetSettingString("cl_mute_enemy_team") == "1";
                    let isEnemy = GameStateAPI.ArePlayersEnemies(oPlayer.m_xuid, GetLocalPlayerId());
                    let hasComAbusePenalty = GameStateAPI.HasCommunicationAbuseMute(oPlayer.m_xuid);
                    let isLocalPlayer = oPlayer.m_xuid == GetLocalPlayerId();
                    oPlayer.m_elPlayer.SetHasClass('muted', isMuted || (isEnemy && isEnemyTeamMuted) || (isLocalPlayer && hasComAbusePenalty));
                };
                break;
            case 'skillgroup':
                fn = oPlayer => {
                    const elPlayer = oPlayer.m_elPlayer;
                    if (!elPlayer || !elPlayer.IsValid())
                        return;
                    let newStatValue = MockAdapter.GetPlayerCompetitiveRanking(oPlayer.m_xuid);
                    let elSkillgroup = elPlayer.FindChildTraverse('jsRatingEmblem');
                    if (elSkillgroup && elSkillgroup.IsValid()) {
                        if (newStatValue > 0) {
                            elSkillgroup.visible = true;
                            if (oPlayer.m_oStats[stat] !== newStatValue) {
                                oPlayer.m_oStats[stat] = newStatValue;
                                let options = {
                                    root_panel: elPlayer.FindChildTraverse('jsRatingEmblem'),
                                    xuid: oPlayer.m_xuid,
                                    api: 'gamestate',
                                    full_details: false,
                                };
                                RatingEmblem.SetXuid(options);
                            }
                        }
                        else {
                            elSkillgroup.visible = false;
                        }
                    }
                    ;
                };
                break;
            case 'rank':
                fn = oPlayer => {
                    let newStatValue = MockAdapter.GetPlayerXpLevel(oPlayer.m_xuid);
                    if (oPlayer.m_oStats[stat] !== newStatValue) {
                        oPlayer.m_oStats[stat] = newStatValue;
                        let elPanel = oPlayer.m_oElStats[stat];
                        if (!elPanel || !elPanel.IsValid())
                            return;
                        let elRankImage = elPanel.FindChildTraverse('image');
                        if (!elRankImage || !elRankImage.IsValid())
                            return;
                        let imagepath = '';
                        if (newStatValue > 0) {
                            imagepath = 'file://{images}/icons/xp/level' + newStatValue + '.png';
                        }
                        else {
                            imagepath = '';
                        }
                        elRankImage.SetImage(imagepath);
                    }
                };
                break;
            default:
                return;
        }
        _m_oUpdateStatFns[stat] = fn;
    }
    function _GetPlayerRowForGameMode() {
        let mode = MockAdapter.GetGameModeInternalName(false);
        let skirmish = MockAdapter.GetGameModeInternalName(true);
        if (GameStateAPI.IsQueuedMatchmakingMode_Team()) {
            return 'snippet_scoreboard-classic__row--premier';
        }
        switch (mode) {
            case 'scrimcomp2v2':
                return 'snippet_scoreboard-classic__row--wingman';
            case 'competitive':
            case 'premier':
                return 'snippet_scoreboard-classic__row--comp';
            case 'training':
                return 'snippet_scoreboard__row--training';
            case 'deathmatch':
                return 'snippet_scoreboard__row--deathmatch';
            case 'coopmission':
            case 'cooperative':
                return 'snippet_scoreboard__row--cooperative';
            case 'casual':
                if (skirmish == 'flyingscoutsman')
                    return 'snippet_scoreboard__row--flyingscoutsman';
                else
                    return 'snippet_scoreboard-classic__row--casual';
            default:
                return 'snippet_scoreboard-classic__row--casual';
        }
    }
    function _HighlightSortStatLabel(stat) {
        _m_cP.FindChildrenWithClassTraverse('sb-row__cell').forEach(function (el) {
            if (el && el.IsValid()) {
                if (el.BHasClass('sb-row__cell--' + stat)) {
                    el.AddClass('sortstat');
                }
                else {
                    el.RemoveClass('sortstat');
                }
            }
        });
    }
    function _CreateLabelForStat(stat, set, isHidden) {
        let elLabelRow = $('#id-sb-players-table__labels-row');
        if (!elLabelRow || !elLabelRow.IsValid())
            return;
        let elLabelRowOrSet = elLabelRow;
        if (set !== '') {
            let labelSetContainerId = 'id-sb-row__set-container';
            let elLabelSetContainer = $('#' + labelSetContainerId);
            if (!elLabelSetContainer || !elLabelSetContainer.IsValid()) {
                elLabelSetContainer = $.CreatePanel('Panel', elLabelRow, labelSetContainerId);
                elLabelSetContainer.BLoadLayoutSnippet('snippet_sb-label-set-container');
                if ($('#id-sb-row__set-container')) {
                    $('#id-sb-meta__cycle').RemoveClass('hidden');
                }
            }
            let elSetLabels = elLabelSetContainer.FindChildTraverse('id-sb-row__sets');
            let LabelSetId = 'id-sb-labels-set-' + set;
            let elLabelSet = elSetLabels.FindChildTraverse(LabelSetId);
            if (!elLabelSet || !elLabelSet.IsValid()) {
                _m_dataSetGetCount++;
                elLabelSet = $.CreatePanel('Panel', elSetLabels, LabelSetId);
                elLabelSet.AddClass('sb-row__set');
                elLabelSet.AddClass('no-hover');
            }
            elLabelRowOrSet = elLabelSet;
            if (set != _m_dataSetCurrent.toString()) {
                elLabelSet.AddClass('hidden');
            }
        }
        let elStatPanel = elLabelRowOrSet.FindChildInLayoutFile('id-sb-' + stat);
        if (!elStatPanel || !elStatPanel.IsValid()) {
            elStatPanel = $.CreatePanel('Button', elLabelRowOrSet, 'id-sb-' + stat);
            elStatPanel.AddClass('sb-row__cell');
            elStatPanel.AddClass('sb-row__cell--' + stat);
            elStatPanel.AddClass('sb-row__cell--label');
            let elStatLabel;
            if (stat === 'ping') {
                elStatLabel = $.CreatePanel('Image', elStatPanel, 'label-' + elStatPanel.id);
                elStatLabel.SetImage('file://{images}/icons/ui/ping_4.svg');
            }
            else {
                elStatLabel = $.CreatePanel('Label', elStatPanel, 'label-' + elStatPanel.id);
                if (isHidden == '1') {
                    elStatLabel.text = '';
                }
                else {
                    elStatLabel.text = $.Localize('#Scoreboard_' + stat);
                }
            }
            let toolTipString = $.Localize('#Scoreboard_' + stat + '_tooltip');
            if (toolTipString !== '') {
                elStatLabel.SetPanelEvent('onmouseover', () => UiToolkitAPI.ShowTextTooltip(elStatLabel.id, toolTipString));
                elStatLabel.SetPanelEvent('onmouseout', function () { UiToolkitAPI.HideTextTooltip(); });
            }
            let _SetNewSortStat = function (stat) {
                let newSortOrder = { 'dc': 0 };
                let modeDefaultSortOrder = _GetSortOrderForMode(MockAdapter.GetGameModeInternalName(false));
                if (stat in modeDefaultSortOrder)
                    newSortOrder[stat] = modeDefaultSortOrder[stat];
                else
                    return;
                _HighlightSortStatLabel(stat);
                for (let s in modeDefaultSortOrder) {
                    if (s == stat)
                        continue;
                    if (s == 'dc')
                        continue;
                    newSortOrder[s] = modeDefaultSortOrder[s];
                }
                _m_sortOrder = newSortOrder;
                for (let i = 0; i < _m_oPlayers.GetCount(); i++) {
                    _SortPlayer(i);
                }
            };
            elStatPanel.SetPanelEvent('onactivate', _SetNewSortStat.bind(undefined, stat));
        }
    }
    function _GetCustomStatTextValue(stat, xuid) {
        let szCustomLabel = null;
        if (stat === 'ping') {
            if (MockAdapter.GetPlayerStatus(xuid) == 15) {
                szCustomLabel = '#SFUI_scoreboard_lbl_dc';
            }
            else if (MockAdapter.IsFakePlayer(xuid)) {
                szCustomLabel = '#SFUI_scoreboard_lbl_bot';
            }
            else if (IsTeamASpecTeam(MockAdapter.GetPlayerTeamName(xuid))) {
                szCustomLabel = '#SFUI_scoreboard_lbl_spec';
            }
        }
        return szCustomLabel;
    }
    function _NewPlayerPanel(oPlayer) {
        if (!oPlayer.m_elTeam || !oPlayer.m_elTeam.IsValid())
            return;
        oPlayer.m_elPlayer = $.CreatePanel('Panel', oPlayer.m_elTeam, 'player-' + oPlayer.m_xuid);
        oPlayer.m_elPlayer.m_xuid = oPlayer.m_xuid;
        _Helper_LoadSnippet(oPlayer.m_elPlayer, _GetPlayerRowForGameMode());
        let idx = 0;
        function _InitStatCell(elStatCell, oPlayer) {
            if (!elStatCell || !elStatCell.IsValid())
                return;
            let stat = elStatCell.GetAttributeString('data-stat', '');
            let set = elStatCell.GetAttributeString('data-set', '');
            let isHidden = elStatCell.GetAttributeString('data-hidden', '');
            let children = elStatCell.Children();
            for (let i = 0; i < children.length; i++) {
                _InitStatCell(children[i], oPlayer);
            }
            if (stat === '') {
                return;
            }
            oPlayer.m_oElStats[stat] = elStatCell;
            elStatCell.AddClass('sb-row__cell');
            elStatCell.AddClass('sb-row__cell--' + stat);
            if (set !== '') {
                let SetContainerId = 'id-sb-row__set-container';
                let elSetContainer = oPlayer.m_elPlayer.FindChildTraverse(SetContainerId);
                if (!elSetContainer || !elSetContainer.IsValid()) {
                    elSetContainer = $.CreatePanel('Panel', oPlayer.m_elPlayer, SetContainerId);
                    oPlayer.m_elPlayer.MoveChildBefore(elSetContainer, elStatCell);
                }
                let setId = 'id-sb-set-' + set;
                let elSet = elSetContainer.FindChildTraverse(setId);
                if (!elSet || !elSet.IsValid) {
                    elSet = $.CreatePanel('Panel', elSetContainer, setId);
                    elSet.AddClass('sb-row__set');
                    elSet.AddClass('no-hover');
                    idx = 0;
                }
                elStatCell.SetParent(elSet);
                if (set != _m_dataSetCurrent.toString()) {
                    elSet.AddClass('hidden');
                }
            }
            if (idx++ % 2)
                elStatCell.AddClass('sb-row__cell--dark');
            if (!isHidden) {
                _CreateStatUpdateFn(stat);
            }
        }
        _CreateStatUpdateFn('teamname');
        _CreateStatUpdateFn('musickit');
        _CreateStatUpdateFn('status');
        _CreateStatUpdateFn('skillgroup');
        _CreateStatUpdateFn('leader');
        _CreateStatUpdateFn('teacher');
        _CreateStatUpdateFn('friendly');
        let elStatCells = oPlayer.m_elPlayer.Children();
        let cellCount = elStatCells.length;
        for (let i = 0; i < cellCount; i++) {
            _InitStatCell(elStatCells[i], oPlayer);
        }
        oPlayer.m_oStats = {};
        oPlayer.m_oStats['idx'] = GameStateAPI.GetPlayerSlot(oPlayer.m_xuid);
        oPlayer.m_elPlayer.SetPanelEvent('onmouseover', function () {
            _m_arrSortingPausedRefGetCounter++;
        });
        oPlayer.m_elPlayer.SetPanelEvent('onmouseout', function () {
            _m_arrSortingPausedRefGetCounter--;
        });
        if (MockAdapter.IsXuidValid(oPlayer.m_xuid)) {
            oPlayer.m_elPlayer.SetPanelEvent('onactivate', function () {
                _m_arrSortingPausedRefGetCounter++;
                let elPlayerCardContextMenu = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('', '', 'file://{resources}/layout/context_menus/context_menu_playercard.xml', 'xuid=' + oPlayer.m_xuid, _OnPlayerCardDismiss.bind(undefined));
                elPlayerCardContextMenu.AddClass('ContextMenu_NoArrow');
                if (!_m_hDenyInputToGame) {
                    _m_hDenyInputToGame = UiToolkitAPI.AddDenyInputFlagsToGame(elPlayerCardContextMenu, 'ScoreboardPlayercard', 'CaptureMouse');
                }
            });
        }
        return oPlayer.m_elPlayer;
    }
    function _OnPlayerCardDismiss() {
        _m_arrSortingPausedRefGetCounter--;
        if (_m_hDenyInputToGame) {
            UiToolkitAPI.ReleaseDenyInputFlagsToGame(_m_hDenyInputToGame);
            _m_hDenyInputToGame = null;
        }
    }
    function _UpdateMatchInfo() {
        if (!_m_bInit)
            return;
        _m_cP.SetDialogVariable('server_name', _m_haveViewers ? '' : MockAdapter.GetServerName());
        _m_cP.SetDialogVariable('map_name', MockAdapter.GetMapName());
        _m_cP.SetDialogVariable('gamemode_name', MockAdapter.GetGameModeName(true));
        _m_cP.SetDialogVariable('tournament_stage', MockAdapter.GetTournamentEventStage());
        const elMapLabel = _m_cP.FindChildTraverse('id-sb-meta__labels__mode-map');
        if (elMapLabel && elMapLabel.IsValid() && elMapLabel.text == '') {
            if (MatchStatsAPI.IsTournamentMatch()) {
                elMapLabel.text = $.Localize('{s:tournament_stage} | {s:map_name}', _m_cP);
            }
            else {
                let strLocalizeScoreboardTitle = '{s:gamemode_name} | {s:map_name}';
                let mode = GameStateAPI.GetGameModeInternalName(true);
                if ((mode === 'competitive' || mode === 'premier') &&
                    (GameTypesAPI.GetMapGroupAttribute('mg_' + GameStateAPI.GetMapBSPName(), 'competitivemod') === 'unranked')) {
                    strLocalizeScoreboardTitle = $.Localize('#SFUI_RankType_Modifier_Unranked', _m_cP) + ' | {s:map_name}';
                }
                else if (GameStateAPI.IsQueuedMatchmakingMode_Team()) {
                    let sMapName = '{s:map_name}';
                    if (GameStateAPI.GetMapBSPName() === 'lobby_mapveto')
                        sMapName = $.Localize('#matchdraft_arena_name', _m_cP);
                    strLocalizeScoreboardTitle = $.Localize('#SFUI_GameModeCompetitiveTeams', _m_cP) + ' | ' + sMapName;
                }
                elMapLabel.text = $.Localize(strLocalizeScoreboardTitle, _m_cP);
            }
        }
        if ($('#id-sb-meta__mode__image')) {
            if (GameStateAPI.IsQueuedMatchmakingMode_Team())
                $('#id-sb-meta__mode__image').SetImage('file://{images}/icons/ui/competitive_teams.svg');
            else
                $('#id-sb-meta__mode__image').SetImage(MockAdapter.GetGameModeImagePath());
        }
        if ($('#sb-meta__labels__map'))
            $('#sb-meta__labels__map').SetImage('file://{images}/map_icons/map_icon_' + MockAdapter.GetMapBSPName() + '.svg');
        let elCoopStats = $('#CoopStats');
        if (elCoopStats) {
            let questID = GameStateAPI.GetActiveQuestID();
            if (questID > 0) {
                elCoopStats.AddClass('show-mission-desc');
                MissionsAPI.ApplyQuestDialogVarsToPanelJS(questID, elCoopStats);
                let elLabel = elCoopStats.FindChildInLayoutFile('MissionDescriptionLabel');
                if (elLabel) {
                    let strMissionDescriptionToken = MissionsAPI.GetQuestDefinitionField(questID, 'loc_description');
                    elLabel.text = $.Localize(strMissionDescriptionToken, elCoopStats);
                }
            }
        }
        if (!MockAdapter.IsDemoOrHltv()) {
            const localTeamName = MockAdapter.GetPlayerTeamName(GetLocalPlayerId());
            if (_m_oTeams[localTeamName])
                _m_oTeams[localTeamName].CalculateAllCommends();
        }
        const elMouseBinding = _m_cP.FindChildInLayoutFile('id-sb-mouse-instructions');
        if (elMouseBinding && elMouseBinding.IsValid()) {
            let bind = GameInterfaceAPI.GetSettingString('cl_scoreboard_mouse_enable_binding');
            if (bind.charAt(0) == '+' || bind.charAt(0) == '-')
                bind = bind.substring(1);
            elMouseBinding.SetDialogVariable('scoreboard_mouse_enable_bind', $.Localize(`{s:bind_${bind}}`, elMouseBinding));
            elMouseBinding.text = $.Localize('#Scoreboard_Mouse_Enable_Instruction', elMouseBinding);
        }
        const elFooterWebsite = _m_cP.FindChildInLayoutFile('id-sb-footer-server-website');
        if (elFooterWebsite && elFooterWebsite.IsValid()) {
            const strWebsiteURL = MatchStatsAPI.GetServerWebsiteURL(false);
            if (strWebsiteURL) {
                elFooterWebsite.SetHasClass('hidden', false);
                elFooterWebsite.SetPanelEvent('onmouseover', () => UiToolkitAPI.ShowTextTooltip('id-sb-footer-server-website', strWebsiteURL));
                elFooterWebsite.SetPanelEvent('onmouseout', () => UiToolkitAPI.HideTextTooltip());
            }
            else {
                elFooterWebsite.SetHasClass('hidden', true);
            }
        }
    }
    function _UpdateHLTVViewerNumber(nViewers) {
        _m_cP.SetDialogVariableInt('viewers', nViewers);
        _m_haveViewers = nViewers > 0;
        _m_cP.SetDialogVariable('hltv_viewers', _m_haveViewers ? $.Localize('#Scoreboard_Viewers', _m_cP) : '');
    }
    function _UpdateRound(rnd, oScoreData, jsoTime) {
        if (!_SupportsTimeline(jsoTime))
            return;
        if (!oScoreData)
            return;
        if (!jsoTime)
            return;
        if (!('teamdata' in oScoreData))
            return;
        let elTimeline = _m_cP.FindChildInLayoutFile('id-sb-timeline__segments');
        if (!elTimeline || !elTimeline.IsValid())
            return;
        let elRnd = elTimeline.FindChildTraverse(rnd.toString());
        if (!elRnd || !elRnd.IsValid())
            return;
        let elRndTop = elRnd.FindChildTraverse('id-sb-timeline__segment__round--top');
        let elRndBot = elRnd.FindChildTraverse('id-sb-timeline__segment__round--bot');
        elRndTop.FindChildTraverse('result').SetImage('');
        elRndBot.FindChildTraverse('result').SetImage('');
        elRndTop.SetDialogVariable('sb_clinch', '');
        elRndBot.SetDialogVariable('sb_clinch', '');
        let elTick = elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick');
        if (elTick && elTick.IsValid()) {
            elTick.SetHasClass('hilite', rnd <= jsoTime['rounds_played'] + 1);
        }
        if (rnd > jsoTime['rounds_played']) {
            let bCanClinch = jsoTime['can_clinch'];
            if (bCanClinch) {
                let numToClinch = jsoTime['num_wins_to_clinch'];
                let topClinchRound = jsoTime['rounds_played'] + numToClinch - m_topScore;
                let bThisRoundIsClinchTop = rnd == topClinchRound;
                let botClinchRound = jsoTime['rounds_played'] + numToClinch - m_botScore;
                let bThisRoundIsClinchBot = rnd == botClinchRound;
                let bShowClinchTop = (bThisRoundIsClinchTop && topClinchRound <= botClinchRound);
                let bShowClinchBot = (bThisRoundIsClinchBot && botClinchRound <= topClinchRound);
                let thisRoundIsClinchAndShowIt = false;
                if (bShowClinchTop) {
                    elRndTop.FindChildTraverse('result').SetImage(dictRoundResultImage['win']);
                    thisRoundIsClinchAndShowIt = true;
                }
                if (bShowClinchBot) {
                    elRndBot.FindChildTraverse('result').SetImage(dictRoundResultImage['win']);
                    thisRoundIsClinchAndShowIt = true;
                }
                let roundIsPastClinch = (rnd > topClinchRound || rnd > botClinchRound);
                elRnd.SetHasClass('past-clinch', roundIsPastClinch);
                elRnd.SetHasClass('clinch-round', thisRoundIsClinchAndShowIt);
            }
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick').RemoveClass('sb-team--CT');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick__label').RemoveClass('sb-team--CT');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick').RemoveClass('sb-team--TERRORIST');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick__label').RemoveClass('sb-team--TERRORIST');
            let _ClearCasualties = function (elRnd) {
                for (let i = 1; i <= 5; i++) {
                    let img = elRnd.FindChildTraverse('casualty-' + i);
                    if (!img)
                        break;
                    img.AddClass('hidden');
                }
            };
            _ClearCasualties(elRndTop);
            _ClearCasualties(elRndBot);
            return;
        }
        let bFlippedSides = false;
        if (MockAdapter.AreTeamsPlayingSwitchedSides() !== MockAdapter.AreTeamsPlayingSwitchedSidesInRound(rnd)) {
            bFlippedSides = true;
            let elTemp = elRndTop;
            elRndTop = elRndBot;
            elRndBot = elTemp;
        }
        elRndTop.AddClass('sb-team--CT');
        elRndBot.AddClass('sb-team--TERRORIST');
        let idx;
        if (MatchStatsAPI.DoesSupportOvertimeStats()) {
            idx = rnd - jsoTime['first_round_this_period'] + 1;
        }
        else {
            idx = rnd;
        }
        const roundData = oScoreData.rounddata[idx];
        if (typeof roundData !== 'object')
            return;
        let result = roundData['result'].replace(/^(ct_|t_)/, '');
        if (roundData['result'].charAt(0) === 'c') {
            bFlippedSides ? m_botScore++ : m_topScore++;
            elRndTop.FindChildTraverse('result').SetImage(dictRoundResultImage[result]);
            elRndTop.FindChildTraverse('result').AddClass('sb-timeline__segment__round--active');
            elRndBot.FindChildTraverse('result').SetImage('');
            elRndBot.FindChildTraverse('result').RemoveClass('sb-timeline__segment__round--active');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick').AddClass('sb-team--CT');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick__label').AddClass('sb-team--CT');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick').RemoveClass('sb-team--TERRORIST');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick__label').RemoveClass('sb-team--TERRORIST');
        }
        else if (roundData['result'].charAt(0) === 't') {
            bFlippedSides ? m_topScore++ : m_botScore++;
            elRndBot.FindChildTraverse('result').SetImage(dictRoundResultImage[result]);
            elRndBot.FindChildTraverse('result').AddClass('sb-timeline__segment__round--active');
            elRndTop.FindChildTraverse('result').SetImage('');
            elRndTop.FindChildTraverse('result').RemoveClass('sb-timeline__segment__round--active');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick').AddClass('sb-team--TERRORIST');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick__label').AddClass('sb-team--TERRORIST');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick').RemoveClass('sb-team--CT');
            elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick__label').RemoveClass('sb-team--CT');
        }
        let _UpdateCasualties = function (teamName, elRnd) {
            if (_m_oTeams[teamName]) {
                let livingCount = teamName === 'CT' ? roundData.players_alive_CT : roundData.players_alive_TERRORIST;
                let nPlayers = 5;
                if (MockAdapter.GetGameModeInternalName(false) == 'scrimcomp2v2')
                    nPlayers = 2;
                for (let i = 1; i <= nPlayers; i++) {
                    let img = elRnd.FindChildTraverse('casualty-' + i);
                    if (!img)
                        break;
                    img.RemoveClass('hidden');
                    if (i > livingCount) {
                        img.AddClass('dead-casualty');
                    }
                    else {
                        img.RemoveClass('dead-casualty');
                    }
                }
            }
        };
        _UpdateCasualties('CT', elRndTop);
        _UpdateCasualties('TERRORIST', elRndBot);
    }
    function _ShowSurvivors(hide = false) {
        let elTimeline = _m_cP.FindChildInLayoutFile('id-sb-timeline__segments');
        if (!elTimeline || !elTimeline.IsValid())
            return;
        let arrPanelsToToggleTransparency = [];
        function CollectPanelsToToggleTransparency(el) {
            if (!el || !el.IsValid())
                return;
            if (el.Children())
                el.Children().forEach(CollectPanelsToToggleTransparency);
            if (el.GetAttributeString('data-casualty-mouse-over-toggle-transparency', 'false') == 'true')
                arrPanelsToToggleTransparency.push(el);
        }
        elTimeline.Children().forEach(CollectPanelsToToggleTransparency);
        arrPanelsToToggleTransparency.forEach(el => el.SetHasClass('transparent', hide));
    }
    function _Casualties_OnMouseOver() {
        if (GameInterfaceAPI.GetSettingString('cl_scoreboard_survivors_always_on') == '0')
            _ShowSurvivors();
        UiToolkitAPI.ShowCustomLayoutTooltipStyled('1', 'id-tooltip-sb-casualties', 'file://{resources}/layout/tooltips/tooltip_scoreboard_casualties.xml', 'Tooltip_NoArrow');
    }
    function _Casualties_OnMouseOut() {
        if (GameInterfaceAPI.GetSettingString('cl_scoreboard_survivors_always_on') == '0')
            _ShowSurvivors(true);
        UiToolkitAPI.HideCustomLayoutTooltip('id-tooltip-sb-casualties');
    }
    function _RoundLossBonusMoneyForTeam(teamname) {
        let nLossAmount = MockAdapter.GetTeamNextRoundLossBonus(teamname);
        let nMaxLoss = parseInt(GameInterfaceAPI.GetSettingString('mp_consecutive_loss_max'));
        if (nLossAmount > nMaxLoss) {
            nLossAmount = nMaxLoss;
        }
        if (nLossAmount < 0) {
            nLossAmount = 0;
        }
        let nBaseAmount = parseInt(GameInterfaceAPI.GetSettingString('cash_team_loser_bonus'));
        let nConsecutiveBonus = parseInt(GameInterfaceAPI.GetSettingString('cash_team_loser_bonus_consecutive_rounds'));
        let nTotalAmount = nBaseAmount + (nLossAmount * nConsecutiveBonus);
        return nTotalAmount;
    }
    function _RoundLossBonusMoney_OnMouseOver_CT() {
        _m_cP.SetDialogVariable('round_loss_income_team', $.Localize('#counter-terrorists'));
        _m_cP.SetDialogVariableInt('round_loss_income_amount', _RoundLossBonusMoneyForTeam('CT'));
        let sTooltipText = $.Localize('#Scoreboard_lossmoneybonus_tooltip', _m_cP);
        UiToolkitAPI.ShowTextTooltip('id-sb-timeline__round-loss-bonus-money', sTooltipText);
    }
    function _RoundLossBonusMoney_OnMouseOut_CT() {
        UiToolkitAPI.HideTextTooltip();
    }
    function _RoundLossBonusMoney_OnMouseOver_TERRORIST() {
        _m_cP.SetDialogVariable('round_loss_income_team', $.Localize('#terrorists'));
        _m_cP.SetDialogVariableInt('round_loss_income_amount', _RoundLossBonusMoneyForTeam('TERRORIST'));
        let sTooltipText = $.Localize('#Scoreboard_lossmoneybonus_tooltip', _m_cP);
        UiToolkitAPI.ShowTextTooltip('id-sb-timeline__round-loss-bonus-money', sTooltipText);
    }
    function _RoundLossBonusMoney_OnMouseOut_TERRORIST() {
        UiToolkitAPI.HideTextTooltip();
    }
    function _UpdateTeamInfo(teamName) {
        let team = _m_oTeams[teamName];
        if (!team) {
            team = _m_oTeams[teamName] = new Team_t(teamName);
        }
        _m_cP.SetDialogVariable('sb_team_name--' + teamName, MockAdapter.GetTeamClanName(teamName));
        const teamLogoImagePath = MockAdapter.GetTeamLogoImagePath(teamName);
        if (teamLogoImagePath != '') {
            for (const elTeamLogoBackground of _m_cP.FindChildrenWithClassTraverse('sb-team-logo-background--' + teamName)) {
                elTeamLogoBackground.style.backgroundImage = `url("file://{images}${teamLogoImagePath}")`;
                elTeamLogoBackground.AddClass('sb-team-logo-bg');
            }
        }
        _m_cP.SetDialogVariableInt(teamName + '_alive', MockAdapter.GetTeamLivingPlayerCount(teamName));
        _m_cP.SetDialogVariableInt(teamName + '_total', MockAdapter.GetTeamTotalPlayerCount(teamName));
    }
    function _UpdateTeams() {
        let oScoreData = MockAdapter.GetScoreDataJSO();
        for (let team in _m_oTeams) {
            _UpdateTeamInfo(team);
            if (!oScoreData || !('teamdata' in oScoreData) || !(team in oScoreData['teamdata']))
                continue;
            const teamData = oScoreData.teamdata[team];
            _m_cP.SetDialogVariableInt('sb_team_score--' + team, teamData['score']);
            if ('score_1h' in teamData) {
                _m_cP.SetDialogVariableInt('sb_team_score_2--' + team, teamData['score_1h']);
            }
            if ('score_2h' in teamData) {
                _m_cP.SetDialogVariableInt('sb_team_score_3--' + team, teamData['score_2h']);
            }
            if ('score_ot' in teamData) {
                _m_cP.SetDialogVariableInt('sb_team_score_ot--' + team, teamData['score_ot']);
            }
            let elOTScore = _m_cP.FindChildTraverse('id-sb-timeline__score_ot');
            if (elOTScore && elOTScore.IsValid()) {
                elOTScore.SetHasClass('hidden', !('score_ot' in teamData));
                elOTScore.SetHasClass('fade', !('score_ot' in teamData));
            }
        }
    }
    function _InitClassicTeams() {
        _UpdateTeamInfo('TERRORIST');
        _UpdateTeamInfo('CT');
    }
    let m_topScore = 0;
    let m_botScore = 0;
    function _UpdateAllRounds() {
        let jsoTime = MockAdapter.GetTimeDataJSO();
        let oScoreData = MockAdapter.GetScoreDataJSO();
        if (!jsoTime)
            return;
        if (!oScoreData)
            return;
        if (!_SupportsTimeline(jsoTime))
            return;
        let lastRound;
        if (MatchStatsAPI.DoesSupportOvertimeStats()) {
            lastRound = jsoTime['last_round_this_period'];
        }
        else {
            lastRound = jsoTime['maxrounds'];
        }
        m_topScore = 0;
        m_botScore = 0;
        if (jsoTime['overtime'] > 0) {
            m_topScore = (jsoTime['maxrounds'] + (jsoTime['overtime'] - 1) * jsoTime['maxrounds_overtime']) / 2;
            m_botScore = (jsoTime['maxrounds'] + (jsoTime['overtime'] - 1) * jsoTime['maxrounds_overtime']) / 2;
        }
        for (let rnd = 1; rnd <= lastRound; rnd++) {
            _UpdateRound(rnd, oScoreData, jsoTime);
        }
    }
    function _UpdateScore_Classic() {
        if (Object.keys(_m_oTeams).length === 0) {
            _InitClassicTeams();
        }
        _UpdateTeams();
        let jsoTime = MockAdapter.GetTimeDataJSO();
        if (!jsoTime)
            return;
        let currentRound = jsoTime['rounds_played'] + 1;
        _m_cP.SetDialogVariable('match_phase', $.Localize('#gamephase_' + jsoTime['gamephase']));
        _m_cP.SetDialogVariable('rounds_remaining', jsoTime['rounds_remaining'].toString());
        _m_cP.SetDialogVariableInt('scoreboard_ot', jsoTime['overtime']);
        _m_cP.SetHasClass('sb-tournament-match', MatchStatsAPI.IsTournamentMatch());
        let bResetTimeline = false;
        if (_m_maxRounds != jsoTime['maxrounds_this_period']) {
            bResetTimeline = true;
            _m_maxRounds = jsoTime['maxrounds_this_period'];
        }
        if (_m_areTeamsSwapped !== MockAdapter.AreTeamsPlayingSwitchedSides()) {
            bResetTimeline = true;
            _m_areTeamsSwapped = MockAdapter.AreTeamsPlayingSwitchedSides();
        }
        if (!_SupportsTimeline(jsoTime)) {
            bResetTimeline = true;
        }
        if (_m_overtime != jsoTime['overtime']) {
            _m_overtime = jsoTime['overtime'];
            bResetTimeline = true;
        }
        if (bResetTimeline || !(currentRound in _m_RoundUpdated)) {
            if (bResetTimeline) {
                _ResetTimeline();
            }
            _UpdateAllRounds();
            _m_RoundUpdated[currentRound] = true;
        }
        else {
            let oScoreData = MockAdapter.GetScoreDataJSO();
            if (oScoreData) {
                _UpdateRound(currentRound - 1, oScoreData, jsoTime);
            }
        }
        _UpdateRoundLossBonus();
    }
    function _InsertTimelineDivider() {
        let elTimeline = _m_cP.FindChildInLayoutFile('id-sb-timeline__segments');
        if (!elTimeline || !elTimeline.IsValid())
            return;
        let elDivider = $.CreatePanel('Panel', elTimeline, 'id-sb-timeline__divider');
        elDivider.AddClass('sb-timeline__divider');
    }
    function _InitTimelineSegment(startRound, endRound, phase) {
        let elTimeline = _m_cP.FindChildInLayoutFile('id-sb-timeline__segments');
        if (!elTimeline || !elTimeline.IsValid())
            return;
        elTimeline.AddClass('sb-team-tint');
        let id = 'id-sb-timeline__segment--' + phase;
        let elSegment = elTimeline.FindChildTraverse(id);
        if (!elSegment || !elSegment.IsValid()) {
            elSegment = $.CreatePanel('Panel', elTimeline, id);
            elSegment.BLoadLayoutSnippet('snippet_scoreboard-classic__timeline__segment');
        }
        let elRoundContainer = elSegment.FindChildTraverse('id-sb-timeline__round-container');
        if (elRoundContainer && elRoundContainer.IsValid()) {
            for (let rnd = startRound; rnd <= endRound; rnd++) {
                let elRnd = elSegment.FindChildTraverse(rnd.toString());
                if (!elRnd || !elRnd.IsValid()) {
                    elRnd = $.CreatePanel('Panel', elRoundContainer, rnd.toString());
                    elRnd.BLoadLayoutSnippet('snippet_scoreboard-classic__timeline__segment__round');
                    let elTop = elRnd.FindChildTraverse('id-sb-timeline__segment__round--top');
                    elTop.BLoadLayoutSnippet('snippet_scoreboard-classic__timeline__segment__round__data');
                    let elBot = elRnd.FindChildTraverse('id-sb-timeline__segment__round--bot');
                    elBot.BLoadLayoutSnippet('snippet_scoreboard-classic__timeline__segment__round__data');
                    if (rnd % 5 == 0) {
                        elRnd.FindChildTraverse('id-sb-timeline__segment__round__tick__label').text = rnd.toString();
                    }
                }
            }
        }
        if (MockAdapter.AreTeamsPlayingSwitchedSides() !== MockAdapter.AreTeamsPlayingSwitchedSidesInRound(endRound)) {
            let elCTScore = elSegment.FindChildTraverse('id-sb-timeline__segment__score__ct');
            let elTScore = elSegment.FindChildTraverse('id-sb-timeline__segment__score__t');
            if (elCTScore && elCTScore.IsValid()) {
                elCTScore.RemoveClass('sb-color--CT');
                elCTScore.AddClass('sb-color--TERRORIST');
            }
            if (elTScore && elTScore.IsValid()) {
                elTScore.RemoveClass('sb-color--TERRORIST');
                elTScore.AddClass('sb-color--CT');
            }
        }
    }
    function _SupportsTimeline(jsoTime) {
        if (jsoTime == undefined)
            jsoTime = MockAdapter.GetTimeDataJSO();
        let roundCountToEvaluate;
        if (MatchStatsAPI.DoesSupportOvertimeStats()) {
            roundCountToEvaluate = jsoTime['maxrounds_this_period'];
        }
        else {
            roundCountToEvaluate = jsoTime['maxrounds'];
        }
        return (roundCountToEvaluate <= 30);
    }
    function _UpdateRoundLossBonus() {
        let elRoundLossBonusMoney = _m_cP.FindChildInLayoutFile('id-sb-timeline__round-loss-bonus-money');
        if (elRoundLossBonusMoney && elRoundLossBonusMoney.IsValid()) {
            elRoundLossBonusMoney.AddClass('hidden');
            if (parseInt(GameInterfaceAPI.GetSettingString('mp_consecutive_loss_max')) > 0 &&
                parseInt(GameInterfaceAPI.GetSettingString('cash_team_loser_bonus_consecutive_rounds')) > 0) {
                let nLossT = MockAdapter.GetTeamNextRoundLossBonus('TERRORIST');
                let nLossCT = MockAdapter.GetTeamNextRoundLossBonus('CT');
                if (nLossT >= 0 && nLossCT >= 0) {
                    elRoundLossBonusMoney.RemoveClass('hidden');
                    for (let nClassIdx = 1; nClassIdx <= 4; ++nClassIdx) {
                        elRoundLossBonusMoney.SetHasClass('sb-timeline__round-loss-bonus-money__TERRORIST' + nClassIdx, nLossT >= nClassIdx);
                    }
                    for (let nClassIdx = 1; nClassIdx <= 4; ++nClassIdx) {
                        elRoundLossBonusMoney.SetHasClass('sb-timeline__round-loss-bonus-money__CT' + nClassIdx, nLossCT >= nClassIdx);
                    }
                }
            }
        }
    }
    function _ResetTimeline() {
        _UpdateRoundLossBonus();
        let elTimeline = _m_cP.FindChildInLayoutFile('id-sb-timeline__segments');
        if (!elTimeline || !elTimeline.IsValid())
            return;
        elTimeline.RemoveAndDeleteChildren();
        let jsoTime = MockAdapter.GetTimeDataJSO();
        if (!jsoTime)
            return;
        if (!_SupportsTimeline(jsoTime))
            return;
        let firstRound;
        let lastRound;
        let midRound;
        if (MatchStatsAPI.DoesSupportOvertimeStats()) {
            firstRound = jsoTime['first_round_this_period'];
            lastRound = jsoTime['last_round_this_period'];
            let elLabel = _m_cP.FindChildTraverse('id-sb-timeline__round-label');
            if (elLabel && elLabel.IsValid()) {
                elLabel.SetHasClass('hidden', jsoTime['overtime'] == 0);
            }
        }
        else {
            firstRound = 1;
            lastRound = jsoTime['maxrounds'];
        }
        midRound = firstRound + Math.ceil((lastRound - firstRound) / 2) - 1;
        if (MockAdapter.HasHalfTime()) {
            _InitTimelineSegment(firstRound, midRound, 'first-half');
            _InsertTimelineDivider();
            _InitTimelineSegment(midRound + 1, lastRound, 'second-half');
        }
        else {
            _InitTimelineSegment(firstRound, lastRound, 'no-halves');
        }
        _UpdateAllRounds();
        if (GameInterfaceAPI.GetSettingString('cl_scoreboard_survivors_always_on') == '1')
            _ShowSurvivors();
    }
    function _UnborrowMusicKit() {
        GameInterfaceAPI.SetSettingString('cl_borrow_music_from_player_slot', '-1');
        let oLocalPlayer = _m_oPlayers.GetPlayerByXuid(GetLocalPlayerId());
        _m_oUpdateStatFns['musickit'](oLocalPlayer, true);
    }
    function UpdateCasterButtons() {
        for (let i = 0; i < 4; i++) {
            let buttonName = '#spec-button' + (i + 1);
            let bActive = true;
            switch (i) {
                default:
                case 0:
                    bActive = !!GetCasterIsCameraman();
                    break;
                case 1:
                    bActive = !!GetCasterIsHeard();
                    break;
                case 2:
                    bActive = !!GetCasterControlsXray();
                    break;
                case 3:
                    bActive = !!GetCasterControlsUI();
                    break;
            }
            ToggleCasterButtonActive(buttonName, bActive);
        }
    }
    function ToggleCasterButtonActive(buttonName, bActive) {
        let button = $(buttonName);
        if (button == null)
            return;
        if (bActive == false && button.BHasClass('sb-spectator-control-button-notactive') == false) {
            button.AddClass('sb-spectator-control-button-notactive');
        }
        else if (bActive == true && button.BHasClass('sb-spectator-control-button-notactive') == true) {
            button.RemoveClass('sb-spectator-control-button-notactive');
        }
    }
    function _ToggleSetCasterIsCameraman() {
        $.DispatchEvent('CSGOPlaySoundEffect', 'generic_button_press', 'MOUSE');
        let nCameraMan = parseInt(GameInterfaceAPI.GetSettingString('spec_autodirector_cameraman'));
        if (GetCasterIsCameraman()) {
            GameStateAPI.SetCasterIsCameraman(0);
        }
        else {
            GameStateAPI.SetCasterIsCameraman(nCameraMan);
        }
        UpdateCasterButtons();
    }
    function _ToggleSetCasterIsHeard() {
        $.DispatchEvent('CSGOPlaySoundEffect', 'generic_button_press', 'MOUSE');
        let nCameraMan = parseInt(GameInterfaceAPI.GetSettingString('spec_autodirector_cameraman'));
        if (GetCasterIsHeard()) {
            GameStateAPI.SetCasterIsHeard(0);
        }
        else {
            GameStateAPI.SetCasterIsHeard(nCameraMan);
        }
        UpdateCasterButtons();
    }
    function _ToggleSetCasterControlsXray() {
        $.DispatchEvent('CSGOPlaySoundEffect', 'generic_button_press', 'MOUSE');
        let nCameraMan = parseInt(GameInterfaceAPI.GetSettingString('spec_autodirector_cameraman'));
        if (GetCasterControlsXray()) {
            GameStateAPI.SetCasterControlsXray(0);
            ToggleCasterButtonActive('#spec-button3', false);
        }
        else {
            GameStateAPI.SetCasterControlsXray(nCameraMan);
            ToggleCasterButtonActive('#spec-button3', true);
        }
    }
    function _ToggleSetCasterControlsUI() {
        $.DispatchEvent('CSGOPlaySoundEffect', 'generic_button_press', 'MOUSE');
        let nCameraMan = parseInt(GameInterfaceAPI.GetSettingString('spec_autodirector_cameraman'));
        if (GetCasterControlsUI()) {
            GameStateAPI.SetCasterControlsUI(0);
        }
        else {
            GameStateAPI.SetCasterControlsUI(nCameraMan);
        }
        UpdateCasterButtons();
    }
    function _CycleStats() {
        if (_m_dataSetGetCount === 0)
            return;
        {
            _m_dataSetCurrent++;
            if (_m_dataSetCurrent >= _m_dataSetGetCount)
                _m_dataSetCurrent = 0;
        }
        let elLabelSets = $('#id-sb-row__sets');
        for (let i = 0; i < elLabelSets.Children().length; i++) {
            let elChild = elLabelSets.Children()[i];
            if (elChild.id == 'id-sb-labels-set-' + _m_dataSetCurrent) {
                elChild.RemoveClass('hidden');
            }
            else {
                elChild.AddClass('hidden');
            }
        }
        for (let i = 0; i < _m_oPlayers.GetCount(); i++) {
            let elPlayer = _m_oPlayers.GetPlayerByIndex(i).m_elPlayer;
            if (elPlayer && elPlayer.IsValid()) {
                let elSetContainer = elPlayer.FindChildTraverse('id-sb-row__set-container');
                if (elSetContainer && elSetContainer.IsValid()) {
                    for (let j = 0; j < elSetContainer.Children().length; j++) {
                        let elChild = elSetContainer.Children()[j];
                        if (elChild.id == 'id-sb-set-' + _m_dataSetCurrent) {
                            elChild.RemoveClass('hidden');
                        }
                        else {
                            elChild.AddClass('hidden');
                        }
                    }
                }
            }
        }
        StoreAPI.RecordUIEvent('ScoreboardMoreStatsToggle');
    }
    function _MuteVoice() {
        GameInterfaceAPI.ConsoleCommand('voice_modenable_toggle');
        $.Schedule(0.1, _UpdateMuteVoiceState);
    }
    function _UpdateMuteVoiceState() {
        StoreAPI.RecordUIEvent('ScoreboardMuteVoiceToggle');
        let muteState = GameInterfaceAPI.GetSettingString('voice_modenable') === '1';
        let elMuteImage = _m_cP.FindChildInLayoutFile('id-sb-meta__mutevoice__image');
        if (!elMuteImage)
            return;
        if (muteState) {
            elMuteImage.SetImage('file://{images}/icons/ui/unmuted.svg');
        }
        else {
            elMuteImage.SetImage('file://{images}/icons/ui/muted.svg');
        }
    }
    function _BlockUgc() {
        StoreAPI.RecordUIEvent('ScoreboardBlockUgcToggle');
        let ugcBlockState = GameInterfaceAPI.GetSettingString('cl_hide_avatar_images') !== '0' ||
            GameInterfaceAPI.GetSettingString('cl_sanitize_player_names') !== '0';
        if (ugcBlockState) {
            GameInterfaceAPI.SetSettingString('cl_sanitize_player_names', '0');
            GameInterfaceAPI.SetSettingString('cl_hide_avatar_images', '0');
        }
        else {
            GameInterfaceAPI.SetSettingString('cl_sanitize_player_names', '1');
            GameInterfaceAPI.SetSettingString('cl_hide_avatar_images', '2');
        }
        $.Schedule(0.1, _UpdateUgcState);
    }
    function _UpdateUgcState() {
        let ugcBlockState = GameInterfaceAPI.GetSettingString('cl_hide_avatar_images') !== '0' ||
            GameInterfaceAPI.GetSettingString('cl_sanitize_player_names') !== '0';
        let elBlockUgcImage = _m_cP.FindChildInLayoutFile('id-sb-meta__blockugc__image');
        if (!elBlockUgcImage)
            return;
        if (ugcBlockState) {
            elBlockUgcImage.SetImage('file://{images}/icons/ui/votekick.svg');
        }
        else {
            elBlockUgcImage.SetImage('file://{images}/icons/ui/player.svg');
        }
    }
    function _CreateLabelsForRow(el) {
        if (!el || !el.IsValid())
            return;
        for (let i = 0; i < el.Children().length; i++) {
            _CreateLabelsForRow(el.Children()[i]);
        }
        let stat = el.GetAttributeString('data-stat', '');
        let set = el.GetAttributeString('data-set', '');
        let isHidden = el.GetAttributeString('data-hidden', '');
        if (stat != '')
            _CreateLabelForStat(stat, set, isHidden);
    }
    function _GetSortOrderForMode(mode) {
        if (GameStateAPI.IsQueuedMatchmakingMode_Team())
            return sortOrder_tmm;
        switch (mode) {
            case 'deathmatch':
                if (GameInterfaceAPI.GetSettingString('mp_dm_teammode') !== '0') {
                    return sortOrder_default;
                }
                return sortOrder_dm;
            case 'competitive':
            case 'premier':
                return sortOrder_tmm;
            default:
                return sortOrder_default;
        }
    }
    function _Initialize() {
        _Reset();
        let jsoTime = MockAdapter.GetTimeDataJSO();
        if (!jsoTime)
            return;
        let scoreboardTemplate;
        let mode = MockAdapter.GetGameModeInternalName(false);
        let skirmish = MockAdapter.GetGameModeInternalName(true);
        if (mode == 'deathmatch') {
            if (GameInterfaceAPI.GetSettingString('mp_teammates_are_enemies') !== '0') {
                skirmish = 'ffadm';
            }
            else if (GameInterfaceAPI.GetSettingString('mp_dm_teammode') !== '0') {
                skirmish = 'teamdm';
            }
        }
        if (mode === 'survival') {
            return;
        }
        switch (mode.toLowerCase()) {
            case 'premier':
            case 'competitive':
            case 'scrimcomp2v2':
                scoreboardTemplate = 'snippet_scoreboard-classic--with-timeline--half-times';
                break;
            case 'deathmatch':
                if (skirmish == 'teamdm') {
                    scoreboardTemplate = 'snippet_scoreboard-classic--no-timeline';
                }
                else {
                    scoreboardTemplate = 'snippet_scoreboard--no-teams';
                }
                break;
            case 'training':
                scoreboardTemplate = 'snippet_scoreboard--no-teams';
                break;
            case 'cooperative':
                scoreboardTemplate = 'snippet_scoreboard--cooperative';
                break;
            case 'coopmission':
                scoreboardTemplate = 'snippet_scoreboard--coopmission';
                break;
            case 'casual':
                if (skirmish == 'flyingscoutsman') {
                    scoreboardTemplate = 'snippet_scoreboard-classic--with-timeline--no-half-times';
                }
                else {
                    scoreboardTemplate = 'snippet_scoreboard-classic--no-timeline';
                }
                break;
            default:
                scoreboardTemplate = 'snippet_scoreboard-classic--no-timeline';
                break;
        }
        _Helper_LoadSnippet(_m_cP, scoreboardTemplate);
        if (MockAdapter.IsDemoOrHltv())
            _m_cP.AddClass('IsDemoOrHltv');
        if (MatchStatsAPI.IsTournamentMatch())
            _m_cP.AddClass('IsTournamentMatch');
        _m_sortOrder = _GetSortOrderForMode(mode);
        let temp = $.CreatePanel('Panel', _m_cP, 'temp');
        _Helper_LoadSnippet(temp, _GetPlayerRowForGameMode());
        temp.visible = false;
        _CreateLabelsForRow(temp);
        temp.DeleteAsync(.0);
        _ResetTimeline();
        _m_bInit = true;
        _m_cP.SetDialogVariable('server_name', '');
        _UpdateHLTVViewerNumber(0);
        _UpdateMatchInfo();
    }
    function _RankRevealAll() {
        for (let i = 0; i < _m_oPlayers.GetCount(); i++) {
            let oPlayer = _m_oPlayers.GetPlayerByIndex(i);
            if (typeof (_m_oUpdateStatFns['skillgroup']) === 'function')
                _m_oUpdateStatFns['skillgroup'](oPlayer, true);
        }
    }
    function _UpdateScore() {
        switch (MockAdapter.GetGameModeInternalName(false)) {
            case 'competitive':
            case 'premier':
                _UpdateScore_Classic();
                break;
            case 'deathmatch':
                if (GameInterfaceAPI.GetSettingString('mp_dm_teammode') !== '0') {
                    _UpdateScore_Classic();
                }
                break;
            default:
            case 'casual':
                _UpdateScore_Classic();
                break;
        }
    }
    function _UpdateJob() {
        _UpdateMatchInfo();
        _UpdateScore();
        _UpdateNextPlayer();
    }
    function _UpdateEverything() {
        if (!_m_bInit) {
            _Initialize();
        }
        _UpdateMuteVoiceState();
        _UpdateUgcState();
        _UpdateMatchInfo();
        _UpdateScore();
        _UpdateAllPlayers_delayed(true);
        _UpdateSpectatorButtons();
    }
    function _OnMouseActive() {
        let elButtonPanel = _m_cP.FindChildTraverse('id-sb-meta__button-panel');
        if (elButtonPanel && elButtonPanel.IsValid())
            elButtonPanel.RemoveClass('hidden');
        let elServerViewers = _m_cP.FindChildTraverse('id-sb-meta__labels__server-viewers');
        if (elServerViewers && elServerViewers.IsValid())
            elServerViewers.AddClass('hidden');
        let elMouseInstructions = _m_cP.FindChildTraverse('id-sb-mouse-instructions');
        if (elMouseInstructions && elMouseInstructions.IsValid())
            elMouseInstructions.AddClass('hidden');
    }
    function _OnMouseInactive() {
        let elButtonPanel = _m_cP.FindChildTraverse('id-sb-meta__button-panel');
        if (elButtonPanel && elButtonPanel.IsValid())
            elButtonPanel.AddClass('hidden');
        let elServerViewers = _m_cP.FindChildTraverse('id-sb-meta__labels__server-viewers');
        if (elServerViewers && elServerViewers.IsValid())
            elServerViewers.RemoveClass('hidden');
        let elMouseInstructions = _m_cP.FindChildTraverse('id-sb-mouse-instructions');
        if (elMouseInstructions && elMouseInstructions.IsValid())
            elMouseInstructions.RemoveClass('hidden');
    }
    function _CloseScoreboard() {
        if (_m_updatePlayerHandler) {
            $.UnregisterForUnhandledEvent('Scoreboard_UpdatePlayerByPlayerSlot', _m_updatePlayerHandler);
            _m_updatePlayerHandler = null;
        }
        $.DispatchEvent('DismissAllContextMenus');
        _OnMouseInactive();
    }
    function _OpenScoreboard() {
        _UpdateEverything();
        _ShowSurvivors((GameInterfaceAPI.GetSettingString('cl_scoreboard_survivors_always_on') == '0'));
        if (!_m_updatePlayerHandler) {
            _m_updatePlayerHandler = $.RegisterForUnhandledEvent('Scoreboard_UpdatePlayerByPlayerSlot', Scoreboard.UpdatePlayerByPlayerSlot);
        }
    }
    function _OnEndOfMatch() {
        _OpenScoreboard();
    }
    function _GetFreeForAllTopThreePlayers() {
        _UpdateEverything();
        if (!$('#Scoreboard'))
            return [undefined, undefined, undefined];
        let elTeam = $('#Scoreboard').FindChildInLayoutFile('players-table-ANY');
        if (elTeam && elTeam.IsValid()) {
            const players = elTeam.Children();
            return [players[0]?.m_xuid || '0', players[1]?.m_xuid || '0', players[2]?.m_xuid || '0'];
        }
        return [undefined, undefined, undefined];
    }
    function _GetFreeForAllPlayerPosition(xuid) {
        _UpdateEverything();
        let elTeam = _m_cP.FindChildInLayoutFile('players-table-ANY');
        if (!elTeam || !elTeam.IsValid())
            return;
        let returnVal = 0;
        for (let i = 0; i < elTeam.Children().length; i++) {
            if (elTeam.Children()[i].m_xuid == xuid)
                returnVal = i + 1;
        }
        $.DispatchEvent('EndOfMatch_GetFreeForAllPlayerPosition_Response', returnVal);
    }
    function GetCasterIsCameraman() {
        let nCameraMan = parseInt(GameInterfaceAPI.GetSettingString('spec_autodirector_cameraman'));
        let bQ = (MockAdapter.IsDemoOrHltv() && nCameraMan != 0 && MockAdapter.IsHLTVAutodirectorOn());
        return bQ;
    }
    function GetCasterIsHeard() {
        if (MockAdapter.IsDemoOrHltv()) {
            return !!parseInt(GameInterfaceAPI.GetSettingString('voice_caster_enable'));
        }
        return false;
    }
    function GetCasterControlsXray() {
        let bXRay = MockAdapter.IsDemoOrHltv() && parseInt(GameInterfaceAPI.GetSettingString('spec_cameraman_xray'));
        return bXRay;
    }
    function GetCasterControlsUI() {
        let bSpecCameraMan = parseInt(GameInterfaceAPI.GetSettingString('spec_cameraman_ui'));
        let bQ = (MockAdapter.IsDemoOrHltv() && bSpecCameraMan);
        return bQ;
    }
    function _ApplyPlayerCrosshairCode(panel, xuid) {
        UiToolkitAPI.ShowGenericPopupYesNo($.Localize('#tooltip_copycrosshair'), $.Localize('#GameUI_Xhair_Copy_Code_Confirm'), '', function () { let code = GameStateAPI.GetCrosshairCode(xuid); MyPersonaAPI.BApplyCrosshairCode(code); }, function () { });
    }
    return {
        OpenScoreboard: _OpenScoreboard,
        CloseScoreboard: _CloseScoreboard,
        UpdateMatchInfo: _UpdateMatchInfo,
        UpdatePlayerByPlayerSlot: _UpdatePlayerByPlayerSlot_delayed,
        UpdateEverything: _UpdateEverything,
        ResetAndInit: _Initialize,
        Casualties_OnMouseOver: _Casualties_OnMouseOver,
        Casualties_OnMouseOut: _Casualties_OnMouseOut,
        RoundLossBonusMoney_OnMouseOver_CT: _RoundLossBonusMoney_OnMouseOver_CT,
        RoundLossBonusMoney_OnMouseOut_CT: _RoundLossBonusMoney_OnMouseOut_CT,
        RoundLossBonusMoney_OnMouseOver_TERRORIST: _RoundLossBonusMoney_OnMouseOver_TERRORIST,
        RoundLossBonusMoney_OnMouseOut_TERRORIST: _RoundLossBonusMoney_OnMouseOut_TERRORIST,
        UpdateJob: _UpdateJob,
        CycleStats: _CycleStats,
        OnMouseActive: _OnMouseActive,
        OnEndOfMatch: _OnEndOfMatch,
        GetFreeForAllTopThreePlayers: _GetFreeForAllTopThreePlayers,
        GetFreeForAllPlayerPosition: _GetFreeForAllPlayerPosition,
        UnborrowMusicKit: _UnborrowMusicKit,
        UpdateHLTVViewerNumber: _UpdateHLTVViewerNumber,
        ToggleSetCasterIsCameraman: _ToggleSetCasterIsCameraman,
        ToggleSetCasterIsHeard: _ToggleSetCasterIsHeard,
        ToggleSetCasterControlsXray: _ToggleSetCasterControlsXray,
        ToggleSetCasterControlsUI: _ToggleSetCasterControlsUI,
        MuteVoice: _MuteVoice,
        BlockUgc: _BlockUgc,
        RankRevealAll: _RankRevealAll,
        ApplyPlayerCrosshairCode: _ApplyPlayerCrosshairCode,
    };
})();
(function () {
    $.RegisterForUnhandledEvent('OnOpenScoreboard', Scoreboard.OpenScoreboard);
    $.RegisterForUnhandledEvent('OnCloseScoreboard', Scoreboard.CloseScoreboard);
    $.RegisterForUnhandledEvent('GameState_OnLevelLoad', Scoreboard.ResetAndInit);
    $.RegisterForUnhandledEvent('Scoreboard_ResetAndInit', Scoreboard.ResetAndInit);
    $.RegisterForUnhandledEvent('Scoreboard_UpdateEverything', Scoreboard.UpdateEverything);
    $.RegisterForUnhandledEvent('Scoreboard_UpdateJob', Scoreboard.UpdateJob);
    $.RegisterForUnhandledEvent('Scoreboard_CycleStats', Scoreboard.CycleStats);
    $.RegisterForUnhandledEvent('Scoreboard_OnMouseActive', Scoreboard.OnMouseActive);
    $.RegisterForUnhandledEvent('Scoreboard_OnEndOfMatch', Scoreboard.OnEndOfMatch);
    $.RegisterForUnhandledEvent('Scoreboard_UnborrowMusicKit', Scoreboard.UnborrowMusicKit);
    $.RegisterForUnhandledEvent('Scoreboard_ToggleSetCasterIsCameraman', Scoreboard.ToggleSetCasterIsCameraman);
    $.RegisterForUnhandledEvent('Scoreboard_ToggleSetCasterIsHeard', Scoreboard.ToggleSetCasterIsHeard);
    $.RegisterForUnhandledEvent('Scoreboard_ToggleSetCasterControlsXray', Scoreboard.ToggleSetCasterControlsXray);
    $.RegisterForUnhandledEvent('Scoreboard_ToggleSetCasterControlsUI', Scoreboard.ToggleSetCasterControlsUI);
    $.RegisterForUnhandledEvent('GameState_RankRevealAll', Scoreboard.RankRevealAll);
    $.RegisterForUnhandledEvent('Scoreboard_UpdateHLTVViewers', Scoreboard.UpdateHLTVViewerNumber);
    $.RegisterForUnhandledEvent('Scoreboard_Casualties_OnMouseOver', Scoreboard.Casualties_OnMouseOver);
    $.RegisterForUnhandledEvent('Scoreboard_Casualties_OnMouseOut', Scoreboard.Casualties_OnMouseOut);
    $.RegisterForUnhandledEvent('Scoreboard_RoundLossBonusMoney_OnMouseOver_CT', Scoreboard.RoundLossBonusMoney_OnMouseOver_CT);
    $.RegisterForUnhandledEvent('Scoreboard_RoundLossBonusMoney_OnMouseOut_CT', Scoreboard.RoundLossBonusMoney_OnMouseOut_CT);
    $.RegisterForUnhandledEvent('Scoreboard_RoundLossBonusMoney_OnMouseOver_TERRORIST', Scoreboard.RoundLossBonusMoney_OnMouseOver_TERRORIST);
    $.RegisterForUnhandledEvent('Scoreboard_RoundLossBonusMoney_OnMouseOut_TERRORIST', Scoreboard.RoundLossBonusMoney_OnMouseOut_TERRORIST);
    $.RegisterForUnhandledEvent('Scoreboard_MuteVoice', Scoreboard.MuteVoice);
    $.RegisterForUnhandledEvent('Scoreboard_BlockUgc', Scoreboard.BlockUgc);
    $.RegisterForUnhandledEvent('Scoreboard_ApplyPlayerCrosshairCode', Scoreboard.ApplyPlayerCrosshairCode);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2NvcmVib2FyZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL3Njb3JlYm9hcmQudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUNsQyx3Q0FBd0M7QUFDeEMsc0RBQXNEO0FBQ3RELDZDQUE2QztBQUM3Qyx5Q0FBeUM7QUFDekMsd0NBQXdDO0FBc0J4QyxJQUFJLFVBQVUsR0FBRyxDQUFFO0lBRWxCLFNBQVMsSUFBSSxDQUFHLElBQVk7SUFHNUIsQ0FBQztJQWtCRCxNQUFNLEtBQUssR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFzQixDQUFDO0lBRXRELElBQUksZ0JBQWdCLEdBQUcsRUFBRSxDQUFDO0lBQzFCLFNBQVMsZ0JBQWdCO1FBRXhCLElBQUssZ0JBQWdCLEtBQUssRUFBRTtZQUMzQixnQkFBZ0IsR0FBRyxZQUFZLENBQUMsa0JBQWtCLEVBQUUsQ0FBQztRQUN0RCxPQUFPLGdCQUFnQixDQUFDO0lBQ3pCLENBQUM7SUFZRCxNQUFNLE1BQU07UUFFWCxxQkFBcUIsR0FBdUU7WUFDM0YsUUFBUSxFQUFFLEVBQUU7WUFDWixTQUFTLEVBQUUsRUFBRTtZQUNiLFVBQVUsRUFBRSxFQUFFO1NBQ2QsQ0FBQztRQUNGLFVBQVUsQ0FBUztRQUVuQixZQUFhLFFBQWdCO1lBRTVCLElBQUksQ0FBQyxVQUFVLEdBQUcsUUFBUSxDQUFDO1FBQzVCLENBQUM7UUFHRCxvQkFBb0I7WUFFakIsQ0FBRSxRQUFRLEVBQUUsU0FBUyxFQUFFLFVBQVUsQ0FBdUIsQ0FBQyxPQUFPLENBQUUsSUFBSSxDQUFDLEVBQUU7Z0JBSzFFLElBQUksQ0FBQyx1QkFBdUIsQ0FBRSxJQUFJLENBQUUsQ0FBQztnQkFFckMsSUFBSSxDQUFDLHFCQUFxQixDQUFFLGNBQWMsQ0FBRSxJQUFJLENBQUUsRUFBRSxJQUFJLEVBQUUsS0FBSyxDQUFFLENBQUM7Z0JBRWxFLGNBQWMsQ0FBRSxJ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