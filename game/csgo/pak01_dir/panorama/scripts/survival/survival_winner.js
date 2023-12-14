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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic3Vydml2YWxfd2lubmVyLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvc3Vydml2YWwvc3Vydml2YWxfd2lubmVyLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUFRckMsSUFBSSxjQUFjLEdBQUcsQ0FBRTtJQUVuQixNQUFNLFVBQVUsR0FBRyxVQUFXLE9BQWU7UUFFekMsSUFBSyxPQUFPLEtBQUssRUFBRSxJQUFJLE9BQU8sS0FBSyxFQUFFLEVBQ3JDO1lBQ0ksT0FBTztTQUNWO1FBRUQsTUFBTSxRQUFRLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDO1FBR3JDLE1BQU0sV0FBVyxHQUFHLFFBQVEsQ0FBQyxxQkFBcUIsQ0FBRSxtQkFBbUIsQ0FBYSxDQUFDO1FBQ3JGLFdBQVcsQ0FBQyxRQUFRLENBQUUsZ0RBQWdELENBQUUsQ0FBQztRQUN6RSxXQUFXLENBQUMsSUFBSSxFQUFFLENBQUM7UUFFbkIsV0FBVyxDQUFDLFFBQVEsQ0FBRSxpQ0FBaUMsQ0FBRSxDQUFDO1FBSzFELENBQUMsQ0FBQyxhQUFhLENBQUUscUJBQXFCLEVBQUUsMEJBQTBCLEVBQUUsT0FBTyxDQUFFLENBQUM7UUFFOUUsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxHQUFHLEVBQUU7WUFFYixDQUFDLENBQUMsYUFBYSxDQUFFLHFCQUFxQixFQUFFLDZCQUE2QixFQUFFLE9BQU8sQ0FBRSxDQUFDO1lBQ2pGLENBQUMsQ0FBQyxhQUFhLENBQUUscUJBQXFCLEVBQUUsc0NBQXNDLEVBQUUsT0FBTyxDQUFFLENBQUM7UUFDOUYsQ0FBQyxDQUFFLENBQUM7UUFFSixRQUFRLENBQUMscUJBQXFCLENBQUUsb0JBQW9CLENBQUUsQ0FBQyxZQUFZLENBQUUseUJBQXlCLENBQUUsQ0FBQztRQUNqRyxRQUFRLENBQUMscUJBQXFCLENBQUUseUJBQXlCLENBQUUsQ0FBQyxZQUFZLENBQUUsOEJBQThCLENBQUUsQ0FBQztRQUMzRyxRQUFRLENBQUMscUJBQXFCLENBQUUsOEJBQThCLENBQUUsQ0FBQyxZQUFZLENBQUUsUUFBUSxDQUFFLENBQUM7SUFFOUYsQ0FBQyxDQUFDO0lBRUYsT0FBTztRQUNILFNBQVMsRUFBRSxVQUFVO0tBQ3hCLENBQUM7QUFFTixDQUFDLENBQUUsRUFBRSxDQUFDO0FBS04sQ0FBRTtJQUVFLENBQUMsQ0FBQyxvQkFBb0IsQ0FBRSxrQkFBa0IsRUFBRSxDQUFDLENBQUMsZUFBZSxFQUFFLEVBQUUsY0FBYyxDQUFDLFNBQVMsQ0FBRSxDQUFDO0FBQ2hHLENBQUMsQ0FBRSxFQUFFLENBQUMifQ==