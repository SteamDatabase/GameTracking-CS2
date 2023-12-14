"use strict";
/// <reference path="../csgo.d.ts" />
var CommonUtil = (function () {
    const remap_lang_to_region = {
        af: 'za',
        ar: 'sa',
        be: 'by',
        cs: 'cz',
        da: 'dk',
        el: 'gr',
        en: 'gb',
        et: 'ee',
        ga: 'ie',
        he: 'il',
        hi: 'in',
        ja: 'jp',
        kk: 'kz',
        ko: 'kr',
        nn: 'no',
        sl: 'si',
        sr: 'rs',
        sv: 'se',
        uk: 'ua',
        ur: 'pk',
        vi: 'vn',
        zh: 'cn',
        zu: 'za',
    };
    function _SetRegionOnLabel(isoCode, elPanel, tooltip = true) {
        let tooltipString = "";
        if (isoCode) {
            tooltipString = $.Localize("#SFUI_Country_" + isoCode.toUpperCase());
        }
        _SetDataOnLabelInternal(isoCode, isoCode, tooltip ? tooltipString : "", elPanel, tooltipString ? false : true);
    }
    function _SetLanguageOnLabel(isoCode, elPanel, tooltip = true) {
        let tooltipString = "";
        let imgCode = isoCode;
        if (isoCode) {
            const sTranslated = $.Localize("#Language_Name_Translated_" + isoCode);
            const sLocal = $.Localize("#Language_Name_Native_" + isoCode);
            if (sTranslated && sLocal && sTranslated === sLocal) {
                tooltipString = sLocal;
            }
            else {
                tooltipString = (sTranslated && sLocal) ? sTranslated + " (" + sLocal + ")" : "";
            }
            if (remap_lang_to_region[isoCode]) {
                imgCode = remap_lang_to_region[isoCode];
            }
        }
        _SetDataOnLabelInternal(isoCode, imgCode, tooltip ? tooltipString : "", elPanel, tooltipString ? false : true);
    }
    function _SetDataOnLabelInternal(isoCode, imgCode, tooltipString, elPanel, bWarningColor) {
        if (!elPanel)
            return;
        const elLabel = elPanel.FindChildTraverse('JsRegionLabel');
        elLabel.AddClass('visible-if-not-perfectworld');
        if (isoCode) {
            elLabel.text = isoCode.toUpperCase();
            elLabel.style.backgroundImage = 'url("file://{images}/regions/' + imgCode + '.png")';
            let elTTAnchor = elLabel.FindChildTraverse('region-tt-anchor');
            if (!elTTAnchor) {
                elTTAnchor = $.CreatePanel("Panel", elLabel, elPanel.id + '-region-tt-anchor');
            }
            if (tooltipString) {
                elLabel.SetPanelEvent('onmouseover', () => UiToolkitAPI.ShowTextTooltip(elTTAnchor.id, tooltipString));
                elLabel.SetPanelEvent('onmouseout', () => UiToolkitAPI.HideTextTooltip());
            }
            elLabel.RemoveClass('hidden');
            elLabel.SetHasClass('world-region-label', true);
            elLabel.SetHasClass('world-region-label--image', true);
        }
        else {
            elLabel.AddClass('hidden');
            elLabel.SetHasClass('world-region-label', false);
            elLabel.SetHasClass('world-region-label--image', false);
        }
    }
    return {
        SetRegionOnLabel: _SetRegionOnLabel,
        SetLanguageOnLabel: _SetLanguageOnLabel,
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY29tbW9udXRpbC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2NvbW1vbi9jb21tb251dGlsLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUFJckMsSUFBSSxVQUFVLEdBQUcsQ0FBRTtJQUtsQixNQUFNLG9CQUFvQixHQUEyQjtRQUNwRCxFQUFFLEVBQUUsSUFBSTtRQUNSLEVBQUUsRUFBRSxJQUFJO1FBQ1IsRUFBRSxFQUFFLElBQUk7UUFDUixFQUFFLEVBQUUsSUFBSTtRQUNSLEVBQUUsRUFBRSxJQUFJO1FBQ1IsRUFBRSxFQUFFLElBQUk7UUFDUixFQUFFLEVBQUUsSUFBSTtRQUNSLEVBQUUsRUFBRSxJQUFJO1FBQ1IsRUFBRSxFQUFFLElBQUk7UUFDUixFQUFFLEVBQUUsSUFBSTtRQUNSLEVBQUUsRUFBRSxJQUFJO1FBQ1IsRUFBRSxFQUFFLElBQUk7UUFDUixFQUFFLEVBQUUsSUFBSTtRQUNSLEVBQUUsRUFBRSxJQUFJO1FBQ1IsRUFBRSxFQUFFLElBQUk7UUFDUixFQUFFLEVBQUUsSUFBSTtRQUNSLEVBQUUsRUFBRSxJQUFJO1FBQ1IsRUFBRSxFQUFFLElBQUk7UUFDUixFQUFFLEVBQUUsSUFBSTtRQUNSLEVBQUUsRUFBRSxJQUFJO1FBQ1IsRUFBRSxFQUFFLElBQUk7UUFDUixFQUFFLEVBQUUsSUFBSTtRQUNSLEVBQUUsRUFBRSxJQUFJO0tBQ1IsQ0FBQztJQUdGLFNBQVMsaUJBQWlCLENBQUcsT0FBZSxFQUFFLE9BQWdCLEVBQUUsVUFBbUIsSUFBSTtRQUV0RixJQUFJLGFBQWEsR0FBRyxFQUFFLENBQUM7UUFDdkIsSUFBSyxPQUFPLEVBQ1o7WUFDQyxhQUFhLEdBQUcsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxnQkFBZ0IsR0FBRyxPQUFPLENBQUMsV0FBVyxFQUFFLENBQUUsQ0FBQztTQUN2RTtRQUNELHVCQUF1QixDQUFFLE9BQU8s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