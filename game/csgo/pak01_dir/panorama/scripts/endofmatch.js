"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/formattext.ts" />
/// <reference path="common/gamerules_constants.ts" />
/// <reference path="endofmatch-characters.ts" />
/// <reference path="mock_adapter.ts" />
var EndOfMatch;
(function (EndOfMatch) {
    const _m_cP = $('#EndOfMatch');
    const _m_data = {
        _m_arrPanelObjects: [],
        _m_currentPanelIndex: -1,
        _m_jobStart: null,
        _m_elActiveTab: null,
        _m_scoreboardVisible: false,
    };
    $.RegisterEventHandler("EndOfMatch_Show", _m_cP, _Start);
    $.RegisterForUnhandledEvent("EndOfMatch_Shutdown", _Shutdown);
    $.RegisterForUnhandledEvent("EndOfMatch_ShowScoreboard", _ShowScoreboard);
    $.RegisterForUnhandledEvent("EndOfMatch_HideScoreboard", _HideScoreboard);
    function _NavigateToTab(tab) {
        if (_m_data._m_elActiveTab && _m_data._m_elActiveTab.IsValid()) {
            _m_data._m_elActiveTab.RemoveClass('eom-panel--active');
        }
        _m_data._m_elActiveTab = _m_cP.FindChildTraverse(tab);
        if (_m_data._m_elActiveTab) {
            _m_data._m_elActiveTab.AddClass('eom-panel--active');
        }
    }
    function ToggleBetweenScoreboardAndCharacters() {
        _m_data._m_scoreboardVisible = !_m_data._m_scoreboardVisible;
        _m_cP.SetHasClass('scoreboard-visible', _m_data._m_scoreboardVisible);
    }
    EndOfMatch.ToggleBetweenScoreboardAndCharacters = ToggleBetweenScoreboardAndCharacters;
    function EnableToggleBetweenScoreboardAndCharacters() {
        _m_cP.SetHasClass('scoreboard-visible', _m_data._m_scoreboardVisible);
    }
    EndOfMatch.EnableToggleBetweenScoreboardAndCharacters = EnableToggleBetweenScoreboardAndCharacters;
    function _ShowScoreboard() {
        _m_cP.SetHasClass('scoreboard-visible', true);
        _m_data._m_scoreboardVisible = true;
    }
    function _HideScoreboard() {
        _m_cP.SetHasClass('scoreboard-visible', false);
        _m_data._m_scoreboardVisible = false;
    }
    function SwitchToPanel(tab) {
        _m_cP.FindChildTraverse('rb--' + tab).RemoveClass("hidden");
        _m_cP.FindChildTraverse('rb--' + tab).checked = true;
        _NavigateToTab(tab);
    }
    EndOfMatch.SwitchToPanel = SwitchToPanel;
    function RegisterPanelObject(panel) {
        _m_data._m_arrPanelObjects.push(panel);
    }
    EndOfMatch.RegisterPanelObject = RegisterPanelObject;
    function _Initialize() {
        _m_cP.SetMouseCapture(true);
        for (var j = 1; j < 10; ++j) {
            var elPanel = $.GetContextPanel().FindChildTraverse('EomCancelReason' + j);
            if (elPanel)
                elPanel.RemoveClass('show');
        }
        $.Schedule(1, () => { $.DispatchEvent("EndOfMatch_Latch"); });
        _m_data._m_arrPanelObjects = [];
        _m_data._m_currentPanelIndex = -1;
        _m_data._m_elActiveTab = null;
        if (_m_data._m_jobStart !== null) {
            $.CancelScheduled(_m_data._m_jobStart);
            _m_data._m_jobStart = null;
        }
        var mode = MockAdapter.GetGameModeInternalName(false);
        _m_data._m_scoreboardVisible = (mode == "cooperative") || (mode == "coopmission");
        var elLayout = _m_cP.FindChildTraverse("id-eom-layout");
        elLayout.RemoveAndDeleteChildren();
        let strEomLayoutSnippet = "snippet-eom-layout--default";
        if (mode == "premier") {
            strEomLayoutSnippet = "snippet-eom-layout--premier";
        }
        elLayout.BLoadLayoutSnippet(strEomLayoutSnippet);
        let elProgBar = _m_cP.FindChildTraverse("id-display-timer-progress-bar");
        elProgBar.style.transitionDuration = "0s";
        elProgBar.style.width = '0%';
        var bind = GameInterfaceAPI.GetSettingString("cl_scoreboard_mouse_enable_binding");
        if (bind.charAt(0) == '+' || bind.charAt(0) == '-')
            bind = bind.substring(1);
        bind = "{s:bind_" + bind + "}";
        bind = $.Localize(bind, _m_cP);
        _m_cP.SetDialogVariable("scoreboard_toggle_bind", bind);
        _m_cP.FindChildrenWithClassTraverse("timer").forEach(el => el.active = false);
        var elNavBar = _m_cP.FindChildTraverse("id-content-navbar__tabs");
        elNavBar.RemoveAndDeleteChildren();
        _m_cP.FindChildrenWithClassTraverse("eom-panel").forEach(function (elPanel, i) {
            var elRBtn = $.CreatePanel("RadioButton", elNavBar, "rb--" + elPanel.id);
            elRBtn.BLoadLayoutSnippet("snippet_navbar-button");
            elRBtn.AddClass("navbar-button");
            elRBtn.AddClass("appear");
            elRBtn.SetPanelEvent('onactivate', _NavigateToTab.bind(undefined, elPanel.id));
            elRBtn.FindChildTraverse("id-navbar-button__label").text = $.Localize("#" + elPanel.id);
        });
    }
    function _ShowPanelStart() {
        if (!_m_cP || !_m_cP.IsValid())
            return;
        _m_cP.AddClass("eom--reveal");
        const elFade = $("#id-eom-fade");
        elFade.AddClass("active");
        let elFallbackBackground = $("#id-eom-fallback-background");
        elFallbackBackground.AddClass("hidden");
        var elBackgroundImage = _m_cP.FindChildInLayoutFile('BackgroundMapImage');
        elBackgroundImage.SetImage('file://{images}/map_icons/screenshots/1080p/' + GameStateAPI.GetMapBSPName() + '.png');
        $.Schedule(0.5, () => {
            _m_cP.SetWantsCamera(true);
            if (_m_cP.FindChildTraverse('id-eom-characters-root')) {
                EOM_Characters.Start();
            }
            elFade.RemoveClass("active");
            if (_m_cP.IsInFallbackMode()) {
                elFallbackBackground.RemoveClass("hidden");
            }
        });
    }
    function _Start(bHardCut) {
        _Initialize();
        if (bHardCut) {
            _m_data._m_jobStart = $.Schedule(0.0, () => {
                _m_data._m_jobStart = null;
                _ShowPanelStart();
                ShowNextPanel();
            });
        }
        else {
            _m_data._m_jobStart = $.Schedule(0.0, () => {
                _m_data._m_jobStart = null;
                _ShowPanelStart();
                $.Schedule(1.25, ShowNextPanel);
            });
        }
    }
    function _StartTestShow(mockData) {
        MockAdapter.SetMockData(mockData);
        $.DispatchEvent("Scoreboard_ResetAndInit");
        $.DispatchEvent("OnOpenScoreboard");
        _m_cP.SetMouseCapture(false);
        _Initialize();
        _ShowPanelStart();
        $.Schedule(1.25, ShowNextPanel);
    }
    function StartDisplayTimer(time) {
        var elProgBar = _m_cP.FindChildTraverse("id-display-timer-progress-bar");
        $.Schedule(0.0, function () {
            if (elProgBar && elProgBar.IsValid()) {
                elProgBar.style.transitionDuration = "0s";
                elProgBar.style.width = '0%';
            }
        });
        $.Schedule(0.0, function () {
            if (elProgBar && elProgBar.IsValid()) {
                elProgBar.style.transitionDuration = time + "s";
                elProgBar.style.width = '100%';
            }
        });
    }
    EndOfMatch.StartDisplayTimer = StartDisplayTimer;
    function ShowNextPanel() {
        _m_data._m_currentPanelIndex++;
        if (_m_data._m_currentPanelIndex < _m_data._m_arrPanelObjects.length) {
            if (_m_data._m_currentPanelIndex === (_m_data._m_arrPanelObjects.length - 1) &&
                !GameStateAPI.IsDemoOrHltv() &&
                !GameStateAPI.IsQueuedMatchmaking()) {
                _m_cP.FindChildrenWithClassTraverse("timer").forEach(el => el.active = true);
            }
            _m_data._m_arrPanelObjects[_m_data._m_currentPanelIndex].Start();
        }
    }
    EndOfMatch.ShowNextPanel = ShowNextPanel;
    function _Shutdown() {
        if (_m_data._m_jobStart) {
            $.CancelScheduled(_m_data._m_jobStart);
            _m_data._m_jobStart = null;
        }
        var elLayout = _m_cP.FindChildTraverse("id-eom-layout");
        elLayout.RemoveAndDeleteChildren();
        for (const panelObject of _m_data._m_arrPanelObjects) {
            if (panelObject.Shutdown)
                panelObject.Shutdown();
        }
        _m_cP.RemoveClass("eom--reveal");
        if (_m_cP.FindChildTraverse('id-eom-characters-root')) {
            EOM_Characters.Shutdown();
        }
        _m_cP.SetWantsCamera(false);
    }
})(EndOfMatch || (EndOfMatch = {}));
(function () {
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZW5kb2ZtYXRjaC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2VuZG9mbWF0Y2gudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUNsQyw2Q0FBNkM7QUFDN0Msc0RBQXNEO0FBQ3RELGlEQUFpRDtBQUNqRCx3Q0FBd0M7QUFxQ3hDLElBQVUsVUFBVSxDQW1abkI7QUFuWkQsV0FBVSxVQUFVO0lBSW5CLE1BQU0sS0FBSyxHQUFxQixDQUFDLENBQUMsYUFBYSxDQUFDLENBQUM7SUFDakQsTUFBTSxPQUFPLEdBQ2I7UUFDQyxrQkFBa0IsRUFBRyxFQUFFO1FBQ3ZCLG9CQUFvQixFQUFHLENBQUMsQ0FBQztRQUN6QixXQUFXLEVBQUcsSUFBSTtRQUNsQixjQUFjLEVBQUcsSUFBSTtRQUNyQixvQkFBb0IsRUFBRyxLQUFLO0tBQzVCLENBQUE7SUFFRCxDQUFDLENBQUMsb0JBQW9CLENBQUUsaUJBQWlCLEVBQUUsS0FBSyxFQUFFLE1BQU0sQ0FBRSxDQUFDO0lBQzNELENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSxxQkFBcUIsRUFBRSxTQUFTLENBQUUsQ0FBQztJQUNoRSxDQUFDLENBQUMseUJBQXlCLENBQUUsMkJBQTJCLEVBQUUsZUFBZSxDQUFFLENBQUM7SUFDNUUsQ0FBQyxDQUFDLHlCQUF5QixDQUFFLDJCQUEyQixFQUFFLGVBQWUsQ0FBRSxDQUFDO0lBVTVFLFNBQVMsY0FBYyxDQUFHLEdBQVc7UUFHcEMsSUFBSyxPQUFPLENBQUMsY0FBYyxJQUFJLE9BQU8sQ0FBQyxjQUFjLENBQUMsT0FBTyxFQUFFLEVBQy9EO1lBQ0MsT0FBTyxDQUFDLGNBQWMsQ0FBQyxXQUFXLENBQUUsbUJBQW1CLENBQUUsQ0FBQztTQUMxRDtRQUVELE9BQU8sQ0FBQyxjQUFjLEdBQUcsS0FBSyxDQUFDLGlCQUFpQixDQUFFLEdBQUcsQ0FBRSxDQUFDO1FBRXhELElBQUssT0FB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