"use strict";
/// <reference path="csgo.d.ts" />
var DigitPanelFactory = (function () {
    function _MakeDigitPanel(elParent, nDigits, suffix = undefined, duration = 0.5, digitStringToken = "#digitpanel_digits", timingFunc = 'cubic-bezier( 0.9, 0.01, 0.1, 1 )') {
        elParent.RemoveAndDeleteChildren();
        const elContainer = $.CreatePanel('Panel', elParent, 'DigitPanel');
        elContainer.m_nDigits = nDigits;
        elContainer.m_suffix = suffix;
        elContainer.m_duration = duration;
        elContainer.m_strDigitsToken = digitStringToken;
        elContainer.m_timingFunc = timingFunc;
        elContainer.m_pendingSetStringHandle = null;
        elContainer.m_bPendingSetStringInstant = false;
        elContainer.style.flowChildren = 'right';
        elContainer.style.overflow = 'clip';
        _MakeDigitPanelContents(elContainer);
        return elContainer;
    }
    function _UpdateSuffix(elContainer) {
        if (elContainer.m_suffix != undefined) {
            var elSuffixLabel = elContainer.FindChildTraverse('DigitPanel-Suffix');
            if (!elSuffixLabel) {
                elSuffixLabel = $.CreatePanel('Label', elContainer, 'DigitPanel-Suffix');
                elSuffixLabel.style.marginLeft = '2px';
                elSuffixLabel.style.height = "100%";
                elSuffixLabel.style.textAlign = "right";
            }
            elSuffixLabel.text = elContainer.m_suffix;
        }
        _SetWidth(elContainer);
    }
    function _MakeDigitPanelContents(elContainer) {
        if (!elContainer.IsValid())
            return;
        const elParent = elContainer.GetParent();
        if (!elParent.IsSizeValid()) {
            $.Schedule(0.5, () => _MakeDigitPanelContents(elContainer));
        }
        else {
            const ParentHeight = Math.floor(elParent.actuallayoutheight / elParent.actualuiscale_y);
            elContainer.style.height = ParentHeight + 'px';
            for (let i = 0; i < elContainer.m_nDigits; i++) {
                const elDigit = $.CreatePanel('Panel', elContainer, 'DigitPanel-Digit-' + i);
                elDigit.style.flowChildren = 'down';
                elDigit.AddClass("digitpanel__digit");
                elDigit.style.transitionProperty = 'transform, position';
                elDigit.m_duration = elContainer.m_duration + 's';
                elDigit.style.transitionDuration = elContainer.m_duration + 's';
                elDigit.style.transitionTimingFunction = elContainer.m_timingFunc;
                const arrSymbols = $.Localize(elContainer.m_strDigitsToken).split("");
                arrSymbols.forEach(function (number) {
                    const elNumeralLabel = $.CreatePanel('Label', elDigit, 'DigitPanel-Numeral-' + number);
                    elNumeralLabel.style.textAlign = 'center';
                    elNumeralLabel.style.letterSpacing = '0px';
                    elNumeralLabel.text = number;
                    elNumeralLabel.style.height = ParentHeight + "px";
                    elNumeralLabel.style.horizontalAlign = 'center';
                    elNumeralLabel.AddClass('digitpanel-font');
                });
            }
            _UpdateSuffix(elContainer);
        }
    }
    function _SetWidth(elContainer) {
        if (!elContainer || !elContainer.IsValid())
            return;
        if (!elContainer.IsSizeValid()) {
            $.Schedule(0.1, () => _SetWidth(elContainer));
        }
        else {
            const dig0 = elContainer.FindChildTraverse('DigitPanel-Digit-0');
            const nDigitWidth = Math.ceil(dig0.actuallayoutwidth / dig0.actualuiscale_x);
            let width = elContainer.m_nDigits * nDigitWidth;
            const elSuffixLabel = elContainer.FindChildTraverse('DigitPanel-Suffix');
            if (elSuffixLabel) {
                width += elSuffixLabel.actuallayoutwidth / elSuffixLabel.actualuiscale_x;
            }
            elContainer.style.width = width + 'px';
        }
    }
    function _SetDigitPanelString(elParent, string, bInstant = false) {
        if (!elParent || !elParent.IsValid())
            return;
        const elContainer = elParent.FindChildTraverse('DigitPanel');
        if (!elContainer)
            return;
        if (elContainer.m_pendingSetStringHandle !== null) {
            $.CancelScheduled(elContainer.m_pendingSetStringHandle);
            elContainer.m_pendingSetStringHandle = null;
        }
        bInstant ||= elContainer.m_bPendingSetStringInstant;
        if (elContainer.GetChildCount() === 0) {
            elContainer.m_pendingSetStringHandle = $.Schedule(0.1, () => {
                elContainer.m_pendingSetStringHandle = null;
                _SetDigitPanelString(elParent, string, bInstant);
            });
            elContainer.m_bPendingSetStringInstant = bInstant;
            return;
        }
        elContainer.m_bPendingSetStringInstant = false;
        const nDigits = elContainer.m_nDigits;
        let arrDigits = String(string).split("");
        const padsNeeded = Math.max(0, nDigits - arrDigits.length);
        if (padsNeeded > 0) {
            const padding = Array(padsNeeded).fill(" ");
            arrDigits = padding.concat(arrDigits);
            arrDigits = arrDigits.slice(0, nDigits);
        }
        const arrSymbols = $.Localize(elContainer.m_strDigitsToken).split("");
        for (let d = nDigits; d >= 0; d--) {
            const symbol = arrDigits[d];
            const elDigit = elContainer.FindChildTraverse('DigitPanel-Digit-' + d);
            if (elDigit) {
                const index = arrSymbols.indexOf(symbol);
                elDigit.visible = d < arrDigits.length;
                if (index >= 0) {
                    elDigit.style.transitionDuration = bInstant ? '0s' : elDigit.m_duration;
                    $.Schedule(0.01, () => {
                        if (elDigit && elDigit.IsValid()) {
                            elDigit.style.transform = "translate3D( " + d + "%," + -Number(index) * 100 + "%, 0px);";
                        }
                    });
                }
            }
        }
        _UpdateSuffix(elContainer);
    }
    return {
        MakeDigitPanel: _MakeDigitPanel,
        SetDigitPanelString: _SetDigitPanelString,
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZGlnaXRwYW5lbC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2RpZ2l0cGFuZWwudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUVsQyxJQUFJLGlCQUFpQixHQUFHLENBQUU7SUFvQnpCLFNBQVMsZUFBZSxDQUFHLFFBQWlCLEVBQUUsT0FBZSxFQUFFLFNBQTZCLFNBQVMsRUFBRSxXQUFtQixHQUFHLEVBQUUsbUJBQTJCLG9CQUFvQixFQUFFLGFBQXFCLG1DQUFtQztRQUV2TyxRQUFRLENBQUMsdUJBQXVCLEVBQUUsQ0FBQztRQUNuQyxNQUFNLFdBQVcsR0FBRyxDQUFDLENBQUMsV0FBVyxDQUFFLE9BQU8sRUFBRSxRQUFRLEVBQUUsWUFBWSxDQUFrQixDQUFDO1FBQ3JGLFdBQVcsQ0FBQyxTQUFTLEdBQUcsT0FBTyxDQUFDO1FBQ2hDLFdBQVcsQ0FBQyxRQUFRLEdBQUcsTUFBTSxDQUFDO1FBQzlCLFdBQVcsQ0FBQyxVQUFVLEdBQUcsUUFBUSxDQUFDO1FBQ2xDLFdBQVcsQ0FBQyxnQkFBZ0IsR0FBRyxnQkFBZ0IsQ0FBQztRQUNoRCxXQUFXLENBQUMsWUFBWSxHQUFHLFVBQVUsQ0FBQztRQUN0QyxXQUFXLENBQUMsd0JBQXdCLEdBQUcsSUFBSSxDQUFDO1FBQzVDLFdBQVcsQ0FBQywwQkFBMEIsR0FBRyxLQUFLLENBQUM7UUFFL0MsV0FBVyxDQUFDLEtBQUssQ0FBQyxZQUFZLEdBQUcsT0FBTyxDQUFDO1FBQ3pDLFdBQVcsQ0FBQyxLQUFLLENBQUMsUUFBUSxHQUFHLE1BQU0sQ0FBQztRQUVwQyx1QkFBdUIsQ0FBRSxXQUFXLENBQUUsQ0FBQztRQUV2QyxPQUFPLFdBQVcsQ0FBQztJQUNwQixDQUFDO0lBRUQsU0FBUyxhQUFhLENBQUcsV0FBeUI7UUFHakQsSUFBSyxXQUFXLENBQUMsUUFBUSxJQUFJLFNBQVMsRUFDdEM7WUFDQyxJQUFJLGFB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