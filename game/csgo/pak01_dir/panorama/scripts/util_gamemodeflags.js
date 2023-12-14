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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoidXRpbF9nYW1lbW9kZWZsYWdzLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvdXRpbF9nYW1lbW9kZWZsYWdzLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFVbEMsSUFBSSxhQUFhLEdBQUcsQ0FBRTtJQUVyQixNQUFNLGVBQWUsR0FBb0M7UUFJeEQsV0FBVyxFQUFFO1lBQ1osSUFBSSxFQUFFLGFBQWE7WUFDbkIsS0FBSyxFQUFFO2dCQUdOLEVBQUU7YUFDRjtZQUNELEtBQUssRUFBRTtnQkFHTix5Q0FBeUM7YUFDekM7WUFDRCxrQkFBa0IsRUFBRSxLQUFLO1NBQ3pCO1FBRUQsVUFBVSxFQUFFO1lBQ1gsSUFBSSxFQUFFLFlBQVk7WUFDbEIsS0FBSyxFQUFFO2dCQUNOLEVBQUU7YUFHRjtZQUNELEtBQUssRUFBRTtnQkFDTiwyQ0FBMkM7YUFHM0M7WUFDRCxrQkFBa0IsRUFBRSxJQUFJO1NBQ3hCO0tBQ0QsQ0FBQTtJQUVELFNBQVMsUUFBUSxDQUFHLElBQVksRUFBRSxLQUFhO1FBRTlDLE1BQU0sU0FBUyxHQUFHLGVBQWUsQ0FBRSxJQUFJLENBQUUsQ0FBQyxLQUFLLENBQUMsT0FBTyxDQUFFLEtBQUssQ0FBRSxDQUFDO1FBQ2pFLE9BQU8sZUFBZSxDQUFFLElBQUksQ0FBRSxDQUFDLEtBQUssQ0FBRSxTQUFTLENBQUUsQ0FBQztJQUNuRCxDQUFDO0lBRUQsU0FBUyxpQkFBaUIsQ0FBRyxJQUFZO1FBRXhDLElBQUksQ0FBQyxHQUFHLEVBQUUsQ0FBQztRQUNYLE1BQU0sR0FBRyxHQUFHLGVBQWUsQ0FBRSxJQUFJLENBQUUsQ0FBQyxLQUFLLENBQUM7UUFDMUMsS0FBTSxJQUFJLENBQUMsR0FBRyxDQUFDLEVBQUUsQ0FBQyxHQUFHLEdBQUcsQ0FBQyxNQUFNLEVBQUUsRUFBRSxDQUFDLEVBQ3BDO1lBQ0MsQ0FBQyxJQUFJLFNBQVMsR0FBRyxDQUFDLEdBQUcsR0FBRyxHQUFHLEdBQUcsQ0FBRSxDQUFDLENBQUUsQ0FBQztTQUNwQztRQUNELE9BQU8sQ0FBQyxDQUFDO0lBQ1YsQ0FBQztJQUVELFNBQVMsY0FBYyxDQUFHLElBQVksRUFBRSxLQUFhO1FBRXBELE1BQU0sZ0JBQWdCLEdBQUcsZUFBZSxDQUFFLElBQUksQ0FBRSxDQUFDLEtBQUssQ0FBQztRQUV2RCxPQUFPLENBQUUsZ0JBQWdCLENBQUMsT0FBTyxDQUFFLEtBQUssQ0FBRSxJQUFJLENBQUMsQ0FBQyxDQUFFLENBQUM7SUFDcEQsQ0FBQztJQUVELFNBQVMsaUJBQWlCLENBQUcsSUFBWTtRQUV4QyxPQUFPLGVBQWUsQ0FBQyxjQUFjLENBQUUsSUFBSSxDQUFFLENBQUM7SUFDL0MsQ0FBQztJQUVELFNBQVMsNkJBQTZCLENBQUcsSUFBWTtRQUVwRCxPQUFPLENBQUUsZUFBZSxDQUFDLGNBQWMsQ0FBRSxJQUFJLENBQUUsQ0FBRSxDQUFDLENBQUMsQ0FBQyxlQUFlLENBQUUsSUFBSSxDQUFFLENBQUMsa0JBQWtCLENBQUMsQ0FBQyxDQUFDLEtBQUssQ0FBQztJQUN4RyxDQUFDO0lBRUQsU0FBUyxTQUFTO1FBRWpCLE9BQU8sZUFBZSxDQUFDO0lBQ3hCLENBQUM7SUFFRCxPQUFPO1FBQ04sZ0JBQWdCLEVBQUksaUJBQWlCO1FBQ3JDLE9BQU8sRUFBTyxRQUFRO1FBQ3RCLGFBQWEsRUFBSyxjQUFjO1FBQ2hDLGdCQUFnQixFQUFJLGlCQUFpQjtRQUNyQyw0QkFBNEIsRUFBRyw2QkFBNkI7UUFDNUQsUUFBUSxFQUFNLFNBQVM7S0FDdkIsQ0FBQztBQUdILENBQUMsQ0FBRSxFQUFFLENBQUM7QUFFTixDQUFFO0FBRUYsQ0FBQyxDQUFFLEVBQUUsQ0FBQyJ9