"use strict";
/// <reference path="../csgo.d.ts" />
var HudTeamCounter = (function () {
    function _ShowDamageReport(elTeamCounter, elAvatarPanel) {
        const bannerDelay = 0;
        const delayDelta = 0.1;
        const bFriendlyFire = 1 == elAvatarPanel.GetAttributeInt("friendlyfire", 0);
        const bDead = 1 == elAvatarPanel.GetAttributeInt("dead", 0);
        const healthRemoved = elAvatarPanel.GetAttributeInt("health_removed", 0);
        const numHits = elAvatarPanel.GetAttributeInt("num_hits", 0);
        const returnHealthRemoved = elAvatarPanel.GetAttributeInt("return_health_removed", 0);
        const returnNumHits = elAvatarPanel.GetAttributeInt("return_num_hits", 0);
        const orderIndex = elAvatarPanel.GetAttributeInt("order_index", 0);
        const elDamageReport = elAvatarPanel.FindChildTraverse('PostRoundDamageReport');
        elDamageReport.SetHasClass('given', healthRemoved > 0);
        elDamageReport.SetHasClass('taken', returnHealthRemoved > 0);
        elDamageReport.SetHasClass('friendlyfire', bFriendlyFire);
        elDamageReport.SetDialogVariableInt("health_removed", healthRemoved);
        elDamageReport.SetDialogVariableInt("num_hits", numHits);
        elDamageReport.SetDialogVariableInt("return_health_removed", returnHealthRemoved);
        elDamageReport.SetDialogVariableInt("return_num_hits", returnNumHits);
        elDamageReport.SwitchClass('advantage', healthRemoved > returnHealthRemoved ? 'won' : 'lost');
        function _reveal(elPanel) {
            if (!elPanel || !elPanel.IsValid())
                return;
            elPanel.AddClass('show-prdr');
        }
        if (healthRemoved > 0 || returnHealthRemoved > 0) {
            $.Schedule(bannerDelay + orderIndex * delayDelta, () => _reveal(elAvatarPanel));
        }
    }
    function _HideDamageReport() {
        $.GetContextPanel().FindChildrenWithClassTraverse("show-prdr").forEach(el => el.RemoveClass('show-prdr'));
    }
    return {
        ShowDamageReport: _ShowDamageReport,
        HideDamageReport: _HideDamageReport
    };
})();
(function () {
    $.RegisterForUnhandledEvent('RevealPostRoundDamageReportPanel', HudTeamCounter.ShowDamageReport);
    $.RegisterForUnhandledEvent('ClearAllPostRoundDamageReportPanels', HudTeamCounter.HideDamageReport);
})();
