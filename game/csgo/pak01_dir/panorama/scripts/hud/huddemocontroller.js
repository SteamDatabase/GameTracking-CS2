"use strict";
/// <reference path="../csgo.d.ts" />
var HudDemoController;
(function (HudDemoController) {
    function EatClick() {
        return true;
    }
    HudDemoController.EatClick = EatClick;
    let ObserverMode;
    (function (ObserverMode) {
        ObserverMode[ObserverMode["OBS_MODE_NONE"] = 0] = "OBS_MODE_NONE";
        ObserverMode[ObserverMode["OBS_MODE_FIXED"] = 1] = "OBS_MODE_FIXED";
        ObserverMode[ObserverMode["OBS_MODE_IN_EYE"] = 2] = "OBS_MODE_IN_EYE";
        ObserverMode[ObserverMode["OBS_MODE_CHASE"] = 3] = "OBS_MODE_CHASE";
        ObserverMode[ObserverMode["OBS_MODE_ROAMING"] = 4] = "OBS_MODE_ROAMING";
    })(ObserverMode || (ObserverMode = {}));
    let Team;
    (function (Team) {
        Team[Team["TEAM_TERRORIST"] = 2] = "TEAM_TERRORIST";
        Team[Team["TEAM_CT"] = 3] = "TEAM_CT";
    })(Team || (Team = {}));
    let DemoTimelineEvent;
    (function (DemoTimelineEvent) {
        DemoTimelineEvent[DemoTimelineEvent["EDemoTimelineEvent_Kill"] = 0] = "EDemoTimelineEvent_Kill";
        DemoTimelineEvent[DemoTimelineEvent["EDemoTimelineEvent_Death"] = 1] = "EDemoTimelineEvent_Death";
        DemoTimelineEvent[DemoTimelineEvent["EDemoTimelineEvent_DamageInflicted"] = 2] = "EDemoTimelineEvent_DamageInflicted";
        DemoTimelineEvent[DemoTimelineEvent["EDemoTimelineEvent_DamageReceived"] = 3] = "EDemoTimelineEvent_DamageReceived";
        DemoTimelineEvent[DemoTimelineEvent["EDemoTimelineEvent_TickMarker"] = 4] = "EDemoTimelineEvent_TickMarker";
    })(DemoTimelineEvent || (DemoTimelineEvent = {}));
    function TimelineEventToLabel(timelineEvent) {
        const labels = [
            "kill",
            "death",
            "dealt_damage",
            "received_damage",
            "tick"
        ];
        return labels[timelineEvent];
    }
    const timeStepSeconds = 15;
    const cp = $.GetContextPanel();
    cp.SetDialogVariableInt("timestep_value", timeStepSeconds);
    const slider = $("#Slider");
    const speedSlider = $("#SpeedSlider");
    const timescale = $("#TimeScale");
    const PlayerListPanel = $("#PlayerList");
    const RoundMenuPanel = $("#RoundMenu");
    const playButton = $("#PlayButton");
    const XRayToggleButton = $("#XRayToggleButton");
    const TrueViewToggleButton = $("#TrueViewToggleButton");
    const TrueViewDOACheckBox = $("#TrueViewDOACheckBox");
    const TrueViewDOAToggleButton = $("#TrueViewDOAToggleButton");
    const TrueViewWrongVersionCheckBox = $("#TrueViewWrongVersionCheckBox");
    const TrueViewWrongVersionToggleButton = $("#TrueViewWrongVersionToggleButton");
    const SettingsPanel = $("#Settings");
    const speedStops = [0, 0.1, 0.25, 0.5, 1, 2, 4];
    const nSpeedStopNormal = speedStops.indexOf(1);
    speedSlider.min = 0;
    speedSlider.max = speedStops.length - 1;
    speedSlider.increment = 1;
    function ShowEndPlaybackTooltip() {
        if (lastState?.bIsOverwatch)
            return;
        UiToolkitAPI.ShowTextTooltip('EndPlayback', '#CSGO_Demo_End_Playback');
    }
    HudDemoController.ShowEndPlaybackTooltip = ShowEndPlaybackTooltip;
    function ShowPlayButtonTooltip() {
        UiToolkitAPI.ShowTextTooltip(playButton.id, cp.BHasClass("paused") ? '#tooltip_demo_play' : '#tooltip_demo_pause');
    }
    HudDemoController.ShowPlayButtonTooltip = ShowPlayButtonTooltip;
    const hud = cp.GetParent();
    $.RegisterForUnhandledEvent("DemoToggleUI", () => {
        if (!cp.IsPlayingDemo())
            return;
        if (lastState && lastState.bIsPlayingBroadcast)
            return;
        if (lastState && lastState.bIsOverwatch)
            return;
        if (hud.BHasClass("DemoControllerMinimal")) {
            hud.SetHasClass("DemoControllerMinimal", false);
            hud.SetHasClass("DemoControllerFull", true);
        }
        else if (hud.BHasClass("DemoControllerFull")) {
            hud.SetHasClass("DemoControllerMinimal", false);
            hud.SetHasClass("DemoControllerFull", false);
        }
        else {
            hud.SetHasClass("DemoControllerMinimal", true);
            hud.SetHasClass("DemoControllerFull", false);
        }
    });
    $.RegisterForUnhandledEvent("DemoSetHUDVisible", (bVisible) => {
        if (!cp.IsPlayingDemo())
            return;
        hud.SetHasClass("hide", !bVisible);
    });
    $.RegisterForUnhandledEvent("DemoSetMouseEnabled", (bEnabled) => {
        if (!cp.IsPlayingDemo())
            return;
        cp.SetHasClass("mouseActive", bEnabled);
    });
    let lastState = null;
    let bRoundsMarked = false;
    let bAtEndOfPlayback = false;
    let nSpectatingPlayerId = -1;
    let bHighlightsMode = false;
    function FrameUpdate() {
        const state = cp.GetDemoControllerState();
        if (state == null) {
            hud.SetHasClass("DemoControllerMinimal", false);
            hud.SetHasClass("DemoControllerFull", false);
            lastState = null;
            $.Schedule(1, FrameUpdate);
            return;
        }
        const nFinalTick = state.bIsPlayingHighlights && state.HighlightIntervals ?
            state.HighlightIntervals.at(-1)?.nTickEnd :
            state.RoundIntervals.at(-1)?.nTickEnd;
        const bStateAtEndOfPlayback = nFinalTick != undefined && state.nTick >= nFinalTick;
        if (bStateAtEndOfPlayback != bAtEndOfPlayback) {
            if (state.bIsOverwatch) {
                const sEndPlayback = bStateAtEndOfPlayback ?
                    $.Localize('#CSGO_Demo_End_Playback_Overwatch_Finished') :
                    $.Localize('#CSGO_Demo_End_Playback_Overwatch');
                cp.SetDialogVariable('end-playback', sEndPlayback);
            }
            bAtEndOfPlayback = bStateAtEndOfPlayback;
        }
        if (!cp.visible || !cp.BReadyForDisplay() || !cp.IsSizeValid()) {
            $.Schedule(1, FrameUpdate);
            return;
        }
        $.Schedule(0, FrameUpdate);
        let bStateChanged = false;
        if (lastState == null || lastState.sFileName !== state.sFileName) {
            bRoundsMarked = false;
            bStateChanged = true;
            let sFileName = state.sFileName.replaceAll("\\", "/");
            let nSlashIndex = sFileName.lastIndexOf("/");
            if (nSlashIndex !== -1)
                sFileName = sFileName.substring(nSlashIndex + 1);
            cp.SetDialogVariable("total_time", TicksToTimeText(state.nTotalTicks, state.nSecondsPerTick));
            if (state?.bIsPlayingBroadcast) {
                hud.SetHasClass("DemoControllerHidden", false);
                hud.SetHasClass("DemoControllerMinimal", false);
                hud.SetHasClass("DemoControllerFull", false);
            }
            else {
                let nUIMode = Number(GameInterfaceAPI.GetSettingString("demo_ui_mode"));
                hud.SetHasClass("DemoControllerHidden", nUIMode == 0);
                hud.SetHasClass("DemoControllerMinimal", nUIMode == 1);
                hud.SetHasClass("DemoControllerFull", nUIMode == 2);
            }
            OnHighlightsModeChanged(state.bIsPlayingHighlights);
            bHighlightsMode = state.bIsPlayingHighlights;
            const sEndPlayback = state.bIsOverwatch ?
                $.Localize('#CSGO_Demo_End_Playback_Overwatch') :
                $.Localize('#CSGO_Demo_Quit');
            cp.SetDialogVariable('end-playback', sEndPlayback);
        }
        lastState = state;
        const pMarkers = $("#RoundMarkers");
        if (pMarkers.actuallayoutwidth > 0 && !bRoundsMarked) {
            bRoundsMarked = true;
            pMarkers.RemoveAndDeleteChildren();
            const pThumb = $("#SliderThumb");
            const nThumbWidth = pThumb.actuallayoutwidth / pThumb.actualuiscale_x;
            const nMarkersWidth = (pMarkers.actuallayoutwidth / pThumb.actualuiscale_x) - nThumbWidth;
            for (let i = 0; i < state.RoundIntervals.length; i++) {
                const nStartTick = state.RoundIntervals[i].nTickStart;
                const nEndTick = state.RoundIntervals[i].nTickEnd;
                let nLeft = nStartTick / state.nTotalTicks * nMarkersWidth + nThumbWidth / 2;
                let nWidth = (nEndTick - nStartTick) / state.nTotalTicks * nMarkersWidth;
                if (i === 0) {
                    nWidth += nLeft;
                    nLeft = 0;
                }
                else if (i === state.RoundIntervals.length - 1) {
                    nWidth += nThumbWidth / 2;
                }
                const className = i % 2 === 0 ? "roundMarker even" : "roundMarker odd";
                const pMarker = $.CreatePanel("Panel", pMarkers, "", { class: className });
                pMarker.style.position = `${nLeft}px 0 0`;
                pMarker.style.width = nWidth + "px";
            }
        }
        if (nSpectatingPlayerId != state.nSpectatingPlayerId) {
            CreateHighlightIntervals();
            CreateTimelineEvents();
            nSpectatingPlayerId = state.nSpectatingPlayerId;
            $("#HighlightsButton")?.SetHasClass("hide", !ShouldShowHighlightsButton());
        }
        if ((state.bIsPlayingHighlights != bHighlightsMode) || bStateChanged) {
            OnHighlightsModeChanged(state.bIsPlayingHighlights);
            bHighlightsMode = state.bIsPlayingHighlights;
        }
        cp.SetHasClass("paused", state.bIsPaused);
        $("#HighlightsButton").SetHasClass("disabled", IsHighlightsToggleDisabled());
        UpdateCameraModeLabel(state.nObserverMode);
        UpdateSpectatedPlayerName();
        slider.min = 0;
        slider.max = state.nTotalTicks;
        if (!slider.mousedown) {
            slider.value = state.nTick;
            SetCurrentTimeText(state.nTick);
            SetRoundNumberLabel();
        }
        CreateSpeedTicks();
        if (!speedSlider.mousedown) {
            speedSlider.SetValueNoEvents(state.bIsPaused ? 0 : TimeScaleToSpeedStop(state.fTimeScale));
        }
        timescale.text = SpeedToText(state.bIsPaused ? 0 : state.fTimeScale);
        if (PlayerListPanel.BHasClass("Visible")) {
            UpdatePlayerList();
        }
        const bSettingsVisible = cp.BHasClass("SettingsVisible");
        if (bSettingsVisible) {
            SettingsPanel.AddClass("Visible");
            const spec_show_xray = parseInt(GameInterfaceAPI.GetSettingString("spec_show_xray"));
            XRayToggleButton.SetSelected(spec_show_xray != 0);
            const cl_demo_predict = parseInt(GameInterfaceAPI.GetSettingString("cl_demo_predict"));
            const cl_trueview_show_doa_predictions = parseInt(GameInterfaceAPI.GetSettingString("cl_trueview_show_doa_predictions"));
            TrueViewToggleButton.SetSelected(cl_demo_predict > 0);
            TrueViewDOAToggleButton.SetSelected(cl_trueview_show_doa_predictions != 0);
            TrueViewDOACheckBox.enabled = cl_demo_predict > 0;
            TrueViewWrongVersionCheckBox.enabled = cl_demo_predict > 0;
            if (cl_demo_predict > 0) {
                TrueViewWrongVersionToggleButton.SetSelected(cl_demo_predict >= 2);
            }
        }
        else {
            SettingsPanel.RemoveClass("Visible");
        }
        const cl_demo_predict = parseInt(GameInterfaceAPI.GetSettingString("cl_demo_predict"));
    }
    $.Schedule(0, FrameUpdate);
    $.RegisterEventHandler("SliderReleased", slider, (_, fValue) => {
        if (lastState == null)
            return true;
        SetCurrentTimeText(fValue);
        SetRoundNumberLabel();
        cp.GotoTick(Math.floor(fValue));
        return true;
    });
    $.RegisterEventHandler("SliderValueChanged", slider, (_, fValue) => {
        if (lastState == null)
            return true;
        SetCurrentTimeText(fValue);
        SetRoundNumberLabel();
        return true;
    });
    $.RegisterEventHandler("SliderValueChanged", speedSlider, (_, fValue) => {
        const nStop = Math.round(fValue);
        if (nStop != fValue) {
            speedSlider.SetValueNoEvents(nStop);
        }
        SetPlaybackSpeedStop(nStop);
        return true;
    });
    function OnPlayClicked() {
        const nStop = cp.BHasClass("paused") ? nSpeedStopNormal : 0;
        speedSlider.SetValueNoEvents(nStop);
        SetPlaybackSpeedStop(nStop);
        ShowPlayButtonTooltip();
        return true;
    }
    HudDemoController.OnPlayClicked = OnPlayClicked;
    function SetPlaybackSpeedStop(nStop) {
        const fSpeed = speedStops[nStop];
        const bWasPaused = cp.BHasClass("paused");
        if (fSpeed == 0) {
            cp.SetPaused(true);
        }
        else {
            cp.SetDemoTimeScale(fSpeed);
            if (bWasPaused)
                cp.SetPaused(false);
        }
        cp.SetHasClass("paused", fSpeed == 0);
        timescale.text = SpeedToText(fSpeed);
    }
    let sSpeedTicksLayout = "";
    function CreateSpeedTicks() {
        const pTicks = $("#SpeedTicks");
        const pThumb = speedSlider.FindChildTraverse("SliderThumb");
        if (!pThumb || pTicks.actuallayoutwidth <= 0 || pThumb.actuallayoutwidth <= 0)
            return;
        const sLayout = `${pTicks.actuallayoutwidth}:${pThumb.actuallayoutwidth}:${pTicks.actualuiscale_x}`;
        if (sLayout == sSpeedTicksLayout)
            return;
        sSpeedTicksLayout = sLayout;
        pTicks.RemoveAndDeleteChildren();
        const nThumbWidth = pThumb.actuallayoutwidth / pThumb.actualuiscale_x;
        const nTravelWidth = (pTicks.actuallayoutwidth / pTicks.actualuiscale_x) - nThumbWidth;
        for (let i = 0; i < speedStops.length; i++) {
            if (speedStops[i] == 0) {
                const nPauseWidth = 12;
                const nPauseLeft = (i / (speedStops.length - 1)) * nTravelWidth + nThumbWidth / 2 - nPauseWidth / 2;
                const pPause = $.CreatePanel("Image", pTicks, "", { class: "speed-tick-pause", src: "file://{images}/icons/ui/pause.svg" });
                pPause.style.marginLeft = `${nPauseLeft}px`;
                continue;
            }
            if (speedStops[i] >= 1) {
                const nArrowWidth = 5;
                const nArrowOverlap = 2;
                const nArrows = speedStops[i];
                const nRowWidth = nArrowWidth + (nArrows - 1) * (nArrowWidth - nArrowOverlap);
                const nArrowsLeft = (i / (speedStops.length - 1)) * nTravelWidth + nThumbWidth / 2 - nRowWidth / 2;
                const pArrows = $.CreatePanel("Panel", pTicks, "", { class: "speed-tick-arrows" });
                pArrows.style.marginLeft = `${nArrowsLeft}px`;
                for (let nArrow = 0; nArrow < nArrows; nArrow++) {
                    const pArrow = $.CreatePanel("Image", pArrows, "", { class: "speed-tick-arrow", src: "file://{images}/icons/ui/message_arrow.svg" });
                    if (nArrow > 0)
                        pArrow.style.marginLeft = `${-nArrowOverlap}px`;
                }
                continue;
            }
            const nTickWidth = i;
            const nLeft = (i / (speedStops.length - 1)) * nTravelWidth + nThumbWidth / 2 - nTickWidth / 2;
            const pTick = $.CreatePanel("Panel", pTicks, "", { class: "speed-tick" });
            pTick.style.width = `${nTickWidth}px`;
            pTick.style.marginLeft = `${nLeft}px`;
        }
    }
    function TimeScaleToSpeedStop(fTimeScale) {
        let nBest = 1;
        for (let i = 2; i < speedStops.length; i++) {
            if (Math.abs(speedStops[i] - fTimeScale) < Math.abs(speedStops[nBest] - fTimeScale))
                nBest = i;
        }
        return nBest;
    }
    function SpeedToText(fSpeed) {
        if (fSpeed == 0)
            return $.Localize('#CSGO_Demo_Paused');
        return parseFloat(fSpeed.toFixed(4)).toString() + "x";
    }
    function SetCurrentTimeText(nTick) {
        if (!lastState)
            return;
        cp.SetDialogVariable("current_time", TicksToTimeText(nTick, lastState.nSecondsPerTick));
        cp.SetDialogVariable("current_tick", Math.floor(nTick).toString().padStart(6, "0"));
    }
    function UpdateCameraModeLabel(nObserverMode) {
        let sMode = '#CSGO_Demo_Camera_FirstPerson';
        if (nObserverMode == ObserverMode.OBS_MODE_CHASE)
            sMode = '#CSGO_Demo_Camera_Chase';
        else if (nObserverMode == ObserverMode.OBS_MODE_ROAMING)
            sMode = '#CSGO_Demo_Camera_Free';
        $("#CameraModeLabel").text = $.Localize(sMode);
    }
    let nSpectatedPlayerSlot = -2;
    let nSpectatedPawnId = -2;
    let flNextPlayerNameRefresh = 0;
    function UpdateSpectatedPlayerName() {
        const flNow = Date.now();
        const nPawnId = lastState ? lastState.nSpectatingPlayerId : -1;
        if (nPawnId == nSpectatedPawnId && flNow < flNextPlayerNameRefresh)
            return;
        nSpectatedPawnId = nPawnId;
        flNextPlayerNameRefresh = flNow + 500;
        const player = nPawnId >= 0 ? cp.GetDemoPlayers().find(p => p.nPawnEntIndex == nPawnId) : undefined;
        const pName = $("#PlayerName");
        pName.SetHasClass("team-ct", player?.nTeam == Team.TEAM_CT);
        pName.SetHasClass("team-t", player?.nTeam == Team.TEAM_TERRORIST);
        const nSlot = player ? player.nPlayerSlot : -1;
        if (nSlot == nSpectatedPlayerSlot)
            return;
        nSpectatedPlayerSlot = nSlot;
        if (player) {
            pName.SetDialogVariableInt("player_slot", nSlot);
            pName.SetLocString("#CSGO_Demo_Player_Name");
        }
        else {
            pName.SetLocString("#CSGO_Demo_Player_None");
        }
    }
    function TogglePlayerListVisible() {
        const bVisible = !PlayerListPanel.BHasClass("Visible");
        PlayerListPanel.SetHasClass("Visible", bVisible);
        if (bVisible) {
            cp.RemoveClass("SettingsVisible");
            SetRoundMenuVisible(false);
            sPlayerListSignature = "";
            UpdatePlayerList();
            const pName = $("#PlayerName");
            const pos = pName.GetPositionWithinAncestor(cp);
            PlayerListPanel.style.marginLeft = (pos.x / pName.actualuiscale_x) + "px";
        }
    }
    HudDemoController.TogglePlayerListVisible = TogglePlayerListVisible;
    let sPlayerListSignature = "";
    function UpdatePlayerList() {
        const players = cp.GetDemoPlayers();
        const SortName = (p) => p.sName.toLowerCase();
        players.sort((a, b) => (a.nTeam - b.nTeam) || (SortName(a) < SortName(b) ? -1 : SortName(a) > SortName(b) ? 1 : 0));
        const sSignature = players.map(p => `${p.nEntIndex}:${p.nPawnEntIndex}:${p.bAlive}:${p.nTeam}:${p.sName}`).join("|") + `#${lastState?.nSpectatingPlayerId}`;
        if (sSignature == sPlayerListSignature)
            return;
        sPlayerListSignature = sSignature;
        PlayerListPanel.RemoveAndDeleteChildren();
        for (const player of players) {
            const pEntry = $.CreatePanel("Panel", PlayerListPanel, "", { class: "player-list-entry interactive" });
            $.CreatePanel("Image", pEntry, "", { class: "player-list-skull", src: "file://{images}/icons/ui/kill.svg" });
            const pName = $.CreatePanel("Label", pEntry, "", { class: "player-list-name", html: "true" });
            pName.SetDialogVariableInt("player_slot", player.nPlayerSlot);
            pName.SetLocString("#CSGO_Demo_Player_Name");
            pEntry.SetHasClass("dead", !player.bAlive);
            pEntry.SetHasClass("team-ct", player.nTeam == Team.TEAM_CT);
            pEntry.SetHasClass("team-t", player.nTeam == Team.TEAM_TERRORIST);
            pEntry.SetHasClass("selected", player.nPawnEntIndex >= 0 && player.nPawnEntIndex == lastState?.nSpectatingPlayerId);
            if (player.bAlive) {
                pEntry.SetPanelEvent('onactivate', () => {
                    cp.SpectatePlayer(player.nEntIndex);
                    PlayerListPanel.RemoveClass("Visible");
                });
            }
        }
    }
    function OnStepTimeBackward() {
        return OnStepTime(-timeStepSeconds);
    }
    HudDemoController.OnStepTimeBackward = OnStepTimeBackward;
    function OnStepTimeForward() {
        return OnStepTime(timeStepSeconds);
    }
    HudDemoController.OnStepTimeForward = OnStepTimeForward;
    function OnStepTime(fStep) {
        if (lastState) {
            cp.GotoTick(lastState.nTick + (fStep / lastState.nSecondsPerTick));
        }
        return true;
    }
    function GetIntervalIndexAtTick(intervals, nTick) {
        const nNext = intervals.findIndex(r => r.nTickStart > nTick);
        return (nNext < 0 ? intervals.length : nNext) - 1;
    }
    function OnStepInterval(nStep) {
        if (!lastState) {
            return false;
        }
        if (lastState.bIsPlayingHighlights) {
            if (lastState.HighlightIntervals?.length > 0) {
                const nIntervalIndex = GetIntervalIndexAtTick(lastState.HighlightIntervals, lastState.nTick);
                let nNewInterval = nIntervalIndex + nStep;
                if (nNewInterval < 0)
                    nNewInterval = 0;
                else if (nNewInterval > lastState.HighlightIntervals.length - 1)
                    nNewInterval = lastState.HighlightIntervals.length - 1;
                cp.GotoTick(lastState.HighlightIntervals[nNewInterval].nTickStart);
            }
        }
        else if (lastState.RoundIntervals?.length > 0) {
            const nIntervalIndex = GetIntervalIndexAtTick(lastState.RoundIntervals, lastState.nTick);
            let nNewInterval = nIntervalIndex + nStep;
            if (nNewInterval < 0)
                nNewInterval = 0;
            else if (nNewInterval > lastState.RoundIntervals.length - 1)
                nNewInterval = lastState.RoundIntervals.length - 1;
            cp.GotoTick(lastState.RoundIntervals[nNewInterval].nTickStart);
        }
        return true;
    }
    HudDemoController.OnStepInterval = OnStepInterval;
    const fEventLeadSeconds = 2;
    function OnRoundButtonActivate() {
        if (!lastState)
            return false;
        const bVisible = !RoundMenuPanel.BHasClass("Visible");
        SetRoundMenuVisible(bVisible);
        if (!bVisible)
            return true;
        cp.RemoveClass("SettingsVisible");
        PlayerListPanel.RemoveClass("Visible");
        RoundMenuPanel.RemoveAndDeleteChildren();
        if (lastState.bIsPlayingHighlights) {
            AddRoundMenuEntry('#CSGO_Demo_Highlight_Start', () => OnStepInterval(0));
        }
        else {
            AddRoundMenuEntry('#CSGO_Demo_Round_Start', () => OnStepInterval(0));
            if (GetCurrentRoundActionStartTick() !== undefined) {
                AddRoundMenuEntry('#CSGO_Demo_Action_Start', () => {
                    const nActionStartTick = GetCurrentRoundActionStartTick();
                    if (nActionStartTick !== undefined)
                        cp.GotoTick(nActionStartTick);
                });
            }
        }
        const pButton = $("#RoundRestart");
        const pos = pButton.GetPositionWithinAncestor(cp);
        RoundMenuPanel.style.marginLeft = (pos.x / pButton.actualuiscale_x) + "px";
        return true;
    }
    HudDemoController.OnRoundButtonActivate = OnRoundButtonActivate;
    function SetRoundMenuVisible(bVisible) {
        RoundMenuPanel.SetHasClass("Visible", bVisible);
    }
    function AddRoundMenuEntry(sLocToken, fnActivate) {
        const pEntry = $.CreatePanel("Panel", RoundMenuPanel, "", { class: "round-menu-entry interactive" });
        const pLabel = $.CreatePanel("Label", pEntry, "");
        pLabel.SetLocString(sLocToken);
        pEntry.SetPanelEvent('onactivate', () => {
            fnActivate();
            SetRoundMenuVisible(false);
        });
    }
    function GetCurrentRoundActionStartTick() {
        if (!lastState || !(lastState.RoundIntervals?.length > 0))
            return undefined;
        const nRound = Math.max(GetIntervalIndexAtTick(lastState.RoundIntervals, lastState.nTick), 0);
        const round = lastState.RoundIntervals[nRound];
        return cp.GetActionStartTicks().find(t => t >= round.nTickStart && t < round.nTickEnd);
    }
    function OnNextEvent() {
        if (lastState?.bIsPlayingHighlights)
            OnGotoNextHighlightEvent();
        else
            OnGotoNextEvent();
        return true;
    }
    HudDemoController.OnNextEvent = OnNextEvent;
    function OnGotoNextEvent() {
        if (!lastState)
            return;
        const nLeadTicks = Math.round(fEventLeadSeconds / lastState.nSecondsPerTick);
        const nTick = lastState.nTick;
        const death = cp.GetDeathEvents().find(d => d.nTick - nLeadTicks > nTick);
        if (death)
            cp.GotoTickAndSpectate(death.nTick - nLeadTicks, death.nControllerEntIndex);
    }
    function OnGotoNextHighlightEvent() {
        if (!lastState)
            return;
        const nLeadTicks = Math.round(fEventLeadSeconds / lastState.nSecondsPerTick);
        const nTick = lastState.nTick;
        const nEventTicks = (lastState.TimelineEvents ?? [])
            .filter(e => (e.eEventType == DemoTimelineEvent.EDemoTimelineEvent_Kill) || (e.eEventType == DemoTimelineEvent.EDemoTimelineEvent_Death))
            .map(e => e.nTick)
            .filter(t => t - nLeadTicks > nTick);
        if (nEventTicks.length > 0)
            cp.GotoTick(Math.min(...nEventTicks) - nLeadTicks);
    }
    function OnStepPlayer(nStep) {
        if (lastState?.nObserverMode == ObserverMode.OBS_MODE_ROAMING)
            GameInterfaceAPI.ConsoleCommand(`spec_mode ${ObserverMode.OBS_MODE_IN_EYE}`);
        GameInterfaceAPI.ConsoleCommand(nStep > 0 ? "spec_next" : "spec_prev");
        return true;
    }
    HudDemoController.OnStepPlayer = OnStepPlayer;
    function OnNextCamera() {
        GameInterfaceAPI.ConsoleCommand("spec_mode");
        return true;
    }
    HudDemoController.OnNextCamera = OnNextCamera;
    function OnStopPlayback() {
        cp.StopPlayback();
        return true;
    }
    HudDemoController.OnStopPlayback = OnStopPlayback;
    function IsHighlightsToggleDisabled() {
        return lastState?.nObserverMode == ObserverMode.OBS_MODE_ROAMING && !lastState.bIsPlayingHighlights;
    }
    function OnHighlightsToggle() {
        if (IsHighlightsToggleDisabled())
            return;
        let bIsEnabled = !lastState?.bIsPlayingHighlights;
        cp.SetHighlightsModeEnabled(!!bIsEnabled);
    }
    HudDemoController.OnHighlightsToggle = OnHighlightsToggle;
    function ShouldShowHighlightsButton() {
        if (lastState?.bIsOverwatch)
            return false;
        return true;
    }
    function OnHighlightsModeChanged(bEnabled) {
        cp.SetHasClass("highlightsActive", bEnabled);
        $("#IntervalLabel").text = bEnabled ? $.Localize('#CSGO_Demo_Highlight') : $.Localize('#CSGO_Demo_Round');
        CreateHighlightIntervals();
        CreateTimelineEvents();
        SetRoundNumberLabel();
        return true;
    }
    function DestroyTimelineEvents() {
        const pHighlightIcons = $("#HighlightIcons");
        pHighlightIcons.RemoveAndDeleteChildren();
    }
    function CreateTimelineEvents() {
        DestroyTimelineEvents();
        if (!lastState || !lastState.TimelineEvents)
            return;
        const pThumb = $("#SliderThumb");
        const pHighlightIcons = $("#HighlightIcons");
        const nThumbWidth = pThumb.actuallayoutwidth / pThumb.actualuiscale_x;
        const nMarkersWidth = (pHighlightIcons.actuallayoutwidth / pHighlightIcons.actualuiscale_x) - nThumbWidth;
        for (let iEvent = lastState.TimelineEvents.length - 1; iEvent >= 0; --iEvent) {
            const timelineEvent = lastState.TimelineEvents[iEvent];
            const nHalfIconWidth = 11;
            const nLeft = (timelineEvent.nTick / lastState.nTotalTicks * nMarkersWidth + nThumbWidth / 2) - nHalfIconWidth;
            const sClass = TimelineEventToLabel(timelineEvent.eEventType);
            const pIcon = $.CreatePanel("Panel", pHighlightIcons, "", { class: `highlight-icon ${sClass}` });
            pIcon.style.marginLeft = nLeft + "px";
            const flSkipToTicksBefore = 64 * 2;
            pIcon.SetPanelEvent('onactivate', () => cp.GotoTick(timelineEvent.nTick - flSkipToTicksBefore));
        }
    }
    function DestroyHighlightIntervals() {
        const pMarkers = $("#HighlightMarkers");
        pMarkers.RemoveAndDeleteChildren();
    }
    function CreateHighlightIntervals() {
        DestroyHighlightIntervals();
        if (!lastState || !lastState.HighlightIntervals)
            return;
        const pMarkers = $("#HighlightMarkers");
        const pThumb = $("#SliderThumb");
        const nThumbWidth = pThumb.actuallayoutwidth / pThumb.actualuiscale_x;
        const nMarkersWidth = (pMarkers.actuallayoutwidth / pThumb.actualuiscale_x) - nThumbWidth;
        for (let i = 0; i < lastState.HighlightIntervals.length; i++) {
            const highlight = lastState.HighlightIntervals[i];
            const nStartTick = highlight.nTickStart;
            const nEndTick = highlight.nTickEnd;
            let nLeft = nStartTick / lastState.nTotalTicks * nMarkersWidth + nThumbWidth / 2;
            let nWidth = (nEndTick - nStartTick) / lastState.nTotalTicks * nMarkersWidth;
            const pMarker = $.CreatePanel("Panel", pMarkers, "");
            pMarker.style.marginLeft = nLeft + "px";
            pMarker.style.width = nWidth + "px";
        }
    }
    function GetCurrentIntervalNumber() {
        if (!lastState)
            return 0;
        if (lastState.bIsPlayingHighlights) {
            return 0;
        }
        return TicksToRound(lastState.nTick, lastState.RoundIntervals);
    }
    function TicksToTimeText(nTick, nSecondsPerTick) {
        const nTime = Math.floor(nSecondsPerTick * nTick);
        const nMinutes = Math.floor(nTime / 60);
        const nSeconds = nTime - nMinutes * 60;
        return `${nMinutes.toString().padStart(2, "0")}:${nSeconds.toString().padStart(2, "0")}`;
    }
    function TicksToRound(nTick, rounds) {
        if (rounds.length === 0 || rounds[0].nTickStart > nTick)
            return 0;
        for (let i = 0; i < rounds.length; i++) {
            if (nTick < rounds[i].nTickStart) {
                return i;
            }
        }
        return rounds.length;
    }
    function ToggleSettingsVisible() {
        cp.ToggleClass("SettingsVisible");
        PlayerListPanel.RemoveClass("Visible");
        SetRoundMenuVisible(false);
        $.Schedule(0, FrameUpdate);
    }
    HudDemoController.ToggleSettingsVisible = ToggleSettingsVisible;
    function ToggleXRay() {
        let spec_show_xray = parseInt(GameInterfaceAPI.GetSettingString("spec_show_xray"));
        spec_show_xray = spec_show_xray ? 0 : 1;
        GameInterfaceAPI.ConsoleCommand(`spec_show_xray ${spec_show_xray}`);
    }
    HudDemoController.ToggleXRay = ToggleXRay;
    function ToggleTrueView() {
        const cl_demo_predict = parseInt(GameInterfaceAPI.GetSettingString("cl_demo_predict"));
        if (cl_demo_predict) {
            GameInterfaceAPI.ConsoleCommand("cl_demo_predict 0");
        }
        else {
            if (!TrueViewWrongVersionToggleButton.IsSelected()) {
                GameInterfaceAPI.ConsoleCommand("cl_demo_predict 1");
            }
            else {
                GameInterfaceAPI.ConsoleCommand("cl_demo_predict 2");
            }
        }
    }
    HudDemoController.ToggleTrueView = ToggleTrueView;
    function ToggleTrueViewDOACommands() {
        let cl_trueview_show_doa_predictions = parseInt(GameInterfaceAPI.GetSettingString("cl_trueview_show_doa_predictions"));
        cl_trueview_show_doa_predictions = cl_trueview_show_doa_predictions ? 0 : 1;
        GameInterfaceAPI.ConsoleCommand(`cl_trueview_show_doa_predictions ${cl_trueview_show_doa_predictions}`);
    }
    HudDemoController.ToggleTrueViewDOACommands = ToggleTrueViewDOACommands;
    function ToggleTrueViewWrongVersion() {
        const cl_demo_predict = parseInt(GameInterfaceAPI.GetSettingString("cl_demo_predict"));
        if (cl_demo_predict == 1) {
            GameInterfaceAPI.ConsoleCommand("cl_demo_predict 2");
        }
        else if (cl_demo_predict == 2) {
            GameInterfaceAPI.ConsoleCommand("cl_demo_predict 1");
        }
    }
    HudDemoController.ToggleTrueViewWrongVersion = ToggleTrueViewWrongVersion;
    function SetRoundNumberLabel() {
        if (lastState && lastState.bIsPlayingHighlights) {
            var roundNumber = $("#RoundNumber");
            if (roundNumber) {
                roundNumber.visible = false;
            }
        }
        else {
            var roundNumber = $("#RoundNumber");
            if (roundNumber) {
                roundNumber.visible = true;
            }
            cp.SetDialogVariableInt("round_number", GetCurrentIntervalNumber());
        }
    }
})(HudDemoController || (HudDemoController = {}));
