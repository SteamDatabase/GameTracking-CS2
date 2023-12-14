"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/async.ts" />
var HudEdgePositions;
(function (HudEdgePositions) {
    const m_CP = $.GetContextPanel();
    const m_Edge = $('#HudEdge');
    const m_XSlider = $('#HudEdgeX');
    const m_YSlider = $('#HudEdgeY');
    async function Init() {
        m_XSlider.OnShow();
        m_YSlider.OnShow();
        await Async.NextFrame();
        HudEdgePositions.Update();
    }
    HudEdgePositions.Init = Init;
    function Update() {
        const height = m_CP.actuallayoutheight / m_CP.actualuiscale_y;
        const width = m_CP.actuallayoutwidth / m_CP.actualuiscale_x;
        const minHeight = m_YSlider.actualvalue * height;
        m_XSlider.min = minHeight / width;
        if (m_XSlider.actualvalue < m_XSlider.min)
            m_XSlider.actualvalue = m_XSlider.min;
        m_Edge.style.margin = `${(1 - m_YSlider.actualvalue) * 100 / 2}% ${(1 - m_XSlider.actualvalue) * 100 / 2}%`;
    }
    HudEdgePositions.Update = Update;
    ;
})(HudEdgePositions || (HudEdgePositions = {}));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfaHVkX2VkZ2VfcG9zaXRpb25zLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvcG9wdXBzL3BvcHVwX2h1ZF9lZGdlX3Bvc2l0aW9ucy50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBQ3JDLDJDQUEyQztBQUUzQyxJQUFVLGdCQUFnQixDQStCekI7QUEvQkQsV0FBVSxnQkFBZ0I7SUFFdEIsTUFBTSxJQUFJLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDO0lBQ2pDLE1BQU0sTUFBTSxHQUFHLENBQUMsQ0FBRSxVQUFVLENBQUcsQ0FBQztJQUNoQyxNQUFNLFNBQVMsR0FBRyxDQUFDLENBQUUsV0FBVyxDQUEwQixDQUFDO0lBQzNELE1BQU0sU0FBUyxHQUFHLENBQUMsQ0FBRSxXQUFXLENBQTBCLENBQUM7SUFFcEQsS0FBSyxVQUFVLElBQUk7UUFLdEIsU0FBUyxDQUFDLE1BQU0sRUFBRSxDQUFDO1FBQ25CLFNBQVMsQ0FBQyxNQUFNLEVBQUUsQ0FBQztRQUVuQixNQUFNLEtBQUssQ0FBQyxTQUFTLEVBQUUsQ0FBQztRQUV4QixnQkFBZ0IsQ0FBQyxNQUFNLEVBQUUsQ0FBQztJQUM5QixDQUFDO0lBWHFCLHFCQUFJLE9BV3pCLENBQUE7SUFFRCxTQUFnQixNQUFNO1FBRWxCLE1BQU0sTUFBTSxHQUFHLElBQUksQ0FBQyxrQkFBa0IsR0FBRyxJQUFJLENBQUMsZUFBZSxDQUFDO1FBQzlELE1BQU0sS0FBSyxHQUFHLElBQUksQ0FBQyxpQkFBaUIsR0FBRyxJQUFJLENBQUMsZUFBZSxDQUFDO1FBQzVELE1BQU0sU0FBUyxHQUFHLFNBQVMsQ0FBQyxXQUFXLEdBQUcsTUFBTSxDQUFDO1FBQ2pELFNBQVMsQ0FBQyxHQUFHLEdBQUcsU0FBUyxHQUFHLEtBQUssQ0FBQztRQUNsQyxJQUFLLFNBQVMsQ0FBQyxXQUFXLEdBQUcsU0FBUyxDQUFDLEdBQUc7WUFDdEMsU0FBUyxDQUFDLFdBQVcsR0FBRyxTQUFTLENBQUMsR0FBRyxDQUFDO1FBRTFDLE1BQU0sQ0FBQyxLQUFLLENBQUMsTUFBTSxHQUFHLEdBQUcsQ0FBRSxDQUFDLEdBQUcsU0FBUyxDQUFDLFdBQVcsQ0FBRSxHQUFHLEdBQUcsR0FBRyxDQUFDLEtBQUssQ0FBRSxDQUFDLEdBQUcsU0FBUyxDQUFDLFdBQVcsQ0FBRSxHQUFHLEdBQUcsR0FBRyxDQUFDLEdBQUcsQ0FBQztJQUNwSCxDQUFDO0lBVmUsdUJBQU0sU0FVckIsQ0FBQTtJQUFBLENBQUM7QUFDTixDQUFDLEVBL0JTLGdCQUFnQixLQUFoQixnQkFBZ0IsUUErQnpCIn0=