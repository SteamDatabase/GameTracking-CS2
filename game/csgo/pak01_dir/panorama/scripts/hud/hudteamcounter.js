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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaHVkdGVhbWNvdW50ZXIuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9odWQvaHVkdGVhbWNvdW50ZXIudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUVyQyxJQUFJLGNBQWMsR0FBRyxDQUFFO0lBR3RCLFNBQVMsaUJBQWlCLENBQUcsYUFBc0IsRUFBRSxhQUFzQjtRQUcxRSxNQUFNLFdBQVcsR0FBRyxDQUFDLENBQUM7UUFDdEIsTUFBTSxVQUFVLEdBQUcsR0FBRyxDQUFDO1FBRXZCLE1BQU0sYUFBYSxHQUFHLENBQUMsSUFBSSxhQUFhLENBQUMsZUFBZSxDQUFFLGNBQWMsRUFBRSxDQUFDLENBQUUsQ0FBQztRQUM5RSxNQUFNLEtBQUssR0FBRyxDQUFDLElBQUksYUFBYSxDQUFDLGVBQWUsQ0FBRSxNQUFNLEVBQUUsQ0FBQyxDQUFFLENBQUM7UUFFOUQsTUFBTSxhQUFhLEdBQUcsYUFBYSxDQUFDLGVBQWUsQ0FBRSxnQkFBZ0IsRUFBRSxDQUFDLENBQUUsQ0FBQztRQUMzRSxNQUFNLE9BQU8sR0FBRyxhQUFhLENBQUMsZUFBZSxDQUFFLFVBQVUsRUFBRSxDQUFDLENBQUUsQ0FBQztRQUMvRCxNQUFNLG1CQUFtQixHQUFHLGFBQWEsQ0FBQyxlQUFlLENBQUUsdUJBQXVCLEVBQUUsQ0FBQyxDQUFFLENBQUM7UUFDeEYsTUFBTSxhQUFhLEdBQUcsYUFBYSxDQUFDLGVBQWUsQ0FBRSxpQkFBaUIsRUFBRSxDQUFDLENBQUUsQ0FBQztRQUU1RSxNQUFNLFVBQVUsR0FBRyxhQUFhLENBQUMsZUFBZSxDQUFFLGFBQWEsRUFBRSxDQUFDLENBQUUsQ0FBQztRQUlyRSxNQUFNLGNBQWMsR0FBRyxhQUFhLENBQUMsaUJBQWlCLENBQUUsdUJBQXVCLENBQUUsQ0FBQztRQUVsRixjQUFjLENBQUMsV0FBVyxDQUFFLE9BQU8sRUFBRSxhQUFhLEdBQUcsQ0FBQyxDQUFFLENBQUM7UUFDekQsY0FBYyxDQUFDLFdBQVcsQ0FBRSxPQUFPLEVBQUUsbUJBQW1CLEdBQUcsQ0FBQyxDQUFFLENBQUM7UUFDL0QsY0FBYyxDQUFDLFdBQVcsQ0FBRSxjQUFjLEVBQUUsYUFBYSxDQUFFLENBQUM7UUFFNUQsY0FBYyxDQUFDLG9CQUFvQixDQUFFLGdCQUFnQixFQUFFLGFBQWEsQ0FBRSxDQUFDO1FBQ3ZFLGNBQWMsQ0FBQyxvQkFBb0IsQ0FBRSxVQUFVLEVBQUUsT0FBTyxDQUFFLENBQUM7UUFDM0QsY0FBYyxDQUFDLG9CQUFvQixDQUFFLHVCQUF1QixFQUFFLG1CQUFtQixDQUFFLENBQUM7UUFDcEYsY0FBYyxDQUFDLG9CQUFvQixDQUFFLGlCQUFpQixFQUFFLGFBQWEsQ0FBRSxDQUFDO1FBRXhFLGNBQWMsQ0FBQyxXQUFXLENBQUUsV0FBVyxFQUFFLGFBQWEsR0FBRyxtQkFBbUIsQ0FBQyxDQUFDLENBQUMsS0FBSyxDQUFDLENBQUMsQ0FBQyxNQUFNLENBQUUsQ0FBQztRQUVoRyxTQUFTLE9BQU8sQ0FBRyxPQUFnQjtZQUVsQyxJQUFLLENBQUMsT0FBTyxJQUFJLENBQUMsT0FBTyxDQUFDLE9BQU8sRUFBRTtnQkFDbEMsT0FBTztZQUVSLE9BQU8sQ0FBQyxRQUFRLENBQUUsV0FBVyxDQUFFLENBQUM7UUFFakMsQ0FBQztRQUVELElBQUssYUFBYSxHQUFHLENBQUMsSUFBSSxtQkFBbUIsR0FBRyxDQUFDLEVBQ2pEO1lBQ0MsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxXQUFXLEdBQUcsVUFBVSxHQUFHLFVBQVUsRUFBRSxHQUFHLEVBQUUsQ0FBQyxPQUFPLENBQUUsYUFBYSxDQUFFLENBQUUsQ0FBQztTQUNwRjtJQUNGLENBQUM7SUFFRCxTQUFTLGlCQUFpQjtRQUV6QixDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsNkJBQTZCLENBQUUsV0FBVyxDQUFFLENBQUMsT0FBTyxDQUFFLEVBQUUsQ0FBQyxFQUFFLENBQUMsRUFBRSxDQUFDLFdBQVcsQ0FBRSxXQUFXLENBQUUsQ0FBRSxDQUFDO0lBQ2pILENBQUM7SUFFRCxPQUFPO1FBRU4sZ0JBQWdCLEVBQUUsaUJBQWlCO1FBQ25DLGdCQUFnQixFQUFFLGlCQUFpQjtLQUNuQyxDQUFDO0FBRUgsQ0FBQyxDQUFFLEVBQUUsQ0FBQztBQUtOLENBQUU7SUFJRCxDQUFDLENBQUMseUJBQXlCLENBQUUsa0NBQWtDLEVBQUUsY0FBYyxDQUFDLGdCQUFnQixDQUFFLENBQUM7SUFDbkcsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLHFDQUFxQyxFQUFFLGNBQWMsQ0FBQyxnQkFBZ0IsQ0FBRSxDQUFDO0FBR3ZHLENBQUMsQ0FBRSxFQUFFLENBQUMifQ==