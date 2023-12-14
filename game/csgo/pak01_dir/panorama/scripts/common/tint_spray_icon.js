"use strict";
/// <reference path="../csgo.d.ts" />
var TintSprayIcon = (function () {
    const _Tint = function (itemId, elImage) {
        if (InventoryAPI.DoesItemMatchDefinitionByName(itemId, 'spraypaint') || InventoryAPI.DoesItemMatchDefinitionByName(itemId, 'spray')) {
            const colorTint = InventoryAPI.GetSprayTintColorCode(itemId);
            if (colorTint) {
                elImage.style.washColor = colorTint.toString();
            }
            else {
                elImage.style.washColor = 'none';
            }
        }
        else {
            elImage.style.washColor = 'none';
        }
    };
    return {
        CheckIsSprayAndTint: _Tint
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoidGludF9zcHJheV9pY29uLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvY29tbW9uL3RpbnRfc3ByYXlfaWNvbi50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBSXJDLElBQUksYUFBYSxHQUFHLENBQUU7SUFFckIsTUFBTSxLQUFLLEdBQUcsVUFBVSxNQUFjLEVBQUUsT0FBZ0I7UUFFdkQsSUFBSyxZQUFZLENBQUMsNkJBQTZCLENBQUUsTUFBTSxFQUFFLFlBQVksQ0FBRSxJQUFJLFlBQVksQ0FBQyw2QkFBNkIsQ0FBRSxNQUFNLEVBQUUsT0FBTyxDQUFFLEVBQ3hJO1lBQ0MsTUFBTSxTQUFTLEdBQUcsWUFBWSxDQUFDLHFCQUFxQixDQUFFLE1BQU0sQ0FBRSxDQUFDO1lBRS9ELElBQUssU0FBUyxFQUNkO2dCQUNDLE9BQU8sQ0FBQyxLQUFLLENBQUMsU0FBUyxHQUFHLFNBQVMsQ0FBQyxRQUFRLEVBQUUsQ0FBQzthQUMvQztpQkFFRDtnQkFDQyxPQUFPLENBQUMsS0FBSyxDQUFDLFNBQVMsR0FBRyxNQUFNLENBQUM7YUFDakM7U0FDRDthQUVEO1lBQ0MsT0FBTyxDQUFDLEtBQUssQ0FBQyxTQUFTLEdBQUcsTUFBTSxDQUFDO1NBQ2pDO0lBQ0YsQ0FBQyxDQUFDO0lBZ0JGLE9BQU07UUFDTCxtQkFBbUIsRUFBRyxLQUFLO0tBRTNCLENBQUM7QUFDSCxDQUFDLENBQUMsRUFBRSxDQUFDIn0=