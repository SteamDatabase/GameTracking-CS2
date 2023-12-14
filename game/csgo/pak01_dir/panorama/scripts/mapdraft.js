"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="avatar.ts" />
const MapDraft = (function () {
    const _m_cp = $.GetContextPanel();
    let _m_nPhase = 0;
    let _m_hDenyInputToGame = null;
    let _m_isThisPhasePick = false;
    const _m_phaseTitleText = _m_cp.FindChildInLayoutFile('id-map-draft-phase-info');
    const _m_rowsContainer = _m_cp.FindChildInLayoutFile('id-map-draft-phase-rows');
    const _m_rowPhaseName = 'id-map-draft-phase-buttons-container';
    const _m_nT = 2;
    const _m_nCt = 3;
    let _m_msLastSoundTimestamp = (new Date()).getTime();
    function _PlaySoundEffect(strSoundEffect, msThrottleRequired = 0) {
        const msTimestampNow = (new Date()).getTime();
        if (msThrottleRequired && (msThrottleRequired > 0)) {
            if (msTimestampNow - _m_msLastSoundTimestamp < msThrottleRequired)
                return;
        }
        $.DispatchEvent('CSGOPlaySoundEffect', strSoundEffect, 'MOUSE');
        _m_msLastSoundTimestamp = msTimestampNow;
    }
    function _Update() {
        let sGameUiState = GameStateAPI.GetCSGOGameUIStateName();
        let bThisPanelIsVisible = true;
        if (sGameUiState === 'CSGO_GAME_UI_STATE_LOADINGSCREEN' || MatchDraftAPI.GetDraft() !== 'ingame' || MatchDraftAPI.GetIngamePhase() < 1) {
            bThisPanelIsVisible = false;
        }
        _m_cp.visible = bThisPanelIsVisible;
        _m_cp.SetHasClass('map-draft--show', bThisPanelIsVisible);
        let bMouseCaptureActive = _m_hDenyInputToGame ? true : false;
        if (bMouseCaptureActive != bThisPanelIsVisible) {
            if (bThisPanelIsVisible) {
                _m_hDenyInputToGame = UiToolkitAPI.AddDenyInputFlagsToGame(_m_cp, "MapDraft", "ShareMouse");
                _PopulatePlayerList();
            }
            else {
                UiToolkitAPI.ReleaseDenyInputFlagsToGame(_m_hDenyInputToGame);
                _m_hDenyInputToGame = null;
            }
        }
        if (!bThisPanelIsVisible) {
            _m_rowsContainer.RemoveAndDeleteChildren();
            return;
        }
        _m_cp.visible = true;
        _m_cp.SetHasClass('map-draft--show', true);
        if (MatchDraftAPI.GetIngamePhase() != _m_nPhase) {
            _PlaySoundEffect('tab_mainmenu_watch');
        }
        else {
            const ingameTeamToActNow = MatchDraftAPI.GetIngameTeamToActNow();
            if (ingameTeamToActNow && (ingameTeamToActNow == GameStateAPI.GetPlayerTeamNumber(MyPersonaAPI.GetXuid()))) {
                _PlaySoundEffect('UIPanorama.mainmenu_rollover', 400);
            }
        }
        _m_nPhase = MatchDraftAPI.GetIngamePhase();
        if (_m_nPhase > 6) {
            _m_nPhase = 6;
        }
        _HideFinishedPhaseRows();
        _MakeVoteButtons(_UpdateButtonsRow());
        _UpdateActionText();
        _UpdatePhaseProgressBar();
    }
    const _UpdatePhaseProgressBar = function () {
        const aChildren = _m_cp.FindChildInLayoutFile('id-map-draft-phasebar-container').Children();
        aChildren.forEach(phase => {
            const nPhaseBarIndex = parseInt(phase.GetAttributeString('data-phase', ''));
            phase.SetHasClass('map-draft-phasebar--ban', !_m_isThisPhasePick && nPhaseBarIndex === _m_nPhase);
            phase.SetHasClass('map-draft-phasebar--pick', _m_isThisPhasePick && nPhaseBarIndex === _m_nPhase);
            phase.SetHasClass('map-draft-phasebar--pre', nPhaseBarIndex > _m_nPhase);
            phase.SetHasClass('map-draft-phasebar--post', nPhaseBarIndex < _m_nPhase);
            phase.FindChildInLayoutFile('id-map-draft-phase-name').text = $.Localize('#matchdraft_phase_' + nPhaseBarIndex);
            if (nPhaseBarIndex === _m_nPhase) {
                const nTimeRemaining = MatchDraftAPI.GetIngamePhaseSecondsRemaining() || 0;
                phase.FindChildInLayoutFile('id-map-draft-phase-timer').timeleft = nTimeRemaining;
            }
        });
    };
    const _UpdateButtonsRow = function () {
        let elContainer = _m_rowsContainer.FindChildInLayoutFile(_m_rowPhaseName + _m_nPhase);
        if (!elContainer) {
            elContainer = $.CreatePanel('Panel', _m_rowsContainer, _m_rowPhaseName + _m_nPhase);
            elContainer.AddClass('map-draft-phase-buttons-container');
            elContainer.AddClass('map-draft-phase-buttons-container--show');
            elContainer.Data().phase = _m_nPhase;
        }
        elContainer.SetHasClass('map-draft-phase-buttons-container--show', true);
        elContainer.SetHasClass('map-draft-phase-buttons-container--hide', false);
        elContainer.hittest = true;
        elContainer.hittestchildren = true;
        return elContainer;
    };
    const _HideFinishedPhaseRows = function () {
        const aRows = _m_rowsContainer.Children();
        aRows.forEach(function (row) {
            if (row.Data().phase !== _m_nPhase) {
                row.RemoveClass('map-draft-phase-buttons-container--show');
                row.AddClass('map-draft-phase-buttons-container--hide');
                row.hittest = false;
                row.hittestchildren = false;
            }
        });
    };
    const _MakeVoteButtons = function (elContainer) {
        if (_m_nPhase === 1) {
            _m_isThisPhasePick = true;
            const nYourTeam = GameStateAPI.GetPlayerTeamNumber(MyPersonaAPI.GetXuid());
            const nOtherTeam = nYourTeam === _m_nT ? _m_nCt : _m_nT;
            _MakeButton(elContainer, {
                id: 'id-phase-1-btn-ban-first',
                image: 'url("file://{images}/mapdraft/ban_first.png")',
                selectorimg: "file://{images}/mapdraft/green_check.png",
                name: "#matchdraft_vote_ban_first",
                statustext: '#matchdraft_vote_status_pick',
                ispick: _m_isThisPhasePick,
                voteid: nYourTeam
            });
            _MakeButton(elContainer, {
                id: 'id-phase-1-btn-pick-side',
                image: 'url("file://{images}/mapdraft/pick_team.png")',
                selectorimg: "file://{images}/mapdraft/green_check.png",
                name: "#matchdraft_vote_pick_team",
                statustext: '#matchdraft_vote_status_pick',
                ispick: _m_isThisPhasePick,
                voteid: nOtherTeam
            });
        }
        else if (_m_nPhase === 5) {
            _m_isThisPhasePick = true;
            _MakeButton(elContainer, {
                id: 'id-phase-5-btn-start-ct',
                image: 'url("file://{images}/mapdraft/pick_ct.png")',
                selectorimg: "file://{images}/mapdraft/green_check.png",
                name: "#CSGO_Inventory_Team_CT",
                statustext: '#matchdraft_vote_status_pick',
                ispick: _m_isThisPhasePick,
                voteid: _m_nCt
            });
            _MakeLargeMap(elContainer);
            _MakeButton(elContainer, {
                id: 'id-phase-5-btn-start-t',
                image: 'url("file://{images}/mapdraft/pick_t.png")',
                selectorimg: "file://{images}/mapdraft/green_check.png",
                name: "#CSGO_Inventory_Team_T",
                statustext: '#matchdraft_vote_status_pick',
                ispick: _m_isThisPhasePick,
                voteid: _m_nT
            });
        }
        else if (_m_nPhase === 6) {
            _MakeLargeMap(elContainer, 'map-draft-phase-pick-map-image--large');
        }
        else if (_m_nPhase < 5) {
            _m_isThisPhasePick = false;
            const aVoteIds = MatchDraftAPI.GetIngameMapIdsList().split(',');
            for (let i = 0; i < aVoteIds.length; i++) {
                const nVoteId = parseInt(aVoteIds[i]);
                const mapName = DeepStatsAPI.MapIDToString(nVoteId);
                if (_m_nPhase !== 4 ||
                    (_m_nPhase === 4 && MatchDraftAPI.GetIngameTeamToActNow() !== GameStateAPI.GetPlayerTeamNumber(MyPersonaAPI.GetXuid())) ||
                    (_m_nPhase === 4 && MatchDraftAPI.GetIngameTeamToActNow() === GameStateAPI.GetPlayerTeamNumber(MyPersonaAPI.GetXuid()) &&
                        MatchDraftAPI.GetIngameMapIdState(nVoteId) !== 'veto')) {
                    _MakeButton(elContainer, {
                        id: 'id-phase-' + _m_nPhase + '-btn-' + aVoteIds[i],
                        image: 'url("file://{images}/map_icons/screenshots/360p/' + mapName + '.png")',
                        selectorimg: "file://{images}/mapdraft/red_x.png",
                        name: '#SFUI_Map_' + mapName,
                        statustext: '#matchdraft_vote_status_ban',
                        ispick: _m_isThisPhasePick,
                        mapstatus: MatchDraftAPI.GetIngameMapIdState(nVoteId),
                        voteid: nVoteId
                    });
                }
            }
        }
    };
    const _MakeButton = function (elContainer, oBtnData) {
        let elButton = elContainer.FindChildInLayoutFile(oBtnData.id);
        if (!elButton) {
            elButton = $.CreatePanel('Button', elContainer, oBtnData.id);
            elButton.BLoadLayoutSnippet('ButtonMapTile');
            const bgImage = elButton.FindChildInLayoutFile('draft-phase-button-image');
            bgImage.style.backgroundImage = oBtnData.image;
            bgImage.style.backgroundPosition = '50% 0%';
            bgImage.style.backgroundSize = 'auto 100%';
            elButton.FindChildInLayoutFile('draft-phase-button-selectorimg').SetImage(oBtnData.selectorimg);
            elButton.SetDialogVariable('mapname', $.Localize(oBtnData.name));
            const elStatusText = elButton.FindChildInLayoutFile('draft-phase-button-statustext');
            elStatusText.text = $.Localize(oBtnData.statustext);
            elButton.SetPanelEvent('onactivate', () => _OnActivateVoteTile(elContainer, oBtnData));
            elButton.SetPanelEvent('onmouseover', function () {
                if (elButton.enabled) {
                    _PlaySoundEffect('UIPanorama.mainmenu_rollover');
                }
            });
            elButton.Data().voteid = oBtnData.voteid;
        }
        elButton.SetHasClass('map-draft-phase-button__status--positive', oBtnData.ispick);
        elButton.enabled = true;
        if (MatchDraftAPI.GetIngameTeamToActNow() !== GameStateAPI.GetPlayerTeamNumber(MyPersonaAPI.GetXuid()) ||
            oBtnData.hasOwnProperty('mapstatus') && oBtnData.mapstatus === 'veto') {
            elButton.SetHasClass('map-draft-phase-button--vetoed', oBtnData.mapstatus === 'veto');
            elButton.enabled = false;
            return;
        }
        const aVotedXuids = MatchDraftAPI.GetIngameXuidsForVote(Number(oBtnData.voteid)).split(',');
        elButton.SetHasClass('map-draft-phase-button--selected', aVotedXuids.indexOf(MyPersonaAPI.GetXuid()) !== -1);
        if (MatchDraftAPI.GetIngameXuidsForVote(Number(oBtnData.voteid))) {
            const aVoteIds = MatchDraftAPI.GetIngameWinningVotes().split(',');
            elButton.SetHasClass('map-draft-phase-button--winning-vote', aVoteIds.indexOf(oBtnData.voteid.toString()) !== -1);
        }
        else {
            elButton.SetHasClass('map-draft-phase-button--winning-vote', false);
        }
        const elAvatarsContainer = elButton.FindChildInLayoutFile('id-map-draft-phase-avatars-container');
        elAvatarsContainer.RemoveAndDeleteChildren();
        for (let i = 0; i < aVotedXuids.length; i++) {
            _MakeAvatar(aVotedXuids[i], elAvatarsContainer);
        }
    };
    const _OnActivateVoteTile = function (elContainer, oBtnData) {
        const aCurrentVotes = _GetCurrentVotes();
        const matchingVoteSlot = aCurrentVotes.indexOf(oBtnData.voteid);
        if (matchingVoteSlot !== -1) {
            MatchDraftAPI.ActionIngameCastMyVote(_m_nPhase, matchingVoteSlot, 0);
            _PlaySoundEffect('buymenu_select');
            return;
        }
        const aBtns = elContainer.Children().filter(btn => btn.Data().voteid);
        if (aBtns.length < 3) {
            MatchDraftAPI.ActionIngameCastMyVote(_m_nPhase, 0, oBtnData.voteid);
            _PlaySoundEffect('buymenu_purchase');
            return;
        }
        const freeSlot = _GetFirstFreeVoteSlot(aCurrentVotes);
        if (freeSlot !== null) {
            MatchDraftAPI.ActionIngameCastMyVote(_m_nPhase, freeSlot, oBtnData.voteid);
            _PlaySoundEffect('buymenu_purchase');
        }
        else {
            aBtns.forEach(function (btn) {
                if (btn.BHasClass('map-draft-phase-button--selected')) {
                    btn.RemoveClass('map-draft-phase-button--pulse');
                    btn.AddClass('map-draft-phase-button--pulse');
                }
            });
            _PlaySoundEffect('buymenu_failure');
        }
    };
    const _GetCurrentVotes = function () {
        const aCurrentVotes = [];
        for (let i = 0; i < _GetNumVoteSlots(); i++) {
            const voteId = MatchDraftAPI.GetIngameMyVoteInSlot(i) || "empty";
            aCurrentVotes.push(voteId);
        }
        return aCurrentVotes;
    };
    const _GetFirstFreeVoteSlot = function (aCurrentVotes) {
        for (let i = 0; i < aCurrentVotes.length; i++) {
            if (aCurrentVotes[i] === 'empty') {
                return i;
            }
        }
        return null;
    };
    const _GetNumVoteSlots = function () {
        if (_m_nPhase === 1 || _m_nPhase === 5) {
            return 1;
        }
        if (_m_nPhase === 2) {
            return 2;
        }
        if (_m_nPhase === 3) {
            return 3;
        }
        if (_m_nPhase === 4) {
            return 1;
        }
        return 0.;
    };
    const _UpdateActionText = function () {
        const isWaiting = MatchDraftAPI.GetIngameTeamToActNow() !== GameStateAPI.GetPlayerTeamNumber(MyPersonaAPI.GetXuid());
        _m_cp.FindChildInLayoutFile('id-map-draft-phase-info').SetHasClass('map-draft-phase-info--hidden', isWaiting);
        _m_cp.FindChildInLayoutFile('id-map-draft-phase-waiting').SetHasClass('map-draft-phase-info--hidden', !isWaiting);
        if (isWaiting) {
            _m_cp.FindChildInLayoutFile('id-map-draft-phase-wait').text = $.Localize('#matchdraft_phase_action_wait_' + _m_nPhase);
            return;
        }
        const elContainer = _m_rowsContainer.FindChildInLayoutFile(_m_rowPhaseName + _m_nPhase);
        const nPickedMaps = elContainer.Children().filter(btn => btn.BHasClass('map-draft-phase-button--selected'));
        _m_cp.SetDialogVariableInt('maps', nPickedMaps.length);
        _m_phaseTitleText.text = $.Localize('#matchdraft_phase_action_' + _m_nPhase, _m_cp);
    };
    const _MakeLargeMap = function (elContainer, style) {
        const aMapIds = MatchDraftAPI.GetIngameMapIdsList().split(',');
        const mapPickId = aMapIds.filter(id => MatchDraftAPI.GetIngameMapIdState(parseInt(id)) === 'pick')[0];
        const mapName = DeepStatsAPI.MapIDToString(parseInt(mapPickId));
        let elMapImage = elContainer.FindChildInLayoutFile('id-map-draft-phase-pick-map-image');
        if (!elMapImage) {
            elMapImage = $.CreatePanel('Panel', elContainer, 'id-map-draft-phase-pick-map-image');
            elMapImage.BLoadLayoutSnippet('FinalMapPick');
        }
        elMapImage.SetDialogVariable('mapname', $.Localize('#SFUI_Map_' + mapName));
        elMapImage.style.backgroundImage = 'url("file://{images}/map_icons/screenshots/360p/' + mapName + '.png")';
        elMapImage.style.backgroundPosition = '50% 0%';
        elMapImage.style.backgroundSize = 'auto 100%';
        elMapImage.style.backgroundImgOpacity = '.5';
        if (style) {
            elMapImage.AddClass(style);
            const nYourTeam = GameStateAPI.GetPlayerTeamNumber(MyPersonaAPI.GetXuid());
            const nOtherTeam = nYourTeam === _m_nT ? _m_nCt : _m_nT;
            const nStartingTeam = (MatchDraftAPI.GetIngameTeamWithFirstChoice() === MatchDraftAPI.GetIngameTeamStartingCT())
                ? nOtherTeam : nYourTeam;
            const teamLogo = nStartingTeam === _m_nT ? 't_logo.svg' : 'ct_logo.svg';
            const startingTeam = nStartingTeam === _m_nT ? '#CSGO_Inventory_Team_T' : '#CSGO_Inventory_Team_CT';
            elContainer.FindChildInLayoutFile('id-map-draft-starting-team').visible = true;
            elContainer.FindChildInLayoutFile('id-map-draft-starting-team-icon').SetImage("file://{images}/icons/" + teamLogo);
            elContainer.SetDialogVariable('teamname', $.Localize(startingTeam));
        }
    };
    function _PopulatePlayerList() {
        const yourXuid = MyPersonaAPI.GetXuid();
        const oPlayerList = GameStateAPI.GetPlayerDataJSO();
        const teamNames = ['TERRORIST', 'CT'];
        let iYourXuidTeamIdx = 1;
        for (let iTeam = 0; iTeam < teamNames.length; ++iTeam) {
            const teamName = teamNames[iTeam];
            let players = {};
            if (oPlayerList !== undefined && oPlayerList[teamName]) {
                players = oPlayerList[teamName];
            }
            if (iTeam === 0 && Object.values(players).indexOf(yourXuid) !== -1) {
                iYourXuidTeamIdx = 0;
            }
            const teamPanelId = (iYourXuidTeamIdx === iTeam) ? 'id-map-draft-phase-your-team' : 'id-map-draft-phase-other-team';
            const elTeammates = _m_cp.FindChildInLayoutFile(teamPanelId).FindChild('id-map-draft-phase-avatars');
            elTeammates.RemoveAndDeleteChildren();
            for (const j in players) {
                const xuid = players[j];
                if (!GameStateAPI.IsFakePlayer(xuid)) {
                    _MakeAvatar(xuid, elTeammates, true);
                }
            }
        }
    }
    const _CleanUpAvatars = function (xuids, elTeammates) {
        const listOfTeammatesPanels = elTeammates.Children();
        listOfTeammatesPanels.forEach(function (element) {
            if (xuids.indexOf(element.id) === -1 ||
                !GameStateAPI.IsPlayerConnected(element.id)) {
                element.AddClass('hidden');
            }
        });
        elTeammates.RemoveAndDeleteChildren();
    };
    const _MakeAvatar = function (xuid, elTeammates, bisTeamLister = false) {
        if (xuid === "0")
            return;
        if (xuid) {
            let elAvatar = elTeammates.FindChildInLayoutFile(xuid);
            const panelType = bisTeamLister ? 'Button' : 'Panel';
            if (!elAvatar || elAvatar.BHasClass('hidden')) {
                elAvatar = $.CreatePanel(panelType, elTeammates, xuid);
                elAvatar.BLoadLayoutSnippet('SmallAvatar');
                if (bisTeamLister) {
                    _AddOpenPlayerCardAction(elAvatar, xuid);
                }
            }
            elAvatar.FindChildTraverse('JsAvatarImage').PopulateFromSteamID(xuid);
            const teamColor = GameStateAPI.GetPlayerColor(xuid);
            const elTeamColor = elAvatar.FindChildInLayoutFile('JsAvatarTeamColor');
            if (!teamColor) {
                elTeamColor.visible = false;
            }
            else {
                elTeamColor.visible = true;
                elTeamColor.style.washColor = teamColor;
            }
            elAvatar.SetDialogVariable('teammate_name', FriendsListAPI.GetFriendName(xuid));
        }
    };
    const _AddOpenPlayerCardAction = function (elAvatar, xuid) {
        const openCard = function (xuid) {
            $.DispatchEvent('SidebarContextMenuActive', true);
            if (xuid !== "0") {
                const contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('', '', 'file://{resources}/layout/context_menus/context_menu_playercard.xml', 'xuid=' + xuid, function () {
                    $.DispatchEvent('SidebarContextMenuActive', false);
                });
                contextMenuPanel.AddClass("ContextMenu_NoArrow");
            }
        };
        elAvatar.SetPanelEvent("onactivate", () => openCard(xuid));
    };
    const m_eventHandles = [];
    function _OnReadyForDisplay() {
        m_eventHandles.push(['PanoramaComponent_IngameDraft_DraftUpdate', $.RegisterForUnhandledEvent('PanoramaComponent_IngameDraft_DraftUpdate', _Update)]);
        m_eventHandles.push(['UnloadLoadingScreenAndReinit', $.RegisterForUnhandledEvent('UnloadLoadingScreenAndReinit', _Update)]);
        m_eventHandles.push(['PlayerTeamChanged', $.RegisterForUnhandledEvent('PlayerTeamChanged', _PopulatePlayerList)]);
    }
    ;
    function _OnUnreadyForDisplay() {
        while (m_eventHandles.length > 0) {
            const h = m_eventHandles.pop();
            $.UnregisterForUnhandledEvent(h[0], h[1]);
        }
    }
    ;
    return {
        Update: _Update,
        PopulatePlayerList: _PopulatePlayerList,
        OnReadyForDisplay: _OnReadyForDisplay,
        OnUnreadyForDisplay: _OnUnreadyForDisplay,
    };
})();
(function () {
    $.RegisterEventHandler('ReadyForDisplay', $.GetContextPanel(), MapDraft.OnReadyForDisplay);
    $.RegisterEventHandler('UnreadyForDisplay', $.GetContextPanel(), MapDraft.OnUnreadyForDisplay);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWFwZHJhZnQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9tYXBkcmFmdC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsa0NBQWtDO0FBQ2xDLGtDQUFrQztBQUVsQyxNQUFNLFFBQVEsR0FBRyxDQUFFO0lBR2xCLE1BQU0sS0FBSyxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQztJQUNsQyxJQUFJLFNBQVMsR0FBRyxDQUFDLENBQUM7SUFDbEIsSUFBSSxtQkFBbUIsR0FBa0IsSUFBSSxDQUFDO0lBQzlDLElBQUksa0JBQWtCLEdBQUcsS0FBSyxDQUFDO0lBQy9CLE1BQU0saUJBQWlCLEdBQUcsS0FBSyxDQUFDLHFCQUFxQixDQUFFLHlCQUF5QixDQUFhLENBQUM7SUFDOUYsTUFBTSxnQkFBZ0IsR0FBRyxLQUFLLENBQUMscUJBQXFCLENBQUUseUJBQXlCLENBQUUsQ0FBQztJQUNsRixNQUFNLGVBQWUsR0FBRyxzQ0FBc0MsQ0FBQztJQUkvRCxNQUFNLEtBQUssR0FBRyxDQUFDLENBQUM7SUFDaEIsTUFBTSxNQUFNLEdBQUcsQ0FBQyxDQUFDO0lBRWpCLElBQUksdUJBQXVCLEdBQUcsQ0FBRSxJQUFJLElBQUksRUFBRSxDQUFFLENBQUMsT0FBTyxFQUFFLENBQUM7SUFDdkQsU0FBUyxnQkFBZ0IsQ0FBRyxjQUFzQixFQUFFLHFCQUE2QixDQUFDO1FBRWpGLE1BQU0sY0FBYyxHQUFHLENBQUUsSUFBSSxJQUFJLEVBQUUsQ0FBRSxDQUFDLE9BQU8sRUFBRSxDQUFDO1FBQ2hELElBQUssa0JBQWtCLElBQUksQ0FBRSxrQkFBa0IsR0FBRyxDQUFDLENBQUUsRUFDckQ7WUFDQyxJQUFLLGNBQWMsR0FBRyx1QkFBdUIsR0FBRyxrQkFBa0I7Z0JBQ2pFLE9BQU87U0FDUjtRQUVELENBQUMsQ0FBQyxhQUFhLENBQUUscUJBQXFCLEVBQUUsY0FBYyxFQUFFLE9BQU8s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