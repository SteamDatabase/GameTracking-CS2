"use strict";
/// <reference path="../csgo.d.ts" />
var IconUtil = (function () {
    const _SetPNGImageFallback = function (mapIconDetails, icon_image_path) {
        if (mapIconDetails.m_type == 'svg') {
            mapIconDetails.m_type = 'png';
            mapIconDetails.m_icon.SetImage(icon_image_path + '.png');
        }
        else {
            mapIconDetails.m_icon.SetImage('file://{images}/map_icons/map_icon_NONE.png');
        }
    };
    const _SetupFallbackMapIcon = function (elIconPanel, icon_image_path) {
        const mapIconDetails = { m_icon: elIconPanel, m_type: 'svg', m_handler: -1 };
        $.RegisterEventHandler('ImageFailedLoad', elIconPanel, () => _SetPNGImageFallback(mapIconDetails, icon_image_path));
    };
    return {
        SetupFallbackMapIcon: _SetupFallbackMapIcon
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaWNvbi5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2NvbW1vbi9pY29uLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUFLckMsSUFBSSxRQUFRLEdBQUcsQ0FBRTtJQVViLE1BQU0sb0JBQW9CLEdBQUcsVUFBVyxjQUE4QixFQUFFLGVBQXVCO1FBRTNGLElBQUssY0FBYyxDQUFDLE1BQU0sSUFBSSxLQUFLLEVBQ25DO1lBQ0ksY0FBYyxDQUFDLE1BQU0sR0FBRyxLQUFLLENBQUM7WUFDOUIsY0FBYyxDQUFDLE1BQU0sQ0FBQyxRQUFRLENBQUUsZUFBZSxHQUFHLE1BQU0sQ0FBRSxDQUFDO1NBQzlEO2FBRUQ7WUFFSSxjQUFjLENBQUMsTUFBTSxDQUFDLFFBQVEsQ0FBRSw2Q0FBNkMsQ0FBRSxDQUFDO1NBQ25GO0lBQ0wsQ0FBQyxDQUFDO0lBRUYsTUFBTSxxQkFBcUIsR0FBRyxVQUFXLFdBQW9CLEVBQUUsZUFBdUI7UUFFbEYsTUFBTSxjQUFjLEdBQW1CLEVBQUUsTUFBTSxFQUFFLFdBQVcsRUFBRSxNQUFNLEVBQUUsS0FBSyxFQUFFLFNBQVMsRUFBRSxDQUFDLENBQUMsRUFBRSxDQUFDO1FBQzdGLENBQUMsQ0FBQyxvQkFBb0IsQ0FBRSxpQkFBaUIsRUFBRSxXQUFXLEVBQUUsR0FBRyxFQUFFLENBQUMsb0JBQW9CLENBQUUsY0FBYyxFQUFFLGVBQWUsQ0FBRSxDQUFFLENBQUM7SUFFNUgsQ0FBQyxDQUFDO0lBRUYsT0FBTztRQUNILG9CQUFvQixFQUFFLHFCQUFxQjtLQUM5QyxDQUFDO0FBQ04sQ0FBQyxDQUFFLEVBQUUsQ0FBQyJ9