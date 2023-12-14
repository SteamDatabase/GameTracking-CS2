"use strict";
/// <reference path="../csgo.d.ts" />
var Collapse = (function () {
    const _LogInternal = function (str) {
    };
    const _LogInternalEmpty = function (str) { };
    const _Log = _LogInternalEmpty;
    const _RegisterTransitionEndEventHandler = function (panel) {
        if (panel.Collapse_OnTransitionEndEvent === undefined) {
            panel.Collapse_OnTransitionEndEvent = function (panelName, propertyName) {
                if (panel.id === panelName && propertyName === 'height' && panel.BHasClass('Collapsing')) {
                    _Log('Collpase - End of transition');
                    panel.RemoveClass('Collapsing');
                    panel.style.height = null;
                    return true;
                }
                return false;
            };
            $.RegisterEventHandler('PropertyTransitionEnd', panel, panel.Collapse_OnTransitionEndEvent);
            _Log('Collpase transition end event registered');
        }
    };
    const _Show = function (panel, bIsStyleHeightFitChildren) {
        _Log('Collapse.Show ' + panel.id);
        _RegisterTransitionEndEventHandler(panel);
        panel.AddClass('Collapsing');
        if (bIsStyleHeightFitChildren) {
            panel.style.height = panel.contentheight + 'px';
        }
        panel.RemoveClass('Collapsed');
    };
    const _Hide = function (panel, bIsStyleHeightFitChildren) {
        _Log('Collapse.Hide ' + panel.id);
        _RegisterTransitionEndEventHandler(panel);
        if (panel.BHasClass('Collapsed')) {
            return;
        }
        if (bIsStyleHeightFitChildren) {
            panel.style.height = panel.contentheight + 'px';
        }
        panel.AddClass('Collapsing');
        panel.AddClass('Collapsed');
        if (bIsStyleHeightFitChildren) {
            panel.style.height = '0px';
        }
    };
    const _Toggle = function (panel, bIsStyleHeightFitChildren) {
        _Log('Collapse.Toggle ' + panel.id);
        if (panel.BHasClass('Collapsed')) {
            _Show(panel, bIsStyleHeightFitChildren);
        }
        else {
            _Hide(panel, bIsStyleHeightFitChildren);
        }
    };
    return {
        Show: _Show,
        Hide: _Hide,
        Toggle: _Toggle
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY29sbGFwc2UuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9jb21tb24vY29sbGFwc2UudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUVyQyxJQUFJLFFBQVEsR0FBRyxDQUFFO0lBR2IsTUFBTSxZQUFZLEdBQUcsVUFBVyxHQUFXO0lBRzNDLENBQUMsQ0FBQztJQUNGLE1BQU0saUJBQWlCLEdBQUcsVUFBVyxHQUFXLElBQVcsQ0FBQyxDQUFDO0lBRTdELE1BQU0sSUFBSSxHQUFHLGlCQUFpQixDQUFDO0lBSS9CLE1BQU0sa0NBQWtDLEdBQUcsVUFBVyxLQUE2QjtRQUUvRSxJQUFLLEtBQUssQ0FBQyw2QkFBNkIsS0FBSyxTQUFTLEVBQ3REO1lBRUksS0FBSyxDQUFDLDZCQUE2QixHQUFHLFVBQVcsU0FBUyxFQUFFLFlBQVk7Z0JBRXBFLElBQUssS0FBSyxDQUFDLEVBQUUsS0FBSyxTQUFTLElBQUksWUFBWSxLQUFLLFFBQVEsSUFBSSxLQUFLLENBQUMsU0FBUyxDQUFFLFlBQVksQ0FBRSxFQUMzRjtvQkFDSSxJQUFJLENBQUUsOEJBQThCLENBQUUsQ0FBQztvQkFFdkMsS0FBSyxDQUFDLFdBQVcsQ0FBRSxZQUFZLENBQUUsQ0FBQztvQkFFbEMsS0FBSyxDQUFDLEtBQUssQ0FBQyxNQUFNLEdBQUcsSUFBSSxDQUFDO29CQUUxQixPQUFPLElBQUksQ0FBQztpQkFDZjtnQkFDRCxPQUFPLEtBQUssQ0FBQztZQUNqQixDQUFDLENBQUM7WUFHRixDQUFDLENBQUMsb0JBQW9CLENBQUUsdUJBQXVCLEVBQUUsS0FBSyxFQUFFLEtBQUssQ0FBQyw2QkFBNkIsQ0FBRSxDQUFDO1lBQzlGLElBQUksQ0FBRSwwQ0FBMEMsQ0FBRSxDQUFDO1NBQ3REO0lBQ0wsQ0FBQyxDQUFDO0lBRUYsTUFBTSxLQUFLLEdBQUcsVUFBVyxLQUFjLEVBQUUseUJBQWtDO1FBRXZFLElBQUksQ0FBRSxnQkFBZ0IsR0FBRyxLQUFLLENBQUMsRUFBRSxDQUFFLENBQUM7UUFFcEMsa0NBQWtDLENBQUUsS0FBSyxDQUFFLENBQUM7UUFHNUMsS0FBSyxDQUFDLFFBQVEsQ0FBRSxZQUFZLENBQUUsQ0FBQztRQUUvQixJQUFLLHlCQUF5QixFQUM5QjtZQUtJLEtBQUssQ0FBQyxLQUFLLENBQUMsTUFBTSxHQUFHLEtBQUssQ0FBQyxhQUFhLEdBQUcsSUFBSSxDQUFDO1NBQ25EO1FBRUQsS0FBSyxDQUFDLFdBQVcsQ0FBRSxXQUFXLENBQUUsQ0FBQztJQUNyQyxDQUFDLENBQUM7SUFFRixNQUFNLEtBQUssR0FBRyxVQUFXLEtBQWMsRUFBRSx5QkFBa0M7UUFFdkUsSUFBSSxDQUFFLGdCQUFnQixHQUFHLEtBQUssQ0FBQyxFQUFFLENBQUUsQ0FBQztRQUVwQyxrQ0FBa0MsQ0FBRSxLQUFLLENBQUUsQ0FBQztRQUU1QyxJQUFLLEtBQUssQ0FBQyxTQUFTLENBQUUsV0FBVyxDQUFFLEVBQ25DO1lBQ0ksT0FBTztTQUNWO1FBRUQsSUFBSyx5QkFBeUIsRUFDOUI7WUFLSSxLQUFLLENBQUMsS0FBSyxDQUFDLE1BQU0sR0FBRyxLQUFLLENBQUMsYUFBYSxHQUFHLElBQUksQ0FBQztTQUNuRDtRQUdELEtBQUssQ0FBQyxRQUFRLENBQUUsWUFBWSxDQUFFLENBQUM7UUFDL0IsS0FBSyxDQUFDLFFBQVEsQ0FBRSxXQUFXLENBQUUsQ0FBQztRQUU5QixJQUFLLHlCQUF5QixFQUM5QjtZQUVJLEtBQUssQ0FBQyxLQUFLLENBQUMsTUFBTSxHQUFHLEtBQUssQ0FBQztTQUM5QjtJQUNMLENBQUMsQ0FBQztJQUVGLE1BQU0sT0FBTyxHQUFHLFVBQVcsS0FBYyxFQUFFLHlCQUFrQztRQUV6RSxJQUFJLENBQUUsa0JBQWtCLEdBQUcsS0FBSyxDQUFDLEVBQUUsQ0FBRSxDQUFDO1FBRXRDLElBQUssS0FBSyxDQUFDLFNBQVMsQ0FBRSxXQUFXLENBQUUsRUFDbkM7WUFDSSxLQUFLLENBQUUsS0FBSyxFQUFFLHlCQUF5QixDQUFFLENBQUM7U0FDN0M7YUFFRDtZQUNJLEtBQUssQ0FBRSxLQUFLLEVBQUUseUJBQXlCLENBQUUsQ0FBQztTQUM3QztJQUNMLENBQUMsQ0FBQztJQUdGLE9BQU87UUFDSCxJQUFJLEVBQUUsS0FBSztRQUNYLElBQUksRUFBRSxLQUFLO1FBQ1gsTUFBTSxFQUFFLE9BQU87S0FDbEIsQ0FBQztBQUVOLENBQUMsQ0FBRSxFQUFFLENBQUMifQ==