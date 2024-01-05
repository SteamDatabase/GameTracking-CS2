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
