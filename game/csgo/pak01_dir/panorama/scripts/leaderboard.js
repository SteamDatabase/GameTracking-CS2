"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="rating_emblem.ts" />
/// <reference path="common/teamcolor.ts" />
const regionToRegionName = {
    'namc': 'NorthAmerica',
    'samc': 'SouthAmerica',
    'euro': 'Europe',
    'asia': 'Asia',
    'ausc': 'Australia',
    'afrc': 'Africa',
    'cn': 'China',
};
var Leaderboard;
(function (Leaderboard) {
    function _msg(msg) {
    }
    let m_bEventsRegistered = false;
    let m_myXuid = MyPersonaAPI.GetXuid();
    let m_lbType;
    let m_LeaderboardsDirtyEventHandler;
    let m_LeaderboardsStateChangeEventHandler;
    let m_FriendsListNameChangedEventHandler;
    let m_LobbyPlayerUpdatedEventHandler;
    let m_NameLockEventHandler;
    let m_leaderboardName = '';
    function RegisterEventHandlers() {
        _msg('RegisterEventHandlers');
        if (!m_bEventsRegistered) {
            m_LeaderboardsDirtyEventHandler = $.RegisterForUnhandledEvent('PanoramaComponent_Leaderboards_Dirty', OnLeaderboardDirty);
            m_LeaderboardsStateChangeEventHandler = $.RegisterForUnhandledEvent('PanoramaComponent_Leaderboards_StateChange', OnLeaderboardStateChange);
            m_FriendsListNameChangedEventHandler = $.RegisterForUnhandledEvent('PanoramaComponent_FriendsList_NameChanged', _UpdateName);
            if (m_lbType === 'party') {
                m_LobbyPlayerUpdatedEventHandler = $.RegisterForUnhandledEvent("PanoramaComponent_PartyList_RebuildPartyList", _UpdatePartyList);
            }
            if (m_lbType === 'general') {
                m_NameLockEventHandler = $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_SetPlayerLeaderboardSafeName', _UpdateNameLockButton);
            }
            m_bEventsRegistered = true;
        }
    }
    Leaderboard.RegisterEventHandlers = RegisterEventHandlers;
    function UnregisterEventHandlers() {
        _msg('UnregisterEventHandlers');
        if (m_bEventsRegistered) {
            $.UnregisterForUnhandledEvent('PanoramaComponent_Leaderboards_Dirty', m_LeaderboardsDirtyEventHandler);
            $.UnregisterForUnhandledEvent('PanoramaComponent_Leaderboards_StateChange', m_LeaderboardsStateChangeEventHandler);
            $.UnregisterForUnhandledEvent('PanoramaComponent_FriendsList_NameChanged', m_FriendsListNameChangedEventHandler);
            if (m_lbType === 'party') {
                $.UnregisterForUnhandledEvent('PanoramaComponent_PartyList_RebuildPartyList', m_LobbyPlayerUpdatedEventHandler);
            }
            if (m_lbType === 'general') {
                $.UnregisterForUnhandledEvent('PanoramaComponent_MyPersona_SetPlayerLeaderboardSafeName', m_NameLockEventHandler);
            }
            m_bEventsRegistered = false;
        }
    }
    Leaderboard.UnregisterEventHandlers = UnregisterEventHandlers;
    function Init() {
        _msg('init');
        m_lbType = $.GetContextPanel().GetAttributeString('lbtype', '');
        RegisterEventHandlers();
        _SetTitle();
        _InitNavPanels();
        _UpdateLeaderboardName();
        if (m_lbType === 'party') {
            _UpdatePartyList();
            if (LeaderboardsAPI.DoesTheLocalPlayerNeedALeaderboardSafeNameSet()) {
                _AutomaticLeaderboardNameLockPopup();
            }
        }
        else if (m_lbType === 'general') {
            UpdateLeaderboardList();
            $.Schedule(0.5, _UpdateNameLockButton);
        }
        _ShowGlobalRank();
    }
    Leaderboard.Init = Init;
    ;
    function _SetTitle() {
        $.GetContextPanel().SetDialogVariable('leaderboard-title', $.Localize('#leaderboard_title_' + String(m_lbType)));
    }
    ;
    function _InitSeasonDropdown() {
        let elSeasonDropdown = $('#jsNavSeason');
        elSeasonDropdown.visible = true;
        elSeasonDropdown.RemoveAllOptions();
        let lbs = LeaderboardsAPI.GetAllSeasonPremierLeaderboards();
        for (let i = 0; i < lbs.length; i++) {
            let szLb = lbs[i];
            const elEntry = $.CreatePanel('Label', elSeasonDropdown, szLb, {
                'class': ''
            });
            elEntry.SetAttributeString('leaderboard', szLb);
            elEntry.SetAcceptsFocus(true);
            elEntry.text = $.Localize('#' + szLb + '_name');
            elSeasonDropdown.AddOption(elEntry);
        }
        elSeasonDropdown.SetSelected(LeaderboardsAPI.GetCurrentSeasonPremierLeaderboard());
    }
    function _InitLocationDropdown() {
        let elLocationDropdown = $('#jsNavLocation');
        elLocationDropdown.visible = true;
        elLocationDropdown.RemoveAllOptions();
        let regions = LeaderboardsAPI.GetAllSeasonPremierLeaderboardRegions();
        regions.sort();
        regions.unshift('World');
        regions.unshift('Friends');
        let defaultRegion = 'World';
        for (let i = 0; i < regions.length; i++) {
            const szRegion = regions[i];
            const elEntry = $.CreatePanel('Label', elLocationDropdown, szRegion);
            const bCurrentRegion = _FindLocalPlayerInRegion(szRegion);
            elEntry.SetHasClass('of-interest', bCurrentRegion);
            switch (szRegion) {
                case 'World':
                    elEntry.SetAttributeString('leaderboard-class', szRegion.toLowerCase());
                    break;
                case 'Friends':
                    elEntry.SetAttributeString('friendslb', 'true');
                    elEntry.SetAttributeString('leaderboard-class', 'friends');
                    break;
                default:
                    elEntry.SetAttributeString('location-suffix', '_' + szRegion);
                    elEntry.SetAttributeString('leaderboard-class', szRegion.toLowerCase());
                    if (bCurrentRegion) {
                        defaultRegion = szRegion;
                    }
            }
            elEntry.SetAcceptsFocus(true);
            elEntry.text = $.Localize('#leaderboard_region_' + szRegion);
            elLocationDropdown.AddOption(elEntry);
        }
        if (MyPersonaAPI.GetLauncherType() === "perfectworld") {
            defaultRegion = 'friends';
        }
        elLocationDropdown.SetSelected(defaultRegion);
    }
    function _getRegionFromLeaderboardName(lbname) {
        return lbname.split('_').slice(-1)[0];
    }
    function _isLeaderboardTheFriendsLeaderboard(lbname) {
        return lbname.split('.').slice(-1)[0] === 'friends';
    }
    function _FindLocalPlayerInRegion(region) {
        let arrLBsOfInterest = LeaderboardsAPI.GetPremierLeaderboardsOfInterest();
        let elSeasonDropdown = $('#jsNavSeason');
        let elSeason = elSeasonDropdown.GetSelected();
        let lb = elSeason.GetAttributeString('leaderboard', '');
        for (let i = 0; i < arrLBsOfInterest.length; i++) {
            switch (region) {
                case 'World':
                    if (arrLBsOfInterest[i] === lb)
                        return true;
                    break;
                case 'Friends':
                    if (_isLeaderboardTheFriendsLeaderboard(arrLBsOfInterest[i]))
                        return true;
                    break;
                default:
                    if (_getRegionFromLeaderboardName(arrLBsOfInterest[i]) === region)
                        return true;
            }
        }
        return false;
    }
    function _UpdateLeaderboardName() {
        if (m_lbType === 'general') {
            let elSeasonDropdown = $('#jsNavSeason');
            let elLocationDropdown = $('#jsNavLocation');
            let elregion = elLocationDropdown.GetSelected();
            let elSeason = elSeasonDropdown.GetSelected();
            if (elregion && elSeason) {
                if (elregion.GetAttributeString('friendslb', '') === 'true') {
                    m_leaderboardName = elSeason.GetAttributeString('leaderboard', '') + '.friends';
                }
                else {
                    m_leaderboardName = elSeason.GetAttributeString('leaderboard', '') + elregion.GetAttributeString('location-suffix', '');
                }
                $.GetContextPanel().SwitchClass('region', elregion.GetAttributeString('leaderboard-class', ''));
            }
        }
        else if (m_lbType === 'party') {
            m_leaderboardName = LeaderboardsAPI.GetCurrentSeasonPremierLeaderboard() + '.party';
        }
        _msg(m_leaderboardName);
        return m_leaderboardName;
    }
    function _UpdateNameLockButton() {
        let elNameButton = $.GetContextPanel().FindChildTraverse('lbNameButton');
        elNameButton.visible = true;
        let status = MyPersonaAPI.GetMyLeaderboardNameStatus();
        let needsName = LeaderboardsAPI.DoesTheLocalPlayerNeedALeaderboardSafeNameSet();
        let showButton = status !== '' || needsName;
        elNameButton.visible = showButton;
        elNameButton.SetHasClass('no-hover', status !== '');
        elNameButton.ClearPanelEvent('onactivate');
        let buttonText = '';
        if (status) {
            let name = MyPersonaAPI.GetMyLeaderboardName();
            elNameButton.SetDialogVariable('leaderboard-name', name);
            buttonText = $.Localize('#leaderboard_namelock_button_hasname', elNameButton);
            let tooltipText = '';
            switch (status) {
                case 'submitted':
                    elNameButton.SwitchClass('status', 'submitted');
                    tooltipText = $.Localize('#leaderboard_namelock_button_tooltip_submitted');
                    break;
                case 'approved':
                    elNameButton.SwitchClass('status', 'approved');
                    tooltipText = $.Localize('#leaderboard_namelock_button_tooltip_approved');
                    break;
            }
            function onMouseOver(id, tooltipText) {
                UiToolkitAPI.ShowTextTooltip(id, tooltipText);
            }
            ;
            elNameButton.SetPanelEvent('onmouseover', onMouseOver.bind(elNameButton, elNameButton.id, tooltipText));
            elNameButton.SetPanelEvent('onmouseout', function () {
                UiToolkitAPI.HideTextTooltip();
            });
        }
        else if (needsName) {
            buttonText = $.Localize('#leaderboard_namelock_button_needsname');
            elNameButton.SetPanelEvent('onactivate', _NameLockPopup);
        }
        elNameButton.SetDialogVariable('leaderboard_namelock_button', buttonText);
    }
    function _InitNavPanels() {
        $('#jsNavSeason').visible = false;
        $('#jsNavLocation').visible = false;
        $('#jsGoToTop').visible = m_lbType === 'general';
        $('#jsGoToMe').visible = m_lbType === 'general';
        if (m_lbType === 'party')
            return;
        _InitSeasonDropdown();
        _InitLocationDropdown();
    }
    let _ShowGlobalRank = function () {
        let showRank = $.GetContextPanel().GetAttributeString('showglobaloverride', 'true');
        $.GetContextPanel().SetHasClass('hide-global-rank', showRank === 'false');
    };
    function _UpdateGoToMeButton() {
        let lb = m_leaderboardName;
        let arrLBsOfInterest = LeaderboardsAPI.GetPremierLeaderboardsOfInterest();
        let myIndex = LeaderboardsAPI.GetIndexByXuid(lb, m_myXuid);
        let bPresent = arrLBsOfInterest.includes(lb) && myIndex !== -1;
        $.GetContextPanel().FindChildInLayoutFile('jsGoToMe').enabled = bPresent;
    }
    function UpdateLeaderboardList() {
        _msg('-------------- UpdateLeaderboardList ' + m_leaderboardName);
        _UpdateGoToMeButton();
        let status = LeaderboardsAPI.GetState(m_leaderboardName);
        _msg(status + '');
        let elStatus = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-loading');
        let elData = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-nodata');
        let elLeaderboardList = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-list');
        if ("none" == status) {
            elStatus.SetHasClass('hidden', false);
            elData.SetHasClass('hidden', true);
            elLeaderboardList.SetHasClass('hidden', true);
            LeaderboardsAPI.Refresh(m_leaderboardName);
            _msg('leaderboard status: requested');
        }
        else if ("loading" == status) {
            elStatus.SetHasClass('hidden', false);
            elData.SetHasClass('hidden', true);
            elLeaderboardList.SetHasClass('hidden', true);
        }
        else if ("ready" == status) {
            let count = LeaderboardsAPI.GetCount(m_leaderboardName);
            if (count === 0) {
                elData.SetHasClass('hidden', false);
                elStatus.SetHasClass('hidden', true);
                elLeaderboardList.SetHasClass('hidden', true);
            }
            else {
                elLeaderboardList.SetHasClass('hidden', false);
                elStatus.SetHasClass('hidden', true);
                elData.SetHasClass('hidden', true);
                _FillOutEntries();
            }
            if (1 <= LeaderboardsAPI.HowManyMinutesAgoCached(m_leaderboardName)) {
                LeaderboardsAPI.Refresh(m_leaderboardName);
                _msg('leaderboard status: requested');
            }
        }
    }
    Leaderboard.UpdateLeaderboardList = UpdateLeaderboardList;
    ;
    function _AddPlayer(elEntry, oPlayer, index) {
        elEntry.SetDialogVariable('player-rank', '');
        elEntry.SetDialogVariable('player-name', '');
        elEntry.SetDialogVariable('player-wins', '');
        elEntry.SetDialogVariable('player-winrate', '');
        elEntry.SetDialogVariable('player-percentile', '');
        elEntry.SetHasClass('no-hover', oPlayer === null);
        elEntry.SetHasClass('background', index % 2 === 0);
        let elAvatar = elEntry.FindChildInLayoutFile('leaderboard-entry-avatar');
        elAvatar.visible = false;
        if (oPlayer) {
            function _AddOpenPlayerCardAction(elPanel, xuid) {
                let openCard = function (xuid) {
                    if (xuid && (xuid !== 0)) {
                        $.DispatchEvent('SidebarContextMenuActive', true);
                        let contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('', '', 'file://{resources}/layout/context_menus/context_menu_playercard.xml', 'xuid=' + xuid, function () {
                            $.DispatchEvent('SidebarContextMenuActive', false);
                        });
                        contextMenuPanel.AddClass("ContextMenu_NoArrow");
                    }
                };
                elPanel.SetPanelEvent("onactivate", openCard.bind(undefined, xuid));
                elPanel.SetPanelEvent("oncontextmenu", openCard.bind(undefined, xuid));
            }
            elEntry.enabled = true;
            if (m_lbType === 'party' && oPlayer.XUID) {
                elAvatar.PopulateFromSteamID(oPlayer.XUID);
                elAvatar.visible = true;
            }
            else {
                elAvatar.visible = false;
            }
            let elRatingEmblem = elEntry.FindChildTraverse('jsRatingEmblem');
            if (m_lbType === 'party') {
                const teamColorIdx = PartyListAPI.GetPartyMemberSetting(oPlayer.XUID, 'game/teamcolor');
                const teamColorRgb = TeamColor.GetTeamColor(Number(teamColorIdx));
                elAvatar.style.border = '2px solid rgb(' + teamColorRgb + ')';
            }
            _AddOpenPlayerCardAction(elEntry, oPlayer.XUID);
            let options;
            if (m_lbType === 'party') {
                options =
                    {
                        root_panel: elRatingEmblem,
                        xuid: oPlayer.XUID,
                        api: 'partylist',
                        rating_type: 'Premier',
                        do_fx: true,
                        leaderboard_details: oPlayer,
                        full_details: false
                    };
            }
            else {
                options =
                    {
                        root_panel: elRatingEmblem,
                        rating_type: 'Premier',
                        do_fx: true,
                        leaderboard_details: oPlayer,
                        full_details: false
                    };
            }
            RatingEmblem.SetXuid(options);
            elEntry.SetDialogVariable('player-name', oPlayer.displayName ?? FriendsListAPI.GetFriendName(oPlayer.XUID));
            elEntry.Data().allowNameUpdates = !oPlayer.hasOwnProperty('displayName');
            elEntry.SetDialogVariable('player-wins', oPlayer.hasOwnProperty('matchesWon') ? String(oPlayer.matchesWon) : '-');
            let bHasRank = oPlayer.hasOwnProperty('rank') && oPlayer.rank > 0;
            elEntry.SetDialogVariableInt('player-rank', bHasRank ? oPlayer.rank : 0);
            elEntry.FindChildTraverse('jsPlayerRank').text = bHasRank ? $.Localize('{d:player-rank}', elEntry) : '-';
            let canShowWinRate = oPlayer.hasOwnProperty('matchesWon') && oPlayer.hasOwnProperty('matchesTied') && oPlayer.hasOwnProperty('matchesLost');
            if (canShowWinRate) {
                let matchesPlayed = (oPlayer.matchesWon ? oPlayer.matchesWon : 0) +
                    (oPlayer.matchesTied ? oPlayer.matchesTied : 0) +
                    (oPlayer.matchesLost ? oPlayer.matchesLost : 0);
                let winRate = matchesPlayed === 0 ? 0 : oPlayer.matchesWon * 100.00 / matchesPlayed;
                elEntry.SetDialogVariable('player-winrate', winRate.toFixed(2) + '%');
            }
            else {
                elEntry.SetDialogVariable('player-winrate', '-');
            }
            elEntry.SetDialogVariable('player-percentile', (oPlayer.hasOwnProperty('pct') && oPlayer.pct && oPlayer.pct > 0) ? oPlayer.pct.toFixed(0) + '%' : '-');
            elEntry.SetDialogVariable('player-region', (oPlayer.hasOwnProperty('region')) ? $.Localize('#leaderboard_region_abbr_' + regionToRegionName[oPlayer.region]) : '-');
        }
        return elEntry;
    }
    function _UpdatePartyList() {
        if (m_lbType !== 'party')
            return;
        let elStatus = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-loading');
        let elData = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-nodata');
        let elLeaderboardList = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-list');
        elLeaderboardList.SetHasClass('hidden', false);
        elStatus.SetHasClass('hidden', true);
        elData.SetHasClass('hidden', true);
        function OnMouseOver(xuid) {
            $.DispatchEvent('LeaderboardHoverPlayer', xuid);
        }
        ;
        function OnMouseOut() {
            $.DispatchEvent('LeaderboardHoverPlayer', '');
        }
        ;
        let elList = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-entries');
        if (LobbyAPI.IsSessionActive()) {
            let members = LobbyAPI.GetSessionSettings().members;
            function GetPartyLBRow(idx) {
                let oPlayer = null;
                let machine = 'machine' + idx;
                let bValidPartyPlayer = members.hasOwnProperty(machine) && members[machine].hasOwnProperty('player0') &&
                    members[machine].player0.hasOwnProperty('xuid');
                if (!bValidPartyPlayer)
                    return null;
                let xuid = members[machine].player0.xuid;
                oPlayer = LeaderboardsAPI.GetEntryDetailsObjectByXuid(m_leaderboardName, xuid);
                if (!oPlayer.XUID) {
                    oPlayer.XUID = xuid;
                }
                if (PartyListAPI.GetFriendCompetitiveRankType(xuid) === "Premier") {
                    var partyScore = PartyListAPI.GetFriendCompetitiveRank(xuid);
                    var partyWins = PartyListAPI.GetFriendCompetitiveWins(xuid);
                    if (partyScore || partyWins) {
                        oPlayer.score = PartyListAPI.GetFriendCompetitiveRank(xuid);
                        oPlayer.matchesWon = PartyListAPI.GetFriendCompetitiveWins(xuid);
                        oPlayer.rankWindowStats = PartyListAPI.GetFriendCompetitivePremierWindowStatsObject(xuid);
                        _msg('PartyList player ' + xuid + ' score=' + oPlayer.score + ' wins=' + oPlayer.matchesWon + ' data={' + JSON.stringify(oPlayer) + '}');
                    }
                }
                return oPlayer;
            }
            elList.SetLoadListItemFunction(function (parent, nPanelIdx, reusePanel) {
                let oPlayer = GetPartyLBRow(nPanelIdx);
                if (!reusePanel || reusePanel.IsValid()) {
                    reusePanel = $.CreatePanel("Button", elList, oPlayer ? oPlayer.XUID : '');
                    reusePanel.BLoadLayoutSnippet("leaderboard-entry");
                }
                _AddPlayer(reusePanel, oPlayer, nPanelIdx);
                reusePanel.SetPanelEvent('onmouseover', oPlayer ? OnMouseOver.bind(reusePanel, oPlayer.XUID) : OnMouseOut);
                reusePanel.SetPanelEvent('onmouseout', OnMouseOut);
                return reusePanel;
            });
            elList.UpdateListItems(PartyListAPI.GetCount());
        }
    }
    function OnLeaderboardDirty(type) {
        _msg('OnLeaderboardDirty');
        if (m_leaderboardName && m_leaderboardName === type) {
            LeaderboardsAPI.Refresh(m_leaderboardName);
        }
    }
    function ReadyForDisplay() {
        _msg("ReadyForDisplay");
        RegisterEventHandlers();
        if (m_leaderboardName) {
            LeaderboardsAPI.Refresh(m_leaderboardName);
        }
    }
    Leaderboard.ReadyForDisplay = ReadyForDisplay;
    ;
    function UnReadyForDisplay() {
        _msg("UnReadyForDisplay");
        UnregisterEventHandlers();
    }
    Leaderboard.UnReadyForDisplay = UnReadyForDisplay;
    ;
    function _UpdateName(xuid) {
        let elList = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-entries');
        let elEntry = elList.FindChildInLayoutFile(xuid);
        if (elEntry && elEntry.Data().allowNameUpdates) {
            elEntry.SetDialogVariable('player-name', FriendsListAPI.GetFriendName(xuid));
        }
    }
    ;
    function _NameLockPopup() {
        UiToolkitAPI.ShowCustomLayoutPopup('', 'file://{resources}/layout/popups/popup_leaderboard_namelock.xml');
    }
    function _AutomaticLeaderboardNameLockPopup() {
        let data = $.GetContextPanel().Data();
        let bAlreadyAsked = data && data.bPromptedForLeaderboardSafeName;
        if (bAlreadyAsked)
            return;
        _NameLockPopup();
        data.bPromptedForLeaderboardSafeName = true;
    }
    function _FillOutEntries() {
        let nPlayers = LeaderboardsAPI.GetCount(m_leaderboardName);
        _msg(nPlayers + ' accounts found.');
        const elList = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-entries');
        elList.SetLoadListItemFunction(function (parent, nPanelIdx, reusePanel) {
            let oPlayer = LeaderboardsAPI.GetEntryDetailsObjectByIndex(m_leaderboardName, nPanelIdx);
            if (!reusePanel || !reusePanel.IsValid()) {
                reusePanel = $.CreatePanel("Button", elList, oPlayer ? oPlayer.XUID : '');
                reusePanel.BLoadLayoutSnippet("leaderboard-entry");
            }
            _AddPlayer(reusePanel, oPlayer, nPanelIdx);
            reusePanel.SetHasClass('local-player', (oPlayer ? oPlayer.XUID : '') === m_myXuid);
            return reusePanel;
        });
        elList.UpdateListItems(nPlayers);
        $.DispatchEvent('ScrollToDelayLoadListItem', elList, 0, 'topleft', true);
    }
    ;
    function OnLeaderboardStateChange(type) {
        _msg('OnLeaderboardStateChange');
        _msg('leaderboard status: received');
        if (m_leaderboardName === type) {
            if (m_lbType === 'party') {
                _UpdatePartyList();
            }
            else if (m_lbType === 'general') {
                UpdateLeaderboardList();
            }
            return;
        }
    }
    Leaderboard.OnLeaderboardStateChange = OnLeaderboardStateChange;
    ;
    function OnLeaderboardChange() {
        _UpdateLeaderboardName();
        UpdateLeaderboardList();
    }
    Leaderboard.OnLeaderboardChange = OnLeaderboardChange;
    function GoToSelf() {
        let myIndex = LeaderboardsAPI.GetIndexByXuid(m_leaderboardName, m_myXuid);
        const elList = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-entries');
        $.DispatchEvent('ScrollToDelayLoadListItem', elList, myIndex, 'topleft', true);
    }
    Leaderboard.GoToSelf = GoToSelf;
    function GoToTop() {
        const elList = $.GetContextPanel().FindChildInLayoutFile('id-leaderboard-entries');
        $.DispatchEvent('ScrollToDelayLoadListItem', elList, 0, 'topleft', true);
    }
    Leaderboard.GoToTop = GoToTop;
})(Leaderboard || (Leaderboard = {}));
(function () {
    $.RegisterEventHandler('ReadyForDisplay', $.GetContextPanel(), Leaderboard.ReadyForDisplay);
    $.RegisterEventHandler('UnreadyForDisplay', $.GetContextPanel(), Leaderboard.UnReadyForDisplay);
    Leaderboard.Init();
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibGVhZGVyYm9hcmQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9sZWFkZXJib2FyZC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsa0NBQWtDO0FBQ2xDLHlDQUF5QztBQUN6Qyw0Q0FBNEM7QUFjNUMsTUFBTSxrQkFBa0IsR0FBOEI7SUFDckQsTUFBTSxFQUFFLGNBQWM7SUFDdEIsTUFBTSxFQUFFLGNBQWM7SUFDdEIsTUFBTSxFQUFFLFFBQVE7SUFDaEIsTUFBTSxFQUFFLE1BQU07SUFDZCxNQUFNLEVBQUUsV0FBVztJQUNuQixNQUFNLEVBQUUsUUFBUTtJQUNoQixJQUFJLEVBQUUsT0FBTztDQUNiLENBQUE7QUFFRCxJQUFVLFdBQVcsQ0E4dUJwQjtBQTl1QkQsV0FBVSxXQUFXO0lBRXBCLFNBQVMsSUFBSSxDQUFHLEdBQVc7SUFHM0IsQ0FBQztJQUVELElBQUksbUJBQW1CLEdBQUcsS0FBSyxDQUFDO0lBQ2hDLElBQUksUUFBUSxHQUFHLFlBQVksQ0FBQyxPQUFPLEVBQUUsQ0FBQztJQUN0QyxJQUFJLFFBQTJCLENBQUM7SUFFaEMsSUFBSSwrQkFBdUMsQ0FBQztJQUM1QyxJQUFJLHFDQUE2QyxDQUFDO0lBQ2xELElBQUksb0NBQTRDLENBQUM7SUFDakQsSUFBSSxnQ0FBd0MsQ0FBQztJQUM3QyxJQUFJLHNCQUE4QixDQUFDO0lBRW5DLElBQUksaUJBQWlCLEdBQVcsRUFBRSxDQUFDO0lBRW5DLFNBQWdCLHFCQUFxQjtRQUVwQyxJQUFJLENBQUUsdUJBQXVCLENBQUUsQ0FBQztRQUVoQyxJQUFLLENBQUMsbUJBQW1CLEVBQ3pCO1lBQ0MsK0JBQStCLEdBQUcsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLHNDQUFzQyxFQUFFLGtCQUFrQixDQUFFLENBQUM7WUFDNUgscUNBQXFDLEdBQUcsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLDRDQUE0QyxFQUFFLHdCQUF3QixDQUFFLENBQUM7WUFDOUksb0NBQW9DLEdBQUcsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLDJDQUEyQyxFQUFFLFdBQVcsQ0FBRSxDQUFDO1lBRS9ILElBQUssUUFBUSxLQUFLLE9BQU8sRUFDekI7Z0JBQ0MsZ0NBQWdDLEdBQUcsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLDhDQUE4QyxFQUFFLGdCQUFnQixDQUFFLENBQUM7YUFDbkk7WUFFRCxJQUFLLFFBQVEsS0FBSyxTQUFTLEVBQzNCO2dCQUNDLHNCQUFzQixHQUFHLENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSwwREFBMEQsRUFBRSxxQkFBcUIsQ0FBRSxDQUFDO2FBQzFJO1lBRUQsbUJBQW1CLEdBQUcsSUFBSSxDQUFDO1NBRTNCO0lBQ0YsQ0FBQztJQXZCZSxpQ0FBcUIsd0JBdUJwQyxDQUFBO0lBRUQsU0FBZ0IsdUJBQXVCO1FBRXRDLElBQUksQ0FBRSx5QkFBeUIsQ0FBRSxDQUFDO1FBRWxDLElBQUssbUJBQW1CLEVBQ3hCO1lBQ0MsQ0FBQyxDQUFDLDJCQUEyQixDQUFFLHNDQUFzQyxFQUFFLCtCQUErQixDQUFFLENBQUM7WUFDekcsQ0FBQyxDQUFDLDJCQUEyQixDQUFFLDRDQUE0QyxFQUFFLHFDQUFxQyxDQUFFLENBQUM7WUFDckgsQ0FBQyxDQUFDLDJCQUEyQixDQUFFLDJDQUEyQyxFQUFFLG9DQUFvQyxDQUFFLENBQUM7WUFFbkgsSUFBSyxRQUFRLEtBQUssT0FBTyxFQUN6QjtnQkFDQyxDQUFDLENBQUMsMkJBQTJCLENBQUUsOENBQThDLEVBQUUsZ0NBQWdDLENBQUUsQ0FBQzthQUNsSDtZQUVELElBQUssUUFBUSxLQUFLLFNBQVMsRUFDM0I7Z0JBQ0MsQ0FBQyxDQUFDLDJCQUEyQixDQUFFLDBEQUEwRCxFQUFFLHNCQUFzQixDQUFFLENBQUM7YUFDcEg7WUFHRCxtQkFBbUIsR0FBRyxLQUFLLENBQUM7U0FFNUI7SUFDRixDQUFDO0lBeEJlLG1DQUF1QiwwQkF3QnRDLENBQUE7SUFFRCxTQUFnQixJQUFJO1FBRW5CLElBQUksQ0FBRSxNQUFNLENBQUUsQ0FBQztRQUVmLFFBQVEsR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsa0JBQWtCLENBQUUsUUFBUSxFQUFFLEVBQUUsQ0FBdUIsQ0FBQztRQUV2RixxQkFBcUIsRUFBRSxDQUFDO1FBRXhCLFNBQVMsRUFBRSxDQUFDO1FBQ1osY0FBYyxFQUFFLENBQUM7UUFDakIsc0JBQXNCLEVBQUUsQ0FBQztRQUV6QixJQUFLLFFBQVEsS0FBSyxPQUFPLEVBQ3pCO1lBQ0MsZ0JBQWdCLEVBQUUsQ0FBQztZQUduQixJQUFNLGVBQWUsQ0FBQyw2Q0FBNkMsRUFBRSxFQUNyRTtnQkFDQyxrQ0FBa0MsRUFBRSxDQUFDO2FBQ3JDO1NBQ0Q7YUFDSSxJQUFLLFFBQVEsS0FBSyxTQUFTLEVBQ2hDO1lBQ0MscUJBQXFCLEVBQUUsQ0FBQztZQUN4QixDQUFDLENBQUMsUUFBUSxDQUFFLEdBQUcsRUFBRSxxQkFBcUIsQ0FBRSxDQUFDO1NBQ3pDO1FBRUQsZUFBZSxFQUFFLENBQUM7SUFDbkIsQ0FBQztJQTdCZSxnQkFBSSxPQTZCbkIsQ0FBQTtJQUFBLENBQUM7SUFFRixTQUFTLFNBQVM7UUFFakIsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLGlCQUFpQixDQUFFLG1CQUFtQixFQUFFLENBQUMsQ0FBQyxRQUFRLENBQUUscUJBQXFCLEdBQUcsTUFBTSxDQUFFLFFBQVEsQ0FBRSxDQUFFLENBQUMsQ0FBQztJQUN2SCxDQUFDO0lBQUEsQ0FBQztJQUdGLFNBQVMsbUJBQW1CO1FBSTNCLElBQUksZ0JBQWdCLEdBQUcsQ0FBQyxDQUFFLGNBQWMsQ0FBZ0IsQ0FBQztRQUN6RCxnQkFBZ0IsQ0FBQyxPQUFPLEdBQUcsSUFBSSxDQUFDO1FBRWhDLGdCQUFnQixDQUFDLGdCQUFnQixFQUFFLENBQUM7UUFFcEMsSUFBSSxHQUFHLEdBQUcsZUFBZSxDQUFDLCtCQUErQixFQUFFLENBQUM7UUFDNUQsS0FBTSxJQUFJLENBQUMsR0FBRyxDQUFDLEVBQUUsQ0FBQyxHQUFHLEdBQUcsQ0FBQyxNQUFNLEVBQUUsQ0FBQyxFQUFFLEVBQ3BDO1lBQ0MsSUFBSSxJQUFJLEdBQUcsR0FBRyxDQUFFLENBQUMsQ0FBRSxDQUFDO1lBRXBCLE1BQU0sT0FBTyxHQUFHLENBQUMsQ0FBQyxXQUFXLENBQUUsT0FBTyxFQUFFLGdCQUFnQixFQUFFLElBQUksRUFBRTtnQkFDL0QsT0FBTyxFQUFFLEVBQUU7YUFDWCxDQUFFLENBQUM7WUFFSixPQUFPLENBQUMsa0JBQWtCLENBQUUsYUFBYSxFQUFFLElBQUksQ0FBRSxDQUFDO1lBQ2xELE9BQU8sQ0FBQyxlQUFlLENBQUUsSUFBSSxDQUFFLENBQUM7WUFDaEMsT0FBTyxDQUFDLElBQUksR0FBRyxDQUFDLENBQUMsUUFBUSxDQUFFLEdBQUcsR0FBRyxJQUFJLEdBQUcsT0FBTyxDQUFFLENBQUM7WUFDbEQsZ0JBQWdCLENBQUMsU0FBUyxDQUFFLE9BQU8sQ0FBRSxDQUFDO1NBQ3RDO1FBRUQsZ0JBQWdCLENBQUMsV0FBVyxDQUFFLGVBQWUsQ0FBQyxrQ0FBa0MsRUFBRSxDQUFFLENBQUM7SUFDdEYsQ0FBQztJQUVELFNBQVMscUJBQXFCO1FBRzdCLElBQUksa0JBQWtCLEdBQUcsQ0FBQyxDQUFFLGdCQUFnQixDQUFnQixDQUFDO1FBQzdELGtCQUFrQixDQUFDLE9BQU8sR0FBRyxJQUFJLENBQUM7UUFFbEMsa0JBQWtCLENBQUMsZ0JBQWdCLEVBQUUsQ0FBQztRQUV0QyxJQUFJLE9BQU8sR0FBRyxlQUFlLENBQUMscUNBQXFDLEVBQUUsQ0FBQztRQUt0RSxPQUFPLENBQUMsSUFBSSxFQUFFLENBQUM7UUFFZixPQUFPLENBQUMsT0FBTyxDQUFFLE9BQU8sQ0FBRSxDQUFDO1FBQzNCLE9BQU8sQ0FBQyxPQUFPLENBQUUsU0FBUyxDQUFFLENBQUM7UUFFN0IsSUFBSSxhQUFhLEdBQUcsT0FBTyxDQUFDO1FBRTVCLEtBQU0sSUFBSSxDQUFDLEdBQUcsQ0FBQyxFQUFFLENBQUMsR0FBRyxPQUFPLENBQUMsTUFBTSxFQUFFLENBQUMsRUFBRSxFQUN4QztZQUNDLE1BQU0sUUFBUSxHQUFHLE9BQU8sQ0FBRSxDQUFDLENBQUUsQ0FBQztZQUM5QixNQUFNLE9BQU8sR0FBRyxDQUFDLENBQUMsV0FBVyxDQUFFLE9BQU8sRUFBRSxrQkFBa0IsRUFBRSxRQUFRLENBQUUsQ0FBQztZQUN2RSxNQUFNLGNBQWMsR0FBRyx3QkFBd0IsQ0FBRSxRQUFRLENBQUUsQ0FBQztZQUU1RCxPQUFPLENBQUMsV0FBVyxDQUFFLGFBQWEsRUFBRSxjQUFjLENBQUUsQ0FBQztZQUVyRCxRQUFTLFFBQVEsRUFDakI7Z0JBQ0MsS0FBSyxPQUFPO29CQUNYLE9BQU8sQ0FBQyxrQkFBa0IsQ0FBRSxtQkFBbUIsRUFBRSxRQUFRLENBQUMsV0FBVyxFQUFFLENBQUUsQ0FBQztvQkFDMUUsTUFBTTtnQkFFUCxLQUFLLFNBQVM7b0JBQ2IsT0FBTyxDQUFDLGtCQUFrQixDQUFFLFdBQVcsRUFBRSxNQUFNLENBQUUsQ0FBQztvQkFDbEQsT0FBTyxDQUFDLGtCQUFrQixDQUFFLG1CQUFtQixFQUFFLFNBQVMsQ0FBRSxDQUFDO29CQUM3RCxNQUFNO2dCQUVQO29CQUNDLE9BQU8sQ0FBQyxrQkFBa0IsQ0FBRSxpQkFBaUIsRUFBRSxHQUFHLEdBQUcsUUFBUSxDQUFFLENBQUM7b0JBQ2hFLE9BQU8sQ0FBQyxrQkFBa0IsQ0FBRSxtQkFBbUIsRUFBRSxRQUFRLENBQUMsV0FBVyxFQUFFLENBQUUsQ0FBQztvQkFDMUUsSUFBSyxjQUFjLEVBQ25CO3dCQUNDLGFBQWEsR0FBRyxRQUFRLENBQUM7cUJBQ3pCO2FBQ0Y7WUFFRCxPQUFPLENBQUMsZUFBZSxDQUFFLElBQUksQ0FBRSxDQUFDO1lBQ2hDLE9BQU8sQ0FBQyxJQUFJLEdBQUcsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxzQkFBc0IsR0FBRyxRQUFRLENBQUUsQ0FBQztZQUMvRCxrQkFBa0IsQ0FBQyxTQUFTLENBQUUsT0FBTyxDQUFFLENBQUM7U0FFeEM7UUFFRCxJQUFLLFlBQVksQ0FBQyxlQUFlLEVBQUUsS0FBSyxjQUFjLEVBQ3REO1lBQ0MsYUFBYSxHQUFHLFNBQVMsQ0FBQztTQUMxQjtRQUVELGtCQUFrQixDQUFDLFdBQVcsQ0FBRSxhQUFhLENBQUUsQ0FBQztJQUNqRCxDQUFDO0lBRUQsU0FBUyw2QkFBNkIsQ0FBRyxNQUFjO1FBRXRELE9BQU8sTUFBTSxDQUFDLEtBQUssQ0FBRSxHQUFHLENBQUUsQ0FBQyxLQUFLLENBQUUsQ0FBQyxDQUFDLENBQUUsQ0FBRSxDQUFDLENBQUUsQ0FBQTtJQUM1QyxDQUFDO0lBRUQsU0FBUyxtQ0FBbUMsQ0FBRyxNQUFjO1FBRTVELE9BQU8sTUFBTSxDQUFDLEtBQUssQ0FBRSxHQUFHLENBQUUsQ0FBQyxLQUFLLENBQUUsQ0FBQyxDQUFDLENBQUUsQ0FBRSxDQUFDLENBQUUsS0FBSyxTQUFTLENBQUM7SUFDM0QsQ0FBQztJQUVELFNBQVMsd0JBQXdCLENBQUcsTUFBYztRQUVqRCxJQUFJLGdCQUFnQixHQUFHLGVBQWUsQ0FBQyxnQ0FBZ0MsRUFBRSxDQUFDO1FBRTFFLElBQUksZ0JBQWdCLEdBQUcsQ0FBQyxDQUFFLGNBQWMsQ0FBZ0IsQ0FBQztRQUN6RCxJQUFJLFFBQVEsR0FBRyxnQkFBZ0IsQ0FBQyxXQUFXLEVBQUUsQ0FBQztRQUM5QyxJQUFJLEVBQUUsR0FBRyxRQUFRLENBQUMsa0JBQWtCLENBQUUsYUFBYSxFQUFFLEVBQUUsQ0FBRSxDQUFBO1FBRXpELEtBQU0sSUFBSSxDQUFDLEdBQUcsQ0FBQyxFQUFFLENBQUMsR0FBRyxnQkFBZ0IsQ0FBQyxNQUFNLEVBQUcsQ0FBQyxFQUFFLEVBQ2xEO1lBQ0MsUUFBUyxNQUFNLEVBQ2Y7Z0JBQ0MsS0FBSyxPQUFPO29CQUNYLElBQUssZ0JBQWdCLENBQUUsQ0FBQyxDQUFFLEtBQUssRUFBRTt3QkFDaEMsT0FBTyxJQUFJLENBQUM7b0JBQ2IsTUFBTTtnQkFFUCxLQUFLLFNBQVM7b0JBQ2IsSUFBSyxtQ0FBbUMsQ0FBQyxnQkFBZ0IsQ0FBRSxDQUFDLENBQUUsQ0FBRTt3QkFDL0QsT0FBTyxJQUFJLENBQUM7b0JBQ2IsTUFBTTtnQkFFUDtvQkFDQyxJQUFLLDZCQUE2QixDQUFDLGdCQUFnQixDQUFFLENBQUMsQ0FBRSxDQUFDLEtBQUssTUFBTTt3QkFDbkUsT0FBTyxJQUFJLENBQUM7YUFDZDtTQUNEO1FBRUQsT0FBTyxLQUFLLENBQUM7SUFDZCxDQUFDO0lBRUQsU0FBUyxzQkFBc0I7UUFJOUIsSUFBSyxRQUFRLEtBQUssU0FBUyxFQUMzQjtZQUNDLElBQUksZ0JBQWdCLEdBQUcsQ0FBQyxDQUFFLGNBQWMsQ0FBZ0IsQ0FBQztZQUN6RCxJQUFJLGtCQUFrQixHQUFHLENBQUMsQ0FBRSxnQkFBZ0IsQ0FBZ0IsQ0FBQztZQUU3RCxJQUFJLFFBQVEsR0FBRyxrQkFBa0IsQ0FBQyxXQUFXLEVBQUUsQ0FBQztZQUNoRCxJQUFJLFFBQVEsR0FBRyxnQkFBZ0IsQ0FBQyxXQUFXLEVBQUUsQ0FBQztZQUU5QyxJQUFLLFFBQVEsSUFBSSxRQUFRLEVBQ3pCO2dCQUNDLElBQUssUUFBUSxDQUFDLGtCQUFrQixDQUFFLFdBQVcsRUFBRSxFQUFFLENBQUUsS0FBSyxNQUFNLEVBQzlEO29CQUNDLGlCQUFpQixHQUFHLFFBQVEsQ0FBQyxrQkFBa0IsQ0FBRSxhQUFhLEVBQUUsRUFBRSxDQUFFLEdBQUcsVUFBVSxDQUFDO2lCQUNsRjtxQkFFRDtvQkFDQyxpQkFBaUIsR0FBRyxRQUFRLENBQUMsa0JBQWtCLENBQUUsYUFBYSxFQUFFLEVBQUUsQ0FBRSxHQUFHLFFBQVEsQ0FBQyxrQkFBa0IsQ0FBRSxpQkFBaUIsRUFBRSxFQUFFLENBQUUsQ0FBQztpQkFDNUg7Z0JBRUQsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLFdBQVcsQ0FBRSxRQUFRLEVBQUUsUUFBUSxDQUFDLGtCQUFrQixDQUFFLG1CQUFtQixFQUFFLEVBQUUsQ0FBRSxDQUFFLENBQUM7YUFFcEc7U0FDRDthQUNJLElBQUssUUFBUSxLQUFLLE9BQU8sRUFDOUI7WUFDQyxpQkFBaUIsR0FBRyxlQUFlLENBQUMsa0NBQWtDLEVBQUUsR0FBRyxRQUFRLENBQUM7U0FDcEY7UUFFRCxJQUFJLENBQUUsaUJBQWlCLENBQUUsQ0FBQztRQUUxQixPQUFPLGlCQUFpQixDQUFDO0lBRTFCLENBQUM7SUFFRCxTQUFTLHFCQUFxQjtRQUU3QixJQUFJLFlBQVksR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsaUJBQWlCLENBQUUsY0FBYyxDQUFFLENBQUM7UUFFM0UsWUFBWSxDQUFDLE9BQU8sR0FBRyxJQUFJLENBQUM7UUFFNUIsSUFBSSxNQUFNLEdBQUcsWUFBWSxDQUFDLDBCQUEwQixFQUFFLENBQUM7UUFDdkQsSUFBSSxTQUFTLEdBQUcsZUFBZSxDQUFDLDZDQUE2QyxFQUFFLENBQUM7UUFDaEYsSUFBSSxVQUFVLEdBQUcsTUFBTSxLQUFLLEVBQUUsSUFBSSxTQUFTLENBQUM7UUFFNUMsWUFBYSxDQUFDLE9BQU8sR0FBRyxVQUFVLENBQUM7UUFDbkMsWUFBWSxDQUFDLFdBQVcsQ0FBRSxVQUFVLEVBQUUsTUFBTSxLQUFLLEVBQUUsQ0FBRSxDQUFDO1FBQ3RELFlBQVksQ0FBQyxlQUFlLENBQUUsWUFBWSxDQUFFLENBQUM7UUFFN0MsSUFBSSxVQUFVLEdBQUcsRUFBRSxDQUFDO1FBRXBCLElBQUssTUFBTSxFQUNYO1lBQ0MsSUFBSSxJQUFJLEdBQUcsWUFBWSxDQUFDLG9CQUFvQixFQUFFLENBQUM7WUFDL0MsWUFBYSxDQUFDLGlCQUFpQixDQUFFLGtCQUFrQixFQUFFLElBQUksQ0FBRSxDQUFDO1lBQzVELFVBQVUsR0FBRyxDQUFDLENBQUMsUUFBUSxDQUFFLHNDQUFzQyxFQUFFLFlBQVksQ0FBRSxDQUFDO1lBRWhGLElBQUksV0FBVyxHQUFHLEVBQUUsQ0FBQztZQUNyQixRQUFTLE1BQU0sRUFDZjtnQkFDQyxLQUFLLFdBQVc7b0JBQ2YsWUFBWSxDQUFDLFdBQVcsQ0FBRSxRQUFRLEVBQUUsV0FBVyxDQUFFLENBQUM7b0JBQ2xELFdBQVcsR0FBRyxDQUFDLENBQUMsUUFBUSxDQUFDLGdEQUFnRCxDQUFDLENBQUM7b0JBQzNFLE1BQU07Z0JBQ1AsS0FBSyxVQUFVO29CQUNkLFlBQVksQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLFVBQVUsQ0FBRSxDQUFDO29CQUNqRCxXQUFXLEdBQUcsQ0FBQyxDQUFDLFFBQVEsQ0FBRSwrQ0FBK0MsQ0FBRSxDQUFDO29CQUM1RSxNQUFNO2FBQ1A7WUFFRCxTQUFTLFdBQVcsQ0FBRyxFQUFVLEVBQUUsV0FBbUI7Z0JBRXJELFlBQVksQ0FBQyxlQUFlLENBQUUsRUFBRSxFQUFFLFdBQVcsQ0FBRSxDQUFDO1lBQ2pELENBQUM7WUFBQSxDQUFDO1lBRUYsWUFBWSxDQUFDLGFBQWEsQ0FBRSxhQUFhLEVBQUUsV0FBVyxDQUFDLElBQUksQ0FBRSxZQUFZLEVBQUUsWUFBWSxDQUFDLEVBQUUsRUFBRSxXQUFXLENBQUUsQ0FBRSxDQUFDO1lBQzVHLFlBQVksQ0FBQyxhQUFhLENBQUUsWUFBWSxFQUFFO2dCQUV6QyxZQUFZLENBQUMsZUFBZSxFQUFFLENBQUM7WUFDaEMsQ0FBQyxDQUFFLENBQUM7U0FDSjthQUNJLElBQUssU0FBUyxFQUNuQjtZQUNDLFVBQVUsR0FBRyxDQUFDLENBQUMsUUFBUSxDQUFFLHdDQUF3QyxDQUFFLENBQUM7WUFDcEUsWUFBWSxDQUFDLGFBQWEsQ0FBRSxZQUFZLEVBQUUsY0FBYyxDQUFFLENBQUM7U0FDM0Q7UUFFRCxZQUFZLENBQUMsaUJBQWlCLENBQUUsNkJBQTZCLEVBQUUsVUFBVSxDQUFFLENBQUM7SUFDN0UsQ0FBQztJQUVELFNBQVMsY0FBYztRQUVwQixDQUFDLENBQUUsY0FBYyxDQUFrQixDQUFDLE9BQU8sR0FBRyxLQUFLLENBQUM7UUFDcEQsQ0FBQyxDQUFFLGdCQUFnQixDQUFrQixDQUFDLE9BQU8sR0FBRyxLQUFLLENBQUM7UUFFdEQsQ0FBQyxDQUFFLFlBQVksQ0FBZSxDQUFDLE9BQU8sR0FBRyxRQUFRLEtBQUssU0FBUyxDQUFDO1FBQ2hFLENBQUMsQ0FBRSxXQUFXLENBQWUsQ0FBQyxPQUFPLEdBQUcsUUFBUSxLQUFLLFNBQVMsQ0FBQztRQUVqRSxJQUFLLFFBQVEsS0FBSyxPQUFPO1lBQ3hCLE9BQU87UUFFUixtQkFBbUIsRUFBRSxDQUFDO1FBQ3RCLHFCQUFxQixFQUFFLENBQUM7SUFDekIsQ0FBQztJQUVELElBQUksZUFBZSxHQUFHO1FBRXJCLElBQUksUUFBUSxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxrQkFBa0IsQ0FBRSxvQkFBb0IsRUFBRSxNQUFNLENBQUUsQ0FBQztRQUN0RixDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsV0FBVyxDQUFFLGtCQUFrQixFQUFFLFFBQVEsS0FBSyxPQUFPLENBQUUsQ0FBQztJQUM3RSxDQUFDLENBQUM7SUFFRixTQUFTLG1CQUFtQjtRQUUzQixJQUFJLEVBQUUsR0FBRyxpQkFBaUIsQ0FBQztRQUUzQixJQUFJLGdCQUFnQixHQUFHLGVBQWUsQ0FBQyxnQ0FBZ0MsRUFBRSxDQUFDO1FBQzFFLElBQUksT0FBTyxHQUFHLGVBQWUsQ0FBQyxjQUFjLENBQUUsRUFBRSxFQUFFLFFBQVEsQ0FBRSxDQUFDO1FBRTdELElBQUksUUFBUSxHQUFHLGdCQUFnQixDQUFDLFFBQVEsQ0FBRSxFQUFFLENBQUUsSUFBSSxPQUFPLEtBQUssQ0FBQyxDQUFDLENBQUM7UUFFakUsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLHFCQUFxQixDQUFFLFVBQVUsQ0FBRSxDQUFDLE9BQU8sR0FBRyxRQUFRLENBQUM7SUFDNUUsQ0FBQztJQUVELFNBQWdCLHFCQUFxQjtRQUVwQyxJQUFJLENBQUUsdUNBQXVDLEdBQUcsaUJBQWlCLENBQUUsQ0FBQztRQUVwRSxtQkFBbUIsRUFBRSxDQUFDO1FBRXRCLElBQUksTUFBTSxHQUFHLGVBQWUsQ0FBQyxRQUFRLENBQUUsaUJBQWlCLENBQUUsQ0FBQztRQUMzRCxJQUFJLENBQUUsTUFBTSxHQUFHLEVBQUUsQ0FBRSxDQUFDO1FBRXBCLElBQUksUUFBUSxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxxQkFBcUIsQ0FBRSx3QkFBd0IsQ0FBRSxDQUFDO1FBQ3JGLElBQUksTUFBTSxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxxQkFBcUIsQ0FBRSx1QkFBdUIsQ0FBRSxDQUFDO1FBQ2xGLElBQUksaUJBQWlCLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLHFCQUFxQixDQUFFLHFCQUFxQixDQUFFLENBQUM7UUFFM0YsSUFBSyxNQUFNLElBQUksTUFBTSxFQUNyQjtZQUNDLFFBQVEsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLEtBQUssQ0FBRSxDQUFDO1lBQ3hDLE1BQU0sQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLElBQUksQ0FBRSxDQUFDO1lBQ3JDLGlCQUFpQixDQUFDLFdBQVcsQ0FBRSxRQUFRLEVBQUUsSUFBSSxDQUFFLENBQUM7WUFDaEQsZUFBZSxDQUFDLE9BQU8sQ0FBRSxpQkFBaUIsQ0FBRSxDQUFDO1lBQzdDLElBQUksQ0FBRSwrQkFBK0IsQ0FBRSxDQUFDO1NBRXhDO2FBRUksSUFBSyxTQUFTLElBQUksTUFBTSxFQUM3QjtZQUNDLFFBQVEsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLEtBQUssQ0FBRSxDQUFDO1lBQ3hDLE1BQU0sQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLElBQUksQ0FBRSxDQUFDO1lBQ3JDLGlCQUFpQixDQUFDLFdBQVcsQ0FBRSxRQUFRLEVBQUUsSUFBSSxDQUFFLENBQUM7U0FDaEQ7YUFFSSxJQUFLLE9BQU8sSUFBSSxNQUFNLEVBQzNCO1lBQ0MsSUFBSSxLQUFLLEdBQUcsZUFBZSxDQUFDLFFBQVEsQ0FBRSxpQkFBaUIsQ0FBRSxDQUFDO1lBQzFELElBQUssS0FBSyxLQUFLLENBQUMsRUFDaEI7Z0JBQ0MsTUFBTSxDQUFDLFdBQVcsQ0FBRSxRQUFRLEVBQUUsS0FBSyxDQUFFLENBQUM7Z0JBQ3RDLFFBQVEsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLElBQUksQ0FBRSxDQUFDO2dCQUN2QyxpQkFBaUIsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLElBQUksQ0FBRSxDQUFDO2FBQ2hEO2lCQUVEO2dCQUNDLGlCQUFpQixDQUFDLFdBQVcsQ0FBRSxRQUFRLEVBQUUsS0FBSyxDQUFFLENBQUM7Z0JBQ2pELFFBQVEsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLElBQUksQ0FBRSxDQUFDO2dCQUN2QyxNQUFNLENBQUMsV0FBVyxDQUFFLFFBQVEsRUFBRSxJQUFJLENBQUUsQ0FBQztnQkFFckMsZUFBZSxFQUFFLENBQUM7YUFDbEI7WUFFRCxJQUFLLENBQUMsSUFBSSxlQUFlLENBQUMsdUJBQXVCLENBQUUsaUJBQWlCLENBQUUsRUFDdEU7Z0JBQ0MsZUFBZSxDQUFDLE9BQU8sQ0FBRSxpQkFBaUIsQ0FBRSxDQUFDO2dCQUM3QyxJQUFJLENBQUUsK0JBQStCLENBQUUsQ0FBQzthQUN4QztTQUNEO0lBQ0YsQ0FBQztJQXREZSxpQ0FBcUIsd0JBc0RwQyxDQUFBO0lBQUEsQ0FBQztJQUVGLFNBQVMsVUFBVSxDQUFHLE9BQWdCLEVBQUUsT0FBeUMsRUFBRSxLQUFhO1FBRS9GLE9BQU8sQ0FBQyxpQkFBaUIsQ0FBRSxhQUFhLEVBQUUsRUFBRSxDQUFFLENBQUM7UUFDL0MsT0FBTyxDQUFDLGlCQUFpQixDQUFFLGFBQWEsRUFBRSxFQUFFLENBQUUsQ0FBQztRQUMvQyxPQUFPLENBQUMsaUJBQWlCLENBQUUsYUFBYSxFQUFFLEVBQUUsQ0FBRSxDQUFDO1FBQy9DLE9BQU8sQ0FBQyxpQkFBaUIsQ0FBRSxnQkFBZ0IsRUFBRSxFQUFFLENBQUUsQ0FBQztRQUNsRCxPQUFPLENBQUMsaUJBQWlCLENBQUUsbUJBQW1CLEVBQUUsRUFBRSxDQUFFLENBQUM7UUFFckQsT0FBTyxDQUFDLFdBQVcsQ0FBRSxVQUFVLEVBQUUsT0FBTyxLQUFLLElBQUksQ0FBQyxDQUFDO1FBQ25ELE9BQU8sQ0FBQyxXQUFXLENBQUUsWUFBWSxFQUFFLEtBQUssR0FBRyxDQUFDLEtBQUssQ0FBQyxDQUFFLENBQUM7UUFFckQsSUFBSSxRQUFRLEdBQUcsT0FBTyxDQUFDLHFCQUFxQixDQUFFLDBCQUEwQixDQUF1QixDQUFDO1FBQ2hHLFFBQVEsQ0FBQyxPQUFPLEdBQUcsS0FBSyxDQUFDO1FBRXpCLElBQUssT0FBTyxFQUNaO1lBQ0MsU0FBUyx3QkFBd0IsQ0FBRyxPQUFnQixFQUFFLElBQXFCO2dCQUUxRSxJQUFJLFFBQVEsR0FBRyxVQUFXLElBQXFCO29CQUU5QyxJQUFLLElBQUksSUFBSSxDQUFFLElBQUksS0FBSyxDQUFDLENBQUUsRUFDM0I7d0JBRUMsQ0FBQyxDQUFDLGFBQWEsQ0FBRSwwQkFBMEIsRUFBRSxJQUFJLENBQUUsQ0FBQzt3QkFFcEQsSUFBSSxnQkFBZ0IsR0FBRyxZQUFZLENBQUMsaURBQWlELENBQ3BGLEVBQUUsRUFDRixFQUFFLEVBQ0YscUVBQXFFLEVBQ3JFLE9BQU8sR0FBRyxJQUFJLEVBQ2Q7NEJBRUMsQ0FBQyxDQUFDLGFBQWEsQ0FBRSwwQkFBMEIsRUFBRSxLQUFLLENBQUUsQ0FBQzt3QkFDdEQsQ0FBQyxDQUNELENBQUM7d0JBQ0YsZ0JBQWdCLENBQUMsUUFBUSxDQUFFLHFCQUFxQixDQUFFLENBQUM7cUJBQ25EO2dCQUNGLENBQUMsQ0FBQztnQkFFRixPQUFPLENBQUMsYUFBYSxDQUFFLFlBQVksRUFBRSxRQUFRLENBQUMsSUFBSSxDQUFFLFNBQVMsRUFBRSxJQUFJLENBQUUsQ0FBRSxDQUFDO2dCQUN4RSxPQUFPLENBQUMsYUFBYSxDQUFFLGVBQWUsRUFBRSxRQUFRLENBQUMsSUFBSSxDQUFFLFNBQVMsRUFBRSxJQUFJLENBQUUsQ0FBRSxDQUFDO1lBQzVFLENBQUM7WUFFRCxPQUFPLENBQUMsT0FBTyxHQUFHLElBQUksQ0FBQztZQUV2QixJQUFLLFFBQVEsS0FBSyxPQUFPLElBQUksT0FBTyxDQUFDLElBQUksRUFDekM7Z0JBQ0MsUUFBUSxDQUFDLG1CQUFtQixDQUFFLE9BQU8sQ0FBQyxJQUFLLENBQUUsQ0FBQztnQkFDOUMsUUFBUSxDQUFDLE9BQU8sR0FBRyxJQUFJLENBQUM7YUFDeEI7aUJBRUQ7Z0JBQ0MsUUFBUSxDQUFDLE9BQU8sR0FBRyxLQUFLLENBQUM7YUFDekI7WUFFRCxJQUFJLGNBQWMsR0FBRyxPQUFPLENBQUMsaUJBQWlCLENBQUUsZ0JBQWdCLENBQUUsQ0FBQztZQUVuRSxJQUFLLFFBQVEsS0FBSyxPQUFPLEVBQ3pCO2dCQUNDLE1BQU0sWUFBWSxHQUFHLFlBQVksQ0FBQyxxQkFBcUIsQ0FBRSxPQUFPLENBQUMsSUFBSyxFQUFFLGdCQUFnQixDQUFFLENBQUM7Z0JBQzNGLE1BQU0sWUFBWSxHQUFHLFNBQVMsQ0FBQyxZQUFZLENBQUUsTUFBTSxDQUFFLFlBQVksQ0FBRSxDQUFFLENBQUM7Z0JBRXRFLFFBQVEsQ0FBQyxLQUFLLENBQUMsTUFBTSxHQUFHLGdCQUFnQixHQUFHLFlBQVksR0FBRyxHQUFHLENBQUM7YUFDOUQ7WUFFRCx3QkFBd0IsQ0FBRSxPQUFPLEVBQUUsT0FBTyxDQUFDLElBQUssQ0FBRSxDQUFDO1lBRW5ELElBQUksT0FBOEIsQ0FBQztZQUduQyxJQUFLLFFBQVEsS0FBSyxPQUFPLEVBQ3pCO2dCQUNDLE9BQU87b0JBQ1A7d0JBQ0MsVUFBVSxFQUFFLGNBQWM7d0JBQzFCLElBQUksRUFBRSxPQUFPLENBQUMsSUFBSzt3QkFDbkIsR0FBRyxFQUFFLFdBQVc7d0JBQ2hCLFdBQVcsRUFBRSxTQUFTO3dCQUN0QixLQUFLLEVBQUUsSUFBSTt3QkFDWCxtQkFBbUIsRUFBRSxPQUFPO3dCQUM1QixZQUFZLEVBQUUsS0FBSztxQkFDbkIsQ0FBQzthQUNGO2lCQUVEO2dCQUNDLE9BQU87b0JBQ1A7d0JBQ0MsVUFBVSxFQUFFLGNBQWM7d0JBQzFCLFdBQVcsRUFBRSxTQUFTO3dCQUN0QixLQUFLLEVBQUUsSUFBSTt3QkFDWCxtQkFBbUIsRUFBRSxPQUFPO3dCQUM1QixZQUFZLEVBQUUsS0FBSztxQkFDbkIsQ0FBQzthQUNGO1lBRUQsWUFBWSxDQUFDLE9BQU8sQ0FBRSxPQUFPLENBQUUsQ0FBQztZQUVoQyxPQUFPLENBQUMsaUJBQWlCLENBQUUsYUFBYSxFQUFFLE9BQU8sQ0FBQyxXQUFXLElBQUksY0FBYyxDQUFDLGFBQWEsQ0FBRSxPQUFPLENBQUMsSUFBSyxDQUFFLENBQUUsQ0FBQztZQUNqSCxPQUFPLENBQUMsSUFBSSxFQUFFLENBQUMsZ0JBQWdCLEdBQUcsQ0FBQyxPQUFPLENBQUMsY0FBYyxDQUFFLGFBQWEsQ0FBRSxDQUFDO1lBRTNFLE9BQU8sQ0FBQyxpQkFBaUIsQ0FBRSxhQUFhLEVBQUUsT0FBTyxDQUFDLGNBQWMsQ0FBRSxZQUFZLENBQUUsQ0FBQyxDQUFDLENBQUMsTUFBTSxDQUFFLE9BQU8sQ0FBQyxVQUFVLENBQUUsQ0FBQyxDQUFDLENBQUMsR0FBRyxDQUFFLENBQUM7WUFFeEgsSUFBSSxRQUFRLEdBQUcsT0FBTyxDQUFDLGNBQWMsQ0FBRSxNQUFNLENBQUUsSUFBSSxPQUFPLENBQUMsSUFBSyxHQUFHLENBQUMsQ0FBQztZQUNyRSxPQUFPLENBQUMsb0JBQW9CLENBQUUsYUFBYSxFQUFFLFFBQVEsQ0FBQyxDQUFDLENBQUMsT0FBTyxDQUFDLElBQUssQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFFLENBQUM7WUFDMUUsT0FBTyxDQUFDLGlCQUFpQixDQUFFLGNBQWMsQ0FBZSxDQUFDLElBQUksR0FBRyxRQUFRLENBQUMsQ0FBQyxDQUFDLENBQUMsQ0FBQyxRQUFRLENBQUUsaUJBQWlCLEVBQUUsT0FBTyxDQUFFLENBQUMsQ0FBQyxDQUFDLEdBQUcsQ0FBQztZQUc1SCxJQUFJLGNBQWMsR0FBRyxPQUFPLENBQUMsY0FBYyxDQUFFLFlBQVksQ0FBRSxJQUFJLE9BQU8sQ0FBQyxjQUFjLENBQUUsYUFBYSxDQUFFLElBQUksT0FBTyxDQUFDLGNBQWMsQ0FBRSxhQUFhLENBQUUsQ0FBQztZQUNsSixJQUFLLGNBQWMsRUFDbkI7Z0JBQ0MsSUFBSSxhQUFhLEdBQUcsQ0FBRSxPQUFPLENBQUMsVUFBVSxDQUFDLENBQUMsQ0FBQyxPQUFPLENBQUMsVUFBVSxDQUFDLENBQUMsQ0FBQyxDQUFDLENBQUU7b0JBQ2xFLENBQUUsT0FBTyxDQUFDLFdBQVcsQ0FBQyxDQUFDLENBQUMsT0FBTyxDQUFDLFdBQVcsQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFFO29CQUNqRCxDQUFFLE9BQU8sQ0FBQyxXQUFXLENBQUMsQ0FBQyxDQUFDLE9BQU8sQ0FBQyxXQUFXLENBQUMsQ0FBQyxDQUFDLENBQUMsQ0FBRSxDQUFDO2dCQUVuRCxJQUFJLE9BQU8sR0FBRyxhQUFhLEtBQUssQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFDLE9BQU8sQ0FBQyxVQUFXLEdBQUcsTUFBTSxHQUFHLGFBQWEsQ0FBQztnQkFDckYsT0FBTyxDQUFDLGlCQUFpQixDQUFFLGdCQUFnQixFQUFFLE9BQU8sQ0FBQyxPQUFPLENBQUUsQ0FBQyxDQUFFLEdBQUcsR0FBRyxDQUFFLENBQUM7YUFDMUU7aUJBRUQ7Z0JBQ0MsT0FBTyxDQUFDLGlCQUFpQixDQUFFLGdCQUFnQixFQUFFLEdBQUcsQ0FBRSxDQUFDO2FBQ25EO1lBRUQsT0FBTyxDQUFDLGlCQUFpQixDQUFFLG1CQUFtQixFQUFFLENBQUUsT0FBTyxDQUFDLGNBQWMsQ0FBRSxLQUFLLENBQUUsSUFBSSxPQUFPLENBQUMsR0FBRyxJQUFJLE9BQU8sQ0FBQyxHQUFHLEdBQUcsQ0FBQyxDQUFFLENBQUMsQ0FBQyxDQUFDLE9BQU8sQ0FBQyxHQUFJLENBQUMsT0FBTyxDQUFFLENBQUMsQ0FBRSxHQUFHLEdBQUcsQ0FBQyxDQUFDLENBQUMsR0FBRyxDQUFFLENBQUM7WUFDaEssT0FBTyxDQUFDLGlCQUFpQixDQUFFLGVBQWUsRUFBRSxDQUFFLE9BQU8sQ0FBQyxjQUFjLENBQUUsUUFBUSxDQUFFLENBQUUsQ0FBQyxDQUFDLENBQUMsQ0FBQyxDQUFDLFFBQVEsQ0FBRSwyQkFBMkIsR0FBRyxrQkFBa0IsQ0FBRSxPQUFPLENBQUMsTUFBTyxDQUFFLENBQUMsQ0FBQyxDQUFDLENBQUMsR0FBRyxDQUFFLENBQUM7U0FDOUs7UUFFRCxPQUFPLE9BQU8sQ0FBQztJQUNoQixDQUFDO0lBRUQsU0FBUyxnQkFBZ0I7UUFFeEIsSUFBSyxRQUFRLEtBQUssT0FBTztZQUN4QixPQUFPO1FBRVIsSUFBSSxRQUFRLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLHFCQUFxQixDQUFFLHdCQUF3QixDQUFFLENBQUM7UUFDckYsSUFBSSxNQUFNLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLHFCQUFxQixDQUFFLHVCQUF1QixDQUFFLENBQUM7UUFDbEYsSUFBSSxpQkFBaUIsR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMscUJBQXFCLENBQUUscUJBQXFCLENBQUUsQ0FBQztRQUUzRixpQkFBaUIsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLEtBQUssQ0FBRSxDQUFDO1FBQ2pELFFBQVEsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLElBQUksQ0FBRSxDQUFDO1FBQ3ZDLE1BQU0sQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLElBQUksQ0FBRSxDQUFDO1FBRXJDLFNBQVMsV0FBVyxDQUFHLElBQVk7WUFFbEMsQ0FBQyxDQUFDLGFBQWEsQ0FBRSx3QkFBd0IsRUFBRSxJQUFJLENBQUUsQ0FBQztRQUNuRCxDQUFDO1FBQUEsQ0FBQztRQUVGLFNBQVMsVUFBVTtZQUVsQixDQUFDLENBQUMsYUFBYSxDQUFFLHdCQUF3QixFQUFFLEVBQUUsQ0FBRSxDQUFDO1FBQ2pELENBQUM7UUFBQSxDQUFDO1FBRUYsSUFBSSxNQUFNLEdBQXFCLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxxQkFBcUIsQ0FBRSx3QkFBd0IsQ0FBcUIsQ0FBQztRQUN4SCxJQUFLLFFBQVEsQ0FBQyxlQUFlLEVBQUUsRUFDL0I7WUFDQyxJQUFJLE9BQU8sR0FBRyxRQUFRLENBQUMsa0JBQWtCLEVBQUUsQ0FBQyxPQUFPLENBQUM7WUFDcEQsU0FBUyxhQUFhLENBQUMsR0FBVTtnQkFFaEMsSUFBSSxPQUFPLEdBQUcsSUFBSSxDQUFDO2dCQUNuQixJQUFJLE9BQU8sR0FBRyxTQUFTLEdBQUcsR0FBRyxDQUFDO2dCQUM5QixJQUFJLGlCQUFpQixHQUFHLE9BQU8sQ0FBQyxjQUFjLENBQUUsT0FBTyxDQUFFLElBQUksT0FBTyxDQUFFLE9BQU8sQ0FBRSxDQUFDLGNBQWMsQ0FBRSxTQUFTLENBQUU7b0JBQzFHLE9BQU8sQ0FBRSxPQUFPLENBQUUsQ0FBQyxPQUFPLENBQUMsY0FBYyxDQUFFLE1BQU0sQ0FBRSxDQUFDO2dCQUNyRCxJQUFLLENBQUMsaUJBQWlCO29CQUN0QixPQUFPLElBQUksQ0FBQztnQkFFYixJQUFJLElBQUksR0FBRyxPQUFPLENBQUMsT0FBTyxDQUFDLENBQUMsT0FBTyxDQUFDLElBQUksQ0FBQztnQkFDekMsT0FBTyxHQUFHLGVBQWUsQ0FBQywyQkFBMkIsQ0FBRSxpQkFBaUIsRUFBRSxJQUFJLENBQUUsQ0FBQztnQkFHakYsSUFBSyxDQUFDLE9BQU8sQ0FBQyxJQUFJLEVBQ2xCO29CQUNDLE9BQU8sQ0FBQyxJQUFJLEdBQUcsSUFBSSxDQUFDO2lCQUNwQjtnQkFHRCxJQUFLLFlBQVksQ0FBQyw0QkFBNEIsQ0FBRSxJQUFJLENBQUUsS0FBSyxTQUFTLEVBQ3BFO29CQUNDLElBQUksVUFBVSxHQUFHLFlBQVksQ0FBQyx3QkFBd0IsQ0FBRSxJQUFJLENBQUUsQ0FBQztvQkFDL0QsSUFBSSxTQUFTLEdBQUcsWUFBWSxDQUFDLHdCQUF3QixDQUFFLElBQUksQ0FBRSxDQUFDO29CQUM5RCxJQUFLLFVBQVUsSUFBSSxTQUFTLEVBQzVCO3dCQUNDLE9BQU8sQ0FBQyxLQUFLLEdBQUcsWUFBWSxDQUFDLHdCQUF3QixDQUFFLElBQUksQ0FBRSxDQUFDO3dCQUM5RCxPQUFPLENBQUMsVUFBVSxHQUFHLFlBQVksQ0FBQyx3QkFBd0IsQ0FBRSxJQUFJLENBQUUsQ0FBQzt3QkFDbkUsT0FBTyxDQUFDLGVBQWUsR0FBRyxZQUFZLENBQUMsNENBQTRDLENBQUUsSUFBSSxDQUFFLENBQUM7d0JBRTVGLElBQUksQ0FBRSxtQkFBbUIsR0FBRyxJQUFJLEdBQUcsU0FBUyxHQUFHLE9BQU8sQ0FBQyxLQUFLLEdBQUcsUUFBUSxHQUFHLE9BQU8sQ0FBQyxVQUFVLEdBQUcsU0FBUyxHQUFHLElBQUksQ0FBQyxTQUFTLENBQUUsT0FBTyxDQUFFLEdBQUcsR0FBRyxDQUFFLENBQUM7cUJBQzdJO2lCQUNEO2dCQUNELE9BQU8sT0FBTyxDQUFDO1lBQ2hCLENBQUM7WUFFRCxNQUFNLENBQUMsdUJBQXVCLENBQUUsVUFBVSxNQUFlLEVBQUUsU0FBaUIsRUFBRSxVQUFtQjtnQkFDaEcsSUFBSSxPQUFPLEdBQUcsYUFBYSxDQUFDLFNBQVMsQ0FBQyxDQUFDO2dCQUN2QyxJQUFLLENBQUMsVUFBVSxJQUFJLFVBQVUsQ0FBQyxPQUFPLEVBQUUsRUFDeEM7b0JBQ0MsVUFBVSxHQUFHLENBQUMsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLE1BQU0sRUFBRSxPQUFPLENBQUMsQ0FBQyxDQUFDLE9BQU8sQ0FBQyxJQUFJLENBQUMsQ0FBQyxDQUFDLEVBQUUsQ0FBYSxDQUFDO29CQUN2RixVQUFVLENBQUMsa0JBQWtCLENBQUUsbUJBQW1CLENBQUUsQ0FBQztpQkFDckQ7Z0JBQ0QsVUFBVSxDQUFFLFVBQVUsRUFBRSxPQUFPLEVBQUUsU0FBUyxDQUFFLENBQUM7Z0JBRTdDLFVBQVUsQ0FBQyxhQUFhLENBQUUsYUFBYSxFQUFFLE9BQU8sQ0FBQyxDQUFDLENBQUMsV0FBVyxDQUFDLElBQUksQ0FBRSxVQUFVLEVBQUUsT0FBTyxDQUFDLElBQUssQ0FBRSxDQUFDLENBQUMsQ0FBQyxVQUFVLENBQUUsQ0FBQztnQkFDaEgsVUFBVSxDQUFDLGFBQWEsQ0FBRSxZQUFZLEVBQUUsVUFBVSxDQUFFLENBQUM7Z0JBRXJELE9BQU8sVUFBVSxDQUFDO1lBQ25CLENBQUMsQ0FBQyxDQUFDO1lBQ0gsTUFBTSxDQUFDLGVBQWUsQ0FBRSxZQUFZLENBQUMsUUFBUSxFQUFFLENBQUMsQ0FBQztTQUNqRDtJQUNGLENBQUM7SUFFRCxTQUFTLGtCQUFrQixDQUFFLElBQVk7UUFFeEMsSUFBSSxDQUFFLG9CQUFvQixDQUFFLENBQUM7UUFFN0IsSUFBSyxpQkFBaUIsSUFBSSxpQkFBaUIsS0FBSyxJQUFJLEVBQ3BEO1lBQ0MsZUFBZSxDQUFDLE9BQU8sQ0FBRSxpQkFBaUIsQ0FBRSxDQUFDO1NBQzdDO0lBQ0YsQ0FBQztJQUVELFNBQWdCLGVBQWU7UUFFOUIsSUFBSSxDQUFFLGlCQUFpQixDQUFFLENBQUM7UUFDMUIscUJBQXFCLEVBQUUsQ0FBQztRQUV4QixJQUFLLGlCQUFpQixFQUN0QjtZQUNDLGVBQWUsQ0FBQyxPQUFPLENBQUUsaUJBQWlCLENBQUUsQ0FBQztTQUM3QztJQUNGLENBQUM7SUFUZSwyQkFBZSxrQkFTOUIsQ0FBQTtJQUFBLENBQUM7SUFFRixTQUFnQixpQkFBaUI7UUFFaEMsSUFBSSxDQUFFLG1CQUFtQixDQUFFLENBQUM7UUFDNUIsdUJBQXVCLEVBQUUsQ0FBQztJQUMzQixDQUFDO0lBSmUsNkJBQWlCLG9CQUloQyxDQUFBO0lBQUEsQ0FBQztJQUVGLFNBQVMsV0FBVyxDQUFHLElBQVk7UUFFbEMsSUFBSSxNQUFNLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLHFCQUFxQixDQUFFLHdCQUF3QixDQUFFLENBQUM7UUFDbkYsSUFBSSxPQUFPLEdBQUcsTUFBTSxDQUFDLHFCQUFxQixDQUFFLElBQUksQ0FBRSxDQUFDO1FBRW5ELElBQUssT0FBTyxJQUFJLE9BQU8sQ0FBQyxJQUFJLEVBQUUsQ0FBQyxnQkFBZ0IsRUFDL0M7WUFDQyxPQUFPLENBQUMsaUJBQWlCLENBQUUsYUFBYSxFQUFFLGNBQWMsQ0FBQyxhQUFhLENBQUUsSUFBSSxDQUFFLENBQUUsQ0FBQztTQUNqRjtJQUNGLENBQUM7SUFBQSxDQUFDO0lBR0YsU0FBUyxjQUFjO1FBRXRCLFlBQVksQ0FBQyxxQkFBcUIsQ0FDakMsRUFBRSxFQUNGLGlFQUFpRSxDQUNqRSxDQUFDO0lBQ0gsQ0FBQztJQUVELFNBQVMsa0NBQWtDO1FBRTFDLElBQUksSUFBSSxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxJQUFJLEVBQVMsQ0FBQztRQUM3QyxJQUFJLGFBQWEsR0FBRyxJQUFJLElBQUksSUFBSSxDQUFDLCtCQUErQixDQUFDO1FBRWpFLElBQUssYUFBYTtZQUNqQixPQUFPO1FBRVIsY0FBYyxFQUFFLENBQUM7UUFFakIsSUFBSSxDQUFDLCtCQUErQixHQUFHLElBQUksQ0FBQztJQUU3QyxDQUFDO0lBRUQsU0FBUyxlQUFlO1FBRXZCLElBQUksUUFBUSxHQUFHLGVBQWUsQ0FBQyxRQUFRLENBQUUsaUJBQWlCLENBQUUsQ0FBQztRQUM3RCxJQUFJLENBQUUsUUFBUSxHQUFHLGtCQUFrQixDQUFFLENBQUM7UUFDdEMsTUFBTSxNQUFNLEdBQXFCLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxxQkFBcUIsQ0FBRSx3QkFBd0IsQ0FBcUIsQ0FBQztRQUMxSCxNQUFNLENBQUMsdUJBQXVCLENBQUUsVUFBVyxNQUFlLEVBQUUsU0FBaUIsRUFBRSxVQUFtQjtZQUVqRyxJQUFJLE9BQU8sR0FBRyxlQUFlLENBQUMsNEJBQTRCLENBQUUsaUJBQWlCLEVBQUUsU0FBUyxDQUFFLENBQUM7WUFDM0YsSUFBSyxDQUFDLFVBQVUsSUFBSSxDQUFDLFVBQVUsQ0FBQyxPQUFPLEVBQUUsRUFDekM7Z0JBQ0MsVUFBVSxHQUFHLENBQUMsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLE1BQU0sRUFBRSxPQUFPLENBQUMsQ0FBQyxDQUFDLE9BQU8sQ0FBQyxJQUFJLENBQUMsQ0FBQyxDQUFDLEVBQUUsQ0FBYSxDQUFDO2dCQUN2RixVQUFVLENBQUMsa0JBQWtCLENBQUUsbUJBQW1CLENBQUUsQ0FBQzthQUNyRDtZQUNELFVBQVUsQ0FBRSxVQUFVLEVBQUUsT0FBTyxFQUFFLFNBQVMsQ0FBRSxDQUFDO1lBQzdDLFVBQVUsQ0FBQyxXQUFXLENBQUUsY0FBYyxFQUFFLENBQUUsT0FBTyxDQUFDLENBQUMsQ0FBQyxPQUFPLENBQUMsSUFBSSxDQUFDLENBQUMsQ0FBQyxFQUFFLENBQUUsS0FBSyxRQUFRLENBQUUsQ0FBQztZQUN2RixPQUFPLFVBQVUsQ0FBQztRQUNuQixDQUFDLENBQUMsQ0FBQztRQUNILE1BQU0sQ0FBQyxlQUFlLENBQUUsUUFBUSxDQUFFLENBQUM7UUFFbkMsQ0FBQyxDQUFDLGFBQWEsQ0FBRSwyQkFBMkIsRUFBRSxNQUFNLEVBQUUsQ0FBQyxFQUFFLFNBQVMsRUFBRSxJQUFJLENBQUUsQ0FBQztJQUU1RSxDQUFDO0lBQUEsQ0FBQztJQUVGLFNBQWdCLHdCQUF3QixDQUFHLElBQVk7UUFFdEQsSUFBSSxDQUFFLDBCQUEwQixDQUFFLENBQUM7UUFDbkMsSUFBSSxDQUFFLDhCQUE4QixDQUFFLENBQUM7UUFFdkMsSUFBSyxpQkFBaUIsS0FBSyxJQUFJLEVBQy9CO1lBQ0MsSUFBSyxRQUFRLEtBQUssT0FBTyxFQUN6QjtnQkFDQyxnQkFBZ0IsRUFBRSxDQUFDO2FBQ25CO2lCQUNJLElBQUssUUFBUSxLQUFLLFNBQVMsRUFDaEM7Z0JBQ0MscUJBQXFCLEVBQUUsQ0FBQzthQUN4QjtZQUNELE9BQU87U0FDUDtJQUNGLENBQUM7SUFqQmUsb0NBQXdCLDJCQWlCdkMsQ0FBQTtJQUFBLENBQUM7SUFHRixTQUFnQixtQkFBbUI7UUFFbEMsc0JBQXNCLEVBQUUsQ0FBQztRQUN6QixxQkFBcUIsRUFBRSxDQUFDO0lBQ3pCLENBQUM7SUFKZSwrQkFBbUIsc0JBSWxDLENBQUE7SUFFRCxTQUFnQixRQUFRO1FBRXZCLElBQUksT0FBTyxHQUFHLGVBQWUsQ0FBQyxjQUFjLENBQUUsaUJBQWlCLEVBQUUsUUFBUSxDQUFFLENBQUM7UUFDNUUsTUFBTSxNQUFNLEdBQW9CLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxxQkFBcUIsQ0FBRSx3QkFBd0IsQ0FBcUIsQ0FBQztRQUN6SCxDQUFDLENBQUMsYUFBYSxDQUFFLDJCQUEyQixFQUFFLE1BQU0sRUFBRSxPQUFPLEVBQUUsU0FBUyxFQUFFLElBQUksQ0FBRSxDQUFDO0lBQ2xGLENBQUM7SUFMZSxvQkFBUSxXQUt2QixDQUFBO0lBRUQsU0FBZ0IsT0FBTztRQUV0QixNQUFNLE1BQU0sR0FBb0IsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLHFCQUFxQixDQUFFLHdCQUF3QixDQUFxQixDQUFDO1FBQ3pILENBQUMsQ0FBQyxhQUFhLENBQUUsMkJBQTJCLEVBQUUsTUFBTSxFQUFFLENBQUMsRUFBRSxTQUFTLEVBQUUsSUFBSSxDQUFFLENBQUM7SUFDNUUsQ0FBQztJQUplLG1CQUFPLFVBSXRCLENBQUE7QUFDRixDQUFDLEVBOXVCUyxXQUFXLEtBQVgsV0FBVyxRQTh1QnBCO0FBSUQsQ0FBRTtJQUVELENBQUMsQ0FBQyxvQkFBb0IsQ0FBRSxpQkFBaUIsRUFBRSxDQUFDLENBQUMsZUFBZSxFQUFFLEVBQUUsV0FBVyxDQUFDLGVBQWUsQ0FBRSxDQUFDO0lBQzlGLENBQUMsQ0FBQyxvQkFBb0IsQ0FBRSxtQkFBbUIsRUFBRSxDQUFDLENBQUMsZUFBZSxFQUFFLEVBQUUsV0FBVyxDQUFDLGlCQUFpQixDQUFFLENBQUM7SUFFbEcsV0FBVyxDQUFDLElBQUksRUFBRSxDQUFDO0FBQ3BCLENBQUMsQ0FBQyxFQUFFLENBQUMifQ==