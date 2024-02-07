"use strict";
/// <reference path="../csgo.d.ts" />
var HudDemoController;
(function (HudDemoController) {
    function EatClick() {
        return true;
    }
    HudDemoController.EatClick = EatClick;
    const cp = $.GetContextPanel();
    const slider = $("#Slider");
    const speeds = $("#SpeedControls").Children().slice(1);
    let bActive = cp.BHasClass("active");
    $.RegisterForUnhandledEvent("DemoToggleUI", () => {
        bActive = !bActive;
        cp.SetHasClass("active", bActive);
        cp.SetInputCaptureEnabled(bActive);
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
        }
        lastState = state;
        const pMarkers = $("#RoundMarkers");
        if (pMarkers.actuallayoutwidth > 0 && !bRoundsMarked) {
            bRoundsMarked = true;
            pMarkers.RemoveAndDeleteChildren();
            const pThumb = $("#SliderThumb");
            const nThumbWidth = pThumb.actuallayoutwidth / pThumb.actualuiscale_x;
            const nMarkersWidth = (pMarkers.actuallayoutwidth / pThumb.actualuiscale_x) - nThumbWidth;
            for (let i = 0; i < state.RoundStarts.length; i++) {
                const nStartTick = state.RoundStarts[i].nTick;
                const nEndTick = i < state.RoundStarts.length - 1 ? state.RoundStarts[i + 1].nTick - 1 : state.nTotalTicks;
                let nLeft = nStartTick / state.nTotalTicks * nMarkersWidth + nThumbWidth / 2;
                let nWidth = (nEndTick - nStartTick) / state.nTotalTicks * nMarkersWidth;
                if (i === 0) {
                    nWidth += nLeft;
                    nLeft = 0;
                }
                else if (i === state.RoundStarts.length - 1) {
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
            cp.SetDialogVariableInt("round_number", TicksToRound(state.nTick, state.RoundStarts));
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
        cp.SetDialogVariableInt("round_number", TicksToRound(fValue, lastState.RoundStarts));
        cp.GotoTick(Math.floor(fValue));
        return true;
    });
    $.RegisterEventHandler("SliderValueChanged", slider, (_, fValue) => {
        if (lastState == null)
            return true;
        cp.SetDialogVariable("current_time", TicksToTimeText(fValue, lastState.nSecondsPerTick));
        cp.SetDialogVariableInt("round_number", TicksToRound(fValue, lastState.RoundStarts));
        return true;
    });
    function OnPlayClicked() {
        cp.SetPaused(!cp.BHasClass("paused"));
        return true;
    }
    HudDemoController.OnPlayClicked = OnPlayClicked;
    function OnStepTime(fStep) {
        if (lastState) {
            cp.GotoTick(lastState.nTick + (fStep / lastState.nSecondsPerTick));
        }
        return true;
    }
    HudDemoController.OnStepTime = OnStepTime;
    function OnStepRound(nStep) {
        if (lastState && lastState.RoundStarts.length > 0) {
            const nRoundIndex = lastState.RoundStarts.findIndex(r => r.nTick > lastState.nTick) - 1;
            let nNewRound = nRoundIndex + nStep;
            if (nNewRound < 0)
                nNewRound = 0;
            else if (nNewRound > lastState.RoundStarts.length - 1)
                nNewRound = lastState.RoundStarts.length - 1;
            cp.GotoTick(lastState.RoundStarts[nNewRound].nTick);
        }
        return true;
    }
    HudDemoController.OnStepRound = OnStepRound;
    function OnTimeScale(fTimeScale) {
        cp.SetTimeScale(fTimeScale);
        return true;
    }
    HudDemoController.OnTimeScale = OnTimeScale;
    function TicksToTimeText(nTick, nSecondsPerTick) {
        const nTime = Math.floor(nSecondsPerTick * nTick);
        const nSeconds = nTime % 60;
        const nMinutes = Math.floor(nTime / 60);
        const sSeconds = nSeconds < 10 ? "0" + nSeconds : nSeconds.toString();
        return `${nMinutes}:${sSeconds}`;
    }
    function TicksToRound(nTick, rounds) {
        if (rounds.length === 0 || rounds[0].nTick > nTick)
            return 0;
        for (let i = 0; i < rounds.length; i++) {
            if (nTick < rounds[i].nTick) {
                return i - 1;
            }
        }
        return rounds.length;
    }
})(HudDemoController || (HudDemoController = {}));
