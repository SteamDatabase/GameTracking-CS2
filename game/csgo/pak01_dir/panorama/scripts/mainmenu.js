"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/characteranims.ts" />
/// <reference path="common/licenseutil.ts" />
/// <reference path="common/promoted_settings.ts" />
/// <reference path="popups/popup_acknowledge_item.ts" />
/// <reference path="inspect.ts" />
/// <reference path="avatar.ts" />
/// <reference path="vanity_player_info.ts" />
/// <reference path="particle_controls.ts" />
var MainMenu = (function () {
    const _m_bPerfectWorld = (MyPersonaAPI.GetLauncherType() === "perfectworld");
    let _m_activeTab = null;
    let _m_sideBarElementContextMenuActive = false;
    const _m_elContentPanel = $('#JsMainMenuContent');
    let _m_playedInitalFadeUp = false;
    const _m_elNotificationsContainer = $('#NotificationsContainer');
    let _m_notificationSchedule = false;
    let _m_bVanityAnimationAlreadyStarted = false;
    let _m_bHasPopupNotification = false;
    let _m_tLastSeenDisconnectedFromGC = 0;
    const _m_NotificationBarColorClasses = [
        "NotificationRed", "NotificationYellow", "NotificationGreen", "NotificationLoggingOn"
    ];
    let _m_LobbyPlayerUpdatedEventHandler = null;
    let _m_LobbyMatchmakingSessionUpdateEventHandler = null;
    let _m_LobbyForceRestartVanityEventHandler = null;
    let _m_LobbyMainMenuSwitchVanityEventHandler = null;
    let _m_UiSceneFrameBoundaryEventHandler = null;
    let _m_storePopupElement = null;
    let m_TournamentPickBanPopup = null;
    let _m_hOnEngineSoundSystemsRunningRegisterHandle = null;
    let _m_jobFetchTournamentData = null;
    const TOURNAMENT_FETCH_DELAY = 10;
    const nNumNewSettings = UpdateSettingsMenuAlert();
    const m_MainMenuTopBarParticleFX = $('#MainMenuNavigateParticles');
    ParticleControls.UpdateMainMenuTopBar(m_MainMenuTopBarParticleFX, '');
    let _m_bShownBefore = false;
    function _msg(text) {
    }
    function UpdateSettingsMenuAlert() {
        let elNewSettingsAlert = $("#MainMenuSettingsAlert");
        if (elNewSettingsAlert) {
            let nNewSettings = PromotedSettingsUtil.GetUnacknowledgedPromotedSettings().length;
            elNewSettingsAlert.SetHasClass("has-new-settings", nNewSettings > 0);
            elNewSettingsAlert.SetDialogVariable("num_settings", nNewSettings.toString());
            return nNewSettings;
        }
        return 0;
    }
    if (nNumNewSettings > 0) {
        const hPromotedSettingsViewedEvt = $.RegisterForUnhandledEvent("MainMenu_PromotedSettingsViewed", function () {
            UpdateSettingsMenuAlert();
            $.UnregisterForUnhandledEvent("MainMenu_PromotedSettingsViewed", hPromotedSettingsViewedEvt);
        });
    }
    const _OnInitFadeUp = function () {
        if (!_m_playedInitalFadeUp) {
            $('#MainMenuContainerPanel').TriggerClass('show');
            _m_playedInitalFadeUp = true;
            _RegisterOnShowEvents();
            _UpdateBackgroundMap();
            SetHideTranstionOnLeftColumn();
        }
    };
    function SetHideTranstionOnLeftColumn() {
        const elLeftColumn = $.FindChildInContext('#JsLeftColumn');
        const fnOnPropertyTransitionEndEvent = function (panelName, propertyName) {
            if (elLeftColumn.id === panelName && propertyName === 'opacity') {
                if (elLeftColumn.visible === true && elLeftColumn.BIsTransparent()) {
                    elLeftColumn.SetReadyForDisplay(false);
                    elLeftColumn.visible = false;
                    return true;
                }
            }
            return false;
        };
        $.RegisterEventHandler('PropertyTransitionEnd', elLeftColumn, fnOnPropertyTransitionEndEvent);
    }
    function _FetchTournamentData() {
        if (_m_jobFetchTournamentData)
            return;
        TournamentsAPI.RequestTournaments();
        _m_jobFetchTournamentData = $.Schedule(TOURNAMENT_FETCH_DELAY, function () {
            _m_jobFetchTournamentData = null;
            _FetchTournamentData();
        });
    }
    function _StopFetchingTournamentData() {
        if (_m_jobFetchTournamentData) {
            $.CancelScheduled(_m_jobFetchTournamentData);
            _m_jobFetchTournamentData = null;
        }
    }
    const _UpdateBackgroundMap = function () {
        let savedMapName = GameInterfaceAPI.GetSettingString('ui_mainmenu_bkgnd_movie');
        let backgroundMap = !savedMapName ? 'de_dust2_vanity' : savedMapName + '_vanity';
        let elMapPanel = $('#JsMainmenu_Vanity');
        if (!(elMapPanel && elMapPanel.IsValid())) {
            elMapPanel = $.CreatePanel('MapVanityPreviewPanel', $('#JsMainmenu_Vanity-Container'), 'JsMainmenu_Vanity', {
                "require-composition-layer": "true",
                "pin-fov": "vertical",
                class: 'align-preview',
                camera: 'cam_default',
                player: "true",
                playermodel: "",
                map: backgroundMap,
                playername: "vanity_character",
                animgraphcharactermode: 'main-menu',
                initial_entity: 'vanity_character',
                mouse_rotate: 'false',
                parallax_degrees: ".5",
                parallax_offset: "200.0"
            });
            elMapPanel.Data().loadedMap = backgroundMap;
            _PlayBackgroundMapSound(savedMapName);
        }
        else if (elMapPanel.Data().loadedMap !== backgroundMap) {
            elMapPanel.SwitchMap(backgroundMap);
            elMapPanel.Data().loadedMap = backgroundMap;
            _PlayBackgroundMapSound(savedMapName);
        }
        if (backgroundMap === 'de_nuke_vanity') {
            elMapPanel.FireEntityInput('main_light', 'SetBrightness', '2');
            elMapPanel.FireEntityInput('main_light', 'Enable');
        }
        InspectModelImage.HidePanelItemEntities(elMapPanel);
        _SetCSMSplitPlane0DistanceOverride(elMapPanel, backgroundMap);
        return elMapPanel;
    };
    function _SetCSMSplitPlane0DistanceOverride(elPanel, backgroundMap) {
        let flSplitPlane0Distance = 0.0;
        if (backgroundMap === 'de_ancient_vanity') {
            flSplitPlane0Distance = 80.0;
        }
        else if (backgroundMap === 'de_anubis_vanity') {
            flSplitPlane0Distance = 100.0;
        }
        else if (backgroundMap === 'de_dust2_vanity') {
            flSplitPlane0Distance = 130.0;
        }
        else if (backgroundMap === 'de_inferno_vanity') {
            flSplitPlane0Distance = 150.0;
        }
        else if (backgroundMap === 'cs_italy_vanity') {
            flSplitPlane0Distance = 200.0;
        }
        else if (backgroundMap === 'de_mirage_vanity') {
            flSplitPlane0Distance = 120.0;
        }
        else if (backgroundMap === 'de_overpass_vanity') {
            flSplitPlane0Distance = 150.0;
        }
        else if (backgroundMap === 'de_vertigo_vanity') {
            flSplitPlane0Distance = 90.0;
        }
        if (flSplitPlane0Distance > 0.0) {
            elPanel.SetCSMSplitPlane0DistanceOverride(flSplitPlane0Distance);
        }
    }
    let m_backgroundMapSoundHandle = null;
    const _PlayBackgroundMapSound = function (backgroundMap) {
        let soundName = 'UIPanorama.BG_' + backgroundMap;
        if (m_backgroundMapSoundHandle) {
            UiToolkitAPI.StopSoundEvent(m_backgroundMapSoundHandle, 0.1);
            m_backgroundMapSoundHandle = null;
        }
        m_backgroundMapSoundHandle = UiToolkitAPI.PlaySoundEvent(soundName);
    };
    const _RegisterOnShowEvents = function () {
        if (!_m_LobbyMatchmakingSessionUpdateEventHandler && !GameStateAPI.IsLocalPlayerPlayingMatch()) {
            _m_LobbyMatchmakingSessionUpdateEventHandler = $.RegisterForUnhandledEvent("PanoramaComponent_Lobby_MatchmakingSessionUpdate", MainMenu.LobbyPlayerUpdated);
            _m_LobbyPlayerUpdatedEventHandler = $.RegisterForUnhandledEvent("PanoramaComponent_PartyList_RebuildPartyList", MainMenu.LobbyPlayerUpdated);
            _m_LobbyForceRestartVanityEventHandler = $.RegisterForUnhandledEvent("ForceRestartVanity", MainMenu.ForceRestartVanity);
            _m_LobbyMainMenuSwitchVanityEventHandler = $.RegisterForUnhandledEvent("MainMenuSwitchVanity", MainMenu.SwitchVanity);
        }
        if (!_m_UiSceneFrameBoundaryEventHandler) {
            _m_UiSceneFrameBoundaryEventHandler = $.RegisterForUnhandledEvent("UISceneFrameBoundary", _OnUISceneFrameBoundary);
        }
    };
    const _OnShowMainMenu = function () {
        $.DispatchEvent('PlayMainMenuMusic', true, true);
        _RegisterOnShowEvents();
        _m_bVanityAnimationAlreadyStarted = false;
        _LobbyPlayerUpdated();
        _OnInitFadeUp();
        $('#MainMenuNavBarPlay').SetHasClass('pausemenu-navbar__btn-small--hidden', false);
        _UpdateNotifications();
        _UpdateInventoryBtnAlert();
        _UpdateStoreAlert();
        _GcLogonNotificationReceived();
        _DeleteSurvivalEndOfMatch();
        _ShowHideAlertForNewEventForWatchBtn();
        _UpdateUnlockCompAlert();
        _FetchTournamentData();
        _ShowFloatingPanels();
        $('#MainMenuNavBarHome').checked = true;
        if (!_m_bShownBefore) {
            _CheckGraphicsDrivers();
        }
        else if (GameTypesAPI.ShouldShowNewUserPopup()) {
            _NewUser_ShowTrainingCompletePopup();
        }
        _m_bShownBefore = true;
    };
    const _TournamentDraftUpdate = function () {
        if (!m_TournamentPickBanPopup || !m_TournamentPickBanPopup.IsValid()) {
            m_TournamentPickBanPopup = UiToolkitAPI.ShowCustomLayoutPopup('tournament_pickban_popup', 'file://{resources}/layout/popups/popup_tournament_pickban.xml');
        }
    };
    let _m_bGcLogonNotificationReceivedOnce = false;
    const _GcLogonNotificationReceived = function () {
        if (_m_bGcLogonNotificationReceivedOnce)
            return;
        const strFatalError = MyPersonaAPI.GetClientLogonFatalError();
        if (strFatalError
            && (strFatalError !== "ShowGameLicenseNoOnlineLicensePW")
            && (strFatalError !== "ShowGameLicenseNoOnlineLicense")) {
            _m_bGcLogonNotificationReceivedOnce = true;
            if (strFatalError === "ShowGameLicenseNeedToLinkAccountsWithMoreInfo") {
                UiToolkitAPI.ShowGenericPopupThreeOptionsBgStyle("#CSGO_Purchasable_Game_License_Short", "#SFUI_LoginLicenseAssist_PW_NeedToLinkAccounts_WW_hint", "", "#UI_Yes", function () { SteamOverlayAPI.OpenURL("https://community.csgo.com.cn/join/pwlink_csgo"); }, "#UI_No", function () { }, "#ShowFAQ", function () { _OnGcLogonNotificationReceived_ShowFaqCallback(); }, "dim");
            }
            else if (strFatalError === "ShowGameLicenseNeedToLinkAccounts") {
                _OnGcLogonNotificationReceived_ShowLicenseYesNoBox("#SFUI_LoginLicenseAssist_PW_NeedToLinkAccounts", "https://community.csgo.com.cn/join/pwlink_csgo");
            }
            else if (strFatalError === "ShowGameLicenseHasLicensePW") {
                _OnGcLogonNotificationReceived_ShowLicenseYesNoBox("#SFUI_LoginLicenseAssist_HasLicense_PW", "https://community.csgo.com.cn/join/pwlink_csgo?needlicense=1");
            }
            else if (strFatalError === "ShowGameLicenseNoOnlineLicensePW") {
            }
            else if (strFatalError === "ShowGameLicenseNoOnlineLicense") {
            }
            else {
                UiToolkitAPI.ShowGenericPopupOneOptionBgStyle("#SFUI_LoginPerfectWorld_Title_Error", strFatalError, "", "#GameUI_Quit", function () { GameInterfaceAPI.ConsoleCommand("quit"); }, "dim");
            }
            return;
        }
        const nAntiAddictionTrackingState = MyPersonaAPI.GetTimePlayedTrackingState();
        if (nAntiAddictionTrackingState > 0) {
            _m_bGcLogonNotificationReceivedOnce = true;
            const pszDialogTitle = "#SFUI_LoginPerfectWorld_Title_Info";
            let pszDialogMessageText = "#SFUI_LoginPerfectWorld_AntiAddiction1";
            let pszOverlayUrlToOpen = null;
            if (nAntiAddictionTrackingState != 2) {
                pszDialogMessageText = "#SFUI_LoginPerfectWorld_AntiAddiction2";
                pszOverlayUrlToOpen = "https://community.csgo.com.cn/join/pwcompleteaccountinfo";
            }
            if (pszOverlayUrlToOpen) {
                UiToolkitAPI.ShowGenericPopupYesNo(pszDialogTitle, pszDialogMessageText, "", function () { SteamOverlayAPI.OpenURL(pszOverlayUrlToOpen); }, function () { });
            }
            else {
                UiToolkitAPI.ShowGenericPopup(pszDialogTitle, pszDialogMessageText, "");
            }
            return;
        }
    };
    let _m_numGameMustExitNowForAntiAddictionHandled = 0;
    let _m_panelGameMustExitDialog = null;
    const _GameMustExitNowForAntiAddiction = function () {
        if (_m_panelGameMustExitDialog && _m_panelGameMustExitDialog.IsValid())
            return;
        if (_m_numGameMustExitNowForAntiAddictionHandled >= 100)
            return;
        ++_m_numGameMustExitNowForAntiAddictionHandled;
        _m_panelGameMustExitDialog =
            UiToolkitAPI.ShowGenericPopupOneOptionBgStyle("#GameUI_QuitConfirmationTitle", "#UI_AntiAddiction_ExitGameNowMessage", "", "#GameUI_Quit", function () { GameInterfaceAPI.ConsoleCommand("quit"); }, "dim");
    };
    const _OnGcLogonNotificationReceived_ShowLicenseYesNoBox = function (strTextMessage, pszOverlayUrlToOpen) {
        UiToolkitAPI.ShowGenericPopupTwoOptionsBgStyle("#CSGO_Purchasable_Game_License_Short", strTextMessage, "", "#UI_Yes", function () { SteamOverlayAPI.OpenURL(pszOverlayUrlToOpen); }, "#UI_No", function () { }, "dim");
    };
    const _OnGcLogonNotificationReceived_ShowFaqCallback = function () {
        SteamOverlayAPI.OpenURL("https://support.steampowered.com/kb_article.php?ref=6026-IFKZ-7043&l=schinese");
        _m_bGcLogonNotificationReceivedOnce = false;
        _GcLogonNotificationReceived();
    };
    const _OnHideMainMenu = function () {
        const vanityPanel = $('#JsMainmenu_Vanity');
        if (vanityPanel) {
            CharacterAnims.CancelScheduledAnim(vanityPanel);
        }
        _m_elContentPanel.RemoveClass('mainmenu-content--animate');
        _m_elContentPanel.AddClass('mainmenu-content--offscreen');
        _CancelNotificationSchedule();
        _UnregisterShowEvents();
        UiToolkitAPI.CloseAllVisiblePopups();
        _StopFetchingTournamentData();
    };
    const _UnregisterShowEvents = function () {
        if (_m_LobbyMatchmakingSessionUpdateEventHandler) {
            $.UnregisterForUnhandledEvent("PanoramaComponent_Lobby_MatchmakingSessionUpdate", _m_LobbyMatchmakingSessionUpdateEventHandler);
            _m_LobbyMatchmakingSessionUpdateEventHandler = null;
        }
        if (_m_LobbyPlayerUpdatedEventHandler) {
            $.UnregisterForUnhandledEvent("PanoramaComponent_PartyList_RebuildPartyList", _m_LobbyPlayerUpdatedEventHandler);
            _m_LobbyPlayerUpdatedEventHandler = null;
        }
        if (_m_LobbyForceRestartVanityEventHandler) {
            $.UnregisterForUnhandledEvent("ForceRestartVanity", _m_LobbyForceRestartVanityEventHandler);
            _m_LobbyForceRestartVanityEventHandler = null;
        }
        if (_m_LobbyMainMenuSwitchVanityEventHandler) {
            $.UnregisterForUnhandledEvent("MainMenuSwitchVanity", _m_LobbyMainMenuSwitchVanityEventHandler);
            _m_LobbyMainMenuSwitchVanityEventHandler = null;
        }
        if (_m_UiSceneFrameBoundaryEventHandler) {
            $.UnregisterForUnhandledEvent("UISceneFrameBoundary", _m_UiSceneFrameBoundaryEventHandler);
            _m_UiSceneFrameBoundaryEventHandler = null;
        }
    };
    const _OnShowPauseMenu = function () {
        const elContextPanel = $.GetContextPanel();
        elContextPanel.AddClass('MainMenuRootPanel--PauseMenuMode');
        const bMultiplayer = elContextPanel.IsMultiplayer();
        const bQueuedMatchmaking = GameStateAPI.IsQueuedMatchmaking();
        const bTraining = elContextPanel.IsTraining();
        const bGotvSpectating = elContextPanel.IsGotvSpectating();
        const bIsCommunityServer = !_m_bPerfectWorld && MatchStatsAPI.IsConnectedToCommunityServer();
        $('#MainMenuNavBarPlay').SetHasClass('pausemenu-navbar__btn-small--hidden', true);
        $('#MainMenuNavBarSwitchTeams').SetHasClass('pausemenu-navbar__btn-small--hidden', (bTraining || bQueuedMatchmaking || bGotvSpectating));
        $('#MainMenuNavBarVote').SetHasClass('pausemenu-navbar__btn-small--hidden', (bTraining || bGotvSpectating));
        $('#MainMenuNavBarReportServer').SetHasClass('pausemenu-navbar__btn-small--hidden', !bIsCommunityServer);
        _UpdateSurvivalEndOfMatchInstance();
        _AddPauseMenuMissionPanel();
        _OnHomeButtonPressed();
    };
    const _OnHidePauseMenu = function () {
        $.GetContextPanel().RemoveClass('MainMenuRootPanel--PauseMenuMode');
        _DeletePauseMenuMissionPanel();
        _OnHomeButtonPressed();
    };
    const _BCheckTabCanBeOpenedRightNow = function (tab) {
        if (tab === 'JsInventory' || tab === 'JsMainMenuStore' || tab === 'JsLoadout') {
            const restrictions = LicenseUtil.GetCurrentLicenseRestrictions();
            if (restrictions !== false) {
                LicenseUtil.ShowLicenseRestrictions(restrictions);
                return false;
            }
        }
        if (tab === 'JsInventory' || tab === 'JsPlayerStats' || tab === 'JsLoadout' || tab === 'JsMainMenuStore') {
            if (!MyPersonaAPI.IsInventoryValid() || !MyPersonaAPI.IsConnectedToGC()) {
                UiToolkitAPI.ShowGenericPopupOk($.Localize('#SFUI_SteamConnectionErrorTitle'), $.Localize('#SFUI_Steam_Error_LinkUnexpected'), '', function () { });
                return false;
            }
        }
        return true;
    };
    const _CanOpenStatsPanel = function () {
        if (GameInterfaceAPI.GetSettingString('ui_show_subscription_alert') !== '1') {
            GameInterfaceAPI.SetSettingString('ui_show_subscription_alert', '1');
        }
        _UpdateSubscriptionAlert();
        const rtRecurringSubscriptionNextBillingCycle = InventoryAPI.GetCacheTypeElementFieldByIndex('RecurringSubscription', 0, 'time_next_cycle');
        if (!rtRecurringSubscriptionNextBillingCycle) {
            $.DispatchEvent('OpenSubscriptionUpsell');
            const rtTimeInitiated = InventoryAPI.GetCacheTypeElementFieldByIndex('RecurringSubscription', 0, 'time_initiated');
            if (rtTimeInitiated)
                return true;
            else
                return false;
        }
        return true;
    };
    const _NavigateToTab = function (tab, XmlName) {
        if (!_BCheckTabCanBeOpenedRightNow(tab)) {
            _OnHomeButtonPressed();
            return;
        }
        if (tab === 'JsPlayerStats') {
            return;
        }
        $.DispatchEvent('PlayMainMenuMusic', true, false);
        GameInterfaceAPI.SetSettingString('panorama_play_movie_ambient_sound', '0');
        if (!$.GetContextPanel().FindChildInLayoutFile(tab)) {
            const newPanel = $.CreatePanel('Panel', _m_elContentPanel, tab);
            newPanel.BLoadLayout('file://{resources}/layout/' + XmlName + '.xml', false, false);
            newPanel.SetReadyForDisplay(false);
            newPanel.RegisterForReadyEvents(true);
            $.RegisterEventHandler('PropertyTransitionEnd', newPanel, function (panel, propertyName) {
                if (newPanel.id === panel.id && propertyName === 'opacity') {
                    if (newPanel.visible === true && newPanel.BIsTransparent()) {
                        newPanel.SetReadyForDisplay(false);
                        newPanel.visible = false;
                        return true;
                    }
                    else if (newPanel.visible === true) {
                        $.DispatchEvent('MainMenuTabShown', tab);
                    }
                }
                return false;
            });
        }
        ParticleControls.UpdateMainMenuTopBar(m_MainMenuTopBarParticleFX, tab);
        if (_m_activeTab !== tab) {
            if (XmlName) {
                let soundName = '';
                if (XmlName === 'mainmenu_store_fullscreen') {
                    soundName = 'UIPanorama.tab_mainmenu_shop';
                }
                else if (XmlName === 'loadout_grid') {
                    soundName = 'UIPanorama.tab_mainmenu_loadout';
                }
                else {
                    soundName = 'tab_' + XmlName.replace('/', '_');
                }
                $.DispatchEvent('CSGOPlaySoundEffect', soundName, 'MOUSE');
            }
            if (_m_activeTab) {
                $.GetContextPanel().CancelDrag();
                const panelToHide = $.GetContextPanel().FindChildInLayoutFile(_m_activeTab);
                panelToHide.AddClass('mainmenu-content--hidden');
            }
            _m_activeTab = tab;
            const activePanel = $.GetContextPanel().FindChildInLayoutFile(tab);
            activePanel.RemoveClass('mainmenu-content--hidden');
            activePanel.visible = true;
            activePanel.SetReadyForDisplay(true);
            _PauseMainMenuCharacter();
        }
        _ShowContentPanel();
    };
    const _ShowContentPanel = function () {
        if (_m_elContentPanel.BHasClass('mainmenu-content--offscreen')) {
            _m_elContentPanel.AddClass('mainmenu-content--animate');
            _m_elContentPanel.RemoveClass('mainmenu-content--offscreen');
        }
        $.GetContextPanel().AddClass("mainmenu-content--open");
        $.DispatchEvent('ShowContentPanel');
        _DimMainMenuBackground(false);
        _HideFloatingPanels();
    };
    const _OnHideContentPanel = function () {
        _m_elContentPanel.AddClass('mainmenu-content--animate');
        _m_elContentPanel.AddClass('mainmenu-content--offscreen');
        $.GetContextPanel().RemoveClass("mainmenu-content--open");
        const elActiveNavBarBtn = _GetActiveNavBarButton();
        if (elActiveNavBarBtn && elActiveNavBarBtn.id !== 'MainMenuNavBarHome') {
            elActiveNavBarBtn.checked = false;
        }
        _DimMainMenuBackground(true);
        if (_m_activeTab) {
            $.GetContextPanel().CancelDrag();
            const panelToHide = $.GetContextPanel().FindChildInLayoutFile(_m_activeTab);
            panelToHide.AddClass('mainmenu-content--hidden');
        }
        _m_activeTab = '';
        _ShowFloatingPanels();
    };
    const _GetActiveNavBarButton = function () {
        const elNavBar = $('#MainMenuNavBarTop');
        const children = elNavBar.Children();
        const count = children.length;
        for (let i = 0; i < count; i++) {
            if (children[i].IsSelected()) {
                return children[i];
            }
        }
    };
    const _ShowHideNavDrawer = function () {
        UiToolkitAPI.ShowCustomLayoutPopup('', 'file://{resources}/layout/popups/popup_navdrawer.xml');
    };
    const _ExpandSidebar = function (AutoClose = false) {
        const elSidebar = $('#JsMainMenuSidebar');
        if (elSidebar.BHasClass('mainmenu-sidebar--minimized')) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'sidemenu_slidein', 'MOUSE');
        }
        elSidebar.RemoveClass('mainmenu-sidebar--minimized');
        _SlideSearchPartyParticles(true);
        $.DispatchEvent('SidebarIsCollapsed', false);
        _DimMainMenuBackground(false);
        if (AutoClose) {
            $.Schedule(1, _MinimizeSidebar);
        }
    };
    const _MinimizeSidebar = function () {
        if (_m_elContentPanel == null) {
            return;
        }
        if (_m_sideBarElementContextMenuActive) {
            return;
        }
        const elSidebar = $('#JsMainMenuSidebar');
        if (!elSidebar.BHasClass('mainmenu-sidebar--minimized')) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'sidemenu_slideout', 'MOUSE');
        }
        elSidebar.AddClass('mainmenu-sidebar--minimized');
        _SlideSearchPartyParticles(false);
        $.DispatchEvent('SidebarIsCollapsed', true);
        _DimMainMenuBackground(true);
    };
    const _OnSideBarElementContextMenuActive = function (bActive) {
        _m_sideBarElementContextMenuActive = bActive;
        $.Schedule(0.25, () => {
            if (!$('#JsMainMenuSidebar').BHasHoverStyle())
                _MinimizeSidebar();
        });
        _DimMainMenuBackground(false);
    };
    const _DimMainMenuBackground = function (removeDim) {
        if (removeDim && _m_elContentPanel.BHasClass('mainmenu-content--offscreen') &&
            $('#mainmenu-content__blur-target').BHasHoverStyle() === false) {
            $('#MainMenuBackground').RemoveClass('Dim');
        }
        else
            $('#MainMenuBackground').AddClass('Dim');
    };
    function _OnHomeButtonPressed() {
        $.DispatchEvent('HideContentPanel');
        ParticleControls.UpdateMainMenuTopBar(m_MainMenuTopBarParticleFX, '');
        const vanityPanel = $('#JsMainmenu_Vanity');
        if (vanityPanel) {
            vanityPanel.Pause();
        }
        $('#MainMenuNavBarHome').checked = true;
        _CheckRankUpRedemptionStore();
    }
    function _OnQuitButtonPressed() {
        UiToolkitAPI.ShowGenericPopupOneOptionCustomCancelBgStyle('#UI_ConfirmExitTitle', '#UI_ConfirmExitMessage', '', '#UI_Quit', function () {
            QuitGame('Option1');
        }, '#UI_Return', function () {
        }, 'dim');
    }
    function QuitGame(msg) {
        GameInterfaceAPI.ConsoleCommand('quit');
    }
    const _InitFriendsList = function () {
        const friendsList = $.CreatePanel('Panel', $.FindChildInContext('#mainmenu-sidebar__blur-target'), 'JsFriendsList');
        friendsList.BLoadLayout('file://{resources}/layout/friendslist.xml', false, false);
    };
    const _InitNewsAndStore = function () {
    };
    const _AddStream = function () {
        const elStream = $.CreatePanel('Panel', $.FindChildInContext('#JsStreamContainer'), 'JsStreamPanel', {
            useglobalcontext: 'true'
        });
        elStream.BLoadLayout('file://{resources}/layout/mainmenu_stream.xml', false, false);
    };
    const _AddFeaturedPanel = function (xmlPath, panelId) {
        const featuredXML = 'file://{resources}/layout/' + xmlPath;
        const elPanel = $.CreatePanel('Panel', $.FindChildInContext('#JsNewsContainer'), panelId, {
            useglobalcontext: 'true'
        });
        elPanel.BLoadLayout(featuredXML, false, false);
        $.FindChildInContext('#JsNewsContainer').MoveChildBefore(elPanel, $.FindChildInContext('#JsNewsPanel'));
        const overrideStyle = (featuredXML.indexOf('tournament') !== -1 || featuredXML.indexOf('operation') !== -1) ?
            '' :
            'news-panel-style-feature-panel-visible';
        if (overrideStyle !== '') {
            $.FindChildInContext('#JsNewsContainer').SetHasClass(overrideStyle, true);
        }
    };
    const _HideMainMenuNewsPanel = function () {
        const elNews = $.FindChildInContext('#JsNewsContainer');
        elNews.SetHasClass('news-panel--hide-news-panel', true);
        elNews.SetHasClass('news-panel-style-feature-panel-visible', false);
    };
    const _AddWatchNoticePanel = function () {
        const WatchNoticeXML = 'file://{resources}/layout/mainmenu_watchnotice.xml';
        const elPanel = $.CreatePanel('Panel', $.FindChildInContext('#JsNewsContainer'), 'JsWatchNoticePanel');
        $.FindChildInContext('#JsNewsContainer').MoveChildAfter(elPanel, $("#JsNewsPanel"));
        elPanel.BLoadLayout(WatchNoticeXML, false, false);
    };
    const _ShowFloatingPanels = function () {
        $.FindChildInContext('#JsLeftColumn').SetHasClass('hidden', false);
        $.FindChildInContext('#JsActiveMissionPanel').SetHasClass('hidden', false);
        $.FindChildInContext('#MainMenuVanityInfo').SetHasClass('hidden', false);
        const elVanityButton = $.FindChildInContext('#VanityControls');
        if (elVanityButton) {
            elVanityButton.visible = true;
        }
        $.FindChildInContext('#JsStreamContainer').SetHasClass('hidden', false);
    };
    const _HideFloatingPanels = function () {
        $.FindChildInContext('#JsLeftColumn').SetHasClass('hidden', true);
        $.FindChildInContext('#JsActiveMissionPanel').SetHasClass('hidden', true);
        $.FindChildInContext('#JsActiveMissionPanel').SetHasClass('hidden', true);
        $.FindChildInContext('#MainMenuVanityInfo').SetHasClass('hidden', true);
        const elVanityButton = $.FindChildInContext('#VanityControls');
        if (elVanityButton) {
            elVanityButton.visible = false;
        }
        $.FindChildInContext('#JsStreamContainer').SetHasClass('hidden', true);
    };
    const _OnSteamIsPlaying = function () {
        const elNewsContainer = $.FindChildInContext('#JsNewsContainer');
        if (elNewsContainer) {
            elNewsContainer.SetHasClass('mainmenu-news-container-stream-active', EmbeddedStreamAPI.IsVideoPlaying());
        }
    };
    const _ResetNewsEntryStyle = function () {
        const elNewsContainer = $.FindChildInContext('#JsNewsContainer');
        if (elNewsContainer) {
            elNewsContainer.RemoveClass('mainmenu-news-container-stream-active');
        }
    };
    const _UpdatePartySearchParticlesType = function (isPremier) {
        const particle_container = $('#party-search-particles');
        if (isPremier) {
            particle_container.SetParticleNameAndRefresh("particles/ui/ui_mainmenu_active_search_gold.vpcf");
        }
        else {
            particle_container.SetParticleNameAndRefresh("particles/ui/ui_mainmenu_active_search.vpcf");
        }
    };
    const _UpdatePartySearchSetControlPointParticles = function (cpArray) {
        const particle_container = $('#party-search-particles');
        particle_container.StopParticlesImmediately(true);
        particle_container.StartParticles();
        for (const [cp, xpos, ypos, zpos] of cpArray) {
            particle_container.SetControlPoint(cp, xpos, ypos, zpos);
        }
        m_isParticleActive = true;
    };
    let m_verticalSpread = 0;
    let m_isParticleActive = false;
    const _UpdatePartySearchParticles = function () {
        const particle_container = $('#party-search-particles');
        if (particle_container.type !== "ParticleScenePanel")
            return;
        let numPlayersActuallyInParty;
        let AddServerErrors = 0;
        var serverWarning = NewsAPI.GetCurrentActiveAlertForUser();
        var isWarning = serverWarning !== '' && serverWarning !== undefined ? true : false;
        let bAttemptPremierMode = LobbyAPI.GetSessionSettings()?.game?.mode_ui === 'premier';
        if (isWarning)
            AddServerErrors = 5;
        let strStatus = LobbyAPI.GetMatchmakingStatusString();
        const bShowParticles = strStatus != null && (strStatus.endsWith("searching") || strStatus.endsWith("registering") || strStatus.endsWith("reserved"));
        if (!bShowParticles) {
            if (m_isParticleActive) {
                particle_container.StopParticlesImmediately(true);
                m_isParticleActive = false;
            }
            return;
        }
        let verticlSpread = 14 + (PartyListAPI.GetCount() - 1) * 5 + AddServerErrors;
        if (m_verticalSpread === verticlSpread && m_isParticleActive)
            return;
        _UpdatePartySearchParticlesType(bAttemptPremierMode);
        m_verticalSpread = verticlSpread;
        let CpArray = [
            [1, verticlSpread, .5, 1],
            [2, 1, .25, 0],
            [16, 15, 230, 15],
        ];
        _UpdatePartySearchSetControlPointParticles(CpArray);
    };
    const _ForceRestartVanity = function () {
        if (GameStateAPI.IsLocalPlayerPlayingMatch()) {
            return;
        }
        _m_bVanityAnimationAlreadyStarted = false;
        _InitVanity();
    };
    let m_aDisplayLobbyVanityData = [];
    const _InitVanity = function () {
        if (MatchStatsAPI.GetUiExperienceType()) {
            return;
        }
        if (!MyPersonaAPI.IsInventoryValid()) {
            if (MyPersonaAPI.GetClientLogonFatalError()) {
                _ShowVanity();
            }
            return;
        }
        if (_m_bVanityAnimationAlreadyStarted) {
            return;
        }
        _ShowVanity();
    };
    function _ShowVanity() {
        const vanityPanel = $('#JsMainmenu_Vanity');
        if (!vanityPanel) {
            return;
        }
        _m_bVanityAnimationAlreadyStarted = true;
        if (vanityPanel.BHasClass('hidden')) {
            vanityPanel.RemoveClass('hidden');
        }
        _UpdateLocalPlayerVanity();
    }
    function _UpdateLocalPlayerVanity() {
        const oSettings = ItemInfo.GetOrUpdateVanityCharacterSettings();
        const oLocalPlayer = m_aDisplayLobbyVanityData.filter(storedEntry => { return storedEntry.isLocalPlayer === true; });
        oSettings.playeridx = oLocalPlayer.length > 0 ? oLocalPlayer[0].playeridx : 0;
        oSettings.xuid = MyPersonaAPI.GetXuid();
        oSettings.isLocalPlayer = true;
        _ApplyVanitySettingsToLobbyMetadata(oSettings);
        _UpdatePlayerVanityModel(oSettings);
        _CreatUpdateVanityInfo(oSettings);
    }
    ;
    const _ApplyVanitySettingsToLobbyMetadata = function (oSettings) {
        PartyListAPI.SetLocalPlayerVanityPresence(oSettings.team, oSettings.charItemId, oSettings.glovesItemId, oSettings.loadoutSlot, oSettings.weaponItemId);
    };
    const _UpdatePlayerVanityModel = function (oSettings) {
        const vanityPanel = _UpdateBackgroundMap();
        vanityPanel.SetActiveCharacter(oSettings.playeridx);
        oSettings.panel = vanityPanel;
        CharacterAnims.PlayAnimsOnPanel(oSettings);
    };
    const _CreatUpdateVanityInfo = function (oSettings) {
        $.Schedule(.1, () => {
            const elVanityPlayerInfo = VanityPlayerInfo.CreateOrUpdateVanityInfoPanel($.GetContextPanel().FindChildInLayoutFile('MainMenuVanityInfo'), oSettings);
            if (elVanityPlayerInfo) {
                $.GetContextPanel().FindChildInLayoutFile('MainMenuVanityParent').AddBlurPanel(elVanityPlayerInfo.FindChildInLayoutFile('vanity-info-container'));
                let defName = '';
                let weaponId = oSettings.weaponItemId
                    ? oSettings.weaponItemId
                    : (oSettings.hasOwnProperty('vanity_data') && oSettings.vanity_data)
                        ? oSettings.vanity_data.split(',')[4]
                        : '';
                let team = oSettings.hasOwnProperty('team') && oSettings.team
                    ? oSettings.team
                    : (oSettings.hasOwnProperty('vanity_data') && oSettings.vanity_data)
                        ? oSettings.vanity_data.split(',')[0]
                        : '';
                if (weaponId) {
                    defName = InventoryAPI.GetItemDefinitionName(weaponId);
                }
                elVanityPlayerInfo.SetHasClass('move-up', (defName === 'weapon_negev' || defName === 'weapon_m249') && team === 'ct');
            }
        });
    };
    const _LobbyPlayerUpdated = function () {
        _UpdatePartySearchParticles();
        let numPlayersActuallyInParty = PartyListAPI.GetCount();
        if (!LobbyAPI.IsSessionActive() || MatchStatsAPI.GetUiExperienceType() || numPlayersActuallyInParty < 1 || !numPlayersActuallyInParty) {
            _ClearLobbyPlayers();
            _m_bVanityAnimationAlreadyStarted = false;
            $.Schedule(.1, _InitVanity);
            return;
        }
        const maxSlots = 5;
        const aCurrentLobbyVanityData = [];
        if (numPlayersActuallyInParty > 0) {
            numPlayersActuallyInParty = (numPlayersActuallyInParty > maxSlots) ? maxSlots : numPlayersActuallyInParty;
            for (let k = 0; k < numPlayersActuallyInParty; k++) {
                const xuid = PartyListAPI.GetXuidByIndex(k);
                aCurrentLobbyVanityData.push({
                    xuid: xuid,
                    isLocalPlayer: xuid === MyPersonaAPI.GetXuid(),
                    playeridx: k,
                    vanity_data: PartyListAPI.GetPartyMemberVanity(xuid)
                });
            }
            _CompareLobbyPlayers(aCurrentLobbyVanityData);
        }
        else {
            _ClearLobbyPlayers();
            _ForceRestartVanity();
        }
    };
    const _CompareLobbyPlayers = function (aCurrentLobbyVanityData) {
        const maxSlots = 5;
        for (let i = 0; i < maxSlots; i++) {
            if (aCurrentLobbyVanityData[i]) {
                if (!m_aDisplayLobbyVanityData[i]) {
                    m_aDisplayLobbyVanityData[i] = {
                        xuid: "",
                        playeridx: 0,
                        vanity_data: "",
                        isLocalPlayer: false
                    };
                }
                m_aDisplayLobbyVanityData[i].playeridx = aCurrentLobbyVanityData[i].playeridx;
                m_aDisplayLobbyVanityData[i].isLocalPlayer = aCurrentLobbyVanityData[i].isLocalPlayer;
                if (m_aDisplayLobbyVanityData[i].xuid !== aCurrentLobbyVanityData[i].xuid) {
                    VanityPlayerInfo.DeleteVanityInfoPanel($.GetContextPanel().FindChildInLayoutFile('MainMenuVanityInfo'), aCurrentLobbyVanityData[i].playeridx);
                    if (aCurrentLobbyVanityData[i].isLocalPlayer) {
                        _UpdateLocalPlayerVanity();
                    }
                }
                m_aDisplayLobbyVanityData[i].xuid = aCurrentLobbyVanityData[i].xuid;
                if (m_aDisplayLobbyVanityData[i].vanity_data !== aCurrentLobbyVanityData[i].vanity_data) {
                    if (!aCurrentLobbyVanityData[i].isLocalPlayer && aCurrentLobbyVanityData[i].vanity_data) {
                        _UpdateVanityFromLobbyUpdate(aCurrentLobbyVanityData[i].vanity_data, aCurrentLobbyVanityData[i].playeridx, aCurrentLobbyVanityData[i].xuid);
                    }
                }
                _CreatUpdateVanityInfo(aCurrentLobbyVanityData[i]);
                m_aDisplayLobbyVanityData[i].vanity_data = aCurrentLobbyVanityData[i].vanity_data;
            }
            else if (m_aDisplayLobbyVanityData[i]) {
                _ClearLobbyVanityModel(m_aDisplayLobbyVanityData[i].playeridx);
                delete m_aDisplayLobbyVanityData[i];
            }
        }
    };
    const _ClearLobbyPlayers = function () {
        m_aDisplayLobbyVanityData.forEach((element, index) => {
            _ClearLobbyVanityModel(index);
        });
        m_aDisplayLobbyVanityData = [];
    };
    const _ClearLobbyVanityModel = function (index) {
        VanityPlayerInfo.DeleteVanityInfoPanel($.GetContextPanel().FindChildInLayoutFile('MainMenuVanityInfo'), index);
        $('#JsMainmenu_Vanity').SetActiveCharacter(index);
        $('#JsMainmenu_Vanity').RemoveCharacterModel();
    };
    const _UpdateVanityFromLobbyUpdate = function (strVanityData, index, xuid) {
        const arrVanityInfo = strVanityData.split(',');
        const oSettings = {
            xuid: xuid,
            team: arrVanityInfo[0],
            charItemId: arrVanityInfo[1],
            glovesItemId: arrVanityInfo[2],
            loadoutSlot: arrVanityInfo[3],
            weaponItemId: arrVanityInfo[4],
            playeridx: index
        };
        _UpdatePlayerVanityModel(oSettings);
    };
    const _PlayerActivityVoice = function (xuid) {
        const vanityPanel = $('#JsMainmenu_Vanity');
        const elAvatar = vanityPanel.FindChildInLayoutFile('JsPlayerVanityAvatar-' + xuid);
        if (elAvatar && elAvatar.IsValid()) {
            VanityPlayerInfo.UpdateVoiceIcon(elAvatar, xuid);
        }
    };
    const _OnUISceneFrameBoundary = function () {
        const maxSlots = 5;
        const elVanityPanel = $('#JsMainmenu_Vanity');
        if (elVanityPanel && elVanityPanel.IsValid()) {
            const elVanityPlayerInfoParent = $.GetContextPanel().FindChildInLayoutFile('MainMenuVanityInfo');
            for (let i = 0; i < maxSlots; i++) {
                if (elVanityPanel.SetActiveCharacter(i) === true) {
                    const oPanelPos = elVanityPanel.GetBonePositionInPanelSpace('pelvis');
                    oPanelPos.y -= 0.0;
                    VanityPlayerInfo.SetVanityInfoPanelPos(elVanityPlayerInfoParent, i, oPanelPos);
                }
            }
        }
    };
    const _OnEquipSlotChanged = function () {
    };
    const _OpenPlayMenu = function () {
        if (MatchStatsAPI.GetUiExperienceType())
            return;
        _InsureSessionCreated();
        _NavigateToTab('JsPlay', 'mainmenu_play');
        _PauseMainMenuCharacter();
    };
    const _OpenWatchMenu = function () {
        _PauseMainMenuCharacter();
        _NavigateToTab('JsWatch', 'mainmenu_watch');
    };
    const _OpenInventory = function () {
        _PauseMainMenuCharacter();
        _NavigateToTab('JsInventory', 'mainmenu_inventory');
    };
    const _OpenStatsMenu = function () {
        _PauseMainMenuCharacter();
        _NavigateToTab('JsPlayerStats', 'mainmenu_playerstats');
    };
    const _OpenSubscriptionUpsell = function () {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_subscription_upsell.xml', '');
    };
    const _ShowLoadoutForItem = function (itemId) {
        if (!$.GetContextPanel().FindChildInLayoutFile('JsLoadout')) {
            $.DispatchEvent("Activated", $.GetContextPanel().FindChildInLayoutFile('MainMenuNavBarLoadout'), "mouse");
            $.DispatchEvent("ShowLoadoutForItem", itemId);
            return;
        }
        $.DispatchEvent("Activated", $.GetContextPanel().FindChildInLayoutFile('MainMenuNavBarLoadout'), "mouse");
    };
    const _OpenSettings = function () {
        MainMenu.NavigateToTab('JsSettings', 'settings/settings');
    };
    const _PreloadSettings = function () {
        const tab = 'JsSettings';
        const XmlName = 'settings/settings';
        const newPanel = $.CreatePanel('Panel', _m_elContentPanel, tab);
        newPanel.BLoadLayout('file://{resources}/layout/' + XmlName + '.xml', false, false);
        newPanel.RegisterForReadyEvents(true);
        newPanel.AddClass('mainmenu-content--hidden');
        $.RegisterEventHandler('PropertyTransitionEnd', newPanel, function (panelName, propertyName) {
            if (newPanel.id === panelName && propertyName === 'opacity') {
                if (newPanel.visible === true && newPanel.BIsTransparent()) {
                    newPanel.SetReadyForDisplay(false);
                    newPanel.visible = false;
                    return true;
                }
                else if (newPanel.visible === true) {
                    $.DispatchEvent('MainMenuTabShown', tab);
                }
            }
            return false;
        });
    };
    const _InsureSessionCreated = function () {
        if (!LobbyAPI.IsSessionActive()) {
            LobbyAPI.CreateSession();
        }
    };
    const _OnEscapeKeyPressed = function () {
        if (_m_activeTab)
            _OnHomeButtonPressed();
        else
            GameInterfaceAPI.ConsoleCommand("gameui_hide");
    };
    const _InventoryUpdated = function () {
        _ForceRestartVanity();
        if (GameStateAPI.IsLocalPlayerPlayingMatch()) {
            return;
        }
        _UpdateInventoryBtnAlert();
        _UpdateSubscriptionAlert();
        _UpdateStoreAlert();
    };
    function _CheckRankUpRedemptionStore() {
        if (_m_bHasPopupNotification)
            return;
        if (!$('#MainMenuNavBarHome').checked)
            return;
        const objStore = InventoryAPI.GetCacheTypeElementJSOByIndex("PersonalStore", 0);
        if (!objStore)
            return;
        if (!MyPersonaAPI.IsConnectedToGC() || !MyPersonaAPI.IsInventoryValid())
            return;
        const genTime = objStore.generation_time;
        const balance = objStore.redeemable_balance;
        const prevClientGenTime = Number(GameInterfaceAPI.GetSettingString("cl_redemption_reset_timestamp"));
        if (prevClientGenTime != genTime && balance > 0) {
            _m_bHasPopupNotification = true;
            const RankUpRedemptionStoreClosedCallbackHandle = UiToolkitAPI.RegisterJSCallback(MainMenu.OnRankUpRedemptionStoreClosed);
            UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_rankup_redemption_store.xml', 'callback=' + RankUpRedemptionStoreClosedCallbackHandle);
        }
    }
    function _OnRankUpRedemptionStoreClosed() {
        _m_bHasPopupNotification = false;
        _msg('_OnRankUpRedemptionStoreClosed');
    }
    const _UpdateInventoryBtnAlert = function () {
        const aNewItems = AcknowledgeItems.GetItems();
        const count = aNewItems.length;
        const elNavBar = $.GetContextPanel().FindChildInLayoutFile('MainMenuNavBarTop'), elAlert = elNavBar.FindChildInLayoutFile('MainMenuInvAlert');
        elAlert.SetDialogVariable("alert_value", count.toString());
        elAlert.SetHasClass('hidden', count < 1);
    };
    const _OnInventoryInspect = function (id) {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', `itemid=${id}&inspectonly=true&viewfunc=primary`);
    };
    const _OnShowXrayCasePopup = function (toolid, caseId, bShowPopupWarning = false) {
        const showpopup = bShowPopupWarning ? 'yes' : 'no';
        UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-inspect-' + caseId, 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=' + toolid + ',' + caseId +
            '&' + 'asyncworktype=decodeable' +
            '&' + 'isxraymode=yes' +
            '&' + 'showxraypopup=' + showpopup);
    };
    let JsInspectCallback = -1;
    const _OnLootlistItemPreview = function (id, params) {
        if (JsInspectCallback != -1) {
            UiToolkitAPI.UnregisterJSCallback(JsInspectCallback);
            JsInspectCallback = -1;
        }
        const ParamsList = params.split(',');
        const keyId = ParamsList[0];
        const caseId = ParamsList[1];
        const storeId = ParamsList[2];
        const blurOperationPanel = ParamsList[3];
        const extrapopupfullscreenstyle = ParamsList[4];
        const aParamsForCallback = ParamsList.slice(5);
        const showMarketLinkDefault = _m_bPerfectWorld ? 'false' : 'true';
        JsInspectCallback = UiToolkitAPI.RegisterJSCallback(function () {
            let idtoUse = storeId ? storeId : caseId;
            let elPanel = $.GetContextPanel().FindChildInLayoutFile('PopupManager').FindChildInLayoutFile('popup-inspect-' + idtoUse);
            elPanel.visible = true;
            elPanel.SetHasClass('hide-for-lootlist', false);
        });
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + id +
            '&' + 'inspectonly=true' +
            '&' + 'allowsave=false' +
            '&' + 'showequip=false' +
            '&' + 'showitemcert=false' +
            '&' + blurOperationPanel +
            '&' + 'extrapopupfullscreenstyle=' + extrapopupfullscreenstyle +
            '&' + 'showmarketlink=' + showMarketLinkDefault +
            '&' + 'callback=' + JsInspectCallback +
            '&' + 'caseidforlootlist=' + caseId);
    };
    const _OpenDecodeAfterInspect = function (keyId, caseId, storeId, extrapopupfullscreenstyle, aParamsForCallback) {
        const backtostoreiteminspectsettings = storeId ?
            '&' + 'asyncworkitemwarning=no' +
                '&' + 'asyncforcehide=true' +
                '&' + 'storeitemid=' + storeId +
                '&' + 'extrapopupfullscreenstyle=' + extrapopupfullscreenstyle
            : '';
        const backtodecodeparams = aParamsForCallback.length > 0 ?
            '&' + aParamsForCallback.join('&') :
            '';
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=' + keyId + ',' + caseId +
            '&' + 'asyncworktype=decodeable' +
            backtostoreiteminspectsettings +
            backtodecodeparams);
    };
    const _WeaponPreviewRequest = function (id, bWorkshopItemPreview = false) {
        const workshopPreview = bWorkshopItemPreview ? 'true' : 'false';
        UiToolkitAPI.CloseAllVisiblePopups();
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + id +
            '&' + 'inspectonly=true' +
            '&' + 'allowsave=false' +
            '&' + 'showequip=false' +
            '&' + 'showitemcert=true' +
            '&' + 'workshopPreview=' + workshopPreview);
    };
    const _UpdateSubscriptionAlert = function () {
        return;
        const elNavBar = $.GetContextPanel().FindChildInLayoutFile('MainMenuNavBarTop'), elAlert = elNavBar.FindChildInLayoutFile('MainMenuSubscriptionAlert');
        elAlert.SetDialogVariable("alert_value", $.Localize("#Store_Price_New"));
        const hideAlert = GameInterfaceAPI.GetSettingString('ui_show_subscription_alert') === '1' ? true : false;
        elAlert.SetHasClass('hidden', hideAlert);
    };
    function _UpdateStoreAlert() {
        let hideAlert;
        const objStore = InventoryAPI.GetCacheTypeElementJSOByIndex("PersonalStore", 0);
        const gcConnection = MyPersonaAPI.IsConnectedToGC();
        const validInventory = MyPersonaAPI.IsInventoryValid();
        hideAlert = !gcConnection || !validInventory || !objStore || objStore.redeemable_balance === 0;
        const elNavBar = $.GetContextPanel().FindChildInLayoutFile('MainMenuNavBarTop');
        const elAlert = elNavBar.FindChildInLayoutFile('MainMenuStoreAlert');
        elAlert.SetDialogVariable("alert_value", $.Localize("#Store_Price_New"));
        elAlert.SetHasClass('hidden', hideAlert);
    }
    ;
    function _CancelNotificationSchedule() {
        if (_m_notificationSchedule !== false) {
            $.CancelScheduled(_m_notificationSchedule);
            _m_notificationSchedule = false;
        }
    }
    function _AcknowledgePenaltyNotificationsCallback() {
        CompetitiveMatchAPI.ActionAcknowledgePenalty();
        _m_bHasPopupNotification = false;
    }
    function _AcknowledgeMsgNotificationsCallback() {
        MyPersonaAPI.ActionAcknowledgeNotifications();
        _m_bHasPopupNotification = false;
    }
    function _GetPopupNotification() {
        const popupNotification = {
            title: "",
            msg: "",
            color_class: "NotificationYellow",
            callback: function () { },
            html: false
        };
        const nBanRemaining = CompetitiveMatchAPI.GetCooldownSecondsRemaining();
        if (nBanRemaining < 0) {
            popupNotification.title = "#SFUI_MainMenu_Competitive_Ban_Confirm_Title";
            popupNotification.msg = $.Localize("#SFUI_CooldownExplanationReason_Expired_Cooldown") + $.Localize(CompetitiveMatchAPI.GetCooldownReason());
            popupNotification.callback = _AcknowledgePenaltyNotificationsCallback;
            popupNotification.html = true;
            return popupNotification;
        }
        const strNotifications = MyPersonaAPI.GetMyNotifications();
        if (strNotifications !== "") {
            const arrayOfNotifications = strNotifications.split(',');
            arrayOfNotifications.forEach(function (notificationType) {
                if (notificationType !== "6") {
                    popupNotification.color_class = 'NotificationBlue';
                }
                popupNotification.title = '#SFUI_PersonaNotification_Title_' + notificationType;
                popupNotification.msg = '#SFUI_PersonaNotification_Msg_' + notificationType;
                popupNotification.callback = _AcknowledgeMsgNotificationsCallback;
                return true;
            });
            return popupNotification;
        }
        return null;
    }
    function _UpdatePopupnotification() {
        if (!_m_bHasPopupNotification) {
            const popupNotification = _GetPopupNotification();
            if (popupNotification != null) {
                const elPopup = UiToolkitAPI.ShowGenericPopupOneOption(popupNotification.title, popupNotification.msg, popupNotification.color_class, '#SFUI_MainMenu_ConfirmBan', popupNotification.callback);
                if (popupNotification.html)
                    elPopup.EnableHTML();
                _m_bHasPopupNotification = true;
            }
        }
    }
    function _GetNotificationBarData() {
        const notification = { color_class: "", title: "", tooltip: "", link: "" };
        if (LicenseUtil.GetCurrentLicenseRestrictions() === false) {
            const bIsConnectedToGC = MyPersonaAPI.IsConnectedToGC();
            $('#MainMenuInput').SetHasClass('GameClientConnectingToGC', !bIsConnectedToGC);
            if (bIsConnectedToGC) {
                _m_tLastSeenDisconnectedFromGC = 0;
            }
            else if (!_m_tLastSeenDisconnectedFromGC) {
                _m_tLastSeenDisconnectedFromGC = +new Date();
            }
            else if (Math.abs((+new Date()) - _m_tLastSeenDisconnectedFromGC) > 7000) {
                notification.color_class = "NotificationLoggingOn";
                notification.title = $.Localize("#Store_Connecting_ToGc");
                notification.tooltip = $.Localize("#Store_Connecting_ToGc_Tooltip");
                return notification;
            }
        }
        const nIsVacBanned = MyPersonaAPI.IsVacBanned();
        if (nIsVacBanned != 0) {
            notification.color_class = "NotificationRed";
            if (nIsVacBanned == 1) {
                notification.title = $.Localize("#SFUI_MainMenu_Vac_Title");
                notification.tooltip = $.Localize("#SFUI_MainMenu_Vac_Info");
                notification.link = "https://help.steampowered.com/faqs/view/647C-5CC1-7EA9-3C29";
            }
            else {
                notification.title = $.Localize("#SFUI_MainMenu_GameBan_Title");
                notification.tooltip = $.Localize("#SFUI_MainMenu_GameBan_Info");
                notification.link = "https://help.steampowered.com/faqs/view/4E54-0B96-D0A4-1557";
            }
            return notification;
        }
        if (NewsAPI.IsNewClientAvailable()) {
            notification.color_class = "NotificationYellow";
            notification.title = $.Localize("#SFUI_MainMenu_Outofdate_Title");
            notification.tooltip = $.Localize("#SFUI_MainMenu_Outofdate_Body");
            return notification;
        }
        const nBanRemaining = CompetitiveMatchAPI.GetCooldownSecondsRemaining();
        if (nBanRemaining > 0) {
            notification.tooltip = CompetitiveMatchAPI.GetCooldownReason();
            const strType = CompetitiveMatchAPI.GetCooldownType();
            if (strType == "global") {
                notification.title = $.Localize("#SFUI_MainMenu_Global_Ban_Title");
                notification.color_class = "NotificationRed";
            }
            else if (strType == "green") {
                notification.title = $.Localize("#SFUI_MainMenu_Temporary_Ban_Title");
                notification.color_class = "NotificationGreen";
            }
            else if (strType == "competitive") {
                notification.title = $.Localize("#SFUI_MainMenu_Competitive_Ban_Title");
                notification.color_class = "NotificationYellow";
            }
            if (!CompetitiveMatchAPI.CooldownIsPermanent()) {
                const title = notification.title;
                if (CompetitiveMatchAPI.ShowFairPlayGuidelinesForCooldown()) {
                    notification.link = "https://blog.counter-strike.net/index.php/fair-play-guidelines/";
                }
                notification.title = title + ' ' + FormatText.SecondsToSignificantTimeString(nBanRemaining);
            }
            return notification;
        }
        return null;
    }
    function _UpdateNotificationBar() {
        const notification = _GetNotificationBarData();
        _m_NotificationBarColorClasses.forEach(function (strColorClass) {
            const bVisibleColor = notification && notification.color_class;
            _m_elNotificationsContainer.SetHasClass(strColorClass, !!bVisibleColor);
        });
        if (notification !== null) {
            if (notification.link) {
                const btnClickableLink = $.FindChildInContext('#ClickableLinkButton');
                btnClickableLink.enabled = true;
                btnClickableLink.SetPanelEvent('onactivate', () => SteamOverlayAPI.OpenUrlInOverlayOrExternalBrowser(notification.link));
                notification.title = "<span class='fairplay-link'>" + notification.title + "</span>";
            }
            $.FindChildInContext('#MainMenuNotificationTitle').text = notification.title;
        }
        _m_elNotificationsContainer.SetHasClass('hidden', notification === null);
    }
    function _UpdateNotifications() {
        _msg('_UpdateNotifications');
        if (_m_notificationSchedule == false) {
            _LoopUpdateNotifications();
        }
    }
    const _LoopUpdateNotifications = function () {
        _UpdatePopupnotification();
        _UpdateNotificationBar();
        const REDEMPTION_ENABLED = true;
        if (REDEMPTION_ENABLED) {
            _CheckRankUpRedemptionStore();
        }
        _m_notificationSchedule = $.Schedule(1, _LoopUpdateNotifications);
    };
    let _m_acknowledgePopupHandler = null;
    const _ShowAcknowledgePopup = function (type = '', itemid = '') {
        if (type === 'xpgrant') {
            UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_acknowledge_xpgrant.xml', 'none');
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.inventory_new_item', 'MOUSE');
            return;
        }
        let updatedItemTypeAndItemid = '';
        if (itemid && type)
            updatedItemTypeAndItemid = 'ackitemid=' + itemid + '&acktype=' + type;
        if (!_m_acknowledgePopupHandler) {
            let jsPopupCallbackHandle;
            jsPopupCallbackHandle = UiToolkitAPI.RegisterJSCallback(MainMenu.ResetAcknowlegeHandler);
            _m_acknowledgePopupHandler = UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_acknowledge_item.xml', updatedItemTypeAndItemid + '&callback=' + jsPopupCallbackHandle);
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.inventory_new_item', 'MOUSE');
        }
    };
    const _ResetAcknowlegeHandler = function () {
        _m_acknowledgePopupHandler = null;
    };
    const _ShowNotificationBarTooltip = function () {
        const notification = _GetNotificationBarData();
        if (notification !== null) {
            UiToolkitAPI.ShowTextTooltip('NotificationsContainer', notification.tooltip);
        }
    };
    const _ShowVote = function () {
        const contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('MainMenuNavBarVote', '', 'file://{resources}/layout/context_menus/context_menu_vote.xml', '', function () {
        });
        contextMenuPanel.AddClass("ContextMenu_NoArrow");
    };
    const _HideStoreStatusPanel = function () {
        if (_m_storePopupElement && _m_storePopupElement.IsValid()) {
            _m_storePopupElement.DeleteAsync(0);
        }
        _m_storePopupElement = null;
    };
    const _ShowStoreStatusPanel = function (strText, bAllowClose, bCancel, strOkCmd) {
        _HideStoreStatusPanel();
        let paramclose = '0';
        if (bAllowClose) {
            paramclose = '1';
        }
        let paramcancel = '0';
        if (bCancel) {
            paramcancel = '1';
        }
        _m_storePopupElement = UiToolkitAPI.ShowCustomLayoutPopupParameters('store_popup', 'file://{resources}/layout/popups/popup_store_status.xml', 'text=' + strText +
            '&' + 'allowclose=' + paramclose +
            '&' + 'cancel=' + paramcancel +
            '&' + 'okcmd=' + strOkCmd);
    };
    const _ShowWeaponUpdatePopup = function () {
        return;
        const setVersionTo = '1';
        const currentVersion = GameInterfaceAPI.GetSettingString('ui_popup_weaponupdate_version');
        if (currentVersion !== setVersionTo) {
        }
    };
    const _ShowOperationLaunchPopup = function () {
        if (_m_hOnEngineSoundSystemsRunningRegisterHandle) {
            $.UnregisterForUnhandledEvent("PanoramaComponent_GameInterface_EngineSoundSystemsRunning", _m_hOnEngineSoundSystemsRunningRegisterHandle);
            _m_hOnEngineSoundSystemsRunningRegisterHandle = null;
        }
        const setVersionTo = '2109';
        GameInterfaceAPI.SetSettingString('ui_popup_weaponupdate_version', setVersionTo);
    };
    const _ShowUpdateWelcomePopup = function () {
        const setVersionTo = '2303';
        const currentVersion = GameInterfaceAPI.GetSettingString('ui_popup_weaponupdate_version');
        if (currentVersion !== setVersionTo) {
            UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_welcome_launch.xml', 'uisettingversion=' + setVersionTo);
        }
    };
    const _PauseMainMenuCharacter = function () {
        const vanityPanel = $('#JsMainmenu_Vanity');
        if (vanityPanel && UiToolkitAPI.IsPanoramaInECOMode()) {
            vanityPanel.Pause();
        }
    };
    const _ShowTournamentStore = function () {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_tournament_store.xml', '');
    };
    function _AddPauseMenuMissionPanel() {
        let elPanel = null;
        const missionId = GameStateAPI.GetActiveQuestID();
        const oGameState = GameStateAPI.GetTimeDataJSO();
        if (!$.GetContextPanel().FindChildInLayoutFile('JsActiveMission') && missionId && oGameState && oGameState.gamephase !== 5) {
            elPanel = $.CreatePanel('Panel', $('#JsActiveMissionPanel'), 'JsActiveMission');
            elPanel.AddClass('PauseMenuModeOnly');
            elPanel.BLoadLayout('file://{resources}/layout/operation/operation_active_mission.xml', false, false);
        }
        else {
            elPanel = $.GetContextPanel().FindChildInLayoutFile('JsActiveMission');
        }
        if (missionId && elPanel && elPanel.IsValid()) {
            elPanel.SetAttributeString('missionid', missionId.toString());
        }
    }
    function _DeletePauseMenuMissionPanel() {
        if ($.GetContextPanel().FindChildInLayoutFile('JsActiveMission')) {
            $.GetContextPanel().FindChildInLayoutFile('JsActiveMission').DeleteAsync(0.0);
        }
    }
    const _SlideSearchPartyParticles = function (bSlidout) {
        const particle_container = $('#party-search-particles');
        particle_container.SetHasClass("mainmenu-party-search-particle--slide-out", bSlidout);
        particle_container.SetControlPoint(3, 0, 0, 0);
        particle_container.SetControlPoint(3, 1, 0, 0);
    };
    const _ResetSurvivalEndOfMatch = function () {
        _DeleteSurvivalEndOfMatch();
        function CreateEndOfMatchPanel() {
            const elPanel = $('#PauseMenuSurvivalEndOfMatch');
            if (!elPanel) {
            }
            _UpdateSurvivalEndOfMatchInstance();
        }
        $.Schedule(0.1, CreateEndOfMatchPanel);
    };
    const _DeleteSurvivalEndOfMatch = function () {
        if ($('#PauseMenuSurvivalEndOfMatch')) {
            $('#PauseMenuSurvivalEndOfMatch').DeleteAsync(0.0);
        }
    };
    function _UpdateSurvivalEndOfMatchInstance() {
        const elSurvivalPanel = $('#PauseMenuSurvivalEndOfMatch');
        if (elSurvivalPanel && elSurvivalPanel.IsValid()) {
            // @ts-ignore remove after survival_endofmatch.js is TypeScript
            elSurvivalPanel.matchStatus.UpdateFromPauseMenu();
        }
    }
    const _ShowHideAlertForNewEventForWatchBtn = function () {
    };
    const _WatchBtnPressedUpdateAlert = function () {
        _ShowHideAlertForNewEventForWatchBtn();
    };
    const _StatsBtnPressedUpdateAlert = function () {
        _ShowHideAlertForNewEventForWatchBtn();
    };
    const _UpdateUnlockCompAlert = function () {
        const btn = $.GetContextPanel().FindChildInLayoutFile('MainMenuNavBarPlay');
        const alert = btn.FindChildInLayoutFile('MainMenuPlayAlert');
        alert.SetDialogVariable("alert_value", $.Localize("#Store_Price_New"));
        if (!MyPersonaAPI.IsConnectedToGC()) {
            alert.AddClass('hidden');
            return;
        }
        const bHide = GameInterfaceAPI.GetSettingString('ui_show_unlock_competitive_alert') === '1' ||
            MyPersonaAPI.HasPrestige() ||
            MyPersonaAPI.GetCurrentLevel() !== 2;
        alert.SetHasClass('hidden', bHide);
    };
    function _SwitchVanity(team) {
        $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE');
        GameInterfaceAPI.SetSettingString('ui_vanitysetting_team', team);
        _ForceRestartVanity();
    }
    function _GoToCharacterLoadout(team) {
        _OpenInventory();
        let teamName = ((team == '2') ? 't' : 'ct');
        $.DispatchEvent("ShowLoadoutForItem", LoadoutAPI.GetItemID(teamName, 'customplayer'));
    }
    function _OnGoToCharacterLoadoutPressed() {
        if (!MyPersonaAPI.IsInventoryValid() || !MyPersonaAPI.IsConnectedToGC()) {
            UiToolkitAPI.ShowGenericPopupOk($.Localize('#SFUI_SteamConnectionErrorTitle'), $.Localize('#SFUI_Steam_Error_LinkUnexpected'), '', function () { });
            return;
        }
        const team = GameInterfaceAPI.GetSettingString('ui_vanitysetting_team') == 't' ? 2 : 3;
        const elVanityContextMenu = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('id-vanity-contextmenu', '', 'file://{resources}/layout/context_menus/context_menu_mainmenu_vanity.xml', 'type=catagory' +
            '&' + 'team=' + team, function () { });
        elVanityContextMenu.AddClass("ContextMenu_NoArrow");
    }
    function _CheckConnection() {
        if (!MyPersonaAPI.IsConnectedToGC()) {
            if (!_BCheckTabCanBeOpenedRightNow(_m_activeTab)) {
                _OnHomeButtonPressed();
            }
        }
    }
    function _OnPlayButtonPressed() {
        if (GameTypesAPI.ShouldForceNewUserTraining()) {
            _OnHomeButtonPressed();
            _NewUser_ShowForceTrainingPopup();
        }
        else if (GameTypesAPI.ShouldShowNewUserPopup()) {
            _OnHomeButtonPressed();
            _NewUser_ShowTrainingCompletePopup();
        }
        else {
            $.DispatchEvent('OpenPlayMenu');
        }
    }
    function _NewUser_ShowForceTrainingPopup() {
        UiToolkitAPI.ShowGenericPopupOkCancel('#ForceNewUserTraining_title', '#ForceNewUserTraining_text', '', () => {
            $.DispatchEvent('OpenPlayMenu');
            $.Schedule(0.1, _NewUser_TrainingMatch);
        }, () => { });
    }
    function _NewUser_ShowTrainingCompletePopup() {
        UiToolkitAPI.ShowGenericPopupThreeOptions('#PlayMenu_NewUser_title', '#PlayMenu_NewUser_text', '', '#PlayMenu_NewUser_casual', function () {
            GameTypesAPI.DisableNewUserExperience();
            $.DispatchEvent('OpenPlayMenu');
            $.Schedule(0.1, _NewUser_CasualMatchmaking);
        }, '#PlayMenu_NewUser_training', function () {
            $.DispatchEvent('OpenPlayMenu');
            $.Schedule(0.1, _NewUser_TrainingMatch);
        }, '#PlayMenu_NewUser_other', function () {
            GameTypesAPI.DisableNewUserExperience();
            $.DispatchEvent('OpenPlayMenu');
        });
    }
    function _NewUser_TrainingMatch() {
        const settings = {
            update: {
                Options: {
                    action: 'custommatch',
                    server: 'listen',
                },
                Game: {
                    mode: 'new_user_training',
                    type: 'classic',
                    mapgroupname: 'mg_de_dust2',
                    map: 'de_dust2'
                }
            },
            delete: {}
        };
        LobbyAPI.UpdateSessionSettings(settings);
        LobbyAPI.StartMatchmaking('', '', '', '');
    }
    ;
    function _NewUser_CasualMatchmaking() {
        const settings = {
            update: {
                Options: {
                    action: 'custommatch',
                    server: 'official',
                },
                Game: {
                    mode: 'casual',
                    mode_ui: 'casual',
                    type: 'classic',
                    gamemodeflags: 0,
                    mapgroupname: 'mg_dust247',
                    map: 'de_dust2'
                }
            },
            delete: {}
        };
        LobbyAPI.UpdateSessionSettings(settings);
        LobbyAPI.StartMatchmaking('', '', '', '');
    }
    ;
    function _OnLeaderboardStateChange() {
        _msg('leaderboard status: received');
        _UpdateLocalPlayerVanity();
    }
    function _CheckGraphicsDrivers() {
        if (GameInterfaceAPI.GetSettingString('cl_graphics_driver_warning_dont_show_again') !== '0')
            return;
        let info = GameInterfaceAPI.GetGraphicsDriverInfo();
        switch (info.vendor_id) {
            case 0x1002:
                {
                    let minHigh = (31 << 16) | 0;
                    let minLow = (21905 << 16) | 1001;
                    if (info.amd_post_vega) {
                        minHigh = (31 << 16) | 0;
                        minLow = (22023 << 16) | 1014;
                    }
                    if (info.version_high < minHigh || (info.version_high == minHigh && info.version_low < minLow))
                        _ShowGraphicsDriverWarning("AMD", 'https://amd.com/support');
                    break;
                }
            case 0x10DE:
                {
                    let minHigh = (31 << 16) | 0;
                    let minLow = (15 << 16) | 4601;
                    if (info.version_high < minHigh || (info.version_high == minHigh && info.version_low < minLow))
                        _ShowGraphicsDriverWarning("Nvidia", 'https://nvidia.com/drivers');
                    break;
                }
        }
    }
    function _ShowGraphicsDriverWarning(vendor, link) {
        UiToolkitAPI.ShowGenericPopupThreeOptions('#PlayMenu_GraphicsDriverWarning_Title', '#PlayMenu_GraphicsDriverWarning_' + vendor, '', '#PlayMenu_GraphicsDriverLink_' + vendor, function () {
            SteamOverlayAPI.OpenExternalBrowserURL(link);
        }, '#PlayMenu_GraphicsDriverWarning_DontShowAgain', () => {
            GameInterfaceAPI.SetSettingString('cl_graphics_driver_warning_dont_show_again', '1');
        }, '#OK', () => { });
    }
    return {
        OnInitFadeUp: _OnInitFadeUp,
        OnShowMainMenu: _OnShowMainMenu,
        OnHideMainMenu: _OnHideMainMenu,
        OnShowPauseMenu: _OnShowPauseMenu,
        OnHidePauseMenu: _OnHidePauseMenu,
        NavigateToTab: _NavigateToTab,
        PreloadSettings: _PreloadSettings,
        ShowContentPanel: _ShowContentPanel,
        OnHideContentPanel: _OnHideContentPanel,
        GetActiveNavBarButton: _GetActiveNavBarButton,
        ShowHideNavDrawer: _ShowHideNavDrawer,
        ExpandSidebar: _ExpandSidebar,
        MinimizeSidebar: _MinimizeSidebar,
        OnSideBarElementContextMenuActive: _OnSideBarElementContextMenuActive,
        InitFriendsList: _InitFriendsList,
        InitNewsAndStore: _InitNewsAndStore,
        InitVanity: _InitVanity,
        ForceRestartVanity: _ForceRestartVanity,
        OnEquipSlotChanged: _OnEquipSlotChanged,
        OpenPlayMenu: _OpenPlayMenu,
        OpenWatchMenu: _OpenWatchMenu,
        OpenStatsMenu: _OpenStatsMenu,
        OpenInventory: _OpenInventory,
        OpenSettings: _OpenSettings,
        OnHomeButtonPressed: _OnHomeButtonPressed,
        OnQuitButtonPressed: _OnQuitButtonPressed,
        OnEscapeKeyPressed: _OnEscapeKeyPressed,
        GameMustExitNowForAntiAddiction: _GameMustExitNowForAntiAddiction,
        GcLogonNotificationReceived: _GcLogonNotificationReceived,
        InventoryUpdated: _InventoryUpdated,
        LobbyPlayerUpdated: _LobbyPlayerUpdated,
        OnInventoryInspect: _OnInventoryInspect,
        OnShowXrayCasePopup: _OnShowXrayCasePopup,
        WeaponPreviewRequest: _WeaponPreviewRequest,
        OnLootlistItemPreview: _OnLootlistItemPreview,
        UpdateNotifications: _UpdateNotifications,
        ShowAcknowledgePopup: _ShowAcknowledgePopup,
        ShowOperationLaunchPopup: _ShowOperationLaunchPopup,
        ResetAcknowlegeHandler: _ResetAcknowlegeHandler,
        ShowNotificationBarTooltip: _ShowNotificationBarTooltip,
        ShowVote: _ShowVote,
        ShowStoreStatusPanel: _ShowStoreStatusPanel,
        HideStoreStatusPanel: _HideStoreStatusPanel,
        UpdateBackgroundMap: _UpdateBackgroundMap,
        PauseMainMenuCharacter: _PauseMainMenuCharacter,
        ShowTournamentStore: _ShowTournamentStore,
        TournamentDraftUpdate: _TournamentDraftUpdate,
        ResetSurvivalEndOfMatch: _ResetSurvivalEndOfMatch,
        OnGoToCharacterLoadoutPressed: _OnGoToCharacterLoadoutPressed,
        ResetNewsEntryStyle: _ResetNewsEntryStyle,
        OnSteamIsPlaying: _OnSteamIsPlaying,
        WatchBtnPressedUpdateAlert: _WatchBtnPressedUpdateAlert,
        StatsBtnPressedUpdateAlert: _StatsBtnPressedUpdateAlert,
        HideMainMenuNewsPanel: _HideMainMenuNewsPanel,
        ShowLoadoutForItem: _ShowLoadoutForItem,
        SwitchVanity: _SwitchVanity,
        GoToCharacterLoadout: _GoToCharacterLoadout,
        OpenSubscriptionUpsell: _OpenSubscriptionUpsell,
        UpdateUnlockCompAlert: _UpdateUnlockCompAlert,
        PlayerActivityVoice: _PlayerActivityVoice,
        CheckConnection: _CheckConnection,
        OnPlayButtonPressed: _OnPlayButtonPressed,
        UpdateLocalPlayerVanity: _UpdateLocalPlayerVanity,
        OnLeaderboardStateChange: _OnLeaderboardStateChange,
        OnRankUpRedemptionStoreClosed: _OnRankUpRedemptionStoreClosed
    };
})();
(function () {
    $.LogChannel("CSGO_MainMenu", "LV_DEFAULT", "#aaff80");
    $.RegisterForUnhandledEvent('HideContentPanel', MainMenu.OnHideContentPanel);
    $.RegisterForUnhandledEvent('SidebarContextMenuActive', MainMenu.OnSideBarElementContextMenuActive);
    $.RegisterForUnhandledEvent('OpenPlayMenu', MainMenu.OpenPlayMenu);
    $.RegisterForUnhandledEvent('OpenInventory', MainMenu.OpenInventory);
    $.RegisterForUnhandledEvent('OpenWatchMenu', MainMenu.OpenWatchMenu);
    $.RegisterForUnhandledEvent('OpenStatsMenu', MainMenu.OpenStatsMenu);
    $.RegisterForUnhandledEvent('OpenSubscriptionUpsell', MainMenu.OpenSubscriptionUpsell);
    $.RegisterForUnhandledEvent('CSGOShowMainMenu', MainMenu.OnShowMainMenu);
    $.RegisterForUnhandledEvent('CSGOHideMainMenu', MainMenu.OnHideMainMenu);
    $.RegisterForUnhandledEvent('CSGOShowPauseMenu', MainMenu.OnShowPauseMenu);
    $.RegisterForUnhandledEvent('CSGOHidePauseMenu', MainMenu.OnHidePauseMenu);
    $.RegisterForUnhandledEvent('OpenSidebarPanel', MainMenu.ExpandSidebar);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_GameMustExitNowForAntiAddiction', MainMenu.GameMustExitNowForAntiAddiction);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_GcLogonNotificationReceived', MainMenu.GcLogonNotificationReceived);
    $.RegisterForUnhandledEvent('PanoramaComponent_GC_Hello', MainMenu.UpdateUnlockCompAlert);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', MainMenu.InventoryUpdated);
    $.RegisterForUnhandledEvent('InventoryItemPreview', MainMenu.OnInventoryInspect);
    $.RegisterForUnhandledEvent('LootlistItemPreview', MainMenu.OnLootlistItemPreview);
    $.RegisterForUnhandledEvent('ShowXrayCasePopup', MainMenu.OnShowXrayCasePopup);
    $.RegisterForUnhandledEvent('PanoramaComponent_Inventory_WeaponPreviewRequest', MainMenu.WeaponPreviewRequest);
    $.RegisterForUnhandledEvent("PanoramaComponent_TournamentMatch_DraftUpdate", MainMenu.TournamentDraftUpdate);
    $.RegisterForUnhandledEvent('ShowLoadoutForItem', MainMenu.ShowLoadoutForItem);
    $.RegisterForUnhandledEvent('ShowAcknowledgePopup', MainMenu.ShowAcknowledgePopup);
    $.RegisterForUnhandledEvent('ShowStoreStatusPanel', MainMenu.ShowStoreStatusPanel);
    $.RegisterForUnhandledEvent('HideStoreStatusPanel', MainMenu.HideStoreStatusPanel);
    $.RegisterForUnhandledEvent('UnloadLoadingScreenAndReinit', MainMenu.ResetSurvivalEndOfMatch);
    $.RegisterForUnhandledEvent('MainMenu_OnGoToCharacterLoadoutPressed', MainMenu.OnGoToCharacterLoadoutPressed);
    $.RegisterForUnhandledEvent("PanoramaComponent_EmbeddedStream_VideoPlaying", MainMenu.OnSteamIsPlaying);
    $.RegisterForUnhandledEvent("StreamPanelClosed", MainMenu.ResetNewsEntryStyle);
    $.RegisterForUnhandledEvent("HideMainMenuNewsPanel", MainMenu.HideMainMenuNewsPanel);
    $.RegisterForUnhandledEvent("CSGOMainInitBackgroundMovie", MainMenu.UpdateBackgroundMap);
    $.RegisterForUnhandledEvent("MainMenuGoToSettings", MainMenu.OpenSettings);
    $.RegisterForUnhandledEvent("MainMenuGoToCharacterLoadout", MainMenu.GoToCharacterLoadout);
    $.RegisterForUnhandledEvent("PanoramaComponent_PartyList_PlayerActivityVoice", MainMenu.PlayerActivityVoice);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_UpdateConnectionToGC', MainMenu.CheckConnection);
    MainMenu.MinimizeSidebar();
    MainMenu.InitVanity();
    MainMenu.MinimizeSidebar();
    MainMenu.InitFriendsList();
    MainMenu.InitNewsAndStore();
    $.RegisterForUnhandledEvent('CSGOMainMenuEscapeKeyPressed', MainMenu.OnEscapeKeyPressed);
    $.RegisterForUnhandledEvent('PanoramaComponent_GC_Hello', MainMenu.UpdateLocalPlayerVanity);
    $.RegisterForUnhandledEvent('PanoramaComponent_FriendsList_ProfileUpdated', MainMenu.UpdateLocalPlayerVanity);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_PipRankUpdate', MainMenu.UpdateLocalPlayerVanity);
    $.RegisterForUnhandledEvent('PanoramaComponent_FriendsList_NameChanged', MainMenu.UpdateLocalPlayerVanity);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWFpbm1lbnUuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9tYWlubWVudS50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsa0NBQWtDO0FBQ2xDLGlEQUFpRDtBQUNqRCw4Q0FBOEM7QUFDOUMsb0RBQW9EO0FBQ3BELHlEQUF5RDtBQUN6RCxtQ0FBbUM7QUFDbkMsa0NBQWtDO0FBQ2xDLDhDQUE4QztBQUM5Qyw2Q0FBNkM7QUFNN0MsSUFBSSxRQUFRLEdBQUcsQ0FBRTtJQUVoQixNQUFNLGdCQUFnQixHQUFHLENBQUUsWUFBWSxDQUFDLGVBQWUsRUFBRSxLQUFLLGNBQWMsQ0FBRSxDQUFDO0lBQy9FLElBQUksWUFBWSxHQUFrQixJQUFJLENBQUM7SUFDdkMsSUFBSSxrQ0FBa0MsR0FBRyxLQUFLLENBQUM7SUFDL0MsTUFBTSxpQkFBaUIsR0FBRyxDQUFDLENBQUUsb0JBQW9CLENBQUcsQ0FBQztJQUNyRCxJQUFJLHFCQUFxQixHQUFHLEtBQUssQ0FBQztJQUdsQyxNQUFNLDJCQUEyQixHQUFHLENBQUMsQ0FBRSx5QkFBeUIsQ0FBRyxDQUFDO0lBQ3BFLElBQUksdUJBQXVCLEdBQW1CLEtBQUssQ0FBQztJQUNwRCxJQUFJLGlDQUFpQyxHQUFHLEtBQUssQ0FBQztJQUM5QyxJQUFJLHdCQUF3QixHQUFHLEtBQUssQ0FBQztJQUNyQyxJQUFJLDhCQUE4QixHQUFHLENBQUMsQ0FBQztJQUN2QyxNQUFNLDhCQUE4QixHQUFHO1FBQ3RDLGlCQUFpQixFQUFFLG9CQUFvQixFQUFFLG1CQUFtQixFQUFFLHVCQUF1QjtLQUNyRixDQUFDO0lBR0YsSUFBSSxpQ0FBaUMsR0FBa0IsSUFBSSxDQUFDO0lBQzVELElBQUksNENBQTRDLEdBQWtCLElBQUksQ0FBQztJQUN2RSxJQUFJLHNDQUFzQyxHQUFrQixJQUFJLENBQUM7SUFDakUsSUFBSSx3Q0FBd0MsR0FBa0IsSUFBSSxDQUFD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