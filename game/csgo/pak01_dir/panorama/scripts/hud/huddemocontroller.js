"use strict";
/// <reference path="../csgo.d.ts" />
var HudDemoController;
(function (HudDemoController) {
    function EatClick() {
        return true;
    }
    HudDemoController.EatClick = EatClick;
    const timeStepSeconds = 15;
    const cp = $.GetContextPanel();
    cp.SetDialogVariableInt("timestep_value", timeStepSeconds);
    const slider = $("#Slider");
    const speeds = $("#SpeedControls").Children().slice(1);
    const hud = cp.GetParent();
    $.RegisterForUnhandledEvent("DemoToggleUI", () => {
        if (!cp.IsPlayingDemo())
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
            state.HighlightIntervals.at(-1)?.interval.nTickEnd :
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
        if (!cp.visible) {
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
            let nUIMode = Number(GameInterfaceAPI.GetSettingString("demo_ui_mode"));
            if (nUIMode == 1) {
                hud.SetHasClass("DemoControllerMinimal", true);
            }
            else if (nUIMode == 2) {
                hud.SetHasClass("DemoControllerFull", true);
            }
            OnHighlightsModeChanged(state.bIsPlayingHighlights);
            bHighlightsMode = state.bIsPlayingHighlights;
            const sEndPlayback = state.bIsOverwatch ?
                $.Localize('#CSGO_Demo_End_Playback_Overwatch') :
                $.Localize('#CSGO_Demo_End_Playback');
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
        const pHighlightIcons = $("#HighlightIcons");
        if (nSpectatingPlayerId != state.nSpectatingPlayerId && pHighlightIcons.actuallayoutwidth > 0) {
            pHighlightIcons.RemoveAndDeleteChildren();
            DestroyHighlightIntervals();
            if (state.HighlightIntervals) {
                const pThumb = $("#SliderThumb");
                const nThumbWidth = pThumb.actuallayoutwidth / pThumb.actualuiscale_x;
                const nMarkersWidth = (pHighlightIcons.actuallayoutwidth / pHighlightIcons.actualuiscale_x) - nThumbWidth;
                for (let iInterval = state.HighlightIntervals.length - 1; iInterval >= 0; --iInterval) {
                    const highlightInterval = state.HighlightIntervals[iInterval];
                    for (let iEvent = highlightInterval.events.length - 1; iEvent >= 0; --iEvent) {
                        const highlightEvent = highlightInterval.events[iEvent];
                        let nIconTick = highlightEvent.nTick;
                        if (highlightInterval.events.length == 1 || state.bHighlightsCanBeTagged) {
                            nIconTick = (highlightInterval.interval.nTickStart + highlightInterval.interval.nTickEnd) / 2;
                        }
                        const nHalfIconWidth = 11;
                        const nLeft = (nIconTick / state.nTotalTicks * nMarkersWidth + nThumbWidth / 2) - nHalfIconWidth;
                        const sClass = state.bHighlightsCanBeTagged ? "untagged" : highlightEvent.sLabel;
                        const pIcon = $.CreatePanel("Panel", pHighlightIcons, "", { class: `highlight-icon ${sClass}` });
                        pIcon.style.marginLeft = nLeft + "px";
                        pIcon.SetPanelEvent('onactivate', () => OnHighlightButtonToggled(pIcon, iInterval));
                        if (state.bHighlightsCanBeTagged) {
                            break;
                        }
                    }
                }
            }
            CreateHighlightIntervals();
            nSpectatingPlayerId = state.nSpectatingPlayerId;
            $("#HighlightsButton")?.SetHasClass("hide", !ShouldShowHighlightsButton());
            cp.SetHasClass("flyCamActive", nSpectatingPlayerId == -1);
        }
        if ((state.bIsPlayingHighlights != bHighlightsMode) || bStateChanged) {
            OnHighlightsModeChanged(state.bIsPlayingHighlights);
            bHighlightsMode = state.bIsPlayingHighlights;
        }
        cp.SetHasClass("paused", state.bIsPaused);
        slider.min = 0;
        slider.max = state.nTotalTicks;
        if (!slider.mousedown) {
            slider.value = state.nTick;
            cp.SetDialogVariable("current_time", TicksToTimeText(state.nTick, state.nSecondsPerTick));
            cp.SetDialogVariableInt("round_number", GetCurrentIntervalNumber());
        }
        speeds[0].SetHasClass("selected", state.fTimeScale === .25);
        speeds[1].SetHasClass("selected", state.fTimeScale === .5);
        speeds[2].SetHasClass("selected", state.fTimeScale === 1);
        speeds[3].SetHasClass("selected", state.fTimeScale === 2);
        speeds[4].SetHasClass("selected", state.fTimeScale === 4);
        speeds[5].SetHasClass("selected", state.fTimeScale === 8);
    }
    $.Schedule(0, FrameUpdate);
    $.RegisterEventHandler("SliderReleased", slider, (_, fValue) => {
        if (lastState == null)
            return true;
        cp.SetDialogVariable("current_time", TicksToTimeText(fValue, lastState.nSecondsPerTick));
        cp.SetDialogVariableInt("round_number", GetCurrentIntervalNumber());
        cp.GotoTick(Math.floor(fValue));
        return true;
    });
    $.RegisterEventHandler("SliderValueChanged", slider, (_, fValue) => {
        if (lastState == null)
            return true;
        cp.SetDialogVariable("current_time", TicksToTimeText(fValue, lastState.nSecondsPerTick));
        cp.SetDialogVariableInt("round_number", GetCurrentIntervalNumber());
        return true;
    });
    function OnPlayClicked() {
        cp.SetPaused(!cp.BHasClass("paused"));
        return true;
    }
    HudDemoController.OnPlayClicked = OnPlayClicked;
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
    function OnStepInterval(nStep) {
        if (!lastState) {
            return false;
        }
        if (lastState.bIsPlayingHighlights) {
            if (lastState.HighlightIntervals.length > 0) {
                const nIntervalIndex = lastState.HighlightIntervals.findIndex(r => r.interval.nTickStart > lastState.nTick) - 1;
                let nNewInterval = nIntervalIndex + nStep;
                if (nNewInterval < 0)
                    nNewInterval = 0;
                else if (nNewInterval > lastState.HighlightIntervals.length - 1)
                    nNewInterval = lastState.HighlightIntervals.length - 1;
                cp.GotoTick(lastState.HighlightIntervals[nNewInterval].interval.nTickStart);
            }
        }
        else if (lastState.RoundIntervals.length > 0) {
            const nIntervalIndex = lastState.RoundIntervals.findIndex(r => r.nTickStart > lastState.nTick) - 1;
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
    function OnTimeScale(fTimeScale) {
        cp.SetTimeScale(fTimeScale);
        return true;
    }
    HudDemoController.OnTimeScale = OnTimeScale;
    function OnStopPlayback() {
        cp.StopPlayback();
        return true;
    }
    HudDemoController.OnStopPlayback = OnStopPlayback;
    function OnHighlightsToggle() {
        let bIsEnabled = !lastState?.bIsPlayingHighlights;
        bIsEnabled == bIsEnabled &&
            lastState?.HighlightIntervals &&
            lastState.HighlightIntervals.length > 0;
        cp.SetHighlightsModeEnabled(bIsEnabled);
    }
    HudDemoController.OnHighlightsToggle = OnHighlightsToggle;
    function OnHighlightButtonToggled(pIcon, nIndex) {
        let bTagged = false;
        if (lastState?.bHighlightsCanBeTagged) {
            bTagged = pIcon.BHasClass("untagged");
            pIcon.SetHasClass("tagged", bTagged);
            pIcon.SetHasClass("untagged", !bTagged);
        }
        cp.OnHighlightSelected(nIndex, bTagged);
    }
    function ShouldShowHighlightsButton() {
        if (lastState?.bIsOverwatch)
            return false;
        if (!lastState?.HighlightIntervals)
            return false;
        return lastState.HighlightIntervals.length > 0;
    }
    function OnHighlightsModeChanged(bEnabled) {
        cp.SetHasClass("highlightsActive", bEnabled);
        $("#IntervalLabel").text = bEnabled ? $.Localize('#CSGO_Demo_Highlight') : $.Localize('#CSGO_Demo_Round');
        return true;
    }
    function DestroyHighlightIntervals() {
        const pMarkers = $("#HighlightMarkers");
        pMarkers.RemoveAndDeleteChildren();
    }
    function CreateHighlightIntervals() {
        const pMarkers = $("#HighlightMarkers");
        const pThumb = $("#SliderThumb");
        const nThumbWidth = pThumb.actuallayoutwidth / pThumb.actualuiscale_x;
        const nMarkersWidth = (pMarkers.actuallayoutwidth / pThumb.actualuiscale_x) - nThumbWidth;
        for (let i = 0; i < lastState.HighlightIntervals.length; i++) {
            const highlight = lastState.HighlightIntervals[i];
            const nStartTick = highlight.interval.nTickStart;
            const nEndTick = highlight.interval.nTickEnd;
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
            return lastState.nCurrentHighlightInterval + 1;
        }
        return TicksToRound(lastState.nTick, lastState.RoundIntervals);
    }
    function TicksToTimeText(nTick, nSecondsPerTick) {
        const nTime = Math.floor(nSecondsPerTick * nTick);
        const nSeconds = nTime % 60;
        const nMinutes = Math.floor(nTime / 60);
        const sSeconds = nSeconds < 10 ? "0" + nSeconds : nSeconds.toString();
        return `${nMinutes}:${sSeconds}`;
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
})(HudDemoController || (HudDemoController = {}));
