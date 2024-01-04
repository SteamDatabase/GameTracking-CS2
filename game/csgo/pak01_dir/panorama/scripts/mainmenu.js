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
    let _m_equipSlotChangedHandler = null;
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
        if (!_m_equipSlotChangedHandler) {
            _m_equipSlotChangedHandler = $.RegisterForUnhandledEvent('PanoramaComponent_Loadout_EquipSlotChanged', MainMenu.UpdateLocalPlayerVanity);
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
        if (_m_equipSlotChangedHandler) {
            $.UnregisterForUnhandledEvent("PanoramaComponent_Loadout_EquipSlotChanged", _m_equipSlotChangedHandler);
            _m_equipSlotChangedHandler = null;
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