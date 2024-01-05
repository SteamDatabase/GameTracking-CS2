"use strict";
/// <reference path="../csgo.d.ts" />
var SurvivalWinner = (function () {
    const _ShowPanel = function (numType) {
        if (numType !== 21 && numType !== 22) {
            return;
        }
        const elParent = $.GetContextPanel();
        const videoPlayer = elParent.FindChildInLayoutFile('id-survival-movie');
        videoPlayer.SetMovie("file://{resources}/videos/survival_winner.webm");
        videoPlayer.Play();
        videoPlayer.AddClass('survival-winner__movie--fadeout');
        $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.gameover_show', 'MOUSE');
        $.Schedule(0.4, function () {
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.XP.NewSkillGroup', 'MOUSE');
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.inventory_new_item_accept', 'MOUSE');
        });
        elParent.FindChildInLayoutFile('id-survival-winner').TriggerClass('survival-winner--reveal');
        elParent.FindChildInLayoutFile('id-survivor_winner-ring').TriggerClass('survival-winner__ring--flash');
        elParent.FindChildInLayoutFile('id-survival-avatar-container').TriggerClass('reveal');
    };
    return {
        ShowPanel: _ShowPanel
    };
})();
(function () {
    $.RegisterEventHandler("HudWinPanel_Show", $.GetContextPanel(), SurvivalWinner.ShowPanel);
})();
