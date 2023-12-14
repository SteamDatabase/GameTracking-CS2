"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/async.ts" />
/// <reference path="mock_adapter.ts" />
/// <reference path="match_stakes.ts" />
var TeamIntroMenu = (function () {
    const MAX_PLAYERS = 64;
    function _msg(msg) {
    }
    async function _StartTeamIntro() {
        _msg('_StartTeamIntro');
        const type = MockAdapter.GetPlayerCompetitiveRankType(GameStateAPI.GetLocalPlayerXuid());
        const elMenu = $.GetContextPanel();
        elMenu.SetHasClass('premier', type === 'Premier');
        const sLocalXuid = GameStateAPI.GetLocalPlayerXuid();
        const nLocalTeam = GameStateAPI.GetPlayerTeamNumber(sLocalXuid);
        const endPromise = Async.UnhandledEvent("EndTeamIntro");
        elMenu.SetHasClass("active", true);
        _SetFaded(true, 0);
        elMenu.StartCamera();
        const modelRefs = _SetupModels(nLocalTeam);
        _SetTeam(nLocalTeam);
        _SetupHeader(nLocalTeam);
        const teamInfoAbort = new Async.AbortController();
        _SetupTeamInfos(nLocalTeam, modelRefs, teamInfoAbort.signal);
        await Async.Delay(0.5);
        _SetFaded(false, 0.5);
        MatchStakes.StartTeamIntro();
        $.DispatchEvent('CSGOPlaySoundEffect', 'TeamIntro', 'MOUSE');
        if (nLocalTeam == 2) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'TeamIntro_TSuits', 'MOUSE');
        }
        else {
            $.DispatchEvent('CSGOPlaySoundEffect', 'TeamIntro_CTSuits', 'MOUSE');
        }
        await endPromise;
        _SetFaded(true, 0.5);
        await Async.Delay(0.5);
        teamInfoAbort.abort();
        $("#TeamIntroHeader").AddClass("hidden");
        $("#TeamIntroTeammateInfos").RemoveAndDeleteChildren();
        MatchStakes.EndTeamIntro();
        _ClearBackground();
        elMenu.StopCamera();
        elMenu.ClearModels();
        _SetFaded(false, 0.5);
        await Async.Delay(0.5);
        elMenu.SetHasClass("active", false);
    }
    function _SetTeam(nTeamNumber) {
        switch (nTeamNumber) {
            case 2:
                $.GetContextPanel().SwitchClass('team', "TERRORIST");
                break;
            case 3:
                $.GetContextPanel().SwitchClass('team', "CT");
                break;
        }
    }
    function _ClearBackground() {
        $.GetContextPanel().SwitchClass('team', "no-background");
    }
    function _SetupTeamInfos(nTeamNumber, modelRefs, abortSignal) {
        const elMenu = $.GetContextPanel();
        $("#TeamIntroTeammateInfos").RemoveAndDeleteChildren();
        const teammateInfos = new Map();
        Async.RunSequence(function* () {
            for (const ref of modelRefs.values()) {
                yield Async.Delay(1.0);
                const elInfo = _CreateTeammateInfo(ref.sXuid, ref.nOrdinal);
                teammateInfos.set(ref.nOrdinal, elInfo);
                elInfo.RemoveClass("hidden");
            }
        }, abortSignal);
        Async.RunSequence(function* () {
            while (true) {
                for (const [nOrdinal, elInfo] of teammateInfos) {
                    let { x, y } = elMenu.GetModelBonePosition(nTeamNumber, nOrdinal, "neck_0");
                    if (isFinite(x) && isFinite(y) && elInfo) {
                        y -= 10.0;
                        x -= elInfo.actuallayoutwidth / elInfo.actualuiscale_x * 0.5;
                        y -= elInfo.actuallayoutheight / elInfo.actualuiscale_y;
                        elInfo.style.transform = "translate3d( " + x + "px, " + y + "px, 0px )";
                    }
                }
                yield Async.NextFrame();
            }
        }, abortSignal);
    }
    function _CreateTeammateInfo(sXuid, nOrdinal) {
        const elInfos = $("#TeamIntroTeammateInfos");
        const elInfo = $.CreatePanel("Panel", elInfos, nOrdinal.toString());
        elInfo.BLoadLayoutSnippet("TeamIntroTeammateInfo");
        const elAvatarImage = elInfo.FindChildInLayoutFile("AvatarImage");
        elAvatarImage.PopulateFromPlayerSlot(GameStateAPI.GetPlayerSlot(sXuid));
        const elName = elInfo.FindChildInLayoutFile("Name");
        elName.text = GameStateAPI.GetPlayerName(sXuid);
        const teamColor = GameStateAPI.GetPlayerColor(sXuid);
        if (teamColor)
            elName.style.washColor = teamColor;
        return elInfo;
    }
    function _SetupModels(nLocalTeam) {
        const elMenu = $.GetContextPanel();
        elMenu.ClearModels();
        const modelRefs = [];
        for (let nOrdinal = 1;; ++nOrdinal) {
            const sXuid = elMenu.AddModel(nLocalTeam, nOrdinal);
            if (!sXuid)
                break;
            modelRefs.push({ sXuid, nOrdinal });
        }
        return modelRefs;
    }
    function _SetFaded(bVisible, transitionDuration) {
        const elFade = $("#TeamIntroFade");
        elFade.style.transitionDuration = `${transitionDuration}s`;
        elFade.SetHasClass("hidden", !bVisible);
    }
    function _SetupHeader(nTeamNumber) {
        const timeData = GameStateAPI.GetTimeDataJSO();
        const nOvertime = timeData.overtime;
        const bFirstHalf = timeData.gamephase === 2;
        $("#TeamIntroHeader").RemoveClass("hidden");
        const elIcon = $("#TeamIntroIcon");
        const elHalfLabel = $("#TeamIntroHalfLabel");
        const elTeamLabel = $("#TeamIntroTeamLabel");
        if (nOvertime > 0) {
            elHalfLabel.SetDialogVariableInt("overtime_num", nOvertime);
            elHalfLabel.SetLocString(bFirstHalf ? "#team-intro-overtime-1st-half" : "#team-intro-overtime-2nd-half");
        }
        else {
            elHalfLabel.SetLocString(bFirstHalf ? "#team-intro-1st-half" : "#team-intro-2nd-half");
        }
        switch (nTeamNumber) {
            case 2:
                if (elIcon) {
                    elIcon.SetImage("file://{images}/icons/t_logo.svg");
                }
                elTeamLabel.SetLocString(nOvertime == 0 && bFirstHalf ? "#team-intro-starting-as-t" : "#team-intro-playing-as-t");
                break;
            case 3:
                if (elIcon) {
                    elIcon.SetImage("file://{images}/icons/ct_logo.svg");
                }
                elTeamLabel.SetLocString(nOvertime == 0 && bFirstHalf ? "#team-intro-starting-as-ct" : "#team-intro-playing-as-ct");
                break;
        }
    }
    return {
        StartTeamIntro: _StartTeamIntro
    };
})();
(function () {
    $.RegisterForUnhandledEvent("StartTeamIntro", TeamIntroMenu.StartTeamIntro);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoidGVhbWludHJvbWVudS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL3RlYW1pbnRyb21lbnUudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUNsQyx3Q0FBd0M7QUFDeEMsd0NBQXdDO0FBQ3hDLHdDQUF3QztBQUd4QyxJQUFJLGFBQWEsR0FBRyxDQUFFO0lBaUJsQixNQUFNLFdBQVcsR0FBRyxFQUFFLENBQUM7SUFFdkIsU0FBUyxJQUFJLENBQUcsR0FBVztJQUczQixDQUFDO0lBRUQsS0FBSyxVQUFVLGVBQWU7UUFFMUIsSUFBSSxDQUFFLGlCQUFpQixDQUFFLENBQUM7UUFFMUIsTUFBTSxJQUFJLEdBQUcsV0FBVyxDQUFDLDRCQUE0QixDQUFFLFlBQVksQ0FBQyxrQkFBa0IsRUFBRSxDQUFFLENBQUM7UUFDM0YsTUFBTSxNQUFNLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBeUIsQ0FBQztRQUMxRCxNQUFNLENBQUMsV0FBVyxDQUFFLFNBQVMsRUFBRSxJQUFJLEtBQUssU0FBUyxDQUFFLENBQUM7UUFFcEQsTUFBTSxVQUFVLEdBQUcsWUFBWSxDQUFDLGtCQUFrQixFQUFFLENBQUM7UUFDckQsTUFBTSxVQUFVLEdBQUcsWUFBWSxDQUFDLG1CQUFtQixDQUFFLFVBQVUsQ0FBRSxDQUFDO1FBRWxFLE1BQU0sVUFBVSxHQUFHLEtBQUssQ0FBQyxjQUFjLENBQUUsY0FBYyxDQUFFLENBQUM7UUFFMUQsTUFBTSxDQUFDLFdBQVcsQ0FBRSxRQUFRLEVBQUUsSUFBSSxDQUFFLENBQUM7UUFDckMsU0FBUyxDQUFFLElBQUksRUFBRSxDQUFDLENBQUUsQ0FBQztRQUNyQixNQUFNLENBQUMsV0FBVyxFQUFFLENBQUM7UUFDckIsTUFBTSxTQUFTLEdBQUcsWUFBWSxDQUFFLFVBQVUsQ0FBRSxDQUFDO1FBRTdDLFFBQVEsQ0FBRSxVQUFVLENBQUUsQ0FBQztRQUV2QixZQUFZLENBQUUsVUFBVSxDQUFFLENBQUM7UUFFM0IsTUFBTSxhQUFhLEdBQUcsSUFBSSxLQUFLLENBQUMsZUFBZSxFQUFFLENBQUM7UUFDbEQsZUFBZSxDQUFFLFVBQVUsRUFBRSxTQUFTLEVBQUUsYUFBYSxDQUFDLE1BQU0sQ0FBRSxDQUFDO1FBRS9ELE1BQU0sS0FBSyxDQUFDLEtBQUssQ0FBRSxHQUFHLENBQUUsQ0FBQztRQUN6QixTQUFTLENBQUUsS0FBSyxFQUFFLEdBQUcsQ0FBRSxDQUFDO1FBRXhCLFdBQVcsQ0FBQyxjQUFjLEVBQUUsQ0FBQztRQUU3QixDQUFDLENBQUMsYUFBYSxDQUFFLHFCQUFxQixFQUFFLFdBQVcsRUFBRSxPQUFPLENBQUUsQ0FBQztRQUUvRCxJQUFLLFVBQVUsSUFBSSxDQUFDLEVBQ3BCO1lBQ1EsQ0FBQyxDQUFDLGFBQWEsQ0FBRSxxQkFBcUIsRUFBRSxrQkFBa0IsRUFBRSxPQUFPLENBQUUsQ0FBQztTQUM3RTthQUVEO1lBQ1EsQ0FBQyxDQUFDLGFBQWEsQ0FBRSxxQkFBcUIsRUFBRSxtQkFBbUIsRUFBRSxPQUFPLENBQUUsQ0FBQztTQUM5RTtRQUVELE1BQU0sVUFBVSxDQUFDO1FBQ2pCLFNBQVMsQ0FBRSxJQUFJLEVBQUUsR0FBRyxDQUFFLENBQUM7UUFFdkIsTUFBTSxLQUFLLENBQUMsS0FBSyxDQUFFLEdBQUcsQ0FBRSxDQUFDO1FBRXpCLGFBQWEsQ0FBQyxLQUFLLEVBQUUsQ0FBQztRQUN0QixDQUFDLENBQUUsa0JBQWtCLENBQUcsQ0FBQyxRQUFRLENBQUUsUUFBUSxDQUFFLENBQUM7UUFDOUMsQ0FBQyxDQUFFLHlCQUF5QixDQUFHLENBQUMsdUJBQXVCLEVBQUUsQ0FBQztRQUMxRCxXQUFXLENBQUMsWUFBWSxFQUFFLENBQUM7UUFDM0IsZ0JBQWdCLEVBQUUsQ0FBQztRQUNuQixNQUFNLENBQUMsVUFBVSxFQUFFLENBQUM7UUFDcEIsTUFBTSxDQUFDLFdBQVcsRUFBRSxDQUFDO1FBQ3JCLFNBQVMsQ0FBRSxLQUFLLEVBQUUsR0FBRyxDQUFFLENBQUM7UUFFeEIsTUFBTSxLQUFLLENBQUMsS0FBSyxDQUFFLEdBQUcsQ0FBRSxDQUFDO1FBQ3pCLE1BQU0sQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLEtBQUssQ0FBRSxDQUFDO0lBQzFDLENBQUM7SUFFRCxTQUFTLFFBQVEsQ0FBRyxXQUFtQjtRQUVuQyxRQUFTLFdBQVcsRUFDcEI7WUFDSSxLQUFLLENBQUM7Z0JBQ0YsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLFdBQVcsQ0FBRSxNQUFNLEVBQUUsV0FBVyxDQUFFLENBQUM7Z0JBQ3ZELE1BQU07WUFDVixLQUFLLENBQUM7Z0JBQ0YsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLFdBQVcsQ0FBRSxNQUFNLEVBQUUsSUFBSSxDQUFFLENBQUM7Z0JBQ2hELE1BQU07U0FDYjtJQUNMLENBQUM7SUFHRCxTQUFTLGdCQUFnQjtRQUVyQixDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsV0FBVyxDQUFFLE1BQU0sRUFBRSxlQUFlLENBQUUsQ0FBQztJQUMvRCxDQUFDO0lBR0QsU0FBUyxlQUFlLENBQUcsV0FBbUIsRUFBRSxTQUF1QixFQUFFLFdBQWdDO1FBRXJHLE1BQU0sTUFBTSxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQXlCLENBQUM7UUFDMUQsQ0FBQyxDQUFFLHlCQUF5QixDQUFHLENBQUMsdUJBQXVCLEVBQUUsQ0FBQztRQUMxRCxNQUFNLGFBQWEsR0FBeUIsSUFBSSxHQUFHLEVBQUUsQ0FBQztRQUV0RCxLQUFLLENBQUMsV0FBVyxDQUFFLFFBQVEsQ0FBQztZQUV4QixLQUFNLE1BQU0sR0FBRyxJQUFJLFNBQVMsQ0FBQyxNQUFNLEVBQUUsRUFDckM7Z0JBQ0ksTUFBTSxLQUFLLENBQUMsS0FBSyxDQUFFLEdBQUcsQ0FBRSxDQUFDO2dCQUN6QixNQUFNLE1BQU0sR0FBRyxtQkFBbUIsQ0FBRSxHQUFHLENBQUMsS0FBSyxFQUFFLEdBQUcsQ0FBQyxRQUFRLENBQUUsQ0FBQztnQkFDOUQsYUFBYSxDQUFDLEdBQUcsQ0FBRSxHQUFHLENBQUMsUUFBUSxFQUFFLE1BQU0sQ0FBRSxDQUFDO2dCQUMxQyxNQUFNLENBQUMsV0FBVyxDQUFFLFFBQVEsQ0FBRSxDQUFDO2FBQ2xDO1FBQ0wsQ0FBQyxFQUFFLFdBQVcsQ0FBRSxDQUFDO1FBRWpCLEtBQUssQ0FBQyxXQUFXLENBQUUsUUFBUSxDQUFDO1lBRXhCLE9BQVEsSUFBSSxFQUNaO2dCQUNJLEtBQU0sTUFBTSxDQUFFLFFBQVEsRUFBRSxNQUFNLENBQUUsSUFBSSxhQUFhLEVBQ2pEO29CQUNJLElBQUksRUFBRSxDQUFDLEVBQUUsQ0FBQyxFQUFFLEdBQUcsTUFBTSxDQUFDLG9CQUFvQixDQUFFLFdBQVcsRUFBRSxRQUFRLEVBQUUsUUFBUSxDQUFFLENBQUM7b0JBQzlFLElBQUssUUFBUSxDQUFFLENBQUMsQ0FBRSxJQUFJLFFBQVEsQ0FBRSxDQUFDLENBQUUsSUFBSSxNQUFNLEVBQzdDO3dCQUNJLENBQUMsSUFBSSxJQUFJLENBQUM7d0JBQ1YsQ0FBQyxJQUFJLE1BQU0sQ0FBQyxpQkFBaUIsR0FBRyxNQUFNLENBQUMsZUFBZSxHQUFHLEdBQUcsQ0FBQzt3QkFDN0QsQ0FBQyxJQUFJLE1BQU0sQ0FBQyxrQkFBa0IsR0FBRyxNQUFNLENBQUMsZUFBZSxDQUFDO3dCQUN4RCxNQUFNLENBQUMsS0FBSyxDQUFDLFNBQVMsR0FBRyxlQUFlLEdBQUcsQ0FBQyxHQUFHLE1BQU0sR0FBRyxDQUFDLEdBQUcsV0FBVyxDQUFDO3FCQUMzRTtpQkFDSjtnQkFDRCxNQUFNLEtBQUssQ0FBQyxTQUFTLEVBQUUsQ0FBQzthQUMzQjtRQUNMLENBQUMsRUFBRSxXQUFXLENBQUUsQ0FBQztJQUNyQixDQUFDO0lBRUQsU0FBUyxtQkFBbUIsQ0FBRyxLQUFhLEVBQUUsUUFBZ0I7UUFFMUQsTUFBTSxPQUFPLEdBQUcsQ0FBQyxDQUFFLHlCQUF5QixDQUFHLENBQUM7UUFDaEQsTUFBTSxNQUFNLEdBQUcsQ0FBQyxDQUFDLFdBQVcsQ0FBRSxPQUFPLEVBQUUsT0FBTyxFQUFFLFFBQVEsQ0FBQyxRQUFRLEVBQUUsQ0FBRSxDQUFDO1FBQ3RFLE1BQU0sQ0FBQyxrQkFBa0IsQ0FBRSx1QkFBdUIsQ0FBRSxDQUFDO1FBR3JELE1BQU0sYUFBYSxHQUFHLE1BQU0sQ0FBQyxxQkFBcUIsQ0FBRSxhQUFhLENBQXVCLENBQUM7UUFDekYsYUFBYSxDQUFDLHNCQUFzQixDQUFFLFlBQVksQ0FBQyxhQUFhLENBQUUsS0FBSyxDQUFFLENBQUUsQ0FBQztRQUc1RSxNQUFNLE1BQU0sR0FBRyxNQUFNLENBQUMscUJBQXFCLENBQUUsTUFBTSxDQUFhLENBQUM7UUFDakUsTUFBTSxDQUFDLElBQUksR0FBRyxZQUFZLENBQUMsYUFBYSxDQUFFLEtBQUssQ0FBRSxDQUFDO1FBQ2xELE1BQU0sU0FBUyxHQUFHLFlBQVksQ0FBQyxjQUFjLENBQUUsS0FBSyxDQUFFLENBQUM7UUFDdkQsSUFBSyxTQUFTO1lBQ1YsTUFBTSxDQUFDLEtBQUssQ0FBQyxTQUFTLEdBQUcsU0FBUyxDQUFDO1FBRXZDLE9BQU8sTUFBTSxDQUFDO0lBQ2xCLENBQUM7SUFFRCxTQUFTLFlBQVksQ0FBRyxVQUFrQjtRQUV0QyxNQUFNLE1BQU0sR0FBRyxDQUFDLENBQUMsZUFBZSxFQUF5QixDQUFDO1FBRTFELE1BQU0sQ0FBQyxXQUFXLEVBQUUsQ0FBQztRQUVyQixNQUFNLFNBQVMsR0FBaUIsRUFBRSxDQUFDO1FBQ25DLEtBQU0sSUFBSSxRQUFRLEdBQUcsQ0FBQyxHQUFHLEVBQUUsUUFBUSxFQUNuQztZQUNJLE1BQU0sS0FBSyxHQUFHLE1BQU0sQ0FBQyxRQUFRLENBQUUsVUFBVSxFQUFFLFFBQVEsQ0FBRSxDQUFDO1lBQ3RELElBQUssQ0FBQyxLQUFLO2dCQUNQLE1BQU07WUFFVixTQUFTLENBQUMsSUFBSSxDQUFFLEVBQUUsS0FBSyxFQUFFLFFBQVEsRUFBRSxDQUFFLENBQUM7U0FDekM7UUFFRCxPQUFPLFNBQVMsQ0FBQztJQUNyQixDQUFDO0lBRUQsU0FBUyxTQUFTLENBQUcsUUFBaUIsRUFBRSxrQkFBMEI7UUFFOUQsTUFBTSxNQUFNLEdBQUcsQ0FBQyxDQUFFLGdCQUFnQixDQUFHLENBQUM7UUFDdEMsTUFBTSxDQUFDLEtBQUssQ0FBQyxrQkFBa0IsR0FBRyxHQUFHLGtCQUFrQixHQUFHLENBQUM7UUFDM0QsTUFBTSxDQUFDLFdBQVcsQ0FBRSxRQUFRLEVBQUUsQ0FBQyxRQUFRLENBQUUsQ0FBQztJQUM5QyxDQUFDO0lBRUQsU0FBUyxZQUFZLENBQUcsV0FBbUI7UUFFdkMsTUFBTSxRQUFRLEdBQUcsWUFBWSxDQUFDLGNBQWMsRUFBRSxDQUFDO1FBQy9DLE1BQU0sU0FBUyxHQUFHLFFBQVEsQ0FBQyxRQUFRLENBQUM7UUFDcEMsTUFBTSxVQUFVLEdBQUcsUUFBUSxDQUFDLFNBQVMsS0FBSyxDQUFDLENBQUM7UUFFNUMsQ0FBQyxDQUFFLGtCQUFrQixDQUFHLENBQUMsV0FBVyxDQUFFLFFBQVEsQ0FBRSxDQUFDO1FBRWpELE1BQU0sTUFBTSxHQUFHLENBQUMsQ0FBRSxnQkFBZ0IsQ0FBYSxDQUFDO1FBQ2hELE1BQU0sV0FBVyxHQUFHLENBQUMsQ0FBRSxxQkFBcUIsQ0FBYSxDQUFDO1FBQzFELE1BQU0sV0FBVyxHQUFHLENBQUMsQ0FBRSxxQkFBcUIsQ0FBYSxDQUFDO1FBRTFELElBQUssU0FBUyxHQUFHLENBQUMsRUFDbEI7WUFDSSxXQUFXLENBQUMsb0JBQW9CLENBQUUsY0FBYyxFQUFFLFNBQVMsQ0FBRSxDQUFDO1lBQzlELFdBQVcsQ0FBQyxZQUFZLENBQUUsVUFBVSxDQUFDLENBQUMsQ0FBQywrQkFBK0IsQ0FBQyxDQUFDLENBQUMsK0JBQStCLENBQUUsQ0FBQztTQUM5RzthQUVEO1lBQ0ksV0FBVyxDQUFDLFlBQVksQ0FBRSxVQUFVLENBQUMsQ0FBQyxDQUFDLHNCQUFzQixDQUFDLENBQUMsQ0FBQyxzQkFBc0IsQ0FBRSxDQUFDO1NBQzVGO1FBRUQsUUFBUyxXQUFXLEVBQ3BCO1lBQ0ksS0FBSyxDQUFDO2dCQUNGLElBQUssTUFBTSxFQUNYO29CQUNJLE1BQU0sQ0FBQyxRQUFRLENBQUUsa0NBQWtDLENBQUUsQ0FBQztpQkFDekQ7Z0JBQ0QsV0FBVyxDQUFDLFlBQVksQ0FBRSxTQUFTLElBQUksQ0FBQyxJQUFJLFVBQVUsQ0FBQyxDQUFDLENBQUMsMkJBQTJCLENBQUMsQ0FBQyxDQUFDLDBCQUEwQixDQUFFLENBQUM7Z0JBQ3BILE1BQU07WUFDVixLQUFLLENBQUM7Z0JBQ0YsSUFBSyxNQUFNLEVBQ1g7b0JBQ0ksTUFBTSxDQUFDLFFBQVEsQ0FBRSxtQ0FBbUMsQ0FBRSxDQUFDO2lCQUMxRDtnQkFDRCxXQUFXLENBQUMsWUFBWSxDQUFFLFNBQVMsSUFBSSxDQUFDLElBQUksVUFBVSxDQUFDLENBQUMsQ0FBQyw0QkFBNEIsQ0FBQyxDQUFDLENBQUMsMkJBQTJCLENBQUUsQ0FBQztnQkFDdEgsTUFBTTtTQUNiO0lBQ0wsQ0FBQztJQUVELE9BQU87UUFDSCxjQUFjLEVBQUUsZUFBZTtLQUNsQyxDQUFDO0FBQ04sQ0FBQyxDQUFFLEVBQUUsQ0FBQztBQUVOLENBQUU7SUFFRSxDQUFDLENBQUMseUJBQXlCLENBQUUsZ0JBQWdCLEVBQUUsYUFBYSxDQUFDLGNBQWMsQ0FBRSxDQUFDO0FBQ2xGLENBQUMsQ0FBRSxFQUFFLENBQUMifQ==