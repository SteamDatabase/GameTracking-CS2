"use strict";
/// <reference path="../csgo.d.ts" />
var CFormattedText = class {
    tag;
    vars;
    constructor(strLocTag, mapDialogVars) {
        this.tag = strLocTag;
        this.vars = Object.assign({}, mapDialogVars);
    }
    SetOnLabel(elLabel) {
        FormatText.SetFormattedTextOnLabel(elLabel, this);
    }
};
var FormatText = (function () {
    const _FormatPluralLoc = function (sLocToken, nQuantity, nPrecision = 0) {
        let sText = $.Localize(sLocToken, nQuantity, nPrecision);
        return sText.replace(/%s1/g, nQuantity.toFixed(nPrecision));
    };
    const _SetFormattedTextOnLabel = function (elLabel, fmtText) {
        _ClearFormattedTextFromLabel(elLabel);
        elLabel.text = fmtText.tag;
        elLabel.fmtTextVars = {};
        for (const varName in fmtText.vars) {
            elLabel.SetDialogVariable(varName, elLabel.html ? $.HTMLEscape(fmtText.vars[varName]) : fmtText.vars[varName]);
            elLabel.fmtTextVars[varName] = true;
        }
    };
    const _ClearFormattedTextFromLabel = function (elLabel) {
        elLabel.text = '';
        if (!elLabel.fmtTextVars)
            return;
        for (const varName in elLabel.fmtTextVars) {
            elLabel.SetDialogVariable(varName, '');
        }
        delete elLabel.fmtTextVars;
    };
    const _SecondsToDDHHMMSSWithSymbolSeperator = function (rawSeconds) {
        const time = _ConvertSecondsToDaysHoursMinSec(rawSeconds);
        const timeText = [];
        let returnRemaining = false;
        for (const key in time) {
            const value = time[key];
            if ((value > 0 && !returnRemaining) || key == 'minutes')
                returnRemaining = true;
            if (returnRemaining) {
                const valueToShow = (value < 10) ? ('0' + value.toString()) : value.toString();
                timeText.push(valueToShow);
            }
        }
        return timeText.join(':');
    };
    const _SecondsToSignificantTimeString = function (rawSeconds) {
        rawSeconds = Math.floor(Number(rawSeconds));
        if (rawSeconds < 60)
            return _FormatPluralLoc('#SFUI_Store_Timer_Min:p', 1);
        const time = _ConvertSecondsToDaysHoursMinSec(rawSeconds);
        let numComponentsReturned = 0;
        let strResult = '';
        for (const key in time) {
            const value = time[key];
            if (key == 'seconds')
                break;
            let bAppendThisComponent = false;
            const bFinishedAfterThisComponent = (numComponentsReturned > 0);
            if (value > 0) {
                bAppendThisComponent = true;
            }
            if (bAppendThisComponent) {
                if (bFinishedAfterThisComponent)
                    strResult += ' ';
                let lockey;
                if (key == 'minutes')
                    lockey = '#SFUI_Store_Timer_Min:p';
                else if (key == 'hours')
                    lockey = '#SFUI_Store_Timer_Hour:p';
                else
                    lockey = '#SFUI_Store_Timer_Day:p';
                strResult += _FormatPluralLoc(lockey, value);
                ++numComponentsReturned;
            }
            if (bFinishedAfterThisComponent)
                break;
        }
        return strResult;
    };
    const _ConvertSecondsToDaysHoursMinSec = function (rawSeconds) {
        rawSeconds = Number(rawSeconds);
        const time = {
            days: Math.floor(rawSeconds / 86400),
            hours: Math.floor((rawSeconds % 86400) / 3600),
            minutes: Math.floor(((rawSeconds % 86400) % 3600) / 60),
            seconds: ((rawSeconds % 86400) % 3600) % 60
        };
        return time;
    };
    const _PadNumber = function (integer, digits, char = '0') {
        integer = integer.toString();
        while (integer.length < digits)
            integer = char + integer;
        return integer;
    };
    const _SplitAbbreviateNumber = function (number, fixed = 0) {
        if (number < 0)
            return -1;
        let pow10 = Math.log10(number) | 0;
        let stringToken = "";
        const locFilePrefix = "#NumberAbbreviation_suffix_E";
        do {
            stringToken = locFilePrefix + [pow10];
            if ($.Localize(stringToken) != stringToken)
                break;
        } while (--pow10 > 0);
        if ($.Localize(stringToken) == stringToken)
            return [number.toString(), ''];
        const scale = Math.pow(10, pow10);
        const scaledNumber = number / scale;
        const decimals = scaledNumber < 10.0 ? 1 : 0;
        const finalNum = scaledNumber.toFixed(fixed).replace(/\.0+$/, '');
        return [finalNum, $.Localize(stringToken)];
    };
    const _AbbreviateNumber = function (number) {
        if (number < 0)
            return -1;
        let pow10 = Math.log10(number) | 0;
        let stringToken = "";
        const locFilePrefix = "#NumberAbbreviation_E";
        function _IsLocalizationValid(symbol) {
            return (symbol === "");
        }
        do {
            stringToken = locFilePrefix + [pow10];
            if (_IsLocalizationValid($.Localize(stringToken, $.GetContextPanel())))
                break;
        } while (--pow10 > 0);
        if (!_IsLocalizationValid($.Localize(stringToken, $.GetContextPanel())))
            return number.toString();
        const scale = Math.pow(10, pow10);
        const scaledNumber = number / scale;
        const decimals = scaledNumber < 10.0 ? 1 : 0;
        const finalNum = scaledNumber.toFixed(decimals).replace(/\.0+$/, '');
        $.GetContextPanel().SetDialogVariable('abbreviated_number', finalNum);
        const result = $.Localize(stringToken, $.GetContextPanel());
        return result;
    };
    function _CapitalizeFirstLetterOfEachWord(sentence) {
        return sentence.replace(/\w\S*/g, function (txt) {
            return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
        });
    }
    function _ForceSign(num) {
        if (Number(num) >= 0)
            return '+' + num;
        else
            return String(num);
    }
    return {
        FormatPluralLoc: _FormatPluralLoc,
        SetFormattedTextOnLabel: _SetFormattedTextOnLabel,
        ClearFormattedTextFromLabel: _ClearFormattedTextFromLabel,
        SecondsToDDHHMMSSWithSymbolSeperator: _SecondsToDDHHMMSSWithSymbolSeperator,
        SecondsToSignificantTimeString: _SecondsToSignificantTimeString,
        PadNumber: _PadNumber,
        AbbreviateNumber: _AbbreviateNumber,
        SplitAbbreviateNumber: _SplitAbbreviateNumber,
        CapitalizeFirstLetterOfEachWord: _CapitalizeFirstLetterOfEachWord,
        ForceSign: _ForceSign,
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZm9ybWF0dGV4dC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2NvbW1vbi9mb3JtYXR0ZXh0LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUE0QnJDLElBQUksY0FBYyxHQUFHO0lBRXBCLEdBQUcsQ0FBUztJQUNaLElBQUksQ0FBcUI7SUFFekIsWUFBYSxTQUFpQixFQUFFLGFBQWlDO1FBRWhFLElBQUksQ0FBQyxHQUFHLEdBQUcsU0FBUyxDQUFDO1FBR3JCLElBQUksQ0FBQyxJQUFJLEdBQUcsTUFBTSxDQUFDLE1BQU0sQ0FBRSxFQUFFLEVBQUUsYUFBYSxDQUFFLENBQUM7SUFDaEQsQ0FBQztJQUVELFVBQVUsQ0FBRyxPQUFnQjtRQUU1QixVQUFVLENBQUMsdUJBQXVCLENBQUUsT0FBTyxFQUFFLElBQUksQ0FBRSxDQUFDO0lBQ3JELENBQUM7Q0FDRCxDQUFDO0FBRUYsSUFBSSxVQUFVLEdBQUcsQ0FBRTtJQUVsQixNQUFNLGdCQUFnQixHQUFHLFVBQVcsU0FBaUIsRUFBRSxTQUFpQixFQUFFLGFBQXFCLENBQUM7UUFFL0YsSUFBSSxLQUFLLEdBQUcsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxTQUFTLEVBQUUsU0FBUyxFQUFFLFVBQVUsQ0FBRSxDQUFDO1FBQzNELE9BQU8sS0FBSyxDQUFDLE9BQU8sQ0FBRSxNQUFNLEVBQUUsU0FBUyxDQUFDLE9BQU8sQ0FBRSxVQUFVLENBQUUsQ0FBRSxDQUFDO0lBQ2pFLENBQUMsQ0FBQTtJQUVELE1BQU0sd0JBQXdCLEdBQUcsVUFBVyxPQUF1QixFQUFFLE9BQW1EO1FBRXZILDRCQUE0QixDQUFFLE9BQU8sQ0FBRSxDQUFDO1FBRXhDLE9BQU8sQ0FBQyxJQUFJLEdBQUcsT0FBTyxDQUFDLEdBQUcsQ0FBQztRQUMzQixPQUFPLENBQUMsV0FBVyxHQUFHLEVBQUUsQ0FBQztRQUN6QixLQUFNLE1BQU0sT0FB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