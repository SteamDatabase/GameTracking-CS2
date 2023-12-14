"use strict";
/// <reference path="../csgo.d.ts" />
function UpdateNavContentSelectionBar(btn, elSelectionBar) {
    const selectedBtn = $('#' + btn);
    const elContentNavBar = elSelectionBar.FindChildTraverse('JsContentNavBar');
    if (!selectedBtn) {
        elContentNavBar.style.position = '0px 0px 0px';
        return;
    }
    elContentNavBar.style.position = selectedBtn.actualxoffset + 'px 0px 0px';
    elContentNavBar.style.width = selectedBtn.contentwidth + 'px';
}
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWVudWFuaW1zLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvY29tbW9uL21lbnVhbmltcy50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBRXJDLFNBQVMsNEJBQTRCLENBQUUsR0FBVyxFQUFFLGNBQXVCO0lBRXZFLE1BQU0sV0FBVyxHQUFHLENBQUMsQ0FBRSxHQUFHLEdBQUcsR0FBRyxDQUFFLENBQUM7SUFDbkMsTUFBTSxlQUFlLEdBQUcsY0FBYyxDQUFDLGlCQUFpQixDQUFFLGlCQUFpQixDQUFHLENBQUM7SUFHL0UsSUFBSSxDQUFDLFdBQVcsRUFDaEI7UUFDSSxlQUFlLENBQUMsS0FBSyxDQUFDLFFBQVEsR0FBRyxhQUFhLENBQUM7UUFDL0MsT0FBTztLQUNWO0lBRUQsZUFBZSxDQUFDLEtBQUssQ0FBQyxRQUFRLEdBQUcsV0FBVyxDQUFDLGFBQWEsR0FBRSxZQUFZLENBQUM7SUFDekUsZUFBZSxDQUFDLEtBQUssQ0FBQyxLQUFLLEdBQUcsV0FBVyxDQUFDLFlBQVksR0FBRSxJQUFJLENBQUM7QUFDakUsQ0FBQyJ9