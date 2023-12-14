"use strict";
/// <reference path="csgo.d.ts" />
const LoadingScreen = (function () {
    const cvars = ['mp_roundtime', 'mp_fraglimit', 'mp_maxrounds'];
    const cvalues = ['0', '0', '0'];
    const MAX_SLIDES = 10;
    const SLIDE_DURATION = 4;
    let m_slideShowJob = null;
    let m_mapName = null;
    let m_numImageProcessed = 0;
    let m_elCurrSlide = null;
    function _Init() {
        $('#ProgressBar').value = 0;
        $('#LoadingScreenMapName').text = "";
        $('#LoadingScreenGameMode').SetLocString("#SFUI_LOADING");
        $('#LoadingScreenModeDesc').text = "";
        const elGameModeIcon = $('#LoadingScreenGameModeIcon');
        $.RegisterEventHandler('ImageFailedLoad', elGameModeIcon, () => elGameModeIcon.visible = false);
        elGameModeIcon.visible = false;
        $('#LoadingScreenIcon').visible = false;
        const elSlideShow = $.GetContextPanel().FindChildTraverse('LoadingScreenSlideShow');
        elSlideShow.RemoveAndDeleteChildren();
        m_numImageProcessed = 0;
        if (m_slideShowJob) {
            $.CancelScheduled(m_slideShowJob);
            m_slideShowJob = null;
        }
        m_mapName = null;
    }
    function _CreateSlide(n) {
        const elSlideShow = $.GetContextPanel().FindChildTraverse('LoadingScreenSlideShow');
        const elSlide = $.CreatePanel('Image', elSlideShow, 'slide_' + n);
        elSlide.BLoadLayoutSnippet('snippet-loadingscreen-slide');
        const suffix = n == 0 ? '' : '_' + n;
        const imagePath = 'file://{images}/map_icons/screenshots/1080p/' + m_mapName + suffix + '.png';
        elSlide.SetImage(imagePath);
        elSlide.Data().imagePath = imagePath;
        elSlide.SwitchClass('viz', 'hide');
        const titleToken = '#loadingscreen_title_' + m_mapName + suffix;
        let title = $.Localize(titleToken);
        if (title == titleToken)
            title = '';
        elSlide.SetDialogVariable('screenshot-title', title);
        $.RegisterEventHandler('ImageLoaded', elSlide, () => {
            m_numImageProcessed++;
            if (m_numImageProcessed == MAX_SLIDES)
                _StartSlideShow();
        });
        $.RegisterEventHandler('ImageFailedLoad', elSlide, () => {
            elSlide.DeleteAsync(0.0);
            m_numImageProcessed++;
            if (m_numImageProcessed == MAX_SLIDES)
                _StartSlideShow();
        });
    }
    function _InitSlideShow() {
        if (m_slideShowJob)
            return;
        for (let n = 0; n < MAX_SLIDES; n++) {
            _CreateSlide(n);
        }
    }
    function _StartSlideShow() {
        const elSlideShow = $.GetContextPanel().FindChildTraverse('LoadingScreenSlideShow');
        const arrSlides = elSlideShow.Children();
        const randomOffset = Math.floor(Math.random() * arrSlides.length);
        _NextSlide(randomOffset, true);
    }
    function _NextSlide(n, bFirst = false) {
        m_slideShowJob = null;
        const elSlideShow = $.GetContextPanel().FindChildTraverse('LoadingScreenSlideShow');
        const arrSlides = elSlideShow.Children();
        if (arrSlides.length <= 1)
            return;
        if (n >= arrSlides.length)
            n = n - arrSlides.length;
        let m = n - 1;
        if (m < 0)
            m = arrSlides.length - 1;
        if (arrSlides[n]) {
            m_elCurrSlide = arrSlides[n];
            if (bFirst)
                arrSlides[n].SwitchClass('viz', 'show-first');
            else
                arrSlides[n].SwitchClass('viz', 'show');
        }
        const slide = arrSlides[m];
        if (slide)
            $.Schedule(0.25, () => {
                if (slide && slide.IsValid())
                    slide.SwitchClass('viz', 'hide');
            });
        m_slideShowJob = $.Schedule(SLIDE_DURATION, () => _NextSlide(n + 1));
    }
    function _EndSlideShow() {
        if (m_slideShowJob) {
            $.CancelScheduled(m_slideShowJob);
            m_slideShowJob = null;
        }
    }
    function _OnMapLoadFinished() { _EndSlideShow(); }
    function _UpdateLoadingScreenInfo(mapName, prettyMapName, prettyGameModeName, gameType, gameMode, descriptionText = '') {
        for (let j = 0; j < cvars.length; ++j) {
            const val = GameInterfaceAPI.GetSettingString(cvars[j]);
            if (val !== '0') {
                cvalues[j] = val;
            }
        }
        for (let j = 0; j < cvars.length; ++j) {
            const regex = new RegExp('\\${d:' + cvars[j] + '}', 'gi');
            descriptionText = descriptionText.replace(regex, cvalues[j]);
            $.GetContextPanel().SetDialogVariable(cvars[j], cvalues[j]);
        }
        if (mapName) {
            m_mapName = mapName;
            function mapIconFailedToLoad() {
                $('#LoadingScreenMapName').RemoveClass("loading-screen-content__info__text-title-short");
                $('#LoadingScreenMapName').AddClass("loading-screen-content__info__text-title-long");
                $('#LoadingScreenIcon').visible = false;
            }
            $('#LoadingScreenIcon').visible = true;
            $.RegisterEventHandler('ImageFailedLoad', $('#LoadingScreenIcon'), mapIconFailedToLoad.bind(undefined));
            $('#LoadingScreenMapName').RemoveClass("loading-screen-content__info__text-title-long");
            $('#LoadingScreenMapName').AddClass("loading-screen-content__info__text-title-short");
            $('#LoadingScreenIcon').SetImage('file://{images}/map_icons/map_icon_' + mapName + '.svg');
            $('#LoadingScreenIcon').AddClass('show');
            if (prettyMapName != "")
                $('#LoadingScreenMapName').SetAlreadyLocalizedText(prettyMapName);
            else
                $('#LoadingScreenMapName').SetLocString(GameStateAPI.GetMapDisplayNameToken(mapName));
        }
        const elInfoBlock = $('#LoadingScreenInfo');
        if (gameMode) {
            elInfoBlock.RemoveClass('hidden');
            if (prettyGameModeName != "")
                $('#LoadingScreenGameMode').SetAlreadyLocalizedText(prettyGameModeName);
            else
                $('#LoadingScreenGameMode').SetLocString('#sfui_gamemode_' + gameMode);
            $('#LoadingScreenGameModeIcon').visible = true;
            if (GameStateAPI.IsQueuedMatchmakingMode_Team() || mapName === 'lobby_mapveto')
                $('#LoadingScreenGameModeIcon').SetImage("file://{images}/icons/ui/competitive_teams.svg");
            else
                $('#LoadingScreenGameModeIcon').SetImage('file://{images}/icons/ui/' + gameMode + '.svg');
            if (descriptionText != "")
                $('#LoadingScreenModeDesc').SetAlreadyLocalizedText(descriptionText);
            else
                $('#LoadingScreenModeDesc').SetLocString("");
        }
        else
            elInfoBlock.AddClass('hidden');
        _InitSlideShow();
    }
    return {
        Init: _Init,
        UpdateLoadingScreenInfo: _UpdateLoadingScreenInfo,
        OnMapLoadFinished: _OnMapLoadFinished,
    };
})();
(function () {
    $.RegisterForUnhandledEvent('PopulateLoadingScreen', LoadingScreen.UpdateLoadingScreenInfo);
    $.RegisterForUnhandledEvent('UnloadLoadingScreenAndReinit', LoadingScreen.Init);
    $.RegisterForUnhandledEvent('JsOnMapLoadFinished', LoadingScreen.OnMapLoadFinished);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibG9hZGluZ3NjcmVlbi5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2xvYWRpbmdzY3JlZW4udHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUVsQyxNQUFNLGFBQWEsR0FBRyxDQUFFO0lBR3ZCLE1BQU0sS0FBSyxHQUFHLENBQUUsY0FBYyxFQUFFLGNBQWMsRUFBRSxjQUFjLENBQUUsQ0FBQztJQUNqRSxNQUFNLE9BQU8sR0FBRyxDQUFFLEdBQUcsRUFBRSxHQUFHLEVBQUUsR0FBRyxDQUFFLENBQUM7SUFFbEMsTUFBTSxVQUFVLEdBQUcsRUFBRSxDQUFDO0lBQ3RCLE1BQU0sY0FBYyxHQUFHLENBQUMsQ0FBQztJQUN6QixJQUFJLGNBQWMsR0FBa0IsSUFBSSxDQUFDO0lBQ3pDLElBQUksU0FBUyxHQUFrQixJQUFJLENBQUM7SUFDcEMsSUFBSSxtQkFBbUIsR0FBRyxDQUFDLENBQUM7SUFDNUIsSUFBSSxhQUFhLEdBQW1CLElBQUksQ0FBQztJQUd6QyxTQUFTLEtBQUs7UUFFWCxDQUFDLENBQUUsY0FBYyxDQUFxQixDQUFDLEtBQUssR0FBRyxDQUFDLENBQUM7UUFFakQsQ0FBQyxDQUFFLHVCQUF1QixDQUFlLENBQUMsSUFBSSxHQUFHLEVBQUUsQ0FBQztRQUNwRCxDQUFDLENBQUUsd0JBQXdCLENBQWUsQ0FBQyxZQUFZLENBQUUsZUFBZSxDQUFFLENBQUM7UUFDM0UsQ0FBQyxDQUFFLHdCQUF3QixDQUFlLENBQUMsSUFBSSxHQUFHLEVBQUUsQ0FBQztRQUV2RCxNQUFNLGNBQWMsR0FBRyxDQUFDLENBQUUsNEJBQTRCLENBQWEsQ0FBQztRQUNwRSxDQUFDLENBQUMsb0JBQW9CLENBQUUsaUJBQWlCLEVBQUUsY0FBYyxFQUFFLEdBQUcsRUFBRSxDQUFDLGNBQWMsQ0FBQyxPQUFPLEdBQUcsS0FBSyxDQUFFLENBQUM7UUFDbEcsY0FBYyxDQUFDLE9BQU8sR0FBRyxLQUFLLENBQUM7UUFFL0IsQ0FBQyxDQUFFLG9CQUFvQixDQUFHLENBQUMsT0FBTyxHQUFHLEtBQUssQ0FBQztRQUczQyxNQUFNLFdBQVcsR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsaUJBQWlCLENBQUUsd0JBQXdCLENBQUUsQ0FBQztRQUN0RixXQUFXLENBQUMsdUJBQXVCLEVBQUUsQ0FBQztRQUN0QyxtQkFBbUIsR0FBRyxDQUFDLENBQUM7UUFFeEIsSUFBSyxjQUFjLEVBQ25CO1lBRUMsQ0FBQyxDQUFDLGVBQWUsQ0FBRSxjQUFjLENBQUUsQ0FBQztZQUNwQyxjQUFjLEdBQUcsSUFBSSxDQUFDO1NBQ3RCO1FBRUQsU0FBUyxHQUFHLElBQUksQ0FBQztJQUVsQixDQUFDO0lBRUQsU0FBUyxZQUFZLENBQUcsQ0FBUztRQUVoQyxNQUFNLFdBQVcsR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsaUJBQWlCLENBQUUsd0JBQXdCLENBQUUsQ0FBQztRQUV0RixNQUFNLE9BQU8sR0FBRyxDQUFDLENBQUMsV0FBVyxDQUFFLE9BQU8sRUFBRSxXQUFXLEVBQUUsUUFBUSxHQUFHLENBQUMsQ0FBRSxDQUFDO1FBQ3BFLE9BQU8sQ0FBQyxrQkFBa0IsQ0FBRSw2QkFBNkIsQ0FBRSxDQUFDO1FBRTVELE1BQU0sTUFBTSxHQUFHLENBQUMsSUFBSSxDQUFDLENBQUMsQ0FBQyxDQUFDLEVBQUUsQ0FBQyxDQUFDLENBQUMsR0FBRyxHQUFHLENBQUMsQ0FBQztRQUVyQyxNQUFNLFNBQVMsR0FBRyw4Q0FBOEMsR0FBRyxTQUFTLEdBQUcsTUFBTSxHQUFHLE1BQU0sQ0FBQztRQUUvRixPQUFPLENBQUMsUUFBUSxDQUFFLFNBQVMsQ0FBRSxDQUFDO1FBRTlCLE9BQU8sQ0FBQyxJQUFJLEVBQUUsQ0FBQyxTQUFTLEdBQUcsU0FBUyxDQUFDO1FBQ3JDLE9BQU8sQ0FBQyxXQUFXLENBQUUsS0FBSyxFQUFFLE1BQU0sQ0FBRSxDQUFDO1FBR3JDLE1BQU0sVUFBVSxHQUFHLHVCQUF1QixHQUFHLFNBQVMsR0FBRyxNQUFNLENBQUM7UUFDaEUsSUFBSSxLQUFLLEdBQUcsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxVQUFVLENBQUUsQ0FBQztRQUNyQyxJQUFLLEtBQUssSUFBSSxVQUFVO1lBQ3ZCLEtBQUssR0FBRyxFQUFFLENBQUM7UUFDWixPQUFPLENBQUMsaUJBQWlCLENBQUUsa0JBQWtCLEVBQUUsS0FBSyxDQUFFLENBQUM7UUFFdkQsQ0FBQyxDQUFDLG9CQUFvQixDQUFFLGFBQWEsRUFBRSxPQUFPLEVBQUUsR0FBRyxFQUFFO1lBSXBELG1CQUFtQixFQUFFLENBQUM7WUFFdEIsSUFBSyxtQkFBbUIsSUFBSSxVQUFVO2dCQUNyQyxlQUFlLEVBQUUsQ0FBQztRQUNwQixDQUFDLENBQUUsQ0FBQztRQUVKLENBQUMsQ0FBQyxvQkFBb0IsQ0FBRSxpQkFBaUIsRUFBRSxPQUFPLEVBQUUsR0FBRyxFQUFFO1lBR3hELE9BQU8sQ0FBQyxXQUFXLENBQUUsR0FBRyxDQUFFLENBQUM7WUFFM0IsbUJBQW1CLEVBQUUsQ0FBQztZQUV0QixJQUFLLG1CQUFtQixJQUFJLFVBQVU7Z0JBQ3JDLGVBQWUsRUFBRSxDQUFDO1FBQ3BCLENBQUMsQ0FBRSxDQUFDO0lBQ0wsQ0FBQztJQUlELFNBQVMsY0FBYztRQUV0QixJQUFLLGNBQWM7WUFDbEIsT0FBTztRQUlSLEtBQU0sSUFBSSxDQUFDLEdBQUcsQ0FBQyxFQUFFLENBQUMsR0FBRyxVQUFVLEVBQUUsQ0FBQyxFQUFFLEVBQ3BDO1lBQ0MsWUFBWSxDQUFFLENBQUMsQ0FBRSxDQUFDO1NBQ2xCO0lBQ0YsQ0FBQztJQUlELFNBQVMsZUFBZTtRQUl2QixNQUFNLFdBQVcsR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsaUJBQWlCLENBQUUsd0JBQXdCLENBQUUsQ0FBQztRQUN0RixNQUFNLFNBQVMsR0FBRyxXQUFXLENBQUMsUUFBUSxFQUFFLENBQUM7UUFDekMsTUFBTSxZQUFZLEdBQUcsSUFBSSxDQUFDLEtBQUssQ0FBRSxJQUFJLENBQUMsTUFBTSxFQUFFLEdBQUcsU0FBUyxDQUFDLE1BQU0sQ0FBRSxDQUFDO1FBR3BFLFVBQVUsQ0FBRSxZQUFZLEVBQUUsSUFBSSxDQUFFLENBQUM7SUFDbEMsQ0FBQztJQUdELFNBQVMsVUFBVSxDQUFHLENBQVMsRUFBRSxNQUFNLEdBQUcsS0FBSztRQUU5QyxjQUFjLEdBQUcsSUFBSSxDQUFDO1FBRXRCLE1BQU0sV0FBVyxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxpQkFBaUIsQ0FBRSx3QkFBd0IsQ0FBRSxDQUFDO1FBQ3RGLE1BQU0sU0FBUyxHQUFHLFdBQVcsQ0FBQyxRQUFRLEVBQWUsQ0FBQztRQUV0RCxJQUFLLFNBQVMsQ0FBQyxNQUFNLElBQUksQ0FBQztZQUN6QixPQUFPO1FBRVIsSUFBSyxDQUFDLElBQUksU0FBUyxDQUFDLE1BQU07WUFDekIsQ0FBQyxHQUFHLENBQUMsR0FBRyxTQUFTLENBQUMsTUFBTSxDQUFDO1FBRTFCLElBQUksQ0FBQyxHQUFHLENBQUMsR0FBRyxDQUFDLENBQUM7UUFFZCxJQUFLLENBQUMsR0FBRyxDQUFDO1lBQ1QsQ0FBQyxHQUFHLFNBQVMsQ0FBQyxNQUFNLEdBQUcsQ0FBQyxDQUFDO1FBRTFCLElBQUssU0FBUyxDQUFFLENBQUMsQ0FBRSxFQUNuQjtZQUNDLGFBQWEsR0FBRyxTQUFTLENBQUUsQ0FBQyxDQUFFLENBQUM7WUFJL0IsSUFBSyxNQUFNO2dCQUNWLFNBQVMsQ0FBRSxDQUFDLENBQUUsQ0FBQyxXQUFXLENBQUUsS0FBSyxFQUFFLFlBQVksQ0FBRSxDQUFDOztnQkFFbEQsU0FBUyxDQUFFLENBQUMsQ0FBRSxDQUFDLFdBQVcsQ0FBRSxLQUFLLEVBQUUsTUFBTSxDQUFFLENBQUM7U0FDN0M7UUFHRCxNQUFNLEtBQUssR0FBRyxTQUFTLENBQUUsQ0FBQyxDQUFFLENBQUM7UUFDN0IsSUFBSyxLQUFLO1lBQ1QsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxJQUFJLEVBQUUsR0FBRyxFQUFFO2dCQUV0QixJQUFLLEtBQUssSUFBSSxLQUFLLENBQUMsT0FBTyxFQUFFO29CQUM1QixLQUFLLENBQUMsV0FBVyxDQUFFLEtBQUssRUFBRSxNQUFNLENBQUUsQ0FBQztZQUVyQyxDQUFDLENBQUUsQ0FBQztRQUdMLGNBQWMsR0FBRyxDQUFDLENBQUMsUUFBUSxDQUFFLGNBQWMsRUFBRSxHQUFHLEVBQUUsQ0FBQyxVQUFVLENBQUUsQ0FBQyxHQUFHLENBQUMsQ0FBRSxDQUFFLENBQUM7SUFFMUUsQ0FBQztJQUVELFNBQVMsYUFBYTtRQUdyQixJQUFLLGNBQWMsRUFDbkI7WUFFQyxDQUFDLENBQUMsZUFBZSxDQUFFLGNBQWMsQ0FBRSxDQUFDO1lBQ3BDLGNBQWMsR0FBRyxJQUFJLENBQUM7U0FDdEI7SUFLRixDQUFDO0lBRUQsU0FBUyxrQkFBa0IsS0FBTSxhQUFhLEVBQUUsQ0FBQyxDQUFDLENBQUM7SUFHbkQsU0FBUyx3QkFBd0IsQ0FBRyxPQUFlLEVBQUUsYUFBcUIsRUFBRSxrQkFBMEIsRUFBRSxRQUFnQixFQUFFLFFBQWdCLEVBQUUsZUFBZSxHQUFHLEVBQUU7UUFLL0osS0FBTSxJQUFJLENBQUMsR0FBRyxDQUFDLEVBQUUsQ0FBQyxHQUFHLEtBQUssQ0FBQyxNQUFNLEVBQUUsRUFBRSxDQUFDLEVBQ3RDO1lBQ0MsTUFBTSxHQUFHLEdBQUcsZ0JBQWdCLENBQUMsZ0JBQWdCLENBQUUsS0FBSyxDQUFFLENBQUMsQ0FBRSxDQUFFLENBQUM7WUFDNUQsSUFBSyxHQUFHLEtBQUssR0FBRyxFQUNoQjtnQkFDQyxPQUFPLENBQUUsQ0FBQyxDQUFFLEdBQUcsR0FBRyxDQUFDO2FBQ25CO1NBQ0Q7UUFFRCxLQUFNLElBQUksQ0FBQyxHQUFHLENBQUMsRUFBRSxDQUFDLEdBQUcsS0FBSyxDQUFDLE1BQU0sRUFBRSxFQUFFLENBQUMsRUFDdEM7WUFDQyxNQUFNLEtBQUssR0FBRyxJQUFJLE1BQU0sQ0FBRSxRQUFRLEdBQUcsS0FBSyxDQUFFLENBQUMsQ0FBRSxHQUFHLEdBQUcsRUFBRSxJQUFJLENBQUUsQ0FBQztZQUM5RCxlQUFlLEdBQUcsZUFBZSxDQUFDLE9BQU8sQ0FBRSxLQUFLLEVBQUUsT0FBTyxDQUFFLENBQUMsQ0FBRSxDQUFFLENBQUM7WUFDakUsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLGlCQUFpQixDQUFFLEtBQUssQ0FBRSxDQUFDLENBQUUsRUFBRSxPQUFPLENBQUUsQ0FBQyxDQUFFLENBQUUsQ0FBQztTQUNsRTtRQUVELElBQUssT0FBTyxFQUNaO1lBQ0MsU0FBUyxHQUFHLE9BQU8sQ0FBQztZQUdwQixTQUFTLG1CQUFtQjtnQkFFM0IsQ0FBQyxDQUFFLHVCQUF1QixDQUFHLENBQUMsV0FBVyxDQUFFLGdEQUFnRCxDQUFFLENBQUM7Z0JBQzlGLENBQUMsQ0FBRSx1QkFBdUIsQ0FBRyxDQUFDLFFBQVEsQ0FBRSwrQ0FBK0MsQ0FBRSxDQUFDO2dCQUMxRixDQUFDLENBQUUsb0JBQW9CLENBQUcsQ0FBQyxPQUFPLEdBQUcsS0FBSyxDQUFDO1lBQzVDLENBQUM7WUFFRCxDQUFDLENBQUUsb0JBQW9CLENBQUcsQ0FBQyxPQUFPLEdBQUcsSUFBSSxDQUFDO1lBQzFDLENBQUMsQ0FBQyxvQkFBb0IsQ0FBRSxpQkFBaUIsRUFBRSxDQUFDLENBQUUsb0JBQW9CLENBQUUsRUFBRSxtQkFBbUIsQ0FBQyxJQUFJLENBQUUsU0FBUyxDQUFFLENBQUUsQ0FBQztZQUM5RyxDQUFDLENBQUUsdUJBQXVCLENBQUcsQ0FBQyxXQUFXLENBQUUsK0NBQStDLENBQUUsQ0FBQztZQUM3RixDQUFDLENBQUUsdUJBQXVCLENBQUcsQ0FBQyxRQUFRLENBQUUsZ0RBQWdELENBQUUsQ0FBQztZQUN6RixDQUFDLENBQUUsb0JBQW9CLENBQWUsQ0FBQyxRQUFRLENBQUUscUNBQXFDLEdBQUcsT0FBTyxHQUFHLE1BQU0sQ0FBRSxDQUFDO1lBRTlHLENBQUMsQ0FBRSxvQkFBb0IsQ0FBRyxDQUFDLFFBQVEsQ0FBRSxNQUFNLENBQUUsQ0FBQztZQUU5QyxJQUFLLGFBQWEsSUFBSSxFQUFFO2dCQUNyQixDQUFDLENBQUUsdUJBQXVCLENBQWUsQ0FBQyx1QkFBdUIsQ0FBRSxhQUFhLENBQUUsQ0FBQzs7Z0JBRW5GLENBQUMsQ0FBRSx1QkFBdUIsQ0FBZSxDQUFDLFlBQVksQ0FBRSxZQUFZLENBQUMsc0JBQXNCLENBQUUsT0FBTyxDQUFFLENBQUUsQ0FBQztTQUM1RztRQUVELE1BQU0sV0FBVyxHQUFHLENBQUMsQ0FBRSxvQkFBb0IsQ0FBRyxDQUFDO1FBRS9DLElBQUssUUFBUSxFQUNiO1lBQ0MsV0FBVyxDQUFDLFdBQVcsQ0FBRSxRQUFRLENBQUUsQ0FBQztZQUNwQyxJQUFLLGtCQUFrQixJQUFJLEVBQUU7Z0JBQzFCLENBQUMsQ0FBRSx3QkFBd0IsQ0FBZSxDQUFDLHVCQUF1QixDQUFFLGtCQUFrQixDQUFFLENBQUM7O2dCQUV6RixDQUFDLENBQUUsd0JBQXdCLENBQWUsQ0FBQyxZQUFZLENBQUUsaUJBQWlCLEdBQUcsUUFBUSxDQUFFLENBQUM7WUFFekYsQ0FBQyxDQUFFLDRCQUE0QixDQUFlLENBQUMsT0FBTyxHQUFHLElBQUksQ0FBQztZQUNoRSxJQUFLLFlBQVksQ0FBQyw0QkFBNEIsRUFBRSxJQUFJLE9BQU8sS0FBSyxlQUFlO2dCQUM1RSxDQUFDLENBQUUsNEJBQTRCLENBQWUsQ0FBQyxRQUFRLENBQUUsZ0RBQWdELENBQUUsQ0FBQzs7Z0JBRTVHLENBQUMsQ0FBRSw0QkFBNEIsQ0FBZSxDQUFDLFFBQVEsQ0FBRSwyQkFBMkIsR0FBRyxRQUFRLEdBQUcsTUFBTSxDQUFFLENBQUM7WUFFOUcsSUFBSyxlQUFlLElBQUksRUFBRTtnQkFDdkIsQ0FBQyxDQUFFLHdCQUF3QixDQUFlLENBQUMsdUJBQXVCLENBQUUsZUFBZSxDQUFFLENBQUM7O2dCQUV0RixDQUFDLENBQUUsd0JBQXdCLENBQWUsQ0FBQyxZQUFZLENBQUUsRUFBRSxDQUFFLENBQUM7U0FDakU7O1lBRUEsV0FBVyxDQUFDLFFBQVEsQ0FBRSxRQUFRLENBQUUsQ0FBQztRQUVsQyxjQUFjLEVBQUUsQ0FBQztJQUVsQixDQUFDO0lBR0QsT0FBTztRQUNOLElBQUksRUFBRSxLQUFLO1FBQ1gsdUJBQXVCLEVBQUUsd0JBQXdCO1FBQ2pELGlCQUFpQixFQUFFLGtCQUFrQjtLQUVyQyxDQUFDO0FBQ0gsQ0FBQyxDQUFFLEVBQUUsQ0FBQztBQUdOLENBQUU7SUFFRCxDQUFDLENBQUMseUJBQXlCLENBQUUsdUJBQXVCLEVBQUUsYUFBYSxDQUFDLHVCQUF1QixDQUFFLENBQUM7SUFDOUYsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLDhCQUE4QixFQUFFLGFBQWEsQ0FBQyxJQUFJLENBQUUsQ0FBQztJQUNsRixDQUFDLENBQUMseUJBQXlCLENBQUUscUJBQXFCLEVBQUUsYUFBYSxDQUFDLGlCQUFpQixDQUFFLENBQUM7QUFFdkYsQ0FBQyxDQUFFLEVBQUUsQ0FBQyJ9