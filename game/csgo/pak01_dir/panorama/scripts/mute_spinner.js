"use strict";
/// <reference path="csgo.d.ts" />
var MuteSpinner;
(function (MuteSpinner) {
    let m_curVal;
    let m_isMuted;
    let m_hFadeOutMuteBar = undefined;
    function ToggleMute() {
        let elSpinner = $.GetContextPanel().FindChildTraverse('id-mute-spinner');
        if ('xuid' in $.GetContextPanel().GetParent()) {
            // @ts-ignore
            let xuid = $.GetContextPanel().GetParent().xuid;
            GameStateAPI.ToggleMute(xuid);
            UpdateVolumeDisplay();
        }
    }
    MuteSpinner.ToggleMute = ToggleMute;
    function _GetCurrentValues() {
        if ('xuid' in $.GetContextPanel().GetParent()) {
            // @ts-ignore
            let xuid = $.GetContextPanel().GetParent().xuid;
            m_curVal = GameStateAPI.GetPlayerVoiceVolume(xuid).toFixed(2);
            m_isMuted = GameStateAPI.IsSelectedPlayerMuted(xuid);
        }
    }
    function _OnValueChanged(panel, flNewVal) {
        if ('xuid' in $.GetContextPanel().GetParent()) {
            // @ts-ignore
            let xuid = $.GetContextPanel().GetParent().xuid;
            let sNewVal = flNewVal.toFixed(2);
            _GetCurrentValues();
            if (m_curVal != sNewVal) {
                GameStateAPI.SetPlayerVoiceVolume(xuid, Number(sNewVal));
                UpdateVolumeDisplay();
                let elMuteBar = $.GetContextPanel().FindChildTraverse('id-mute-bar');
                if (elMuteBar) {
                    elMuteBar.RemoveClass("fade");
                    elMuteBar.style.height = Number(m_curVal) * 100 + "%";
                    if (m_hFadeOutMuteBar != undefined)
                        $.CancelScheduled(m_hFadeOutMuteBar);
                    m_hFadeOutMuteBar = $.Schedule(0.5, () => {
                        elMuteBar.AddClass("fade");
                        m_hFadeOutMuteBar = undefined;
                    });
                }
            }
        }
    }
    function UpdateVolumeDisplay() {
        _GetCurrentValues();
        $.GetContextPanel().SetDialogVariable('value', (Number(m_curVal) * 100).toFixed(0));
        let elSpinner = $.GetContextPanel().FindChildTraverse('id-mute-spinner');
        let elSpinnerBar = $.GetContextPanel().FindChildTraverse('id-mute-bar');
        if (!elSpinnerBar || !elSpinnerBar.IsValid())
            return;
        let elSpinnerLabel = $.GetContextPanel().FindChildTraverse('id-mute-value');
        if (!elSpinnerLabel || !elSpinnerLabel.IsValid())
            return;
        let elMutedImage = $.GetContextPanel().FindChildTraverse('id-mute-muted-img');
        if (!elMutedImage || !elMutedImage.IsValid())
            return;
        if (m_isMuted) {
            elMutedImage.RemoveClass("hidden");
            elSpinnerLabel.AddClass("hidden");
            elSpinnerBar.AddClass("hidden");
            elSpinner.AddClass('muted');
        }
        else {
            elMutedImage.AddClass("hidden");
            elSpinnerLabel.RemoveClass("hidden");
            elSpinnerBar.RemoveClass("hidden");
            elSpinner.RemoveClass('muted');
        }
        elSpinner.spinlock = m_isMuted;
    }
    MuteSpinner.UpdateVolumeDisplay = UpdateVolumeDisplay;
    {
        $.RegisterEventHandler("SpinnerValueChanged", $.GetContextPanel(), _OnValueChanged);
    }
})(MuteSpinner || (MuteSpinner = {}));
