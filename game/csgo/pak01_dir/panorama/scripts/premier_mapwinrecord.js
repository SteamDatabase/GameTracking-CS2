"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/teamcolor.ts" />
/// <reference path="common/formattext.ts"/>
var PremierMapWinRecord;
(function (PremierMapWinRecord) {
    function _msg(msg) {
    }
    const m_numMaps = 7;
    const spiderGraph = $('#jsMapWinsSpiderGraph');
    var m_LobbyPlayerUpdatedEventHandler;
    var m_LeaderboardHoverPlayerEventHandler;
    var m_bEventsRegistered = false;
    function Init() {
        RegisterEventHandlers();
        if (spiderGraph.BCanvasReady()) {
            Draw();
        }
        else {
            $.Schedule(0.1, Init);
        }
    }
    PremierMapWinRecord.Init = Init;
    function RegisterEventHandlers() {
        if (!m_bEventsRegistered) {
            m_LobbyPlayerUpdatedEventHandler = $.RegisterForUnhandledEvent("PanoramaComponent_Lobby_PlayerUpdated", Draw);
            m_LeaderboardHoverPlayerEventHandler = $.RegisterForUnhandledEvent("LeaderboardHoverPlayer", _HighlightPlayer);
            $.RegisterForUnhandledEvent("CSGOHideMainMenu", UnregisterEventHandlers);
            $.RegisterForUnhandledEvent("CSGOShowMainMenu", RegisterEventHandlers);
            $.RegisterEventHandler('ReadyForDisplay', $.GetContextPanel(), Draw);
            m_bEventsRegistered = true;
        }
    }
    PremierMapWinRecord.RegisterEventHandlers = RegisterEventHandlers;
    function UnregisterEventHandlers() {
        if (m_bEventsRegistered) {
            $.UnregisterForUnhandledEvent('PanoramaComponent_Lobby_PlayerUpdated', m_LobbyPlayerUpdatedEventHandler);
            $.UnregisterForUnhandledEvent('LeaderboardHoverPlayer', m_LeaderboardHoverPlayerEventHandler);
            m_bEventsRegistered = false;
        }
    }
    PremierMapWinRecord.UnregisterEventHandlers = UnregisterEventHandlers;
    function Draw() {
        _DrawParty();
        _MakeMapPanels();
    }
    PremierMapWinRecord.Draw = Draw;
    ;
    function _HighlightPlayer(xuid) {
        _DrawParty(xuid);
    }
    const oAlpha = {
        'normal': { 'outer': 0.5, 'inner': 0.1 },
        'dim': { 'outer': 0.2, 'inner': 0 },
        'hilit': { 'outer': 1, 'inner': 0.2 },
    };
    function _DrawPlayerPlot(arrValues, rgb, max, plotType = 'normal') {
        let rgbColorOuter = 'rgba(' + rgb + ',' + oAlpha[plotType].outer + ')';
        let rgbColorInner = 'rgba(' + rgb + ',' + oAlpha[plotType].inner + ')';
        arrValues = arrValues.map(a => a / max);
        const options = {
            line_color: rgbColorOuter,
            line_thickness: 3,
            line_softness: 10,
            fill_color_inner: rgbColorInner,
            fill_color_outer: rgbColorInner,
        };
        spiderGraph.DrawGraphPoly(arrValues, options);
    }
    function _GetMapsList() {
        return Object.keys(FriendsListAPI.GetFriendCompetitivePremierWindowStatsObject("0"));
    }
    function _DrawGuides(maxWinsInASingleMap) {
        spiderGraph.ClearJS('rgba(0,0,0,0)');
        const options = {
            bkg_color: "#00000080",
            spokes_color: '#ffffff10',
            spoke_thickness: 2,
            spoke_softness: 100,
            spoke_length_scale: 1.2,
            guideline_color: '#ffffff10',
            guideline_thickness: 2,
            guideline_softness: 100,
            guideline_count: maxWinsInASingleMap + 1,
            deadzone_percent: 0.1,
            scale: 0.70
        };
        spiderGraph.SetGraphOptions(options);
        spiderGraph.DrawGraphBackground(m_numMaps);
    }
    function _SetTitle(totalWins) {
        const pLabel = $('#jsMapWinsLabel');
        pLabel.text = FormatText.FormatPluralLoc("#mapwinrecord_graph_title:p", totalWins);
    }
    function _DrawParty(highlightedPlayerXuid = '') {
        if (LobbyAPI.IsSessionActive()) {
            const party = LobbyAPI.GetSessionSettings().members;
            const nPlayers = party.numPlayers;
            let totalWins = 0;
            let maxWinsInASingleMap = 3;
            let mapList = _GetMapsList();
            let wso = [];
            let lbFallbackName = LeaderboardsAPI.GetCurrentSeasonPremierLeaderboard() + '.party';
            for (let p = 0; p < nPlayers; p++) {
                let xuid = party['machine' + p].player0.xuid;
                let playerObj = null;
                if (PartyListAPI.GetFriendCompetitiveRankType(xuid) === "Premier") {
                    var partyScore = PartyListAPI.GetFriendCompetitiveRank(xuid);
                    var partyWins = PartyListAPI.GetFriendCompetitiveWins(xuid);
                    if (partyScore || partyWins)
                        playerObj = PartyListAPI.GetFriendCompetitivePremierWindowStatsObject(xuid);
                }
                if (!playerObj) {
                    let objLbRow = LeaderboardsAPI.GetEntryDetailsObjectByXuid(lbFallbackName, xuid);
                    if (objLbRow && objLbRow.XUID && objLbRow.rankWindowStats)
                        playerObj = objLbRow.rankWindowStats;
                }
                if (!playerObj)
                    playerObj = PartyListAPI.GetFriendCompetitivePremierWindowStatsObject(xuid);
                wso.push(playerObj);
            }
            for (let p = 0; p < nPlayers; p++) {
                let RankWindowObject = wso[p];
                let playerWins = mapList.map((mapName) => { return mapName.startsWith('de_') ? Number(RankWindowObject[mapName] | 0) : 0; });
                totalWins = totalWins + playerWins.reduce((a, b) => a + b, 0);
                maxWinsInASingleMap = Math.max(maxWinsInASingleMap, Math.max.apply(null, playerWins));
            }
            _DrawGuides(maxWinsInASingleMap);
            _SetTitle(totalWins);
            for (let p = 0; p < nPlayers; p++) {
                let xuid = party['machine' + p].player0.xuid;
                let RankWindowObject = wso[p];
                let playerWins = mapList.map((mapName) => { return mapName.startsWith('de_') ? Number(RankWindowObject[mapName] | 0) : 0; });
                const teamColorIdx = PartyListAPI.GetPartyMemberSetting(xuid, 'game/teamcolor');
                const teamColorRgb = TeamColor.GetTeamColor(Number(teamColorIdx));
                let hilite = highlightedPlayerXuid === '' ? 'normal' : highlightedPlayerXuid === xuid ? 'hilit' : 'dim';
                _DrawPlayerPlot(playerWins, teamColorRgb, maxWinsInASingleMap, hilite);
            }
        }
    }
    function _MakeMapPanels() {
        let arrMaps = _GetMapsList();
        let elMapContainer = $.GetContextPanel().FindChildTraverse('jsMapWinsSpiderGraph');
        elMapContainer.RemoveAndDeleteChildren();
        for (let s = 0; s < m_numMaps; s++) {
            let elMap = $.CreatePanel('Panel', elMapContainer, String(s));
            elMap.BLoadLayoutSnippet('snippet-mwr-map');
            let elMapImage = elMap.FindChildInLayoutFile('mwr-map__image');
            let imageName = arrMaps[s];
            elMapImage.SetImage("file://{images}/map_icons/map_icon_" + imageName + ".svg");
            elMapImage.style.backgroundPosition = '50% 50%';
            elMapImage.style.backgroundSize = 'auto 150%';
            elMap.style.flowChildren = 'up';
            elMap.SetDialogVariable('map-name', $.Localize('#SFUI_Map_' + imageName));
            let vPos = spiderGraph.GraphPositionToUIPosition(s, 1.3);
            elMap.SetPositionInPixels(vPos.x, vPos.y, 0);
        }
    }
})(PremierMapWinRecord || (PremierMapWinRecord = {}));
(function () {
    PremierMapWinRecord.Init();
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicHJlbWllcl9tYXB3aW5yZWNvcmQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9wcmVtaWVyX21hcHdpbnJlY29yZC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsa0NBQWtDO0FBQ2xDLDRDQUE0QztBQUM1Qyw0Q0FBNEM7QUFlNUMsSUFBVSxtQkFBbUIsQ0ErTjVCO0FBL05ELFdBQVUsbUJBQW1CO0lBRzVCLFNBQVMsSUFBSSxDQUFHLEdBQVc7SUFHM0IsQ0FBQztJQUVELE1BQU0sU0FBUyxHQUFHLENBQUMsQ0FBQztJQUNwQixNQUFNLFdBQVcsR0FBRyxDQUFDLENBQUUsdUJBQXVCLENBQW1CLENBQUM7SUFDbEUsSUFBSSxnQ0FBd0MsQ0FBQztJQUM3QyxJQUFJLG9DQUE0QyxDQUFDO0lBQ2pELElBQUksbUJBQW1CLEdBQUcsS0FBSyxDQUFDO0lBSWhDLFNBQWdCLElBQUk7UUFFbkIscUJBQXFCLEVBQUUsQ0FBQztRQUV4QixJQUFLLFdBQVcsQ0FBQyxZQUFZLEVBQUUsRUFDL0I7WUFDQyxJQUFJLEVBQUUsQ0FBQztTQUNQO2FBRUQ7WUFDQyxDQUFDLENBQUMsUUFBUSxDQUFFLEdBQUcsRUFBRSxJQUFJLENBQUUsQ0FBQztTQUl4QjtJQUNGLENBQUM7SUFmZSx3QkFBSSxPQWVuQixDQUFBO0lBRUQsU0FBZ0IscUJBQXFCO1FBRXBDLElBQUssQ0FBQyxtQkFBbUIsRUFDekI7WUFDQyxnQ0FBZ0MsR0FBRyxDQUFDLENBQUMseUJBQXlCLENBQUUsdUNBQXVDLEVBQUUsSUFBSSxDQUFFLENBQUM7WUFDaEgsb0NBQW9DLEdBQUcsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLHdCQUF3QixFQUFFLGdCQUFnQixDQUFFLENBQUM7WUFFakgsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLGtCQUFrQixFQUFFLHVCQUF1QixDQUFFLENBQUM7WUFDM0UsQ0FBQyxDQUFDLHlCQUF5QixD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