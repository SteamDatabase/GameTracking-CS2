"use strict";
/// <reference path="csgo.d.ts" />
var GameModeFlags = (function () {
    const k_gamemodeflags = {
        competitive: {
            name: 'competitive',
            flags: [
                16
            ],
            icons: [
                'file://{images}/icons/ui/timer_long.svg'
            ],
            user_visible_flags: false
        },
        deathmatch: {
            name: 'deathmatch',
            flags: [
                32
            ],
            icons: [
                'file://{images}/icons/ui/free_for_all.svg'
            ],
            user_visible_flags: true
        }
    };
    function _GetIcon(mode, flags) {
        const iconIndex = k_gamemodeflags[mode].flags.indexOf(flags);
        return k_gamemodeflags[mode].icons[iconIndex];
    }
    function _GetOptionsString(mode) {
        let s = '';
        const arr = k_gamemodeflags[mode].flags;
        for (let i = 0; i < arr.length; ++i) {
            s += '&option' + i + '=' + arr[i];
        }
        return s;
    }
    function _AreFlagsValid(mode, flags) {
        const arrPossibleFlags = k_gamemodeflags[mode].flags;
        return (arrPossibleFlags.indexOf(flags) != -1);
    }
    function _DoesModeUseFlags(mode) {
        return k_gamemodeflags.hasOwnProperty(mode);
    }
    function _DoesModeShowUserVisibleFlags(mode) {
        return (k_gamemodeflags.hasOwnProperty(mode)) ? k_gamemodeflags[mode].user_visible_flags : false;
    }
    function _GetFlags() {
        return k_gamemodeflags;
    }
    return {
        GetOptionsString: _GetOptionsString,
        GetIcon: _GetIcon,
        AreFlagsValid: _AreFlagsValid,
        DoesModeUseFlags: _DoesModeUseFlags,
        DoesModeShowUserVisibleFlags: _DoesModeShowUserVisibleFlags,
        GetFlags: _GetFlags
    };
})();
(function () {
})();
