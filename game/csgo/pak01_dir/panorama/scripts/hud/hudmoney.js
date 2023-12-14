"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../digitpanel.ts" />
var MoneyPanel = (function () {
    $.RegisterEventHandler('UpdateHudMoney', $.GetContextPanel(), _UpdateMoney);
    function _UpdateMoney(amt, bInstant = false) {
        const elContainer = $('#jsRotaryMoney');
        if (elContainer) {
            if (!$('#DigitPanel'))
                DigitPanelFactory.MakeDigitPanel(elContainer, 6, '', 0.6, "#digitpanel_digits_hudmoney");
            DigitPanelFactory.SetDigitPanelString(elContainer, '$' + amt, bInstant);
        }
    }
    return {
        UpdateMoney: _UpdateMoney,
    };
})();
(function () {
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaHVkbW9uZXkuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9odWQvaHVkbW9uZXkudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUNyQyx5Q0FBeUM7QUFFekMsSUFBSSxVQUFVLEdBQUcsQ0FBRTtJQUdsQixDQUFDLENBQUMsb0JBQW9CLENBQUUsZ0JBQWdCLEVBQUUsQ0FBQyxDQUFDLGVBQWUsRUFBRSxFQUFFLFlBQVksQ0FBRSxDQUFDO0lBRTlFLFNBQVMsWUFBWSxDQUFHLEdBQVcsRUFBRSxXQUFvQixLQUFLO1FBRTdELE1BQU0sV0FBVyxHQUFHLENBQUMsQ0FBRSxnQkFBZ0IsQ0FBRSxDQUFDO1FBRTFDLElBQUssV0FBVyxFQUNoQjtZQUNDLElBQUssQ0FBQyxDQUFDLENBQUUsYUFBYSxDQUFFO2dCQUN2QixpQkFBaUIsQ0FBQyxjQUFjLENBQUUsV0FBVyxFQUFFLENBQUMsRUFBRSxFQUFFLEVBQUUsR0FBRyxFQUFFLDZCQUE2QixDQUFFLENBQUM7WUFFNUYsaUJBQWlCLENBQUMsbUJBQW1CLENBQUUsV0FBVyxFQUFFLEdBQUcsR0FBRyxHQUFHLEVBQUUsUUFBUSxDQUFFLENBQUM7U0FHMUU7SUFFRixDQUFDO0lBR0QsT0FBTztRQUNOLFdBQVcsRUFBRSxZQUFZO0tBQ3pCLENBQUM7QUFFSCxDQUFDLENBQUUsRUFBRSxDQUFDO0FBS04sQ0FBRTtBQUVGLENBQUMsQ0FBRSxFQUFFLENBQUMifQ==