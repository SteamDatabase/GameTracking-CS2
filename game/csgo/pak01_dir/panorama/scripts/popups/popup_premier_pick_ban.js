"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../util_gamemodeflags.ts" />
/// <reference path="../common/formattext.ts" />
/// <reference path="../common/sessionutil.ts" />
/// <reference path="../common/teamcolor.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../rating_emblem.ts" />
/// <reference path="../avatar.ts" />_m_elPickBanPanel
var PremierPickBan;
(function (PremierPickBan) {
    let bStartTimer = false;
    let _m_nPhase = 0;
    let _m_pickedMapReveal = false;
    const TEAM_SPECTATOR = 1;
    const TEAM_TERRORIST = 2;
    const TEAM_CT = 3;
    const _m_aTeams = ['3', '2'];
    const _m_elPickBanPanel = $.GetContextPanel().FindChildInLayoutFile('id-premier-pick-ban');
    function Init() {
        $.RegisterForUnhandledEvent('PanoramaComponent_PregameDraft_DraftUpdate', OnDraftUpdate);
        $.RegisterForUnhandledEvent('PanoramaComponent_FriendsList_NameChanged', UpdateName);
        SetDefaultTimerValue();
        Show();
        OnDraftUpdate();
        UpdateActivePhaseTimerAndBar();
        const spiderGraph = _m_elPickBanPanel.FindChildInLayoutFile("id-team-vote-spider-graph");
        if (spiderGraph.BCanvasReady()) {
            DrawSpiderGraph();
        }
        else {
            $.RegisterEventHandler("CanvasReady", spiderGraph, DrawSpiderGraph);
        }
        let reflection = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-reflection');
        $.Schedule(1.1, function () { reflection.SetImageFromPanel(_m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-phasebar-container'), false); });
    }
    PremierPickBan.Init = Init;
    function Show() {
        _m_elPickBanPanel.SetHasClass('show', true);
    }
    function SetDefaultTimerValue() {
        let aChildren = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-phasebar-container').Children();
        aChildren.forEach(phase => {
            phase.SetDialogVariable('section-time', '');
        });
    }
    function OnDraftUpdate() {
        let bNewPhase = _m_nPhase !== MatchDraftAPI.GetPregamePhase();
        PlayNewPhaseSound(bNewPhase);
        _m_nPhase = MatchDraftAPI.GetPregamePhase();
        let mapIds = MatchDraftAPI.GetPregameMapIdsList().split(',');
        _m_elPickBanPanel.SwitchClass('pick-ban-phase', 'premier-pickban-phase-' + _m_nPhase);
        let btnMapSettings = {
            isTeam: false,
            list: mapIds,
            btnId: 'id-map-vote-btn-'
        };
        UpdateVoteBtns(btnMapSettings, bNewPhase);
        let btnSettings = {
            isTeam: true,
            list: _m_aTeams,
            btnId: 'id-team-vote-btn-'
        };
        UpdateVoteBtns(btnSettings, bNewPhase);
        UpdateTeamPanelBackground();
        UpdatePhaseProgressBar();
        UpdateTitleText(bNewPhase);
        SetBackgroundColor();
        PlayerTeam();
    }
    function SetBackgroundColor() {
        let elPanel = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-middle');
        if (_m_nPhase < 2) {
            elPanel.SwitchClass('bg-fade', 'premier-pickban__middle--neutral');
            return;
        }
        if (MatchDraftAPI.GetPregameTeamToActNow() === MatchDraftAPI.GetPregameMyTeam()) {
            elPanel.SwitchClass('bg-fade', 'premier-pickban__middle--light');
        }
        else {
            elPanel.SwitchClass('bg-fade', 'premier-pickban__middle--dark');
        }
    }
    function PlayNewPhaseSound(bNewPhase) {
        if (bNewPhase && _m_nPhase > 0 && _m_nPhase <= 4) {
            $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'UI.Premier.MapsLocked', 'MOUSE', 1.0);
        }
        else if (bNewPhase && _m_nPhase > 4) {
            $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'UI.Premier.SubmenuTransition', 'MOUSE', 1.0);
        }
    }
    function UpdatePhaseProgressBar() {
        let aChildren = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-phasebar-container').Children();
        aChildren.forEach(phase => {
            let nPhaseBarIndex = parseInt(phase.GetAttributeString('data-phase', ''));
            phase.SetDialogVariable('section-label', $.Localize('#matchdraft_phase_' + nPhaseBarIndex));
            phase.SetHasClass('premier-pickban__progress--ban', IsBanPhase() && nPhaseBarIndex === _m_nPhase);
            phase.SetHasClass('premier-pickban__progress--pick', !IsBanPhase() && nPhaseBarIndex === _m_nPhase);
            phase.SetHasClass('premier-pickban__progress--pre', nPhaseBarIndex > _m_nPhase);
            phase.SetHasClass('premier-pickban__progress--post', nPhaseBarIndex < _m_nPhase);
        });
    }
    function IsBanPhase() {
        return _m_nPhase > 1 && _m_nPhase < 5;
    }
    function UpdateActivePhaseTimerAndBar() {
        let nPlaySound = 0;
        $.Schedule(.5, () => {
            let elBarContainer = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-phasebar-' + _m_nPhase);
            if (elBarContainer) {
                let nTimeRemaining = MatchDraftAPI.GetPregamePhaseSecondsRemaining();
                nTimeRemaining = nTimeRemaining ? nTimeRemaining : 0;
                elBarContainer.SetDialogVariable('section-time', nTimeRemaining.toString());
                let percentComplete = 100 - Math.floor((nTimeRemaining / GetMaxTimeForPhase()) * 100);
                elBarContainer.FindChildInLayoutFile('id-team-phase-bar-inner').style.width = percentComplete + '%';
                if (nTimeRemaining < 5 && nPlaySound === 0) {
                    $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'UI.Premier.CounterTimer', 'MOUSE', 1.0);
                    nPlaySound++;
                }
                else
                    (nPlaySound > 0);
                {
                    nPlaySound = 0;
                }
            }
            UpdateActivePhaseTimerAndBar();
        });
    }
    ;
    function GetMaxTimeForPhase() {
        let timeMax = 0;
        switch (_m_nPhase) {
            case 0:
                timeMax = 0;
                break;
            case 1:
                timeMax = 0;
                break;
            case 2:
                timeMax = 15;
                break;
            case 3:
                timeMax = 20;
                break;
            case 4:
                timeMax = 10;
                break;
            case 5:
                timeMax = 10;
                break;
            case 6:
                timeMax = 5;
                break;
            default:
                timeMax = 0;
                break;
        }
        return timeMax;
    }
    function UpdateTitleText(bNewPhase) {
        let isWaiting = MatchDraftAPI.GetPregameTeamToActNow() !== MatchDraftAPI.GetPregameMyTeam() || _m_nPhase < 2;
        let sTitleText = isWaiting ? ('#matchdraft_phase_action_wait_' + _m_nPhase) :
            ('#matchdraft_phase_action_' + _m_nPhase);
        let elTitle = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-title-phase');
        _m_elPickBanPanel.SetHasClass('your-turn', !isWaiting);
        _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-title-spinner').SetHasClass('hide', !isWaiting);
        elTitle.visible = true;
        if (bNewPhase) {
            _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-title').TriggerClass('premier-pickban__title--change');
        }
        if (isWaiting) {
            elTitle.text = $.Localize('#matchdraft_phase_action_wait_' + _m_nPhase);
            return;
        }
        let nPickedMaps = GetCurrentVotes().filter(vote => vote !== -1).length;
        elTitle.SetDialogVariableInt('maps', nPickedMaps);
        elTitle.text = $.Localize('#matchdraft_phase_action_' + _m_nPhase, elTitle);
    }
    function UpdateVoteBtns(btnSettings, bNewPhase) {
        let aVoteIds = btnSettings.list;
        let btnId = btnSettings.btnId;
        if (aVoteIds.length > 1) {
            for (let i = 0; i < aVoteIds.length; i++) {
                const elMapBtnParent = _m_elPickBanPanel.FindChildInLayoutFile(btnId + i);
                const elMapBtn = elMapBtnParent.FindChild('id-pickban-btn');
                if (!elMapBtn.Data().voteId) {
                    let imageName = '';
                    let imagePath = '';
                    let backgroundColor = 'none;';
                    if (btnSettings.isTeam) {
                        let team = aVoteIds[i] === '3' ? "ct" : "t";
                        let charId = LoadoutAPI.GetItemID(team, 'customplayer');
                        imageName = InventoryAPI.GetItemInventoryImage(charId);
                        imagePath = 'url("file://{images}' + imageName + '.png")';
                        elMapBtn.SetDialogVariable('map-name', $.Localize('#SFUI_InvUse_Equipped_' + team));
                        elMapBtn.Data().isTeamBtn = true;
                        let elReflection = _m_elPickBanPanel.FindChildInLayoutFile(btnId + 'ref-' + i);
                        elReflection.SetImageFromPanel(elMapBtnParent, false);
                        backgroundColor = team === 'ct' ? 'rgb(150, 200, 250);' : '#eabe54;';
                    }
                    else {
                        imageName = DeepStatsAPI.MapIDToString(parseInt(aVoteIds[i]));
                        imagePath = 'url("file://{images}/map_icons/screenshots/360p/' + imageName + '.png")';
                        elMapBtn.SetDialogVariable('map-name', $.Localize('#SFUI_Map_' + imageName));
                        elMapBtn.Data().isTeamBtn = false;
                        let elReflection = _m_elPickBanPanel.FindChildInLayoutFile(btnId + 'ref-' + i);
                        elReflection.SetImageFromPanel(elMapBtnParent, false);
                    }
                    let elBtnMapImage = elMapBtn.FindChildInLayoutFile('id-pickban-map-btn-bg');
                    elBtnMapImage.style.backgroundImage = imagePath;
                    elBtnMapImage.style.backgroundPosition = '50% 50%';
                    elBtnMapImage.style.backgroundSize = 'cover';
                    elBtnMapImage.style.backgroundColor = backgroundColor;
                    elMapBtn.Data().voteId = aVoteIds[i];
                    elMapBtn.SetPanelEvent('onactivate', () => onActivateCastVote(elMapBtn));
                }
                if (bNewPhase) {
                    elMapBtn.SetHasClass('is-ban-phase', false);
                    elMapBtn.SetHasClass('is-vote-phase', false);
                }
                let isMyTurn = MatchDraftAPI.GetPregameTeamToActNow() === MatchDraftAPI.GetPregameMyTeam();
                if (btnSettings.isTeam) {
                    elMapBtn.enabled = isMyTurn;
                    if (_m_nPhase === 6) {
                        elMapBtn.SetHasClass('premier-pickban-pick', parseInt(aVoteIds[i]) === GetStartingTeam());
                    }
                }
                else {
                    let mapState = MatchDraftAPI.GetPregameMapIdState(parseInt(elMapBtn.Data().voteId));
                    elMapBtn.SetHasClass('premier-pickban-' + mapState, mapState !== '');
                    elMapBtn.enabled = mapState === '' && isMyTurn;
                    if (_m_nPhase >= 5 && !_m_pickedMapReveal) {
                        elMapBtnParent.SetHasClass("premier-pickban__map-btn--picked", mapState === "pick");
                        elMapBtnParent.SetHasClass("not-picked", mapState !== "pick");
                        let elReflection = _m_elPickBanPanel.FindChildInLayoutFile(btnId + 'ref-' + i);
                        elReflection.visible = false;
                    }
                }
                let sXuids = MatchDraftAPI.GetPregameXuidsForVote(parseInt(elMapBtn.Data().voteId));
                if (sXuids) {
                    let aVoteIds = MatchDraftAPI.GetPregameWinningVotes().split(',');
                    elMapBtn.SetHasClass('map-draft-phase-button--winning-vote', aVoteIds.indexOf(elMapBtn.Data().voteId) !== -1);
                }
                UpdateWinningVote(elMapBtn, aVoteIds[i], isMyTurn);
                UpdateBtnAvatars(elMapBtnParent, parseInt(aVoteIds[i]), isMyTurn);
            }
        }
    }
    function onActivateCastVote(elMapBtn) {
        let aCurrentVotes = GetCurrentVotes();
        let matchingVoteSlot = aCurrentVotes.indexOf(parseInt(elMapBtn.Data().voteId));
        if (matchingVoteSlot !== -1) {
            MatchDraftAPI.ActionPregameCastMyVote(_m_nPhase, matchingVoteSlot, 0);
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.Premier.MapDeselect', 'MOUSE');
            return;
        }
        if (elMapBtn.Data().isTeamBtn) {
            for (let i = 0; i < 2; i++) {
                let elBtn = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-btn-' + i).FindChild('id-pickban-btn');
                elBtn.checked = false;
                elBtn.SetHasClass('is-vote-phase', false);
            }
            MatchDraftAPI.ActionPregameCastMyVote(_m_nPhase, 0, parseInt(elMapBtn.Data().voteId));
            elMapBtn.checked = true;
            elMapBtn.SetHasClass('is-vote-phase', true);
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.Premier.TeamSelect', 'MOUSE');
            return;
        }
        let freeSlot = GetFirstFreeVoteSlot(aCurrentVotes);
        if (freeSlot !== null) {
            MatchDraftAPI.ActionPregameCastMyVote(_m_nPhase, freeSlot, parseInt(elMapBtn.Data().voteId));
            elMapBtn.SetHasClass('is-ban-phase', IsBanPhase());
            elMapBtn.SetHasClass('is-vote-phase', !IsBanPhase());
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.Premier.MapSelect', 'MOUSE');
        }
        else {
            elMapBtn.checked = false;
            let aBtns = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-btns-container').Children();
            aBtns.forEach(function (btn) {
                if (btn.id.indexOf('ref') === -1) {
                    let childBtn = btn.FindChild('id-pickban-btn');
                    if (childBtn.IsSelected() && childBtn.enabled) {
                        btn.TriggerClass('map-draft-phase-button--pulse');
                    }
                }
            });
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.buymenu_failure', 'MOUSE');
        }
    }
    function GetCurrentVotes() {
        let aCurrentVotes = [];
        for (let i = 0; i < GetNumVoteSlots(); i++) {
            let voteId = MatchDraftAPI.GetPregameMyVoteInSlot(i);
            voteId = voteId ? voteId : -1;
            aCurrentVotes.push(voteId);
        }
        return aCurrentVotes;
    }
    function GetFirstFreeVoteSlot(aCurrentVotes) {
        for (let i = 0; i < aCurrentVotes.length; i++) {
            if (aCurrentVotes[i] === -1) {
                return i;
            }
        }
        return null;
    }
    function GetNumVoteSlots() {
        if (_m_nPhase === 2) {
            return 2;
        }
        if (_m_nPhase === 3) {
            return 3;
        }
        if (_m_nPhase === 4) {
            return 1;
        }
        if (_m_nPhase === 5) {
            return 1;
        }
        return 0;
    }
    function UpdateWinningVote(elButton, voteId, isMyTurn) {
        if (MatchDraftAPI.GetPregameXuidsForVote(parseInt(voteId)) && isMyTurn) {
            let statusText = elButton.Data().isTeamBtn ? $.Localize('#matchdraft_vote_status_pick') : $.Localize('#matchdraft_vote_status_ban');
            elButton.SetDialogVariable('status', statusText);
            let aVoteIds = MatchDraftAPI.GetPregameWinningVotes().split(',');
            elButton.SetHasClass('premier-pickban__map-btn__show-status', aVoteIds.indexOf(voteId) !== -1);
            elButton.SetHasClass('is-team-pick', elButton.Data().isTeamBtn);
        }
        else {
            elButton.SetHasClass('premier-pickban__map-btn__show-status', false);
        }
    }
    function GetSelectedMap() {
        let aMapIds = MatchDraftAPI.GetPregameMapIdsList().split(',');
        let mapPickId = aMapIds.filter(id => MatchDraftAPI.GetPregameMapIdState(parseInt(id)) === 'pick')[0];
        return DeepStatsAPI.MapIDToString(parseInt(mapPickId));
    }
    function GetStartingTeam() {
        let nYourTeam = MatchDraftAPI.GetPregameMyTeam();
        let nOtherTeam = nYourTeam === 2 ? 3 : 2;
        let nStartingTeam = (MatchDraftAPI.GetPregameTeamWithFirstChoice() === MatchDraftAPI.GetPregameTeamStartingCT())
            ? nOtherTeam : nYourTeam;
        return nStartingTeam;
    }
    function UpdateBtnAvatars(elBtn, voteId, isMyTurn) {
        let aVotedXuids = MatchDraftAPI.GetPregameXuidsForVote(voteId).split(',');
        let elAvatarsContainer = elBtn.FindChildInLayoutFile('id-pickban-btn-avatars');
        elAvatarsContainer.RemoveAndDeleteChildren();
        if (!isMyTurn) {
            return;
        }
        for (let i = 0; i < aVotedXuids.length; i++) {
            MakeAvatar(aVotedXuids[i], elAvatarsContainer);
        }
    }
    function MakeAvatar(xuid, elTeammates) {
        if (xuid === '0' || !xuid)
            return;
        if (xuid) {
            let elAvatar = $.CreatePanel('Panel', elTeammates, xuid);
            elAvatar.BLoadLayoutSnippet('small-avatar');
            let avatarImage = elAvatar.FindChildTraverse('JsAvatarImage');
            avatarImage.PopulateFromSteamID(xuid);
            const teamColorIdx = PartyListAPI.GetPartyMemberSetting(xuid, 'game/teamcolor');
            const teamColorRgb = TeamColor.GetTeamColor(Number(teamColorIdx));
            avatarImage.style.border = '2px solid rgb(' + teamColorRgb + ')';
            elAvatar.SetDialogVariable('teammate_name', FriendsListAPI.GetFriendName(xuid));
            return elAvatar;
        }
    }
    function SetPlayerRank(playerIdx, elAvatar) {
        let playerWindowStats = MatchDraftAPI.GetPregamePlayerWindowStatsObject(playerIdx);
        if (!elAvatar)
            return;
        let options = {
            root_panel: elAvatar,
            rating_type: 'Premier',
            do_fx: true,
            full_details: false,
            leaderboard_details: { score: playerWindowStats.rank_id }
        };
        RatingEmblem.SetXuid(options);
    }
    function MakeOpponentAvatar(elTeammates, indexOpponent) {
        let imgIndex = (indexOpponent < 9) ? ('0' + (indexOpponent + 1).toString()) : (indexOpponent + 1);
        let elAvatar = $.CreatePanel('Panel', elTeammates, indexOpponent.toString());
        elAvatar.BLoadLayoutSnippet('small-avatar-opponent');
        let elImage = elAvatar.FindChildInLayoutFile('id-avatar-opponent-avatar');
        elImage.SetImage('file://{images}/avatars/avatar_sub_' + imgIndex.toString() + '.psd');
        return elAvatar;
    }
    function UpdateTeamPanelBackground() {
        if (_m_nPhase >= 5) {
            let selectedMapName = GetSelectedMap();
            let imagePath = 'url("file://{images}/map_icons/screenshots/360p/' + selectedMapName + '.png")';
            UpdateCharacterModels('ct', 'rifle0');
            UpdateCharacterModels('t', 'smg0');
            $.Schedule(1, () => {
                let elMapIcon = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-map-icon');
                elMapIcon.SetImage('file://{images}/map_icons/map_icon_' + selectedMapName + '.svg');
                elMapIcon.AddClass('show');
                let elMapImage = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-map-image');
                elMapImage.style.backgroundImage = imagePath;
                elMapImage.style.backgroundPosition = '50% 50%';
                elMapImage.style.backgroundSize = 'cover';
                elMapImage.style.brightness = '.1;';
                elMapImage.style.backgroundImgOpacity = '1';
                _m_elPickBanPanel.FindChildInLayoutFile('id-pick-vote-team').AddClass('show');
            });
            if (_m_nPhase === 6) {
                for (let i = 0; i < _m_aTeams.length; i++) {
                    if (parseInt(_m_aTeams[i]) === GetStartingTeam()) {
                        let team = _m_aTeams[i] === '3' ? 'ct' : 't';
                        let elCharPanel = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-agent-' + team);
                        elCharPanel.SetHasClass('premier-pickban__map-btn--picked', true);
                    }
                }
            }
        }
    }
    function UpdateCharacterModels(team, slot) {
        let elCharPanel = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-agent-' + team);
        let charId = LoadoutAPI.GetItemID(team, 'customplayer');
        let glovesId = LoadoutAPI.GetItemID(team, 'clothing_hands');
        let weaponId = LoadoutAPI.GetItemID(team, slot);
        const settings = ItemInfo.GetOrUpdateVanityCharacterSettings(charId);
        settings.panel = elCharPanel;
        settings.weaponItemId = weaponId;
        CharacterAnims.PlayAnimsOnPanel(settings);
    }
    function _GetMapsList() {
        return Object.keys(FriendsListAPI.GetFriendCompetitivePremierWindowStatsObject("0"));
    }
    function ComputeAverageWindowStatsForTeam(teamID) {
        let averageWindowStats = {};
        let nCount = 0.0;
        let mapList = _GetMapsList();
        for (let i = 0; i < MatchDraftAPI.GetPregamePlayerCount(); i++) {
            let playerWindowStats = MatchDraftAPI.GetPregamePlayerWindowStatsObject(i);
            let thisTeamID = MatchDraftAPI.GetPregamePlayerTeam(i);
            if (thisTeamID != teamID)
                continue;
            nCount++;
            mapList.forEach(mapName => {
                let myWinCount = Number(Math.floor(playerWindowStats[mapName] || 0));
                let teamWinCount = Number(Math.floor(averageWindowStats[mapName] || 0));
                averageWindowStats[mapName] = myWinCount + teamWinCount;
            });
        }
        return averageWindowStats;
    }
    function DrawSpiderGraph() {
        let rankWindowStats_T = ComputeAverageWindowStatsForTeam(TEAM_TERRORIST);
        let rankWindowShape_T = Object.keys(rankWindowStats_T).map((mapName) => { return Number(rankWindowStats_T[mapName] | 0); });
        let rankWindowStats_CT = ComputeAverageWindowStatsForTeam(TEAM_CT);
        let rankWindowShape_CT = Object.keys(rankWindowStats_T).map((mapName) => { return Number(rankWindowStats_CT[mapName] | 0); });
        let maxWinsInASingleMap = (Math.max(...rankWindowShape_T, ...rankWindowShape_CT, 3));
        const spiderGraph = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-spider-graph');
        DrawBackground(spiderGraph, maxWinsInASingleMap);
        if (MatchDraftAPI.GetPregameMyTeam() === TEAM_CT) {
            DrawTeamPlot(spiderGraph, rankWindowShape_CT, true, maxWinsInASingleMap);
            DrawTeamPlot(spiderGraph, rankWindowShape_T, false, maxWinsInASingleMap);
        }
        else {
            DrawTeamPlot(spiderGraph, rankWindowShape_T, true, maxWinsInASingleMap);
            DrawTeamPlot(spiderGraph, rankWindowShape_CT, false, maxWinsInASingleMap);
        }
    }
    function DrawBackground(spiderGraph, maxWinsInASingleMap) {
        const numMaps = 7;
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
        spiderGraph.DrawGraphBackground(numMaps);
    }
    function DrawTeamPlot(spiderGraph, rankWindowShape, isMyTeam, max) {
        const oColorsMyTeam = {
            line_color: 'rgba( 100, 100, 100, 1.0);',
            fill_color_inner: 'rgba( 100, 100, 100, 0.5);'
        };
        const oColorsOpponent = {
            line_color: 'rgba( 219, 68, 55, 1.0);',
            fill_color_inner: 'rgba( 219, 68, 55, 0.5);'
        };
        rankWindowShape = rankWindowShape.map(a => a / max);
        const polyOptions = {
            line_color: isMyTeam ? oColorsMyTeam.line_color : oColorsOpponent.line_color,
            line_thickness: 3,
            line_softness: 10,
            fill_color_inner: isMyTeam ? oColorsMyTeam.fill_color_inner : oColorsOpponent.fill_color_inner,
            fill_color_outer: isMyTeam ? oColorsMyTeam.fill_color_inner : oColorsOpponent.fill_color_inner
        };
        spiderGraph.DrawGraphPoly(rankWindowShape, polyOptions);
    }
    function PlayerTeam() {
        let DEBUG_AVATARS = false;
        let aTestids = [
            '148618791998277666',
            '148618791998261669',
            '148618791998203739',
            '148618792083695883',
            '148618791998365706',
            '148618791998209668',
            '148618791998345670',
            '148618792154451370',
            '',
            '148618792083696093'
        ];
        let aTestGroups = [
            1,
            2,
            2,
            3,
            3,
            4,
            5,
            5,
            6,
            7
        ];
        let clientXuid = MyPersonaAPI.GetXuid();
        let aPlayers = [];
        let nCount = MatchDraftAPI.GetPregamePlayerCount();
        if (DEBUG_AVATARS) {
            nCount = 10;
        }
        for (let i = 0; i < nCount; i++) {
            if (DEBUG_AVATARS) {
                if (aTestGroups[i] >= 0) {
                    let player = {
                        xuid: aTestids[i],
                        nParty: aTestGroups[i],
                        idx: i,
                        isClient: aTestids[i] === clientXuid ? true : false
                    };
                    aPlayers.push(player);
                }
            }
            else {
                if (MatchDraftAPI.GetPregamePlayerParty(i) >= 0) {
                    let player = {
                        xuid: MatchDraftAPI.GetPregamePlayerXuid(i),
                        nParty: MatchDraftAPI.GetPregamePlayerParty(i),
                        idx: i,
                        isClient: MatchDraftAPI.GetPregamePlayerXuid(i) === clientXuid ? true : false
                    };
                    aPlayers.push(player);
                }
            }
        }
        if (aPlayers.length < 1) {
            return;
        }
        let indexClient = aPlayers.findIndex(object => { return object.isClient === true; });
        for (let i = 0; i < aPlayers.length; i++) {
            AddPlayerToGroup(aPlayers[i], indexClient);
        }
        AddPartyBoundryLines(_m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-team-teammates'));
        AddPartyBoundryLines(_m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-team-opponent'));
    }
    function AddPlayerToGroup(player, indexClient) {
        let isTeammate = (indexClient < 5 && player.idx < 5) || (indexClient >= 5 && player.idx >= 5);
        let elParent = isTeammate ?
            _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-team-teammates') :
            _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-team-opponent');
        let elContainer = elParent.FindChildInLayoutFile('id-player-party-container-' + player.nParty);
        if (!elContainer) {
            elContainer = $.CreatePanel('Panel', elParent, 'id-player-party-container-' + player.nParty, { class: 'premier-pickban__teammates-party' });
        }
        let elTeammate = isTeammate ? elParent.FindChildInLayoutFile(player.xuid) : elParent.FindChildInLayoutFile(player.idx.toString());
        if (!elTeammate) {
            if (isTeammate) {
                SetPlayerRank(player.idx, MakeAvatar(player.xuid, elContainer));
            }
            else {
                SetPlayerRank(player.idx, MakeOpponentAvatar(elContainer, player.idx));
            }
        }
    }
    function AddPartyBoundryLines(elParent) {
        elParent.Children().forEach(party => {
            let aPartyMembers = party.Children();
            if (aPartyMembers.length > 1) {
                aPartyMembers.forEach((element, index) => {
                    if (index === 0) {
                        element.FindChild('id-avatar-party-line')?.AddClass('premier-pickban__map-avatars__party-line-top');
                    }
                    else if (index === aPartyMembers.length - 1) {
                        element.FindChild('id-avatar-party-line')?.AddClass('premier-pickban__map-avatars__party-line-bottom');
                    }
                    else {
                        element.FindChild('id-avatar-party-line')?.AddClass('premier-pickban__map-avatars__party-line-middle');
                    }
                });
            }
            else if (aPartyMembers.length === 1) {
                aPartyMembers[0].FindChild('id-avatar-party-line')?.AddClass('premier-pickban__map-avatars__party-line-empty');
            }
        });
    }
    function UpdateName(xuid) {
        let elList = _m_elPickBanPanel.FindChildInLayoutFile('id-team-vote-team-teammates');
        let elAvatar = elList.FindChildInLayoutFile(xuid);
        if (elAvatar) {
            elAvatar.SetDialogVariable('teammate_name', FriendsListAPI.GetFriendName(xuid));
        }
    }
})(PremierPickBan || (PremierPickBan = {}));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfcHJlbWllcl9waWNrX2Jhbi5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL3BvcHVwcy9wb3B1cF9wcmVtaWVyX3BpY2tfYmFuLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUFDckMsaURBQWlEO0FBQ2pELGdEQUFnRDtBQUNoRCxpREFBaUQ7QUFDakQsK0NBQStDO0FBQy9DLDhDQUE4QztBQUM5Qyw0Q0FBNEM7QUFDNUMsc0RBQXNEO0FBRXRELElBQVUsY0FBYyxDQWs2QnZCO0FBbDZCRCxXQUFVLGNBQWM7SUFFdkIsSUFBSSxXQUFXLEdBQUcsS0FBSyxDQUFDO0lBQ3hCLElBQUksU0FBUyxHQUFXLENBQUMsQ0FBQztJQUMxQixJQUFJLGtCQUFrQixHQUFHLEtBQUssQ0FBQztJQUUvQixNQUFNLGNBQWMsR0FBRyxDQUFDLENBQUM7SUFDekIsTUFBTSxjQUFjLEdBQUcsQ0FBQyxDQUFDO0lBQ3pCLE1BQU0sT0FBTyxHQUFHLENBQUMsQ0FBQztJQUlsQixNQUFNLFNBQVMsR0FBRyxDQUFFLEdBQUcsRUFBRSxHQUFHLENBQUUsQ0FBQztJQUMvQixNQUFNLGlCQUFpQixHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxxQkFBcUIsQ0FBRSxxQkFBcUIsQ0FBRSxDQUFDO0lBUTdGLFNBQWdCLElBQUk7UUFFbkIsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLDRDQUE0QyxFQUFFLGFBQWEsQ0FBRSxDQUFDO1FBQzNGLENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSwyQ0FBMkMsRUFBRSxVQUFVLENBQUUsQ0FBQztRQU92RixvQkFBb0IsRUFBRSxDQUFDO1FBQ3ZCLElBQUksRUFBRSxDQUFDO1FBQ1AsYUFBYSxFQUFFLENBQUM7UUFDaEIsNEJBQTRCLEVBQUUsQ0FBQztRQUUvQixNQUFNLFdBQVcsR0FBRyxpQkFBaUIsQ0FBQyxxQkFBcUIsQ0FBRSwy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