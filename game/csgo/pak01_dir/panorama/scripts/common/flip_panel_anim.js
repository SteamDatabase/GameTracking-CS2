"use strict";
/// <reference path="../csgo.d.ts" />
var FlipPanelAnimation = (function () {
    class FlipPanelAnimation {
        oData;
        get ActiveIndex() { return this.oData.activeIndex; }
        set ActiveIndex(value) { this.oData.activeIndex = value; }
        set CallbackData(value) { this.oData.oCallbackData = value; }
        constructor(oData) {
            this.oData = oData;
        }
        AddParamToCallbackData(param, value) {
            this.oData.oCallbackData[param] = value;
        }
        ;
        ControlBtnActions() {
            if (this.oData.controlBtnPrev) {
                this.oData.controlBtnPrev.SetPanelEvent('onactivate', this.oData.funcCallback.bind(this, this.oData, true));
                this.oData.controlBtnNext.SetPanelEvent('onactivate', this.oData.funcCallback.bind(this, this.oData, false));
                this.oData.controlBtnPrev.enabled = false;
                this.oData.controlBtnNext.enabled = false;
            }
        }
        ;
        UpdateTextLabel(elPanel, aTextData) {
            aTextData.forEach(element => {
                if (typeof element.value == 'number' && element.value > 0) {
                    elPanel.SetDialogVariableInt(element.name, element.value);
                }
                else if (element.value) {
                    elPanel.SetDialogVariable(element.name, element.value.toString());
                }
            });
        }
        ;
        UseCallback() {
            this.oData.funcCallback(this.oData, false);
        }
        ;
        DetermineVisiblePanel(animPanelA, animPanelB) {
            return animPanelA.BHasClass('flip-panel-anim-down-show') || animPanelA.BHasClass('flip-panel-anim-up-show') ? animPanelA : animPanelB;
        }
        ;
        BtnPressNextAnim(panelA, panelB) {
            const visiblePanel = this.DetermineVisiblePanel(panelA, panelB);
            const hiddenPanel = visiblePanel === panelA ? panelB : panelA;
            visiblePanel.RemoveClass('flip-panel-anim-transition');
            visiblePanel.RemoveClass('flip-panel-anim-up-hidden');
            visiblePanel.RemoveClass('flip-panel-anim-down-show');
            visiblePanel.RemoveClass('flip-panel-anim-up-show');
            visiblePanel.RemoveClass('flip-panel-anim-down-hidden');
            visiblePanel.AddClass('flip-panel-anim-transition');
            visiblePanel.AddClass('flip-panel-anim-down-hidden');
            hiddenPanel.RemoveClass('flip-panel-anim-transition');
            hiddenPanel.RemoveClass('flip-panel-anim-down-hidden');
            hiddenPanel.AddClass('flip-panel-anim-up-hidden');
            hiddenPanel.AddClass('flip-panel-anim-transition');
            hiddenPanel.AddClass('flip-panel-anim-down-show');
        }
        ;
        BtnPressPrevAnim(panelA, panelB) {
            const visiblePanel = this.DetermineVisiblePanel(panelA, panelB);
            const hiddenPanel = visiblePanel === panelA ? panelB : panelA;
            visiblePanel.RemoveClass('flip-panel-anim-transition');
            visiblePanel.RemoveClass('flip-panel-anim-up-hidden');
            visiblePanel.RemoveClass('flip-panel-anim-down-show');
            visiblePanel.RemoveClass('flip-panel-anim-up-show');
            visiblePanel.RemoveClass('flip-panel-anim-down-hidden');
            visiblePanel.AddClass('flip-panel-anim-transition');
            visiblePanel.AddClass('flip-panel-anim-up-hidden');
            hiddenPanel.RemoveClass('flip-panel-anim-transition');
            hiddenPanel.RemoveClass('flip-panel-anim-up-hidden');
            hiddenPanel.AddClass('flip-panel-anim-down-hidden');
            hiddenPanel.AddClass('flip-panel-anim-transition');
            hiddenPanel.AddClass('flip-panel-anim-up-show');
        }
        ;
        DetermineHiddenPanel(animPanelA, animPanelB) {
            return (!animPanelA.BHasClass('flip-panel-anim-down-show') &&
                !animPanelA.BHasClass('flip-panel-anim-up-show')) ?
                animPanelA : animPanelB;
        }
        ;
    }
    return {
        Constructor: FlipPanelAnimation
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZmxpcF9wYW5lbF9hbmltLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvY29tbW9uL2ZsaXBfcGFuZWxfYW5pbS50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBZ0JyQyxJQUFJLGtCQUFrQixHQUFHLENBQUU7SUFFMUIsTUFBTSxrQkFBa0I7UUFFdkIsS0FBSyxDQUF5QjtRQUU5QixJQUFXLFdBQVcsS0FBTSxPQUFPLElBQUksQ0FBQyxLQUFLLENBQUMsV0FBVyxDQUFDLENBQUMsQ0FBQztRQUM1RCxJQUFXLFdBQVcsQ0FBRyxLQUFhLElBQUssSUFBSSxDQUFDLEtBQUssQ0FBQyxXQUFXLEdBQUcsS0FBSyxDQUFDLENBQUMsQ0FBQztRQUU1RSxJQUFXLFlBQVksQ0FBRyxLQUFrQyxJQUFLLElBQUksQ0FBQyxLQUFLLENBQUMsYUFBYSxHQUFHLEtBQUssQ0FBQyxDQUFDLENBQUM7UUFFcEcsWUFBYSxLQUE2QjtZQUV6QyxJQUFJLENBQUMsS0FBSyxHQUFHLEtBQUssQ0FBQztRQUNwQixDQUFDO1FBRUQsc0JBQXNCLENBQUcsS0FBc0IsRUFBRSxLQUFzQjtZQUV0RSxJQUFJLENBQUMsS0FBSyxDQUFDLGFBQWEsQ0FBRSxLQUFLLENBQUUsR0FBRyxLQUFLLENBQUM7UUFDM0MsQ0FBQztRQUFBLENBQUM7UUFFRixpQkFBaUI7WUFFaEIsSUFBSyxJQUFJLENBQUMsS0FBSyxDQUFDLGNBQWMsRUFDOUI7Z0JBQ0MsSUFBSSxDQUFDLEtBQUssQ0FBQyxjQUFjLENBQUMsYUFBYSxDQUFFLFlBQVksRUFBRSxJQUFJLENBQUMsS0FBSyxDQUFDLFlBQVksQ0FBQyxJQUFJLENBQUUsSUFBSSxFQUFFLElBQUksQ0FBQyxLQUFLLEVBQUUsSUFBSSxDQUFFLENBQUUsQ0FBQztnQkFDaEgsSUFBSSxDQUFDLEtBQUssQ0FBQyxjQUFjLENBQUMsYUFBYSxDQUFFLFlB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