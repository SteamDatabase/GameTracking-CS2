"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../util_gamemodeflags.ts" />
/// <reference path="../common/formattext.ts" />
/// <reference path="../common/sessionutil.ts" />
/// <reference path="../popups/popup_premier_pick_ban.ts" />
/// <reference path="../common/teamcolor.ts" />
/// <reference path="../rating_emblem.ts" />
/// <reference path="../avatar.ts" />
const PopupAcceptMatch = (function () {
    let m_hasPressedAccept = false;
    let m_numPlayersReady = 0;
    let m_numTotalClientsInReservation = 0;
    let m_numSecondsRemaining = 0;
    let m_isReconnect = false;
    let m_isNqmmAnnouncementOnly = false;
    let m_gsLocation = '';
    let m_gsPing = 0;
    let m_lobbySettings = null;
    const m_elTimer = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchCountdown');
    let m_jsTimerUpdateHandle = false;
    const _Init = function () {
        const elPlayerSlots = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchSlots');
        elPlayerSlots.RemoveAndDeleteChildren();
        const settings = $.GetContextPanel().GetAttributeString('map_and_isreconnect', '');
        m_gsLocation = $.GetContextPanel().GetAttributeString('location', '');
        m_gsPing = parseInt($.GetContextPanel().GetAttributeString('ping', '0'));
        $.GetContextPanel().SetDialogVariable('region', m_gsLocation);
        $.GetContextPanel().SetDialogVariableInt('ping', m_gsPing);
        const settingsList = settings.split(',');
        let map = settingsList[0];
        if (map.charAt(0) === '@') {
            m_isNqmmAnnouncementOnly = true;
            m_hasPressedAccept = true;
            map = map.substr(1);
        }
        m_isReconnect = settingsList[1] === 'true' ? true : false;
        m_lobbySettings = LobbyAPI.GetSessionSettings();
        if (!m_isReconnect && m_lobbySettings && m_lobbySettings.game) {
            const elAgreement = $.GetContextPanel().FindChildInLayoutFile('Agreement');
            elAgreement.visible = true;
            const elAgreementComp = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchAgreementCompetitive');
            elAgreementComp.visible = m_lobbySettings.game.mode === "competitive";
        }
        $.DispatchEvent("ShowReadyUpPanel", "");
        _SetMatchData(map);
        _UpdateGameServerUi();
        if (m_isNqmmAnnouncementOnly) {
            $('#AcceptMatchDataContainer').SetHasClass('auto', true);
            _UpdateUiState();
            $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'popup_accept_match_confirmed_casual', 'MOUSE', 6.0);
            m_jsTimerUpdateHandle = $.Schedule(4.5, _OnNqmmAutoReadyUp);
        }
        _PopulatePlayerList();
    };
    function _PopulatePlayerList() {
        let numPlayers = LobbyAPI.GetConfirmedMatchPlayerCount();
        if (!numPlayers || numPlayers <= 2)
            return;
        $.GetContextPanel().SetHasClass("accept-match-with-player-list", true);
        $.GetContextPanel().FindChildInLayoutFile('id-map-draft-phase-teams').RemoveClass('hidden');
        let iYourXuidTeamIdx = 0;
        const yourXuid = MyPersonaAPI.GetXuid();
        for (let i = 0; i < numPlayers; ++i) {
            const xuidPlayer = LobbyAPI.GetConfirmedMatchPlayerByIdx(i);
            if (xuidPlayer && xuidPlayer === yourXuid)
                iYourXuidTeamIdx = (i < (numPlayers / 2)) ? 0 : 1;
        }
        for (let i = 0; i < numPlayers; ++i) {
            let xuid = LobbyAPI.GetConfirmedMatchPlayerByIdx(i);
            if (!xuid) {
                continue;
            }
            const iThisPlayerTeamIdx = (i < (numPlayers / 2)) ? 0 : 1;
            const teamPanelId = (iYourXuidTeamIdx === iThisPlayerTeamIdx) ? 'id-map-draft-phase-your-team' : 'id-map-draft-phase-other-team';
            const elTeammates = $.GetContextPanel().FindChildInLayoutFile(teamPanelId).FindChild('id-map-draft-phase-avatars');
            _MakeAvatar(xuid, elTeammates, true);
        }
    }
    const _MakeAvatar = function (xuid, elTeammates, bisTeamLister = false) {
        const panelType = bisTeamLister ? 'Button' : 'Panel';
        const elAvatar = $.CreatePanel(panelType, elTeammates, xuid);
        elAvatar.BLoadLayoutSnippet('SmallAvatar');
        if (bisTeamLister) {
            _AddOpenPlayerCardAction(elAvatar, xuid);
        }
        elAvatar.FindChildTraverse('JsAvatarImage').PopulateFromSteamID(xuid);
        const elTeamColor = elAvatar.FindChildInLayoutFile('JsAvatarTeamColor');
        elTeamColor.visible = false;
        const strName = FriendsListAPI.GetFriendName(xuid);
        elAvatar.SetDialogVariable('teammate_name', strName);
    };
    const _AddOpenPlayerCardAction = function (elAvatar, xuid) {
        elAvatar.SetPanelEvent("onactivate", () => {
            $.DispatchEvent('SidebarContextMenuActive', true);
            if (xuid !== "0") {
                const contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('', '', 'file://{resources}/layout/context_menus/context_menu_playercard.xml', 'xuid=' + xuid, () => $.DispatchEvent('SidebarContextMenuActive', false));
                contextMenuPanel.AddClass("ContextMenu_NoArrow");
            }
        });
    };
    const _UpdateGameServerUi = function () {
        const elGameServer = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchGameServer');
        elGameServer.SetHasClass('hidden', m_hasPressedAccept || m_isReconnect || m_isNqmmAnnouncementOnly ||
            !(m_gsLocation && m_gsPing));
    };
    const _UpdateUiState = function () {
        _UpdateGameServerUi();
        const btnAccept = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchBtn');
        const elPlayerSlots = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchSlots');
        let bHideTimer = false;
        let bShowPlayerSlots = m_hasPressedAccept || m_isReconnect;
        if (m_isNqmmAnnouncementOnly) {
            bShowPlayerSlots = false;
            bHideTimer = true;
        }
        btnAccept.SetHasClass('hidden', m_hasPressedAccept || m_isReconnect);
        elPlayerSlots.SetHasClass('hidden', !bShowPlayerSlots);
        if (bShowPlayerSlots) {
            _UpdatePlayerSlots(elPlayerSlots);
            bHideTimer = true;
        }
        m_elTimer.GetChild(0).text = "0:" + ((m_numSecondsRemaining < 10) ? "0" : "") + m_numSecondsRemaining;
        m_elTimer.SetHasClass("hidden", bHideTimer || (m_numSecondsRemaining <= 0));
        CancelTimerSound();
    };
    const CancelTimerSound = function () {
        if (m_jsTimerUpdateHandle) {
            $.CancelScheduled(m_jsTimerUpdateHandle);
            m_jsTimerUpdateHandle = false;
        }
    };
    const _UpdateTimeRemainingSeconds = function () {
        m_numSecondsRemaining = LobbyAPI.GetReadyTimeRemainingSeconds();
    };
    const _OnTimerUpdate = function () {
        m_jsTimerUpdateHandle = false;
        _UpdateTimeRemainingSeconds();
        _UpdateUiState();
        if (m_numSecondsRemaining > 0) {
            if (m_hasPressedAccept) {
                $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'popup_accept_match_waitquiet', 'MOUSE', 1.0);
            }
            else {
                $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'popup_accept_match_beep', 'MOUSE', 1.0);
            }
            m_jsTimerUpdateHandle = $.Schedule(1.0, _OnTimerUpdate);
        }
    };
    const _FriendsListNameChanged = function (xuid) {
        if (!xuid)
            return;
        const elNameLabel = $.GetContextPanel().FindChildTraverse('xuid');
        if (!elNameLabel)
            return;
        const strName = FriendsListAPI.GetFriendName(xuid);
        elNameLabel.SetDialogVariable('teammate_name', strName);
    };
    const _ReadyForMatch = function (shouldShow, playersReadyCount, numTotalClientsInReservation) {
        if (!shouldShow) {
            if (m_jsTimerUpdateHandle) {
                $.CancelScheduled(m_jsTimerUpdateHandle);
                m_jsTimerUpdateHandle = false;
            }
            $.DispatchEvent("CloseAcceptPopup");
            $.DispatchEvent('UIPopupButtonClicked', '');
            return;
        }
        if (m_hasPressedAccept && m_numPlayersReady && (playersReadyCount > m_numPlayersReady)) {
            $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'popup_accept_match_person', 'MOUSE', 1.0);
        }
        if (playersReadyCount == 1 && numTotalClientsInReservation == 1 && (m_numTotalClientsInReservation > 1)) {
            numTotalClientsInReservation = m_numTotalClientsInReservation;
            playersReadyCount = m_numTotalClientsInReservation;
        }
        m_numPlayersReady = playersReadyCount;
        m_numTotalClientsInReservation = numTotalClientsInReservation;
        _UpdateTimeRemainingSeconds();
        _UpdateUiState();
        m_jsTimerUpdateHandle = $.Schedule(1.0, _OnTimerUpdate);
    };
    const _UpdatePlayerSlots = function (elPlayerSlots) {
        for (let i = 0; i < m_numTotalClientsInReservation; i++) {
            let Slot = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchSlot' + i);
            if (!Slot) {
                Slot = $.CreatePanel('Panel', elPlayerSlots, 'AcceptMatchSlot' + i);
                Slot.BLoadLayoutSnippet('AcceptMatchPlayerSlot');
            }
            Slot.SetHasClass('accept-match__slots__player--accepted', (i < m_numPlayersReady));
        }
        const labelPlayersAccepted = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchPlayersAccepted');
        labelPlayersAccepted.SetDialogVariableInt('accepted', m_numPlayersReady);
        labelPlayersAccepted.SetDialogVariableInt('slots', m_numTotalClientsInReservation);
        labelPlayersAccepted.text = $.Localize('#match_ready_players_accepted', labelPlayersAccepted);
    };
    const _SetMatchData = function (map) {
        if (!m_lobbySettings || !m_lobbySettings.game)
            return;
        const labelData = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchModeMap');
        let strLocalize = '#match_ready_match_data';
        labelData.SetDialogVariable('mode', $.Localize('#SFUI_GameMode_' + m_lobbySettings.game.mode));
        const flags = parseInt(m_lobbySettings.game.gamemodeflags);
        if (GameModeFlags.DoesModeUseFlags(m_lobbySettings.game.mode) && flags &&
            GameModeFlags.DoesModeShowUserVisibleFlags(m_lobbySettings.game.mode)) {
            labelData.SetDialogVariable('modifier', $.Localize('#play_setting_gamemodeflags_' + m_lobbySettings.game.mode + '_' + flags));
            strLocalize = '#match_ready_match_data_modifier';
        }
        if (MyPersonaAPI.GetElevatedState() === 'elevated' && SessionUtil.DoesGameModeHavePrimeQueue(m_lobbySettings.game.mode) && ((m_lobbySettings.game.prime !== 1) || !SessionUtil.AreLobbyPlayersPrime())) {
            $.GetContextPanel().FindChildInLayoutFile('AcceptMatchWarning').RemoveClass('hidden');
        }
        labelData.SetDialogVariable('map', $.Localize('#SFUI_Map_' + map));
        if ((m_lobbySettings.game.mode === 'competitive') && (map === 'lobby_mapveto')) {
            $('#AcceptMatchModeIcon').SetImage("file://{images}/icons/ui/competitive_teams.svg");
            if (m_lobbySettings.options && m_lobbySettings.options.challengekey) {
                strLocalize = '#match_ready_match_data_map';
                labelData.SetDialogVariable('map', $.Localize('#SFUI_Lobby_LeaderMatchmaking_Type_PremierPrivateQueue'));
            }
        }
        labelData.text = $.Localize(strLocalize, labelData);
        const imgMap = $.GetContextPanel().FindChildInLayoutFile('AcceptMatchMapImage');
        imgMap.style.backgroundImage = 'url("file://{images}/map_icons/screenshots/360p/' + map + '.png")';
    };
    const _OnNqmmAutoReadyUp = function () {
        m_jsTimerUpdateHandle = false;
        LobbyAPI.SetLocalPlayerReady('deferred');
        $.DispatchEvent("CloseAcceptPopup");
        $.DispatchEvent('UIPopupButtonClicked', '');
    };
    const _OnAcceptMatchPressed = function () {
        m_hasPressedAccept = true;
        $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'popup_accept_match_person', 'MOUSE', 1.0);
        LobbyAPI.SetLocalPlayerReady('accept');
    };
    const _ShowPreMatchInterface = function () {
        PremierPickBan.Init();
        $.GetContextPanel().FindChildInLayoutFile('id-accept-match').AddClass('hide');
        CancelTimerSound();
    };
    return {
        Init: _Init,
        ReadyForMatch: _ReadyForMatch,
        FriendsListNameChanged: _FriendsListNameChanged,
        OnAcceptMatchPressed: _OnAcceptMatchPressed,
        ShowPreMatchInterface: _ShowPreMatchInterface
    };
})();
(function () {
    $.RegisterForUnhandledEvent('PanoramaComponent_FriendsList_NameChanged', PopupAcceptMatch.FriendsListNameChanged);
    $.RegisterForUnhandledEvent('PanoramaComponent_Lobby_ReadyUpForMatch', PopupAcceptMatch.ReadyForMatch);
    $.RegisterForUnhandledEvent('MatchAssistedAccept', PopupAcceptMatch.OnAcceptMatchPressed);
    $.RegisterForUnhandledEvent('PanoramaComponent_Lobby_ShowPreMatchInterface', PopupAcceptMatch.ShowPreMatchInterface);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfYWNjZXB0X21hdGNoLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvcG9wdXBzL3BvcHVwX2FjY2VwdF9tYXRjaC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBQ3JDLGlEQUFpRDtBQUNqRCxnREFBZ0Q7QUFDaEQsaURBQWlEO0FBQ2pELDREQUE0RDtBQUM1RCwrQ0FBK0M7QUFDL0MsNENBQTRDO0FBQzVDLHFDQUFxQztBQUVyQyxNQUFNLGdCQUFnQixHQUFHLENBQUU7SUFnQjFCLElBQUksa0JBQWtCLEdBQUcsS0FBSyxDQUFDO0lBQy9CLElBQUksaUJBQWlCLEdBQUcsQ0FBQyxDQUFDO0lBQzFCLElBQUksOEJBQThCLEdBQUcsQ0FBQyxDQUFDO0lBQ3ZDLElBQUkscUJBQXFCLEdBQUcsQ0FBQyxDQUFDO0lBQzlCLElBQUksYUFBYSxHQUFHLEtBQUssQ0FBQztJQUMxQixJQUFJLHdCQUF3QixHQUFHLEtBQUssQ0FBQztJQUNyQyxJQUFJLFlBQVksR0FBRyxFQUFFLENBQUM7SUFDdEIsSUFBSSxRQUFRLEdBQVcsQ0FBQyxDQUFDO0lBQ3pCLElBQUksZUFBZSxHQUEyQixJQUFJLENBQUM7SUFDbkQsTUFBTSxTQUFTLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLHFCQUFxQixDQUFFLHNCQUFzQixDQUFFLENBQUM7SUFDdEYsSUFBSSxxQkFBcUIsR0FBbUIsS0FBSyxDQUFDO0lBTWxELE1BQU0sS0FBSyxHQUFHO1FBR2IsTUFBTSxhQUFhLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLHFCQUFxQixDQUFFLGtCQUFrQixDQUFFLENBQUM7UUFDdEYsYUFBYSxDQUFDLHVCQUF1QixFQUFFLENBQUM7UUFFeEMsTUFBTSxRQUFRLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLGtCQUFrQixDQUFFLHFCQUFxQixFQUFF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