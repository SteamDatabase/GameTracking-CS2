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
    let bActive = hud.BHasClass("DemoControllerActive");
    $.RegisterForUnhandledEvent("DemoToggleUI", () => {
        if (!cp.IsPlayingDemo())
            return;
        if (lastState && lastState.bIsOverwatch)
            return;
        bActive = !bActive;
        hud.SetHasClass("DemoControllerActive", bActive);
        cp.SetInputCaptureEnabled(bActive);
    });
    $.RegisterForUnhandledEvent("DemoSetHUDVisible", (bVisible) => {
        if (!cp.IsPlayingDemo())
            return;
        hud.SetHasClass("hide", !bVisible);
    });
    let lastState = null;
    let bRoundsMarked = false;
    function FrameUpdate() {
        if (!cp.visible) {
            $.Schedule(1, FrameUpdate);
            return;
        }
        $.Schedule(0, FrameUpdate);
        const state = cp.GetDemoControllerState();
        if (state == null) {
            lastState = null;
            return;
        }
        if (lastState == null || lastState.sFileName !== state.sFileName) {
            bRoundsMarked = false;
            let sFileName = state.sFileName.replaceAll("\\", "/");
            let nSlashIndex = sFileName.lastIndexOf("/");
            if (nSlashIndex !== -1)
                sFileName = sFileName.substring(nSlashIndex + 1);
            cp.SetDialogVariable("total_time", TicksToTimeText(state.nTotalTicks, state.nSecondsPerTick));
            $("#IntervalLabel").text = state.bIsPlayingHighlights ? $.Localize('#CSGO_Demo_Highlight') : $.Localize('#CSGO_Demo_Round');
            const bShowUI = state.bIsOverwatch;
            hud.SetHasClass("DemoControllerActive", bShowUI);
            cp.SetInputCaptureEnabled(bShowUI);
            $("#EndPlayback").visible = state.bIsOverwatch;
        }
        lastState = state;
        const pMarkers = $("#RoundMarkers");
        if (pMarkers.actuallayoutwidth > 0 && !bRoundsMarked) {
            bRoundsMarked = true;
            pMarkers.RemoveAndDeleteChildren();
            const pThumb = $("#SliderThumb");
            const nThumbWidth = pThumb.actuallayoutwidth / pThumb.actualuiscale_x;
            const nMarkersWidth = (pMarkers.actuallayoutwidth / pThumb.actualuiscale_x) - nThumbWidth;
            for (let i = 0; i < state.PlaybackIntervals.length; i++) {
                const nStartTick = state.PlaybackIntervals[i].nTickStart;
                const nEndTick = state.PlaybackIntervals[i].nTickEnd;
                let nLeft = nStartTick / state.nTotalTicks * nMarkersWidth + nThumbWidth / 2;
                let nWidth = (nEndTick - nStartTick) / state.nTotalTicks * nMarkersWidth;
                if (i === 0 && !state.bIsPlayingHighlights) {
                    nWidth += nLeft;
                    nLeft = 0;
                }
                else if (i === state.PlaybackIntervals.length - 1) {
                    nWidth += nThumbWidth / 2;
                }
                const pMarker = $.CreatePanel("Panel", pMarkers, "", { class: i % 2 === 0 ? "even" : "odd" });
                pMarker.style.marginLeft = nLeft + "px";
                pMarker.style.width = nWidth + "px";
            }
        }
        cp.SetHasClass("paused", state.bIsPaused);
        slider.min = 0;
        slider.max = state.nTotalTicks;
        if (!slider.mousedown) {
            slider.value = state.nTick;
            cp.SetDialogVariable("current_time", TicksToTimeText(state.nTick, state.nSecondsPerTick));
            cp.SetDialogVariableInt("round_number", TicksToRound(state.nTick, state.PlaybackIntervals));
        }
        speeds[0].SetHasClass("selected", state.fTimeScale === .25);
        speeds[1].SetHasClass("selected", state.fTimeScale === .5);
        speeds[2].SetHasClass("selected", state.fTimeScale === 1);
        speeds[3].SetHasClass("selected", state.fTimeScale === 2);
        speeds[4].SetHasClass("selected", state.fTimeScale === 4);
    }
    $.Schedule(0, FrameUpdate);
    $.RegisterEventHandler("SliderReleased", slider, (_, fValue) => {
        if (lastState == null)
            return true;
        cp.SetDialogVariable("current_time", TicksToTimeText(fValue, lastState.nSecondsPerTick));
        cp.SetDialogVariableInt("round_number", TicksToRound(fValue, lastState.PlaybackIntervals));
        cp.GotoTick(Math.floor(fValue));
        return true;
    });
    $.RegisterEventHandler("SliderValueChanged", slider, (_, fValue) => {
        if (lastState == null)
            return true;
        cp.SetDialogVariable("current_time", TicksToTimeText(fValue, lastState.nSecondsPerTick));
        cp.SetDialogVariableInt("round_number", TicksToRound(fValue, lastState.PlaybackIntervals));
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
        if (lastState && lastState.PlaybackIntervals.length > 0) {
            const nIntervalIndex = lastState.PlaybackIntervals.findIndex(r => r.nTickStart > lastState.nTick) - 1;
            let nNewInterval = nIntervalIndex + nStep;
            if (nNewInterval < 0)
                nNewInterval = 0;
            else if (nNewInterval > lastState.PlaybackIntervals.length - 1)
                nNewInterval = lastState.PlaybackIntervals.length - 1;
            cp.GotoTick(lastState.PlaybackIntervals[nNewInterval].nTickStart);
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
