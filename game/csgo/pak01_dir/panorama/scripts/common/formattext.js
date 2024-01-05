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
