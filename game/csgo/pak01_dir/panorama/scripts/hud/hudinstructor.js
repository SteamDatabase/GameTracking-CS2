"use strict";
/// <reference path="../csgo.d.ts" />
var instructorPanel = (function () {
    const _ShowBinding = function (elLesson, hLocator, i) {
        if (elLesson.BHasClass('hidden')) {
            _HideBindings(elLesson);
            return;
        }
        let bindingTexture = 'icon_key_wide';
        let bindingText = '#GameUI_Icons_NONE';
        const binding = $.GetContextPanel().GetBinding(hLocator, i).toUpperCase();
        if (binding != '') {
            bindingText = '';
            if (binding === 'MOUSE1') {
                bindingTexture = 'icon_mouseLeft';
            }
            else if (binding === 'MOUSE2') {
                bindingTexture = 'icon_mouseRight';
            }
            else if (binding === 'MOUSE3') {
                bindingTexture = 'icon_mouseThree';
            }
            else if (binding === 'MWHEELUP') {
                bindingTexture = 'icon_mouseWheel_up';
            }
            else if (binding === 'MWHEELDOWN') {
                bindingTexture = 'icon_mouseWheel_down';
            }
            else if (binding === 'UPARROW') {
                bindingTexture = 'icon_key_up';
            }
            else if (binding === 'LEFTARROW') {
                bindingTexture = 'icon_key_left';
            }
            else if (binding === 'DOWNARROW') {
                bindingTexture = 'icon_key_down';
            }
            else if (binding === 'RIGHTARROW') {
                bindingTexture = 'icon_key_right';
            }
            else if (binding === 'SEMICOLON') {
                bindingTexture = 'icon_key_generic';
                bindingText = ';';
            }
            else if (binding.length <= 3) {
                bindingTexture = 'icon_key_generic';
                bindingText = binding;
            }
            else {
                bindingTexture = 'icon_key_wide';
                bindingText = binding;
            }
            const elBindingLabel = elLesson.FindChildTraverse('LocatorBindingText');
            const bShowBindingText = (bindingText != '');
            elLesson.SetHasClass('ShowBindingText', bShowBindingText);
            if (bShowBindingText) {
                elBindingLabel.text = $.Localize(bindingText);
            }
            elLesson.SwitchClass('BindingIcon', bindingTexture);
            if (elLesson.bindingCount && elLesson.bindingCount > 1) {
                let iNext = i + 1;
                if (iNext == elLesson.bindingCount) {
                    iNext = 0;
                }
                elLesson.animhandle = $.Schedule(.75, () => _ShowBinding(elLesson, hLocator, iNext));
            }
        }
    };
    const _HideBindings = function (elLesson) {
        if (elLesson.animhandle) {
            $.CancelScheduled(elLesson.animhandle);
            elLesson.animhandle = undefined;
        }
        elLesson.SetHasClass('ShowBindingText', false);
        elLesson.SwitchClass('BindingIcon', 'none');
    };
    const _OnShowBindingsEvent = function (elLesson, hLocator, bindingCount) {
        _HideBindings(elLesson);
        elLesson.bindingCount = bindingCount;
        _ShowBinding(elLesson, hLocator, 0);
    };
    const _OnHideBindingsEvent = function (elLesson) {
        _HideBindings(elLesson);
    };
    return {
        OnShowBindingsEvent: _OnShowBindingsEvent,
        OnHideBindingsEvent: _OnHideBindingsEvent
    };
})();
(function () {
    $.RegisterEventHandler('CSGOHudInstructorShowBindings', $.GetContextPanel(), instructorPanel.OnShowBindingsEvent);
    $.RegisterEventHandler('CSGOHudInstructorHideBindings', $.GetContextPanel(), instructorPanel.OnHideBindingsEvent);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaHVkaW5zdHJ1Y3Rvci5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2h1ZC9odWRpbnN0cnVjdG9yLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUFFckMsSUFBSSxlQUFlLEdBQUcsQ0FBRTtJQVV2QixNQUFNLFlBQVksR0FBRyxVQUFXLFFBQXVCLEVBQUUsUUFBZ0IsRUFBRSxDQUFTO1FBRW5GLElBQUssUUFBUSxDQUFDLFNBQVMsQ0FBRSxRQUFRLENBQUUsRUFDbkM7WUFDQyxhQUFhLENBQUUsUUFBUSxDQUFFLENBQUM7WUFDMUIsT0FBTztTQUNQO1FBRUQsSUFBSSxjQUFjLEdBQUcsZUFBZSxDQUFDO1FBQ3JDLElBQUksV0FBVyxHQUFHLG9CQUFvQixDQUFDO1FBQ3ZDLE1BQU0sT0FBTyxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQXVCLENBQUMsVUFBVSxDQUFFLFFBQVEsRUFBRSxDQUFDLENBQUUsQ0FBQyxXQUFXLEVBQUUsQ0FBQztRQUNqRyxJQUFLLE9BQU8sSUFBSSxFQUFFLEVBQ2xCO1lBQ0MsV0FBVyxHQUFHLEVBQUUsQ0FBQztZQUVqQixJQUFLLE9BQU8sS0FBSyxRQUFRLEVBQ3pCO2dCQUNDLGNBQWMsR0FBRyxnQkFBZ0IsQ0FBQzthQUNsQztpQkFDSSxJQUFLLE9BQU8sS0FBSyxRQUFRLEVBQzlCO2dCQUNDLGNBQWMsR0FBRyxpQkFBaUIsQ0FBQzthQUNuQztpQkFDSSxJQUFLLE9BQU8sS0FBSyxRQUFRLEVBQzlCO2dCQUNDLGNBQWMsR0FBRyxpQkFBaUIsQ0FBQzthQUNuQztpQkFDSSxJQUFLLE9BQU8sS0FBSyxVQUFVLEVBQ2hDO2dCQUNDLGNBQWMsR0FBRyxvQkFBb0IsQ0FBQzthQUN0QztpQkFDSSxJQUFLLE9BQU8sS0FBSyxZQUFZLEVBQ2xDO2dCQUNDLGNBQWMsR0FBRyxzQkFBc0IsQ0FBQzthQUN4QztpQkFDSSxJQUFLLE9BQU8sS0FBSyxTQUFTLEVBQy9CO2dCQUNDLGNBQWMsR0FBRyxhQUFhLENBQUM7YUFDL0I7aUJBQ0ksSUFBSyxPQUFPLEtBQUssV0FBVyxFQUNqQztnQkFDQyxjQUFjLEdBQUcsZUFBZSxDQUFDO2FBQ2pDO2lCQUNJLElBQUssT0FBTyxLQUFLLFdBQVcsRUFDakM7Z0JBQ0MsY0FBYyxHQUFHLGVBQWUsQ0FBQzthQUNqQztpQkFDSSxJQUFLLE9BQU8sS0FBSyxZQUFZLEVBQ2xDO2dCQUNDLGNBQWMsR0FBRyxnQkFBZ0IsQ0FBQzthQUNsQztpQkFDSSxJQUFLLE9BQU8sS0FBSyxXQUFXLEVBQ2pDO2dCQUNDLGNBQWMsR0FBRyxrQkFBa0IsQ0FBQztnQkFDcEMsV0FBVyxHQUFHLEdBQUcsQ0FBQzthQUNsQjtpQkFDSSxJQUFLLE9BQU8sQ0FBQyxNQUFNLElBQUksQ0FBQyxFQUM3QjtnQkFDQyxjQUFjLEdBQUcsa0JBQWtCLENBQUM7Z0JBQ3BDLFdBQVcsR0FBRyxPQUFPLENBQUM7YUFDdEI7aUJBRUQ7Z0JBQ0MsY0FBYyxHQUFHLGVBQWUsQ0FBQztnQkFDakMsV0FBVyxHQUFHLE9BQU8sQ0FBQzthQUN0QjtZQUVELE1BQU0sY0FBYyxHQUFHLFFBQVEsQ0FBQyxpQkFBaUIsQ0FBRSxvQkFBb0IsQ0FBYSxDQUFDO1lBQ3JGLE1BQU0sZ0JBQWdCLEdBQUcsQ0FBRSxXQUFXLElBQUksRUFBRSxDQUFFLENBQUM7WUFDL0MsUUFBUSxDQUFDLFdBQVcsQ0FBRSxpQkFBaUIsRUFBRSxnQkFBZ0IsQ0FBRSxDQUFDO1lBQzVELElBQUssZ0JBQWdCLEVBQ3JCO2dCQUNDLGNBQWMsQ0FBQyxJQUFJLEdBQUcsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxXQUFXLENBQUUsQ0FBQzthQUNoRDtZQUVELFFBQVEsQ0FBQyxXQUFXLENBQUUsYUFBYSxFQUFFLGNBQWMsQ0FBRSxDQUFDO1lBRXRELElBQUssUUFBUSxDQUFDLFlBQVksSUFBSSxRQUFRLENBQUMsWUFBWSxHQUFHLENBQUMsRUFDdkQ7Z0JBRUMsSUFBSSxLQUFLLEdBQUcsQ0FBQyxHQUFHLENBQUMsQ0FBQztnQkFDbEIsSUFBSyxLQUFLLElBQUksUUFBUSxDQUFDLFlBQVksRUFDbkM7b0JBQ0MsS0FBSyxHQUFHLENBQUMsQ0FBQztpQkFDVjtnQkFDRCxRQUFRLENBQUMsVUFBVSxHQUFHLENBQUMsQ0FBQyxRQUFRLENBQUUsR0FBRyxFQUFFLEdBQUcsRUFBRSxDQUFDLFlBQVksQ0FBRSxRQUFRLEVBQUUsUUFBUSxFQUFFLEtBQUssQ0FBRSxDQUFFLENBQUM7YUFDekY7U0FDRDtJQUNGLENBQUMsQ0FBQztJQUVGLE1BQU0sYUFBYSxHQUFHLFVBQVcsUUFBdUI7UUFFdkQsSUFBSyxRQUFRLENBQUMsVUFBVSxFQUN4QjtZQUNDLENBQUMsQ0FBQyxlQUFlLENBQUUsUUFBUSxDQUFDLFVBQVUsQ0FBRSxDQUFDO1lBQ3pDLFFBQVEsQ0FBQyxVQUFVLEdBQUcsU0FBUyxDQUFDO1NBQ2hDO1FBQ0QsUUFBUSxDQUFDLFdBQVcsQ0FBRSxpQkFBaUIsRUFBRSxLQUFLLENBQUUsQ0FBQztRQUNqRCxRQUFRLENBQUMsV0FBVyxDQUFFLGFBQWEsRUFBRSxNQUFNLENBQUUsQ0FBQztJQUMvQyxDQUFDLENBQUM7SUFFRixNQUFNLG9CQUFvQixHQUFHLFVBQVcsUUFBdUIsRUFBRSxRQUFnQixFQUFFLFlBQW9CO1FBRXRHLGFBQWEsQ0FBRSxRQUFRLENBQUUsQ0FBQztRQUMxQixRQUFRLENBQUMsWUFBWSxHQUFHLFlBQVksQ0FBQztRQUNyQyxZQUFZLENBQUUsUUFBUSxFQUFFLFFBQVEsRUFBRSxDQUFDLENBQUUsQ0FBQztJQUN2QyxDQUFDLENBQUM7SUFFRixNQUFNLG9CQUFvQixHQUFHLFVBQVcsUUFBdUI7UUFFOUQsYUFBYSxDQUFFLFFBQVEsQ0FBRSxDQUFDO0lBQzNCLENBQUMsQ0FBQztJQUdGLE9BQU87UUFDTixtQkFBbUIsRUFBRSxvQkFBb0I7UUFDekMsbUJBQW1CLEVBQUUsb0JBQW9CO0tBQ3pDLENBQUM7QUFDSCxDQUFDLENBQUUsRUFBRSxDQUFDO0FBTU4sQ0FBRTtJQUVELENBQUMsQ0FBQyxvQkFBb0IsQ0FBRSwrQkFBK0IsRUFBRSxDQUFDLENBQUMsZUFBZSxFQUFFLEVBQUUsZUFBZSxDQUFDLG1CQUFtQixDQUFFLENBQUM7SUFDcEgsQ0FBQyxDQUFDLG9CQUFvQixDQUFFLCtCQUErQixFQUFFLENBQUMsQ0FBQyxlQUFlLEVBQUUsRUFBRSxlQUFlLENBQUMsbUJBQW1CLENBQUUsQ0FBQztBQUNySCxDQUFDLENBQUUsRUFBRSxDQUFDIn0=