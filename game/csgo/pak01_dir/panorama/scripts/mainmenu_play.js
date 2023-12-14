"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/scheduler.ts" />
/// <reference path="avatar.ts" />
/// <reference path="particle_controls.ts" />
/// <reference path="util_gamemodeflags.ts" />
/// <reference path="common/formattext.ts" />
/// <reference path="common/icon.ts" />
/// <reference path="common/licenseutil.ts" />
/// <reference path="common/sessionutil.ts" />
/// <reference path="mainmenu_play_workshop.ts" />
/// <reference path="rating_emblem.ts" />
var PlayMenu = (function () {
    const k_workshopPanelId = 'gameModeButtonContainer_workshop';
    let _m_inventoryUpdatedHandler;
    const m_mapSelectionButtonContainers = {};
    let m_gameModeConfigs = {};
    let m_arrGameModeRadios = [];
    let GetMGDetails;
    let GetGameType;
    const m_bPerfectWorld = (MyPersonaAPI.GetLauncherType() === 'perfectworld');
    let m_activeMapGroupSelectionPanelID = null;
    let m_permissions = '';
    let m_serverSetting = '';
    let m_gameModeSetting = '';
    let m_singleSkirmishMapGroup = null;
    let m_arrSingleSkirmishMapGroups = [];
    const m_gameModeFlags = {};
    let m_isWorkshop = false;
    let m_jsTimerUpdateHandle = false;
    let m_challengeKey = '';
    let m_popupChallengeKeyEntryValidate = null;
    const k_workshopModes = {
        classic: 'casual,competitive',
        casual: 'casual',
        competitive: 'competitive',
        wingman: 'scrimcomp2v2',
        deathmatch: 'deathmatch',
        training: 'training',
        coopstrike: 'coopmission',
        custom: 'custom',
        flyingscoutsman: 'flyingscoutsman',
        retakes: 'retakes'
    };
    const m_PlayMenuActionBarParticleFX = $('#PlayMenuActionBar_Searching_particles');
    ParticleControls.InitMainMenuTopBar(m_PlayMenuActionBarParticleFX);
    function inDirectChallenge() {
        return _GetDirectChallengeKey() != '';
    }
    function StartSearch() {
        const btnStartSearch = $('#StartMatchBtn');
        if (btnStartSearch === null)
            return;
        btnStartSearch.AddClass('pressed');
        $.DispatchEvent('CSGOPlaySoundEffect', 'mainmenu_press_GO', 'MOUSE');
        ParticleControls.UpdateActionBar(m_PlayMenuActionBarParticleFX, "StartMatchBtn");
        if (inDirectChallenge()) {
            _DirectChallengeStartSearch();
            return;
        }
        if (m_isWorkshop) {
            _DisplayWorkshopModePopup();
        }
        else {
            if (m_gameModeSetting !== 'premier') {
                if (!_CheckContainerHasAnyChildChecked(_GetMapListForServerTypeAndGameMode(m_activeMapGroupSelectionPanelID)) && !m_isWorkshop) {
                    _NoMapSelectedPopup();
                    btnStartSearch.RemoveClass('pressed');
                    return;
                }
            }
            if (GameModeFlags.DoesModeUseFlags(_RealGameMode()) && !m_gameModeFlags[m_serverSetting + _RealGameMode()]) {
                btnStartSearch.RemoveClass('pressed');
                const resumeSearchFnHandle = UiToolkitAPI.RegisterJSCallback(StartSearch);
                _OnGameModeFlagsBtnClicked(resumeSearchFnHandle);
                return;
            }
            let settings = (LobbyAPI.IsSessionActive() && !_GetTournamentOpponent()) ? LobbyAPI.GetSessionSettings() : null;
            let stage = _GetTournamentStage();
            LobbyAPI.StartMatchmaking(MyPersonaAPI.GetMyOfficialTournamentName(), MyPersonaAPI.GetMyOfficialTeamName(), _GetTournamentOpponent(), stage);
        }
    }
    function _Init() {
        const cfg = GameTypesAPI.GetConfig();
        for (const type in cfg.gameTypes) {
            for (const mode in cfg.gameTypes[type].gameModes) {
                let obj = cfg.gameTypes[type].gameModes[mode];
                m_gameModeConfigs[mode] = obj;
            }
        }
        GetGameType = function (mode) {
            for (const gameType in cfg.gameTypes) {
                if (cfg.gameTypes[gameType].gameModes.hasOwnProperty(mode))
                    return gameType;
            }
        };
        GetMGDetails = function (mg) {
            return cfg.mapgroups[mg];
        };
        const elGameModeSelectionRadios = $('#GameModeSelectionRadios');
        if (elGameModeSelectionRadios !== null) {
            m_arrGameModeRadios = elGameModeSelectionRadios.Children();
        }
        m_arrGameModeRadios = m_arrGameModeRadios.filter(elPanel => !elPanel.BHasClass('mainmenu-top-navbar__play_seperator'));
        m_arrGameModeRadios.forEach(function (entry) {
            entry.SetPanelEvent('onactivate', function () {
                m_isWorkshop = false;
                _LoadGameModeFlagsFromSettings();
                if (!_IsSingleSkirmishString(entry.id)) {
                    m_singleSkirmishMapGroup = null;
                }
                if (entry.id === "JsDirectChallengeBtn") {
                    m_gameModeSetting = 'competitive';
                    _OnDirectChallengeBtn();
                    return;
                }
                else if (_IsSingleSkirmishString(entry.id)) {
                    m_gameModeSetting = 'skirmish';
                    m_singleSkirmishMapGroup = _GetSingleSkirmishMapGroupFromSingleSkirmishString(entry.id);
                }
                else {
                    m_gameModeSetting = entry.id;
                }
                const alert = entry.FindChild('GameModeAlert');
                if ((entry.id === "competitive" || entry.id === 'scrimcomp2v2') && alert && !alert.BHasClass('hidden')) {
                    if (GameInterfaceAPI.GetSettingString('ui_show_unlock_competitive_alert') !== '1') {
                        GameInterfaceAPI.SetSettingString('ui_show_unlock_competitive_alert', '1');
                    }
                }
                m_challengeKey = '';
                _ApplySessionSettings();
            });
        });
        m_arrGameModeRadios.forEach(function (entry) {
            if (_IsSingleSkirmishString(entry.id)) {
                m_arrSingleSkirmishMapGroups.push(_GetSingleSkirmishMapGroupFromSingleSkirmishString(entry.id));
            }
        });
        _SetUpGameModeFlagsRadioButtons();
        const elBtnContainer = $('#PermissionsSettings');
        const elPermissionsButton = elBtnContainer.FindChild("id-slider-btn");
        elPermissionsButton.SetPanelEvent('onactivate', function () {
            const bCurrentlyPrivate = (LobbyAPI.GetSessionSettings().system.access === "private");
            const sNewAccessSetting = bCurrentlyPrivate ? "public" : "private";
            const settings = {
                update: {
                    system: {
                        access: sNewAccessSetting
                    }
                }
            };
            GameInterfaceAPI.SetSettingString('lobby_default_privacy_bits', (sNewAccessSetting === "public") ? "1" : "0");
            LobbyAPI.UpdateSessionSettings(settings);
            $.DispatchEvent('UIPopupButtonClicked', '');
        });
        const elPracticeSettingsContainer = $('#id-play-menu-practicesettings-container');
        elPracticeSettingsContainer.Children().forEach(function (elChild) {
            if (!elChild.id.startsWith('id-play-menu-practicesettings-'))
                return;
            let strFeatureName = elChild.id;
            strFeatureName = strFeatureName.replace('id-play-menu-practicesettings-', '');
            strFeatureName = strFeatureName.replace('-tooltip', '');
            const elFeatureFrame = elChild.FindChild('id-play-menu-practicesettings-' + strFeatureName);
            const elFeatureSliderBtn = elFeatureFrame.FindChild('id-slider-btn');
            elFeatureSliderBtn.text = $.Localize('#practicesettings_' + strFeatureName + '_button');
            elFeatureSliderBtn.SetPanelEvent('onactivate', function () {
                UiToolkitAPI.HideTextTooltip();
                const sessionSettings = LobbyAPI.GetSessionSettings();
                const curvalue = (sessionSettings && sessionSettings.options && sessionSettings.options.hasOwnProperty('practicesettings_' + strFeatureName))
                    ? sessionSettings.options['practicesettings_' + strFeatureName] : 0;
                const newvalue = curvalue ? 0 : 1;
                const setting = 'practicesettings_' + strFeatureName;
                const newSettings = { update: { options: {} } };
                newSettings.update.options[setting] = newvalue;
                LobbyAPI.UpdateSessionSettings(newSettings);
            });
        });
        const btnStartSearch = $('#StartMatchBtn');
        btnStartSearch.SetPanelEvent('onactivate', StartSearch);
        const btnCancel = $.GetContextPanel().FindChildInLayoutFile('PartyCancelBtn');
        btnCancel.SetPanelEvent('onactivate', function () {
            LobbyAPI.StopMatchmaking();
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE');
            ParticleControls.UpdateActionBar(m_PlayMenuActionBarParticleFX, "RmoveBtnEffects");
        });
        const elWorkshopSearch = $("#WorkshopSearchTextEntry");
        elWorkshopSearch.SetPanelEvent('ontextentrychange', _UpdateWorkshopMapFilter);
        _SyncDialogsFromSessionSettings(LobbyAPI.GetSessionSettings());
        _ApplySessionSettings();
        _ShowNewMatchmakingModePopup();
        const strFavoriteMaps = GameInterfaceAPI.GetSettingString('ui_playsettings_custom_preset');
        if (strFavoriteMaps === '') {
            _SaveMapSelectionToCustomPreset(true);
        }
        _UpdateGameModeFlagsBtn();
        _UpdateDirectChallengePage();
    }
    ;
    function _SetUpGameModeFlagsRadioButtons() {
        const oFlags = GameModeFlags.GetFlags();
        Object.keys(oFlags).forEach(key => {
            const elParent = $.GetContextPanel().FindChildInLayoutFile('id-gamemode-flag-' + key);
            const mode = oFlags[key];
            mode.flags.forEach(flag => {
                if (!elParent.FindChildInLayoutFile(elParent.id + '-' + flag)) {
                    const btn = $.CreatePanel('RadioButton', elParent, elParent.id + '-' + flag, {
                        class: 'gamemode-setting-radiobutton',
                        group: 'game_mode_flag_' + key,
                        text: '#play_settings_' + key + '_dialog_' + flag
                    });
                    const onActivate = function (nflag) {
                        PlayMenu.OnGameModeFlagOptionActivate(nflag);
                    };
                    const onMouseOver = function (id, flag) {
                        if (key === 'competitive') {
                            UiToolkitAPI.ShowTextTooltip(id, '#play_settings_competitive_dialog_' + flag + '_desc');
                        }
                    };
                    btn.SetPanelEvent('onactivate', onActivate.bind(undefined, flag));
                    btn.SetPanelEvent('onmouseover', onMouseOver.bind(undefined, btn.id, flag));
                    btn.SetPanelEvent('onmouseout', function () { UiToolkitAPI.HideTextTooltip(); });
                }
            });
        });
    }
    function _RevertForceDirectChallengeSettings() {
        _LoadGameModeFlagsFromSettings();
    }
    function _TurnOffDirectChallenge() {
        _SetDirectChallengeKey('');
        _RevertForceDirectChallengeSettings();
        _ApplySessionSettings();
        Scheduler.Cancel("directchallenge");
    }
    function _OnDirectChallengeBtn() {
        if (inDirectChallenge()) {
            return;
        }
        else {
            const savedKey = GameInterfaceAPI.GetSettingString('ui_playsettings_directchallengekey');
            if (!savedKey)
                _SetDirectChallengeKey(CompetitiveMatchAPI.GetDirectChallengeCode());
            else
                _SetDirectChallengeKey(savedKey);
            _ApplySessionSettings();
        }
    }
    function _SetDirectChallengeKey(key) {
        let keySource;
        let keySourceLabel;
        let type, id;
        if (key != '') {
            const oReturn = { value: [] };
            const bValid = _IsChallengeKeyValid(key, oReturn, 'set');
            type = oReturn.value[2];
            id = oReturn.value[3];
            if (bValid) {
                switch (type) {
                    case 'u':
                        keySource = FriendsListAPI.GetFriendName(id);
                        keySourceLabel = $.Localize('#DirectChallenge_CodeSourceLabelUser2');
                        break;
                    case 'g':
                        keySource = MyPersonaAPI.GetMyClanNameById(id);
                        keySourceLabel = $.Localize('#DirectChallenge_CodeSourceLabelClan2');
                        if (!keySource) {
                            keySource = $.Localize("#DirectChallenge_UnknownSource");
                        }
                        break;
                }
            }
            GameInterfaceAPI.SetSettingString('ui_playsettings_directchallengekey', key);
        }
        const DirectChallengeCheckBox = $.GetContextPanel().FindChildTraverse('JsDirectChallengeBtn');
        DirectChallengeCheckBox.checked = key != '';
        if (type !== undefined && id != undefined)
            _SetDirectChallengeIcons(type, id);
        $.GetContextPanel().SetDialogVariable('queue-code', key);
        if (keySource)
            $.GetContextPanel().SetDialogVariable('code-source', keySource);
        if (keySourceLabel)
            $.GetContextPanel().SetDialogVariable('code-source-label', keySourceLabel);
        if (id)
            $.GetContextPanel().SetAttributeString('code-xuid', id);
        if (type)
            $.GetContextPanel().SetAttributeString('code-type', type);
        if (key && (m_challengeKey != key)) {
            $.Schedule(0.01, function () {
                const elHeader = $.GetContextPanel().FindChildTraverse("JsDirectChallengeKey");
                if (elHeader && elHeader.IsValid())
                    elHeader.TriggerClass('directchallenge-status__header__queuecode');
            });
        }
        $.GetContextPanel().SetHasClass('directchallenge', key != '');
        m_challengeKey = key;
    }
    const _ClansInfoUpdated = function () {
        if (m_challengeKey && $.GetContextPanel().GetAttributeString('code-type', '') === 'g') {
            _SetDirectChallengeKey(m_challengeKey);
        }
    };
    const _AddOpenPlayerCardAction = function (elAvatar, xuid) {
        const openCard = function (xuid) {
            $.DispatchEvent('SidebarContextMenuActive', true);
            if (xuid !== '') {
                const contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('', '', 'file://{resources}/layout/context_menus/context_menu_playercard.xml', 'xuid=' + xuid, function () {
                    $.DispatchEvent('SidebarContextMenuActive', false);
                });
                contextMenuPanel.AddClass("ContextMenu_NoArrow");
            }
        };
        elAvatar.SetPanelEvent("onactivate", openCard.bind(undefined, xuid));
    };
    function _SetDirectChallengeIcons(type, id) {
        const btn = $("#JsDirectChallengeBtn");
        if (!btn.checked)
            return;
        const elAvatar = $.GetContextPanel().FindChildInLayoutFile('JsDirectChallengeAvatar');
        if (!elAvatar) {
            $.Schedule(0.1, function (type, id) {
                _SetDirectChallengeIcons(type, id);
            }.bind(undefined, type, id));
            return;
        }
        elAvatar.PopulateFromSteamID(id);
        if (!type || !id) {
            elAvatar.SetPanelEvent('onactivate', function () { });
        }
        switch (type) {
            case 'u':
                _AddOpenPlayerCardAction(elAvatar, id);
                break;
            case 'g':
                _AddGoToClanPageAction(elAvatar, id);
                break;
        }
    }
    function _AddGoToClanPageAction(elAvatar, id) {
        elAvatar.SetPanelEvent('onactivate', function () {
            SteamOverlayAPI.OpenUrlInOverlayOrExternalBrowser("https://" + SteamOverlayAPI.GetSteamCommunityURL() + "/gid/" + id);
        });
    }
    function _GetDirectChallengeKey() {
        return m_challengeKey;
    }
    function _OnDirectChallengeRandom() {
        UiToolkitAPI.ShowGenericPopupOkCancel($.Localize('#DirectChallenge_CreateNewKey2'), $.Localize('#DirectChallenge_CreateNewKeyMsg'), '', function () {
            _SetDirectChallengeKey(CompetitiveMatchAPI.GenerateDirectChallengeCode());
            _ApplySessionSettings();
        }, function () { });
    }
    function _GetChallengeKeyType(key) {
        const oReturn = { value: [] };
        if (_IsChallengeKeyValid(key.toUpperCase(), oReturn, '')) {
            const type = oReturn.value[2];
            const id = oReturn.value[3];
            return type;
        }
        else {
            return '';
        }
    }
    function _OnDirectChallengeEdit() {
        function _SubmitCallback(value) {
            _SetDirectChallengeKey(value.toUpperCase());
            _ApplySessionSettings();
            StartSearch();
        }
        const submitCallback = UiToolkitAPI.RegisterJSCallback(_SubmitCallback);
        m_popupChallengeKeyEntryValidate = UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_directchallenge_join.xml', '&' + 'submitCallback=' + submitCallback);
    }
    function _OnDirectChallengeCopy() {
        SteamOverlayAPI.CopyTextToClipboard(_GetDirectChallengeKey());
        UiToolkitAPI.ShowTextTooltip('CopyChallengeKey', '#DirectChallenge_Copied2');
    }
    function _IsChallengeKeyValid(key, oReturn = { string: [] }, how = '') {
        const code = CompetitiveMatchAPI.ValidateDirectChallengeCode(key, how);
        const bValid = (typeof code === 'string') && code.includes(',');
        if (bValid) {
            oReturn.value = code.split(',');
        }
        return bValid;
    }
    function _DirectChallengeStartSearch() {
        const oReturn = { value: [] };
        const bValid = _IsChallengeKeyValid(m_challengeKey.toUpperCase(), oReturn, 'set');
        if (!bValid) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'mainmenu_press_GO', 'MOUSE');
            return;
        }
        _OnPrivateQueuesUpdate();
        LobbyAPI.StartMatchmaking('', oReturn.value[0], oReturn.value[1], '1');
    }
    function _NoMapSelectedPopup() {
        UiToolkitAPI.ShowGenericPopupOk($.Localize('#no_maps_selected_title'), $.Localize('#no_maps_selected_text'), '', function () { });
    }
    function _ShowNewMatchmakingModePopup() {
        return;
        const setVersionTo = '3';
        const currentVersion = GameInterfaceAPI.GetSettingString('ui_popup_weaponupdate_version');
        if (currentVersion !== setVersionTo) {
            GameInterfaceAPI.SetSettingString('ui_popup_weaponupdate_version', setVersionTo);
            UiToolkitAPI.ShowCustomLayoutPopup('prime_status', 'file://{resources}/layout/popups/popup_premier_matchmaking.xml');
        }
    }
    ;
    function _SetGameModeRadioButtonAvailableTooltip(gameMode, isAvailable, txtTooltip) {
        const elGameModeSelectionRadios = $('#GameModeSelectionRadios');
        const elTab = elGameModeSelectionRadios ? elGameModeSelectionRadios.FindChildInLayoutFile(gameMode) : null;
        if (elTab) {
            if (!isAvailable && txtTooltip) {
                let targetLevel = 2;
                let showbar = true;
                if (gameMode === 'premier') {
                    targetLevel = 10;
                    if (MyPersonaAPI.GetElevatedState() !== 'elevated') {
                        txtTooltip += '_nonprime';
                        showbar = false;
                    }
                }
                elTab.SetPanelEvent('onmouseover', function () {
                    UiToolkitAPI.ShowCustomLayoutParametersTooltip(elTab.id, 'GamemodesLockedneedPrime', 'file://{resources}/layout/tooltips/tooltip_title_progressbar.xml', 'titletext=' + '#PlayMenu_unavailable_locked_mode_title' +
                        '&' + 'bodytext=' + txtTooltip +
                        '&' + 'usexp=' + 'true' +
                        '&' + 'targetlevel=' + targetLevel +
                        '&' + 'showbar=' + (showbar ? 'true' : 'false'));
                });
                elTab.SetPanelEvent('onmouseout', function () { UiToolkitAPI.HideCustomLayoutTooltip('GamemodesLockedneedPrime'); });
            }
            else {
                elTab.SetPanelEvent('onmouseover', function () { });
                elTab.SetPanelEvent('onmouseout', function () { });
            }
        }
    }
    function _SetGameModeRadioButtonVisible(gameMode, isVisible) {
        const elGameModeSelectionRadios = $('#GameModeSelectionRadios');
        const elTab = elGameModeSelectionRadios ? elGameModeSelectionRadios.FindChildInLayoutFile(gameMode) : null;
        if (elTab) {
            elTab.visible = isVisible;
        }
    }
    function _IsGameModeAvailable(serverType, gameMode) {
        let isAvailable = true;
        if (gameMode === "cooperative" || gameMode === "coopmission") {
            const questID = GetMatchmakingQuestId();
            const bGameModeMatchesLobby = questID !== 0 && (LobbyAPI.GetSessionSettings().game.mode === gameMode);
            const bAvailable = bGameModeMatchesLobby && MissionsAPI.GetQuestDefinitionField(questID, "gamemode") === gameMode;
            _SetGameModeRadioButtonVisible(gameMode, bAvailable);
            return bAvailable;
        }
        else if (m_gameModeConfigs[gameMode] &&
            _GetAvailableMapGroups(gameMode, _IsValveOfficialServer(serverType)).length == 0) {
            _SetGameModeRadioButtonAvailableTooltip(gameMode, false, '');
            return false;
        }
        if (_IsValveOfficialServer(serverType) &&
            LobbyAPI.BIsHost()) {
            if (gameMode === 'premier') {
                isAvailable = ((MyPersonaAPI.GetElevatedState() === 'elevated') &&
                    (MyPersonaAPI.HasPrestige() || MyPersonaAPI.GetCurrentLevel() >= 10));
            }
            else if (MyPersonaAPI.HasPrestige()) {
                isAvailable = true;
            }
            else if (MyPersonaAPI.GetCurrentLevel() < 2) {
                isAvailable = (gameMode == 'deathmatch' || gameMode == 'casual');
            }
        }
        else if (!_IsValveOfficialServer(serverType)) {
            (isAvailable = (gameMode != 'premier'));
        }
        _SetGameModeRadioButtonAvailableTooltip(gameMode, isAvailable, _IsPlayingOnValveOfficial() ? '#PlayMenu_unavailable_newuser_2' : '');
        return isAvailable;
    }
    function _GetTournamentOpponent() {
        const elTeamDropdown = $.GetContextPanel().FindChildInLayoutFile('TournamentTeamDropdown');
        if (elTeamDropdown.GetSelected() === null)
            return '';
        return elTeamDropdown.GetSelected().GetAttributeString('data', '');
    }
    function _GetTournamentStage() {
        const elStageDropdown = $.GetContextPanel().FindChildInLayoutFile('TournamentStageDropdown');
        if (elStageDropdown.GetSelected() === null)
            return '';
        return elStageDropdown.GetSelected().GetAttributeString('data', '');
    }
    function _UpdateStartSearchBtn(isSearchingForTournament) {
        const btnStartSearch = $.GetContextPanel().FindChildInLayoutFile('StartMatchBtn');
        btnStartSearch.enabled = isSearchingForTournament ? (_GetTournamentOpponent() != '' && _GetTournamentStage() != '') : true;
    }
    function _UpdateTournamentButton(isHost, isSearching, settingsgamemapgroupname) {
        const bIsOfficialCompetitive = _RealGameMode() === "competitive" && _IsPlayingOnValveOfficial();
        const strTeamName = MyPersonaAPI.GetMyOfficialTeamName();
        const strTournament = MyPersonaAPI.GetMyOfficialTournamentName();
        const isInTournament = isHost && strTeamName != "" && strTournament != "";
        $.GetContextPanel().SetHasClass("play-menu__tournament", isInTournament);
        const isSearchingForTournament = bIsOfficialCompetitive && isInTournament;
        const elTeamDropdown = $.GetContextPanel().FindChildInLayoutFile('TournamentTeamDropdown');
        const elStageDropdown = $.GetContextPanel().FindChildInLayoutFile('TournamentStageDropdown');
        if (isInTournament) {
            function AddDropdownOption(elDropdown, entryID, strText, strData, strSelectedData) {
                const newEntry = $.CreatePanel('Label', elDropdown, entryID, { data: strData });
                newEntry.text = strText;
                elDropdown.AddOption(newEntry);
                if (strSelectedData === strData) {
                    elDropdown.SetSelected(entryID);
                }
            }
            const strCurrentOpponent = _GetTournamentOpponent();
            const strCurrentStage = _GetTournamentStage();
            elTeamDropdown.RemoveAllOptions();
            AddDropdownOption(elTeamDropdown, 'PickOpponent', $.Localize('#SFUI_Tournament_Pick_Opponent'), '', strCurrentOpponent);
            const teamCount = CompetitiveMatchAPI.GetTournamentTeamCount(strTournament);
            for (let i = 0; i < teamCount; i++) {
                const strTeam = CompetitiveMatchAPI.GetTournamentTeamNameByIndex(strTournament, i);
                if (strTeamName === strTeam)
                    continue;
                AddDropdownOption(elTeamDropdown, 'team_' + i, strTeam, strTeam, strCurrentOpponent);
            }
            elTeamDropdown.SetPanelEvent('oninputsubmit', _UpdateStartSearchBtn.bind(undefined, isSearchingForTournament));
            elStageDropdown.RemoveAllOptions();
            AddDropdownOption(elStageDropdown, 'PickStage', $.Localize('#SFUI_Tournament_Stage'), '', strCurrentStage);
            const stageCount = CompetitiveMatchAPI.GetTournamentStageCount(strTournament);
            for (let i = 0; i < stageCount; i++) {
                const strStage = CompetitiveMatchAPI.GetTournamentStageNameByIndex(strTournament, i);
                AddDropdownOption(elStageDropdown, 'stage_' + i, strStage, strStage, strCurrentStage);
            }
            elStageDropdown.SetPanelEvent('oninputsubmit', _UpdateStartSearchBtn.bind(undefined, isSearchingForTournament));
        }
        elTeamDropdown.enabled = isSearchingForTournament;
        elStageDropdown.enabled = isSearchingForTournament;
        _UpdateStartSearchBtn(isSearchingForTournament);
        _ShowActiveMapSelectionTab(!isSearchingForTournament);
    }
    function _SyncDialogsFromSessionSettings(settings) {
        if (!settings || !settings.game || !settings.system) {
            return;
        }
        m_serverSetting = settings.options.server;
        m_permissions = settings.system.access;
        m_gameModeSetting = settings.game.mode_ui;
        $.GetContextPanel().SetHasClass('premier', m_gameModeSetting === 'premier');
        _SetDirectChallengeKey(settings.options.hasOwnProperty('challengekey') ? settings.options.challengekey : '');
        _setAndSaveGameModeFlags(parseInt(settings.game.gamemodeflags));
        $.GetContextPanel().SwitchClass("gamemode", m_isWorkshop ? "workshop" : _RealGameMode());
        $.GetContextPanel().SwitchClass("serversetting", m_serverSetting);
        $.GetContextPanel().SetHasClass("directchallenge", inDirectChallenge());
        m_singleSkirmishMapGroup = null;
        if (m_gameModeSetting === 'skirmish' && settings.game.mapgroupname && m_arrSingleSkirmishMapGroups.includes(settings.game.mapgroupname)) {
            m_singleSkirmishMapGroup = settings.game.mapgroupname;
        }
        const isHost = LobbyAPI.BIsHost();
        const isSearching = _IsSearching();
        const isEnabled = !isSearching && isHost ? true : false;
        const elPlayCommunity = $('#PlayCommunity');
        elPlayCommunity.enabled = !isSearching;
        if (m_isWorkshop) {
            _SwitchToWorkshopTab(isEnabled);
            _SelectMapButtonsFromSettings(settings);
        }
        else if (m_gameModeSetting) {
            for (let i = 0; i < m_arrGameModeRadios.length; ++i) {
                const strGameModeForButton = m_arrGameModeRadios[i].id;
                if (inDirectChallenge()) {
                    m_arrGameModeRadios[i].checked = m_arrGameModeRadios[i].id === 'JsDirectChallengeBtn';
                }
                else if (m_singleSkirmishMapGroup) {
                    if (_IsSingleSkirmishString(strGameModeForButton)) {
                        if (m_singleSkirmishMapGroup === _GetSingleSkirmishMapGroupFromSingleSkirmishString(strGameModeForButton)) {
                            m_arrGameModeRadios[i].checked = true;
                        }
                    }
                }
                else if (!_IsSingleSkirmishString(strGameModeForButton)) {
                    if (strGameModeForButton === m_gameModeSetting) {
                        m_arrGameModeRadios[i].checked = true;
                    }
                }
                if (strGameModeForButton === 'competitive' || strGameModeForButton === 'scrimcomp2v2') {
                    const bHide = GameInterfaceAPI.GetSettingString('ui_show_unlock_competitive_alert') === '1' ||
                        MyPersonaAPI.HasPrestige() ||
                        MyPersonaAPI.GetCurrentLevel() !== 2 ||
                        !_IsPlayingOnValveOfficial();
                    if (m_arrGameModeRadios[i].FindChildInLayoutFile('GameModeAlert')) {
                        m_arrGameModeRadios[i].FindChildInLayoutFile('GameModeAlert').SetHasClass('hidden', bHide);
                    }
                }
                const isAvailable = _IsGameModeAvailable(m_serverSetting, strGameModeForButton);
                m_arrGameModeRadios[i].enabled = isAvailable && isEnabled;
                m_arrGameModeRadios[i].SetHasClass('locked', !isAvailable || !isEnabled);
            }
            _UpdateMapGroupButtons(isEnabled, isSearching, isHost);
            _CancelRotatingMapGroupSchedule();
            if (settings.game.mode === "survival") {
                _GetRotatingMapGroupStatus(_RealGameMode(), m_singleSkirmishMapGroup, settings.game.mapgroupname);
            }
            _SelectMapButtonsFromSettings(settings);
        }
        else {
            m_arrGameModeRadios[0].checked = true;
        }
        _ShowHideStartSearchBtn(isSearching, isHost);
        _ShowCancelSearchButton(isSearching, isHost);
        _UpdateTournamentButton(isHost, isSearching, settings.game.mapgroupname);
        _UpdatePrimeBtn(isSearching, isHost);
        _UpdatePermissionBtnText(settings, isEnabled);
        _UpdatePracticeSettingsBtns(isSearching, isHost);
        _UpdateLeaderboardBtn(m_gameModeSetting);
        _UpdateSurvivalAutoFillSquadBtn(m_gameModeSetting);
        _SelectActivePlayPlayTypeBtn();
        _UpdateReplayNewUserTrainingBtn(m_gameModeSetting);
        _UpdateDirectChallengePage(isSearching, isHost);
        _UpdateGameModeFlagsBtn();
        const elPlayTypeNav = $('#PlayTypeTopNav');
        const aPlayTypeBtns = elPlayTypeNav.Children();
        const bIsTopNavBtsEnabled = IsTopNavBtsEnabled();
        aPlayTypeBtns.forEach(btn => {
            btn.enabled = bIsTopNavBtsEnabled;
        });
        _SetClientViewLobbySettingsTitle(isHost);
        function IsTopNavBtsEnabled() {
            if (_IsPlayingOnValveOfficial() &&
                (m_gameModeSetting === "cooperative" || m_gameModeSetting === "coopmission"))
                return false;
            else
                return isEnabled;
        }
        _OnPrivateQueuesUpdate();
        _PipRankUpdate();
    }
    ;
    function _UpdateDirectChallengePage(isSearching = false, isHost = true) {
        const elBtn = $('#JsDirectChallengeBtn');
        elBtn.enabled = (m_serverSetting === "official") && !m_isWorkshop ? true : false;
        if (m_serverSetting !== "official" || m_isWorkshop) {
            return;
        }
        const fnEnableKey = (id, bEnable) => { const p = $(id); if (p)
            p.enabled = bEnable; };
        const bEnable = !isSearching && isHost;
        fnEnableKey("#RandomChallengeKey", bEnable);
        fnEnableKey("#EditChallengeKey", bEnable);
        fnEnableKey("#ClanChallengeKey", bEnable);
        fnEnableKey("#JsDirectChallengeBtn", bEnable && (MyPersonaAPI.HasPrestige() || (MyPersonaAPI.GetCurrentLevel() >= 2)));
    }
    function _OnClanChallengeKeySelected(key) {
        _SetDirectChallengeKey(key);
        _ApplySessionSettings();
        StartSearch();
    }
    function _OnChooseClanKeyBtn() {
        if (MyPersonaAPI.GetMyClanCount() == 0) {
            UiToolkitAPI.ShowGenericPopupThreeOptions('#DirectChallenge_no_steamgroups', '#DirectChallenge_no_steamgroups_desc', '', '#DirectChallenge_create_steamgroup', function () {
                SteamOverlayAPI.OpenUrlInOverlayOrExternalBrowser("https://" + SteamOverlayAPI.GetSteamCommunityURL() + "/actions/GroupCreate");
            }, '#DirectChallenge_openurl2', function () {
                SteamOverlayAPI.OpenUrlInOverlayOrExternalBrowser("https://" + SteamOverlayAPI.GetSteamCommunityURL() + "/search/groups");
            }, '#UI_OK', function () { });
            return;
        }
        const clanKey = _GetChallengeKeyType(m_challengeKey) == 'g' ? m_challengeKey : '';
        const elClanSelector = UiToolkitAPI.ShowCustomLayoutPopupParameters('id-popup_directchallenge_steamgroups', 'file://{resources}/layout/popups/popup_directchallenge_steamgroups.xml', 'currentkey=' + clanKey);
        elClanSelector.AddClass("ContextMenu_NoArrow");
    }
    function _CreatePlayerTile(elTile, xuid, delay = 0) {
        elTile.BLoadLayout('file://{resources}/layout/simple_player_tile.xml', false, false);
        $.Schedule(.1, () => {
            if (!elTile || !elTile.IsValid())
                return;
            const elAvatar = elTile.FindChildTraverse('JsAvatarImage');
            elAvatar.PopulateFromSteamID(xuid);
            const strName = FriendsListAPI.GetFriendName(xuid);
            elTile.SetDialogVariable('player_name', strName);
            _AddOpenPlayerCardAction(elTile, xuid);
            Scheduler.Schedule(delay, function () {
                if (elTile && elTile.IsValid())
                    elTile.RemoveClass('hidden');
            }, "directchallenge");
        });
    }
    function _OnPlayerNameChangedUpdate(xuid) {
        let strName = null;
        const strCodeXuid = $.GetContextPanel().GetAttributeString('code-xuid', '');
        if (strCodeXuid === xuid) {
            if (!strName)
                strName = FriendsListAPI.GetFriendName(xuid);
            $.GetContextPanel().SetDialogVariable('code-source', strName);
        }
        const elMembersContainer = $('#DirectChallengeQueueMembers');
        if (!elMembersContainer)
            return;
        const elUserTile = elMembersContainer.FindChildTraverse(xuid);
        if (!elUserTile)
            return;
        if (!strName)
            strName = FriendsListAPI.GetFriendName(xuid);
        elUserTile.SetDialogVariable('player_name', strName);
    }
    function _GetPartyID(partyXuid, arrMembers = []) {
        let partyId = '';
        const partySize = PartyBrowserAPI.GetPartyMembersCount(partyXuid);
        for (let j = 0; j < partySize; j++) {
            const memberXuid = PartyBrowserAPI.GetPartyMemberXuid(partyXuid, j);
            partyId += '_' + memberXuid;
            arrMembers.push(memberXuid);
        }
        return partyId;
    }
    function _OnPrivateQueuesUpdate() {
        const elMembersContainer = $.GetContextPanel().FindChildTraverse('DirectChallengeQueueMembers');
        if (!elMembersContainer)
            return;
        const elExplanation = $("#id-directchallenge-explanation");
        if (elExplanation)
            elExplanation.SetHasClass('hidden', _IsSearching());
        const elQueueMembers = $("#id-directchallenge-status__queue-members");
        if (elQueueMembers)
            elQueueMembers.SetHasClass('hidden', !_IsSearching());
        if (!_IsSearching()) {
            Scheduler.Cancel("directchallenge");
            const elStatus = $('#id-directchallenge-status');
            if (elStatus)
                elStatus.text = '';
            if (elMembersContainer)
                elMembersContainer.RemoveAndDeleteChildren();
            return;
        }
        const NumberOfParties = PartyBrowserAPI.GetPrivateQueuesCount();
        const NumberOfPlayers = PartyBrowserAPI.GetPrivateQueuesPlayerCount();
        const NumberOfMorePartiesNotShown = PartyBrowserAPI.GetPrivateQueuesMoreParties();
        const elStatus = $('#id-directchallenge-status');
        if (elStatus) {
            $.GetContextPanel().SetDialogVariableInt('directchallenge_players', NumberOfPlayers);
            $.GetContextPanel().SetDialogVariableInt('directchallenge_moreparties', NumberOfMorePartiesNotShown);
            let strStatus = $.Localize(LobbyAPI.GetMatchmakingStatusString());
            if (NumberOfParties > 0) {
                strStatus += "\t";
                strStatus += $.Localize((NumberOfMorePartiesNotShown > 0) ? "#DirectChallenge_SearchingMembersAndMoreParties2" : "#DirectChallenge_SearchingMembersLabel2", $.GetContextPanel());
            }
            elStatus.text = strStatus;
        }
        elMembersContainer.Children().forEach(function (child) {
            child.SetAttributeInt("marked_for_delete", 1);
        });
        let delay = 0;
        for (let i = NumberOfParties; i-- > 0;) {
            const DELAY_INCREMENT = 0.25;
            const arrMembers = [];
            const partyXuid = PartyBrowserAPI.GetPrivateQueuePartyXuidByIndex(i);
            const partyId = _GetPartyID(partyXuid, arrMembers);
            let elParty = elMembersContainer.FindChild(partyId);
            if (!elParty) {
                elParty = $.CreatePanel('Panel', elMembersContainer, partyId, { class: 'directchallenge__party hidden' });
                elParty.SetHasClass('multi', arrMembers.length > 1);
                elMembersContainer.MoveChildBefore(elParty, elMembersContainer.Children()[0]);
                elParty.SetAttributeString("xuid", partyXuid);
                Scheduler.Schedule(delay, () => {
                    if (elParty && elParty.IsValid())
                        elParty.RemoveClass('hidden');
                }, "directchallenge");
                arrMembers.forEach(function (xuid) {
                    if (elParty) {
                        const elTile = $.CreatePanel('Panel', elParty, xuid, { class: "directchallenge__party__member" });
                        _CreatePlayerTile(elTile, xuid, delay);
                    }
                    delay += DELAY_INCREMENT;
                });
            }
            else {
            }
            elParty.SetAttributeInt("marked_for_delete", 0);
        }
        elMembersContainer.Children().forEach(function (child) {
            if (child.GetAttributeInt("marked_for_delete", 0) !== 0) {
                child.DeleteAsync(0.0);
            }
        });
    }
    function _SetClientViewLobbySettingsTitle(isHost) {
        const elPanel = $.GetContextPanel().FindChildInLayoutFile('play-lobby-leader-panel');
        if (!elPanel || !elPanel.IsValid()) {
            return;
        }
        if (isHost) {
            elPanel.visible = false;
            return;
        }
        elPanel.visible = true;
        const elTitle = elPanel.FindChildInLayoutFile('play-lobby-leader-text');
        const xuid = PartyListAPI.GetPartySystemSetting("xuidHost");
        const leaderName = FriendsListAPI.GetFriendName(xuid);
        elTitle.text = leaderName;
        const elAvatar = elPanel.FindChildInLayoutFile('lobby-leader-avatar');
        elAvatar.PopulateFromSteamID(xuid);
    }
    ;
    function _GetAvailableMapGroups(gameMode, isPlayingOnValveOfficial) {
        const gameModeCfg = m_gameModeConfigs[gameMode];
        if (gameModeCfg === undefined)
            return [];
        const mapgroup = isPlayingOnValveOfficial ? gameModeCfg.mapgroupsMP : gameModeCfg.mapgroupsSP;
        if (mapgroup !== undefined && mapgroup !== null) {
            delete mapgroup['mg_lobby_mapveto'];
            return Object.keys(mapgroup);
        }
        if ((gameMode === "cooperative" || gameMode === "coopmission") && GetMatchmakingQuestId() > 0) {
            return [LobbyAPI.GetSessionSettings().game.mapgroupname];
        }
        return [];
    }
    ;
    function _GetMapGroupPanelID() {
        if (inDirectChallenge()) {
            return "gameModeButtonContainer_directchallenge";
        }
        else if (m_gameModeSetting === 'premier') {
            return "gameModeButtonContainer_premier";
        }
        const gameModeId = _RealGameMode() + (m_singleSkirmishMapGroup ? '@' + m_singleSkirmishMapGroup : '');
        const panelID = 'gameModeButtonContainer_' + gameModeId + '_' + m_serverSetting;
        return panelID;
    }
    function _OnActivateMapOrMapGroupButton(mapgroupButton) {
        const mapGroupNameClicked = mapgroupButton.GetAttributeString("mapname", '');
        if ($.GetContextPanel().BHasClass('play-menu__lobbymapveto_activated') && mapGroupNameClicked !== 'mg_lobby_mapveto') {
            return;
        }
        $.DispatchEvent('CSGOPlaySoundEffect', 'submenu_leveloptions_select', 'MOUSE');
        let mapGroupName = mapGroupNameClicked;
        if (mapGroupName) {
            const siblingSuffix = '_scrimmagemap';
            if (mapGroupName.toLowerCase().endsWith(siblingSuffix))
                mapGroupName = mapGroupName.substring(0, mapGroupName.length - siblingSuffix.length);
            else
                mapGroupName = mapGroupName + siblingSuffix;
            let elParent = mapgroupButton.GetParent();
            if (elParent)
                elParent = elParent.GetParent();
            if (elParent && elParent.GetAttributeString('hassections', '')) {
                elParent.Children().forEach(function (section) {
                    section.Children().forEach(function (tile) {
                        const mapGroupNameSibling = tile.GetAttributeString("mapname", '');
                        if (mapGroupNameSibling.toLowerCase() === mapGroupName.toLowerCase()) {
                            tile.checked = false;
                        }
                    });
                });
            }
        }
        _MatchMapSelectionWithQuickSelect();
        if (_CheckContainerHasAnyChildChecked(_GetMapListForServerTypeAndGameMode(m_activeMapGroupSelectionPanelID))) {
            _ApplySessionSettings();
        }
    }
    ;
    function _ShowActiveMapSelectionTab(isEnabled) {
        const panelID = m_activeMapGroupSelectionPanelID;
        for (const key in m_mapSelectionButtonContainers) {
            if (key !== panelID) {
                m_mapSelectionButtonContainers[key].AddClass("hidden");
            }
            else {
                m_mapSelectionButtonContainers[key].RemoveClass("hidden");
                m_mapSelectionButtonContainers[key].visible = true;
                m_mapSelectionButtonContainers[key].enabled = isEnabled;
            }
        }
        const isWorkshop = panelID === k_workshopPanelId;
        $('#WorkshopSearchBar').visible = isWorkshop;
        $('#GameModeSelectionRadios').Children().forEach(element => {
            element.enabled = element.enabled && !isWorkshop && !_IsSearching() && LobbyAPI.BIsHost();
        });
        $('#WorkshopVisitButton').visible = isWorkshop && !m_bPerfectWorld;
        $('#WorkshopVisitButton').enabled = SteamOverlayAPI.IsEnabled();
    }
    ;
    function _GetMapTileContainer() {
        return $.GetContextPanel().FindChildInLayoutFile(_GetMapGroupPanelID());
    }
    function _OnMapQuickSelect(mgName) {
        const arrMapsToSelect = _GetMapsFromQuickSelectMapGroup(mgName);
        let bScrolled = false;
        const prevSelection = _GetSelectedMapsForServerTypeAndGameMode(m_serverSetting, _RealGameMode(), true);
        const elMapGroupContainer = _GetMapTileContainer();
        elMapGroupContainer.Children().forEach(function (elMapBtn) {
            let bFound = false;
            if (mgName === "all") {
                bFound = true;
            }
            else if (mgName === "none") {
                bFound = false;
            }
            else {
                arrMapsToSelect.forEach(function (mapname) {
                    if (elMapBtn.GetAttributeString("mapname", "") == mapname) {
                        bFound = true;
                    }
                });
            }
            elMapBtn.checked = bFound;
            if (bFound && !bScrolled) {
                elMapBtn.ScrollParentToMakePanelFit(2, false);
                bScrolled = true;
            }
        });
        const newSelection = _GetSelectedMapsForServerTypeAndGameMode(m_serverSetting, _RealGameMode(), true);
        if (prevSelection != newSelection) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'submenu_leveloptions_select', 'MOUSE');
            _MatchMapSelectionWithQuickSelect();
            if (_CheckContainerHasAnyChildChecked(_GetMapListForServerTypeAndGameMode(m_activeMapGroupSelectionPanelID))) {
                _ApplySessionSettings();
            }
        }
    }
    function _ValidateMaps(arrMapList) {
        let arrMapTileNames = [];
        const arrMapButtons = _GetMapListForServerTypeAndGameMode(m_activeMapGroupSelectionPanelID);
        arrMapButtons.forEach(elMapTile => arrMapTileNames.push(elMapTile.GetAttributeString("mapname", "")));
        const filteredMapList = arrMapList.filter(strMap => arrMapTileNames.includes(strMap));
        return filteredMapList;
    }
    function _GetMapGroupsWithAttribute(strAttribute, strValue) {
        const arrNewMapgroups = [];
        const elMapGroupContainer = _GetMapTileContainer();
        elMapGroupContainer.Children().forEach(function (elMapBtn) {
            const mgName = elMapBtn.GetAttributeString("mapname", "");
            if (GameTypesAPI.GetMapGroupAttribute(mgName, strAttribute) === strValue) {
                arrNewMapgroups.push(mgName);
            }
        });
        return arrNewMapgroups;
    }
    function _GetMapsFromQuickSelectMapGroup(mgName) {
        if (mgName === ("favorites")) {
            const mapsAsString = GameInterfaceAPI.GetSettingString('ui_playsettings_custom_preset');
            if (mapsAsString === '')
                return [];
            else {
                const arrMapList = mapsAsString.split(',');
                const filteredMapList = _ValidateMaps(arrMapList);
                if (arrMapList.length != filteredMapList.length)
                    GameInterfaceAPI.SetSettingString('ui_playsettings_custom_preset', filteredMapList.length > 0 ? filteredMapList.join(',') : "");
                return filteredMapList;
            }
        }
        else if (mgName === "new") {
            return _GetMapGroupsWithAttribute('showtagui', 'new');
        }
        else if (mgName === "hostage") {
            return _GetMapGroupsWithAttribute('icontag', 'hostage');
        }
        else if (mgName === "activeduty") {
            return _GetMapGroupsWithAttribute('grouptype', 'active').filter(x => x !== 'mg_lobby_mapveto');
        }
        else {
            return [];
        }
    }
    function _MatchMapSelectionWithQuickSelect() {
        const elQuickSelectContainer = $.GetContextPanel().FindChildInLayoutFile("JsQuickSelectParent");
        if (!elQuickSelectContainer || m_isWorkshop)
            return;
        elQuickSelectContainer.FindChildrenWithClassTraverse('preset-button').forEach(function (elQuickBtn, index, aMapGroups) {
            const arrQuickSelectMaps = _GetMapsFromQuickSelectMapGroup(elQuickBtn.id);
            let bMatch = true;
            const elMapGroupContainer = _GetMapTileContainer();
            for (let i = 0; i < elMapGroupContainer.Children().length; i++) {
                const elMapBtn = elMapGroupContainer.Children()[i];
                const mapName = elMapBtn.GetAttributeString("mapname", "");
                if (elQuickBtn.id == "none") {
                    if (elMapBtn.checked) {
                        bMatch = false;
                        break;
                    }
                }
                else if (elQuickBtn.id == "all") {
                    if (!elMapBtn.checked) {
                        bMatch = false;
                        break;
                    }
                }
                else {
                    if (elMapBtn.checked != (arrQuickSelectMaps.includes(mapName))) {
                        bMatch = false;
                        break;
                    }
                }
            }
            elQuickBtn.checked = bMatch;
        });
    }
    function _LazyCreateMapListPanel() {
        const serverType = m_serverSetting;
        const gameMode = _RealGameMode();
        let strRequireTagNameToReuse = null;
        let strRequireTagValueToReuse = null;
        if ((gameMode === "cooperative") || (gameMode === "coopmission")) {
            strRequireTagNameToReuse = 'map-selection-quest-id';
            strRequireTagValueToReuse = '' + GetMatchmakingQuestId();
        }
        const panelID = _GetMapGroupPanelID();
        if (panelID in m_mapSelectionButtonContainers) {
            let bAllowReuseExistingContainer = true;
            const elExistingContainer = m_mapSelectionButtonContainers[panelID];
            if (elExistingContainer && strRequireTagNameToReuse) {
                const strExistingTagValue = elExistingContainer.GetAttributeString(strRequireTagNameToReuse, '');
                bAllowReuseExistingContainer = (strExistingTagValue === strRequireTagValueToReuse);
            }
            const elFriendLeaderboards = elExistingContainer ? elExistingContainer.FindChildTraverse("FriendLeaderboards") : null;
            if (elFriendLeaderboards) {
                const strEmbeddedLeaderboardName = elFriendLeaderboards.GetAttributeString("type", '');
                if (strEmbeddedLeaderboardName) {
                    LeaderboardsAPI.Refresh(strEmbeddedLeaderboardName);
                }
            }
            if (bAllowReuseExistingContainer)
                return panelID;
            else
                elExistingContainer.DeleteAsync(0.0);
        }
        const container = $.CreatePanel("Panel", $('#MapSelectionList'), panelID, {
            class: 'map-selection-list map-selection-list--inner hidden'
        });
        container.AddClass('map-selection-list--' + serverType + '-' + gameMode);
        m_mapSelectionButtonContainers[panelID] = container;
        let strSnippetNameOverride;
        if (inDirectChallenge()) {
            strSnippetNameOverride = "MapSelectionContainer_directchallenge";
        }
        else if (m_gameModeSetting === 'premier') {
            strSnippetNameOverride = "MapSelectionContainer_premier";
        }
        else {
            strSnippetNameOverride = "MapSelectionContainer_" + serverType + "_" + gameMode;
        }
        if (container.BHasLayoutSnippet(strSnippetNameOverride)) {
            container.BLoadLayoutSnippet(strSnippetNameOverride);
            const elMapTile = container.FindChildTraverse("MapTile");
            if (elMapTile)
                elMapTile.BLoadLayoutSnippet("MapGroupSelection");
            _LoadLeaderboardsLayoutForContainer(container);
        }
        else {
            strSnippetNameOverride = '';
        }
        if (strRequireTagNameToReuse && strRequireTagValueToReuse) {
            container.SetAttributeString(strRequireTagNameToReuse, strRequireTagValueToReuse);
        }
        const isPlayingOnValveOfficial = _IsValveOfficialServer(serverType);
        const arrMapGroups = _GetAvailableMapGroups(gameMode, isPlayingOnValveOfficial);
        const numTiles = arrMapGroups.length;
        if (gameMode === 'skirmish' && m_singleSkirmishMapGroup) {
            _UpdateOrCreateMapGroupTile(m_singleSkirmishMapGroup, container, null, panelID + m_singleSkirmishMapGroup, numTiles);
        }
        else {
            arrMapGroups.forEach(function (item, index, aMapGroups) {
                if (gameMode === 'skirmish' && m_arrSingleSkirmishMapGroups.includes(aMapGroups[index])) {
                    return;
                }
                let elSectionContainer = null;
                elSectionContainer = container;
                if (strSnippetNameOverride)
                    elSectionContainer = container.FindChildTraverse("MapTile");
                if (elSectionContainer)
                    _UpdateOrCreateMapGroupTile(aMapGroups[index], elSectionContainer, null, panelID + aMapGroups[index], numTiles);
            });
        }
        const fnOnPropertyTransitionEndEvent = function (panelName, propertyName) {
            if (container.id === panelName && propertyName === 'opacity' &&
                !container.id.startsWith("FriendLeaderboards")) {
                if (container.visible === true && container.BIsTransparent()) {
                    container.visible = false;
                    return true;
                }
            }
            return false;
        };
        $.RegisterEventHandler('PropertyTransitionEnd', container, fnOnPropertyTransitionEndEvent);
        return panelID;
    }
    ;
    function _PopulateQuickSelectBar(isSearching, isHost) {
        const elQuickSelectContainer = $.GetContextPanel().FindChildInLayoutFile("jsQuickSelectionSetsContainer");
        if (!elQuickSelectContainer)
            return;
        if (m_isWorkshop)
            return;
        _MatchMapSelectionWithQuickSelect();
        _EnableDisableQuickSelectBtns(isSearching, isHost);
    }
    function _EnableDisableQuickSelectBtns(isSearching, isHost) {
        const bEnable = !isSearching && isHost;
        const elQuickSelectContainer = $.GetContextPanel().FindChildInLayoutFile("JsQuickSelectParent");
        elQuickSelectContainer.FindChildrenWithClassTraverse('preset-button').forEach(element => element.enabled = bEnable);
    }
    function _SaveMapSelectionToCustomPreset(bSilent = false) {
        if (inDirectChallenge())
            return;
        if (m_gameModeSetting === 'premier')
            return;
        const selectedMaps = _GetSelectedMapsForServerTypeAndGameMode(m_serverSetting, _RealGameMode(), true);
        if (selectedMaps === "") {
            if (!bSilent)
                $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.buymenu_failure', 'MOUSE');
            _NoMapSelectedPopup();
            return;
        }
        GameInterfaceAPI.SetSettingString('ui_playsettings_custom_preset', selectedMaps);
        if (!bSilent) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE');
            $.GetContextPanel().FindChildInLayoutFile("jsQuickSelectionSave").TriggerClass('save');
        }
        _MatchMapSelectionWithQuickSelect();
    }
    function _GetPanelTypeForMapGroupTile(gameMode, singleSkirmishMapGroup) {
        const bIsCompetitive = gameMode === 'competitive';
        const bIsSkirmish = gameMode === 'skirmish' && !singleSkirmishMapGroup;
        const bIsWingman = gameMode === 'scrimcomp2v2';
        return (((bIsCompetitive || bIsSkirmish || bIsWingman) && _IsValveOfficialServer(m_serverSetting)) ? "ToggleButton" : "RadioButton");
    }
    ;
    function _UpdateOrCreateMapGroupTile(mapGroupName, container, elTilePanel, newTileID, numTiles) {
        const mg = GetMGDetails(mapGroupName);
        if (!mg)
            return;
        let p = elTilePanel;
        if (!p) {
            const panelType = _GetPanelTypeForMapGroupTile(_RealGameMode(), m_singleSkirmishMapGroup);
            const panelID = newTileID ? newTileID : (container.id + mapGroupName);
            p = $.CreatePanel(panelType, container, panelID);
            p.BLoadLayoutSnippet("MapGroupSelection");
            if (panelType === "RadioButton") {
                let radioGroupID;
                if (panelID.endsWith(mapGroupName))
                    radioGroupID = panelID.substring(0, panelID.length - mapGroupName.length);
                else
                    radioGroupID = container.id;
                const group = "radiogroup_" + radioGroupID;
                p.SetAttributeString("group", group);
            }
        }
        p.SetAttributeString("mapname", mapGroupName);
        p.SetPanelEvent('onactivate', _OnActivateMapOrMapGroupButton.bind(undefined, p));
        p.SetHasClass('map-selection-btn-activedutymap', mg.grouptype === 'active');
        p.FindChildInLayoutFile('ActiveGroupIcon').visible = mg.grouptype === 'active';
        p.FindChildInLayoutFile('MapGroupName').text = $.Localize(mg.nameID);
        UpdateIconsAndScreenshots(p, numTiles, mapGroupName, mg);
        return p;
    }
    ;
    function _UpdateRatingEmblem(p, mapGroupName) {
        let elRatingEmblem = p.FindChildTraverse('jsRatingEmblem');
        if (!elRatingEmblem || !elRatingEmblem.IsValid())
            return;
        elRatingEmblem.visible = m_serverSetting == 'official' &&
            m_gameModeSetting === 'competitive' &&
            !m_isWorkshop &&
            LobbyAPI.GetSessionSettings() &&
            LobbyAPI.GetSessionSettings().hasOwnProperty('game') &&
            LobbyAPI.GetSessionSettings().game.hasOwnProperty('prime') &&
            LobbyAPI.GetSessionSettings().game.prime;
        let options = {
            root_panel: p,
            xuid: MyPersonaAPI.GetXuid(),
            api: 'mypersona',
            rating_type: 'Competitive',
            rating_map: mapGroupName,
            full_details: true
        };
        RatingEmblem.SetXuid(options);
        let winCountString = RatingEmblem.GetWinCountString(p);
        p.SetDialogVariable('map-win-count', winCountString);
        p.SetHasClass('show-win-count', winCountString != '');
    }
    function UpdateIconsAndScreenshots(p, numTiles, mapGroupName, mg) {
        const keysList = Object.keys(mg.maps);
        const iconSize = 200;
        const iconPath = mapGroupName === 'random_classic' ? 'file://{images}/icons/ui/random_map.svg' : 'file://{images}/' + mg.icon_image_path + '.svg';
        let mapGroupIcon = p.FindChildInLayoutFile('MapSelectionButton').FindChildInLayoutFile('MapGroupCollectionIcon');
        if (keysList.length < 2) {
            if (mapGroupIcon) {
                mapGroupIcon.SetImage(iconPath);
            }
            else {
                mapGroupIcon = $.CreatePanel('Image', p.FindChildInLayoutFile('MapSelectionButton'), 'MapGroupCollectionIcon', {
                    defaultsrc: 'file://{images}/icons/ui/random_map.svg',
                    texturewidth: iconSize,
                    textureheight: iconSize,
                    src: iconPath,
                    class: 'map-selection-btn__map-icon'
                });
                p.FindChildInLayoutFile('MapSelectionButton').MoveChildBefore(mapGroupIcon, p.FindChildInLayoutFile('MapGroupCollectionMultiIcons'));
            }
        }
        let mapImage = null;
        let mapIcon = null;
        if (mapGroupName === 'random_classic') {
            mapImage = p.FindChildInLayoutFile('MapGroupImagesCarousel').FindChildInLayoutFile('MapSelectionScreenshot');
            if (!mapImage) {
                mapImage = $.CreatePanel('Panel', p.FindChildInLayoutFile('MapGroupImagesCarousel'), 'MapSelectionScreenshot');
                mapImage.AddClass('map-selection-btn__screenshot');
            }
            mapImage.style.backgroundImage = 'url("file://{images}/map_icons/screenshots/360p/random.png")';
            mapImage.style.backgroundPosition = '50% 0%';
            mapImage.style.backgroundSize = 'auto 100%';
        }
        _SetMapGroupModifierLabelElements(mapGroupName, p);
        for (let i = 0; i < keysList.length; i++) {
            mapImage = p.FindChildInLayoutFile('MapGroupImagesCarousel').FindChildInLayoutFile('MapSelectionScreenshot' + i);
            if (!mapImage) {
                mapImage = $.CreatePanel('Panel', p.FindChildInLayoutFile('MapGroupImagesCarousel'), 'MapSelectionScreenshot' + i);
                mapImage.AddClass('map-selection-btn__screenshot');
            }
            if (m_gameModeSetting === 'survival') {
                mapImage.style.backgroundImage = 'url("file://{resources}/videos/' + keysList[i] + '_preview.webm")';
            }
            else {
                mapImage.style.backgroundImage = 'url("file://{images}/map_icons/screenshots/720p/' + keysList[i] + '.png")';
            }
            mapImage.style.backgroundPosition = '50% 0%';
            mapImage.style.backgroundSize = 'clip_then_cover';
            if (keysList.length > 1) {
                const mapIconsContainer = p.FindChildInLayoutFile('MapGroupCollectionMultiIcons');
                mapIconsContainer.SetHasClass('left-right-flow-wrap', numTiles === 1);
                mapIconsContainer.SetHasClass('top-bottom-flow-wrap', numTiles > 1);
                const subMapIconImagePanelID = 'MapIcon' + i;
                mapIcon = mapIconsContainer.FindChildInLayoutFile(subMapIconImagePanelID);
                if (!mapIcon) {
                    mapIcon = $.CreatePanel('Image', mapIconsContainer, subMapIconImagePanelID, {
                        defaultsrc: 'file://{images}/map_icons/map_icon_NONE.png',
                        texturewidth: iconSize,
                        textureheight: iconSize,
                        src: 'file://{images}/map_icons/map_icon_' + keysList[i] + '.svg'
                    });
                }
                mapIcon.AddClass('map-selection-btn__map-icon');
                IconUtil.SetupFallbackMapIcon(mapIcon, 'file://{images}/map_icons/map_icon_' + keysList[i]);
            }
        }
        if (mg.tooltipID) {
            p.SetPanelEvent('onmouseover', OnMouseOverMapTile.bind(undefined, p.id, mg.tooltipID, keysList));
            p.SetPanelEvent('onmouseout', OnMouseOutMapTile);
        }
    }
    function OnMouseOverMapTile(id, tooltipText, mapsList) {
        tooltipText = $.Localize(tooltipText);
        const mapNamesList = [];
        if (mapsList.length > 1) {
            mapsList.forEach(function (element) {
                mapNamesList.push($.Localize('#SFUI_Map_' + element));
            });
            const mapGroupsText = mapNamesList.join(', ');
            tooltipText = tooltipText + '<br><br>' + mapGroupsText;
        }
        UiToolkitAPI.ShowTextTooltip(id, tooltipText);
    }
    ;
    function OnMouseOutMapTile() {
        UiToolkitAPI.HideTextTooltip();
    }
    ;
    let m_timerMapGroupHandler = null;
    function _GetRotatingMapGroupStatus(gameMode, singleSkirmishMapGroup, mapgroupname) {
        m_timerMapGroupHandler = null;
        const strSchedule = CompetitiveMatchAPI.GetRotatingOfficialMapGroupCurrentState(gameMode);
        const elTimer = m_mapSelectionButtonContainers[m_activeMapGroupSelectionPanelID].FindChildInLayoutFile('PlayMenuMapRotationTimer');
        if (elTimer) {
            if (strSchedule) {
                const strCurrentMapGroup = strSchedule.split("+")[0];
                const numSecondsRemaining = strSchedule.split("+")[1].split("=")[0];
                const strNextMapGroup = strSchedule.split("=")[1];
                const numWait = FormatText.SecondsToDDHHMMSSWithSymbolSeperator(numSecondsRemaining);
                if (!numWait) {
                    elTimer.AddClass('hidden');
                    return;
                }
                elTimer.RemoveClass('hidden');
                elTimer.SetDialogVariable('map-rotate-timer', numWait);
                const mg = GetMGDetails(strNextMapGroup);
                elTimer.SetDialogVariable('next-mapname', $.Localize(mg.nameID));
                const mapGroupPanelID = _GetMapGroupPanelID() + strCurrentMapGroup;
                const mapGroupContainer = m_mapSelectionButtonContainers[m_activeMapGroupSelectionPanelID].FindChildTraverse('MapTile');
                const mapGroupPanel = mapGroupContainer.FindChildInLayoutFile(mapGroupPanelID);
                if (!mapGroupPanel) {
                    mapGroupContainer.RemoveAndDeleteChildren();
                    const btnMapGroup = _UpdateOrCreateMapGroupTile(strCurrentMapGroup, mapGroupContainer, null, mapGroupPanelID, 1);
                    btnMapGroup.checked = true;
                    _UpdateSurvivalAutoFillSquadBtn(m_gameModeSetting);
                }
                m_timerMapGroupHandler = $.Schedule(1, _GetRotatingMapGroupStatus.bind(undefined, gameMode, singleSkirmishMapGroup, mapgroupname));
            }
            else {
                elTimer.AddClass('hidden');
            }
        }
    }
    ;
    function _StartRotatingMapGroupTimer() {
        _CancelRotatingMapGroupSchedule();
        const activeMapGroup = m_activeMapGroupSelectionPanelID;
        if (_RealGameMode() === "survival"
            && m_mapSelectionButtonContainers && m_mapSelectionButtonContainers[activeMapGroup]
            && m_mapSelectionButtonContainers[activeMapGroup].Children()) {
            const btnSelectedMapGroup = m_mapSelectionButtonContainers[activeMapGroup].Children().filter(entry => entry.GetAttributeString('mapname', '') !== '');
            if (btnSelectedMapGroup[0]) {
                const mapSelectedGroupName = btnSelectedMapGroup[0].GetAttributeString('mapname', '');
                if (mapSelectedGroupName) {
                    _GetRotatingMapGroupStatus(_RealGameMode(), m_singleSkirmishMapGroup, mapSelectedGroupName);
                }
            }
        }
    }
    ;
    function _CancelRotatingMapGroupSchedule() {
        if (m_timerMapGroupHandler) {
            $.CancelScheduled(m_timerMapGroupHandler);
            m_timerMapGroupHandler = null;
        }
    }
    ;
    function _SetMapGroupModifierLabelElements(mapName, elMapPanel) {
        const isUnrankedCompetitive = (_RealGameMode() === 'competitive') && _IsValveOfficialServer(m_serverSetting) && (GameTypesAPI.GetMapGroupAttribute(mapName, 'competitivemod') === 'unranked');
        const isNew = !isUnrankedCompetitive && (GameTypesAPI.GetMapGroupAttribute(mapName, 'showtagui') === 'new');
        elMapPanel.FindChildInLayoutFile('MapGroupNewTag').SetHasClass('hidden', !isNew || mapName === "mg_lobby_mapveto");
        elMapPanel.FindChildInLayoutFile('MapGroupNewTagYellowLarge').SetHasClass('hidden', true);
        elMapPanel.FindChildInLayoutFile('MapSelectionTopRowIcons').SetHasClass('tall', mapName === "mg_lobby_mapveto");
        elMapPanel.FindChildInLayoutFile('MapGroupUnrankedTag').SetHasClass('hidden', !isUnrankedCompetitive);
    }
    ;
    function _ReloadLeaderboardLayoutGivenSettings(container, lbName, strTitleOverride, strPointsTitle) {
        const elFriendLeaderboards = container.FindChildTraverse("FriendLeaderboards");
        elFriendLeaderboards.SetAttributeString("type", lbName);
        if (strPointsTitle)
            elFriendLeaderboards.SetAttributeString("points-title", strPointsTitle);
        if (strTitleOverride)
            elFriendLeaderboards.SetAttributeString("titleoverride", strTitleOverride);
        elFriendLeaderboards.BLoadLayout('file://{resources}/layout/popups/popup_leaderboards.xml', true, false);
        elFriendLeaderboards.AddClass('leaderboard_embedded');
        elFriendLeaderboards.RemoveClass('Hidden');
    }
    function _LoadLeaderboardsLayoutForContainer(container) {
        if ((m_gameModeSetting === "cooperative") || (m_gameModeSetting === "coopmission")) {
            const questID = GetMatchmakingQuestId();
            if (questID > 0) {
                const lbName = "official_leaderboard_quest_" + questID;
                const elFriendLeaderboards = container.FindChildTraverse("FriendLeaderboards");
                if (elFriendLeaderboards.GetAttributeString("type", '') !== lbName) {
                    const strTitle = '#CSGO_official_leaderboard_mission_embedded';
                    _ReloadLeaderboardLayoutGivenSettings(container, lbName, strTitle, '');
                }
                const elDescriptionLabel = container.FindChildTraverse("MissionDesc");
                elDescriptionLabel.text = MissionsAPI.GetQuestDefinitionField(questID, "loc_description");
                MissionsAPI.ApplyQuestDialogVarsToPanelJS(questID, container);
            }
        }
        else if (m_gameModeSetting === "survival") {
        }
    }
    function _UpdateMapGroupButtons(isEnabled, isSearching, isHost) {
        const panelID = _LazyCreateMapListPanel();
        if ((_RealGameMode() === 'competitive' || _RealGameMode() === 'scrimcomp2v2') && _IsPlayingOnValveOfficial()) {
            _UpdateWaitTime(_GetMapListForServerTypeAndGameMode(panelID));
        }
        if (!inDirectChallenge())
            _SetEnabledStateForMapBtns(m_mapSelectionButtonContainers[panelID], isSearching, isHost);
        m_activeMapGroupSelectionPanelID = panelID;
        _ShowActiveMapSelectionTab(isEnabled);
        _PopulateQuickSelectBar(isSearching, isHost);
    }
    ;
    function _SelectMapButtonsFromSettings(settings) {
        const mapsGroups = settings.game.mapgroupname.split(',');
        const aListMaps = _GetMapListForServerTypeAndGameMode(m_activeMapGroupSelectionPanelID);
        aListMaps.forEach(function (e) {
            const mapName = e.GetAttributeString("mapname", "invalid");
            e.checked = mapsGroups.includes(mapName);
        });
    }
    ;
    function _ShowHideStartSearchBtn(isSearching, isHost) {
        let bShow = !isSearching && isHost ? true : false;
        const btnStartSearch = $.GetContextPanel().FindChildInLayoutFile('StartMatchBtn');
        if (bShow) {
            if (btnStartSearch.BHasClass('pressed')) {
                btnStartSearch.RemoveClass('pressed');
            }
            btnStartSearch.RemoveClass('hidden');
        }
        else if (!btnStartSearch.BHasClass('pressed')) {
            btnStartSearch.AddClass('hidden');
        }
        let numStyleToShow = 0;
        if (!isSearching && (_RealGameMode() === 'competitive') &&
            _IsPlayingOnValveOfficial() && (PartyListAPI.GetCount() >= PartyListAPI.GetPartySessionUiThreshold())) {
            numStyleToShow = PartyListAPI.GetCount();
            if ((numStyleToShow > 5) || (0 == PartyListAPI.GetPartySessionUiThreshold())) {
                numStyleToShow = 5;
            }
        }
        numStyleToShow = 0;
        for (let j = 1; j <= 5; ++j) {
        }
    }
    ;
    function _ShowCancelSearchButton(isSearching, isHost) {
        const btnCancel = $.GetContextPanel().FindChildInLayoutFile('PartyCancelBtn');
        btnCancel.enabled = (isSearching && isHost);
        if (!btnCancel.enabled)
            ParticleControls.UpdateActionBar(m_PlayMenuActionBarParticleFX, "RmoveBtnEffects");
    }
    ;
    function _UpdatePracticeSettingsBtns(isSearching, isHost) {
        let elPracticeSettingsContainer = $('#id-play-menu-practicesettings-container');
        let sessionSettings = LobbyAPI.GetSessionSettings();
        let bForceHidden = (m_serverSetting !== 'listen') || m_isWorkshop || !LobbyAPI.IsSessionActive() || !sessionSettings;
        elPracticeSettingsContainer.Children().forEach(function (elChild) {
            if (!elChild.id.startsWith('id-play-menu-practicesettings-'))
                return;
            let strFeatureName = elChild.id;
            strFeatureName = strFeatureName.replace('id-play-menu-practicesettings-', '');
            strFeatureName = strFeatureName.replace('-tooltip', '');
            let elFeatureFrame = elChild.FindChild('id-play-menu-practicesettings-' + strFeatureName);
            let elFeatureSliderBtn = elFeatureFrame.FindChild('id-slider-btn');
            if (bForceHidden || (sessionSettings.game.type !== 'classic')) {
                elChild.visible = false;
                return;
            }
            elChild.visible = true;
            elFeatureSliderBtn.enabled = isHost && !isSearching;
            let curvalue = (sessionSettings && sessionSettings.options && sessionSettings.options.hasOwnProperty('practicesettings_' + strFeatureName))
                ? sessionSettings.options['practicesettings_' + strFeatureName] : 0;
            elFeatureSliderBtn.checked = curvalue ? true : false;
        });
    }
    function _UpdatePrimeBtn(isSearching, isHost) {
        const elPrimePanel = $('#PrimeStatusPanel');
        const elGetPrimeBtn = $('#id-play-menu-get-prime');
        const elPrimeStatus = $('#PrimeStatusLabelContainer');
        if (!_IsPlayingOnValveOfficial() || !MyPersonaAPI.IsInventoryValid() || inDirectChallenge() || m_isWorkshop) {
            elPrimePanel.visible = false;
            return;
        }
        const LocalPlayerHasPrime = PartyListAPI.GetFriendPrimeEligible(MyPersonaAPI.GetXuid());
        elPrimePanel.visible = true;
        elPrimePanel.SetHasClass('play-menu-prime-logo-bg', LocalPlayerHasPrime);
        elGetPrimeBtn.visible = !LocalPlayerHasPrime;
        elPrimeStatus.visible = LocalPlayerHasPrime;
        if (!LocalPlayerHasPrime) {
            const sPrice = StoreAPI.GetStoreItemSalePrice(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(1353, 0), 1, '');
            elGetPrimeBtn.SetDialogVariable("price", sPrice ? sPrice : '$0');
            elGetPrimeBtn.SetPanelEvent('onactivate', function () {
                UiToolkitAPI.HideTextTooltip();
                UiToolkitAPI.ShowCustomLayoutPopup('prime_status', 'file://{resources}/layout/popups/popup_prime_status.xml');
            });
        }
    }
    ;
    function _UpdatePermissionBtnText(settings, isEnabled) {
        let elBtnContainer = $('#PermissionsSettings');
        let elBtn = elBtnContainer.FindChild("id-slider-btn");
        elBtn.SetDialogVariable('slide_toggle_text', $.Localize("#permissions_open_party"));
        elBtn.SetSelected(settings.system.access === 'public');
        elBtn.enabled = isEnabled;
    }
    ;
    function GetMatchmakingQuestId() {
        const settings = LobbyAPI.GetSessionSettings();
        if (settings && settings.game && settings.game.questid)
            return parseInt(settings.game.questid);
        else
            return 0;
    }
    function _UpdateLeaderboardBtn(gameMode, isOfficalMatchmaking = false) {
        const elLeaderboardButton = $('#PlayMenulLeaderboards');
        {
            elLeaderboardButton.visible = false;
        }
    }
    ;
    function _UpdateReplayNewUserTrainingBtn(gameMode) {
        const elButton = $('#PlayMenuReplayNewUserTrainingButton');
        if (gameMode === 'competitive' && m_serverSetting === 'listen' && !m_isWorkshop) {
            elButton.visible = true;
            elButton.SetPanelEvent('onactivate', () => {
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
            });
        }
        else {
            elButton.visible = false;
        }
    }
    ;
    function _UpdateSurvivalAutoFillSquadBtn(gameMode) {
        const elBtn = $('#SurvivalAutoSquadToggle');
        if (!elBtn) {
            return;
        }
        if (gameMode === 'survival' && _IsPlayingOnValveOfficial() && (PartyListAPI.GetCount() <= 1)) {
            elBtn.visible = true;
            const bAutoFill = !(GameInterfaceAPI.GetSettingString('ui_playsettings_survival_solo') === '1');
            elBtn.checked = bAutoFill;
            elBtn.enabled = !_IsSearching();
            function _OnActivate() {
                const bAutoFill = !(GameInterfaceAPI.GetSettingString('ui_playsettings_survival_solo') === '1');
                GameInterfaceAPI.SetSettingString('ui_playsettings_survival_solo', bAutoFill ? '1' : '0');
                _UpdateSurvivalAutoFillSquadBtn('survival');
            }
            ;
            elBtn.SetPanelEvent('onactivate', _OnActivate);
        }
        else {
            elBtn.visible = false;
        }
        if (gameMode === 'survival') {
            const lbType = ((elBtn.visible && !elBtn.checked) ? 'solo' : 'squads');
            const lbName = "official_leaderboard_survival_" + lbType;
            const container = elBtn.GetParent().GetParent();
            const elFriendLeaderboards = container.FindChildTraverse("FriendLeaderboards");
            const sPreviousType = elFriendLeaderboards.GetAttributeString("type", '');
            if (sPreviousType !== lbName) {
                _ReloadLeaderboardLayoutGivenSettings(container, lbName, "#CSGO_official_leaderboard_survival_" + lbType, "#Cstrike_TitlesTXT_WINS");
            }
        }
    }
    ;
    function _SetEnabledStateForMapBtns(elMapList, isSearching, isHost) {
        elMapList.SetHasClass('is-client', (isSearching || !isHost));
        const childrenList = _GetMapListForServerTypeAndGameMode();
        const bEnable = !isSearching && isHost;
        childrenList.forEach(element => {
            if (!element.BHasClass('no-lock')) {
                element.enabled = bEnable;
            }
        });
    }
    ;
    function _UpdateWaitTime(elMapList) {
        const childrenList = elMapList;
        for (let i = 0; i < childrenList.length; i++) {
            const elWaitTime = childrenList[i].FindChildTraverse('MapGroupWaitTime');
            const mapName = childrenList[i].GetAttributeString("mapname", "invalid");
            if (mapName === 'invalid') {
                continue;
            }
            const seconds = LobbyAPI.GetMapWaitTimeInSeconds(_RealGameMode(), mapName);
            const numWait = FormatText.SecondsToDDHHMMSSWithSymbolSeperator(seconds);
            if (numWait) {
                elWaitTime.SetDialogVariable("time", numWait);
                elWaitTime.FindChild('MapGroupWaitTimeLabel').text = $.Localize('#matchmaking_expected_wait_time', elWaitTime);
                elWaitTime.RemoveClass('hidden');
            }
            else {
                elWaitTime.AddClass('hidden');
            }
        }
    }
    ;
    function _SelectActivePlayPlayTypeBtn() {
        const aPlayTypeBtns = $('#PlayTypeTopNav').Children();
        aPlayTypeBtns.forEach(btn => {
            if (m_activeMapGroupSelectionPanelID === k_workshopPanelId) {
                btn.checked = btn.id === 'PlayWorkshop';
            }
            else {
                btn.checked = btn.id === 'Play-' + m_serverSetting;
            }
        });
    }
    ;
    function _UpdateTopNavRadioBtns() {
        $('#GameModeSelectionRadios').Children().forEach(btn => {
            if (m_activeMapGroupSelectionPanelID === k_workshopPanelId && btn.id === 'PlayWorkshop') {
                $.DispatchEvent("Activated", btn, "mouse");
                btn.checked = true;
                return;
            }
            else if (btn.id === 'Play-' + m_serverSetting) {
                $.DispatchEvent("Activated", btn, "mouse");
                btn.checked = true;
                return;
            }
        });
    }
    function _IsValveOfficialServer(serverType) {
        return serverType === "official" ? true : false;
    }
    function _IsPlayingOnValveOfficial() {
        return _IsValveOfficialServer(m_serverSetting);
    }
    ;
    function _IsSearching() {
        const searchingStatus = LobbyAPI.GetMatchmakingStatusString();
        return searchingStatus !== '' && searchingStatus !== undefined ? true : false;
    }
    ;
    function _GetSelectedMapsForServerTypeAndGameMode(serverType, gameMode, bDontToggleMaps = false) {
        const isPlayingOnValveOfficial = _IsValveOfficialServer(serverType);
        const aListMapPanels = _GetMapListForServerTypeAndGameMode();
        if (!_CheckContainerHasAnyChildChecked(aListMapPanels)) {
            let preferencesMapsForThisMode = GameInterfaceAPI.GetSettingString('ui_playsettings_maps_' + serverType + '_' + gameMode);
            if (!preferencesMapsForThisMode)
                preferencesMapsForThisMode = '';
            const savedMapIds = preferencesMapsForThisMode.split(',');
            savedMapIds.forEach(function (strMapNameIndividual) {
                const mapsWithThisName = aListMapPanels.filter(function (map) {
                    const mapName = map.GetAttributeString("mapname", "invalid");
                    return mapName === strMapNameIndividual;
                });
                if (mapsWithThisName.length > 0) {
                    if (!bDontToggleMaps)
                        mapsWithThisName[0].checked = true;
                }
            });
            if (aListMapPanels.length > 0 && !_CheckContainerHasAnyChildChecked(aListMapPanels)) {
                if (!bDontToggleMaps)
                    aListMapPanels[0].checked = true;
            }
        }
        const selectedMaps = aListMapPanels.filter(function (e) {
            return e.checked;
        }).reduce(function (accumulator, e) {
            const mapName = e.GetAttributeString("mapname", "invalid");
            return (accumulator) ? (accumulator + "," + mapName) : mapName;
        }, '');
        return selectedMaps;
    }
    ;
    function _GetMapListForServerTypeAndGameMode(mapGroupOverride = null) {
        const mapGroupPanelID = !mapGroupOverride ? _LazyCreateMapListPanel() : mapGroupOverride;
        const elParent = m_mapSelectionButtonContainers[mapGroupPanelID];
        if (_RealGameMode() === 'competitive' && elParent.GetAttributeString('hassections', '')) {
            let aListMapPanels = [];
            elParent.Children().forEach(function (section) {
                section.Children().forEach(function (tile) {
                    if (tile.id != 'play-maps-section-header-container') {
                        aListMapPanels.push(tile);
                    }
                });
            });
            return aListMapPanels;
        }
        else if (_IsPlayingOnValveOfficial() && (_RealGameMode() === 'survival'
            || _RealGameMode() === 'cooperative'
            || _RealGameMode() === 'coopmission')) {
            let elMapTile = elParent.FindChildTraverse("MapTile");
            if (elMapTile)
                return elMapTile.Children();
            else
                return elParent.Children();
        }
        else {
            return elParent.Children();
        }
    }
    ;
    function _GetSelectedWorkshopMapButtons() {
        const mapGroupPanelID = _LazyCreateWorkshopTab();
        const mapContainer = m_mapSelectionButtonContainers[mapGroupPanelID];
        const children = mapContainer.Children();
        if (children.length == 0 || !children[0].GetAttributeString('group', "")) {
            return [];
        }
        if (!_CheckContainerHasAnyChildChecked(children)) {
            let preferencesMapsForThisMode = GameInterfaceAPI.GetSettingString('ui_playsettings_maps_workshop');
            if (!preferencesMapsForThisMode)
                preferencesMapsForThisMode = '';
            const savedMapIds = preferencesMapsForThisMode.split(',');
            savedMapIds.forEach(function (strMapNameIndividual) {
                const mapsWithThisName = children.filter(function (map) {
                    const mapName = map.GetAttributeString("mapname", "invalid");
                    return mapName === strMapNameIndividual;
                });
                if (mapsWithThisName.length > 0) {
                    mapsWithThisName[0].checked = true;
                }
            });
            if (!_CheckContainerHasAnyChildChecked(children) && children.length > 0) {
                children[0].checked = true;
            }
        }
        const selectedMaps = children.filter(function (e) {
            return e.checked;
        });
        return Array.from(selectedMaps);
    }
    ;
    function _GetSelectedWorkshopMap() {
        const mapButtons = _GetSelectedWorkshopMapButtons();
        const selectedMaps = mapButtons.reduce(function (accumulator, e) {
            const mapName = e.GetAttributeString("mapname", "invalid");
            return (accumulator) ? (accumulator + "," + mapName) : mapName;
        }, '');
        return selectedMaps;
    }
    ;
    function _GetSingleSkirmishIdFromMapGroup(mapGroup) {
        return mapGroup.replace('mg_skirmish_', '');
    }
    ;
    function _GetSingleSkirmishMapGroupFromId(skirmishId) {
        return 'mg_skirmish_' + skirmishId;
    }
    ;
    function _GetSingleSkirmishIdFromSingleSkirmishString(entry) {
        return entry.replace('skirmish_', '');
    }
    ;
    function _GetSingleSkirmishMapGroupFromSingleSkirmishString(entry) {
        return _GetSingleSkirmishMapGroupFromId(_GetSingleSkirmishIdFromSingleSkirmishString(entry));
    }
    ;
    function _IsSingleSkirmishString(entry) {
        return entry.startsWith('skirmish_');
    }
    ;
    function _CheckContainerHasAnyChildChecked(aMapList) {
        if (aMapList.length < 1)
            return false;
        return aMapList.filter(function (map) {
            return map.checked;
        }).length > 0;
    }
    ;
    function _ValidateSessionSettings() {
        if (m_isWorkshop) {
            m_serverSetting = "listen";
        }
        if (!_IsGameModeAvailable(m_serverSetting, m_gameModeSetting)) {
            m_gameModeSetting = GameInterfaceAPI.GetSettingString("ui_playsettings_mode_" + m_serverSetting);
            m_singleSkirmishMapGroup = null;
            if (_IsSingleSkirmishString(_RealGameMode())) {
                m_singleSkirmishMapGroup = _GetSingleSkirmishMapGroupFromSingleSkirmishString(_RealGameMode());
                m_gameModeSetting = 'skirmish';
            }
            if (!_IsGameModeAvailable(m_serverSetting, m_gameModeSetting)) {
                const modes = [
                    "premier",
                    "competitive",
                    "scrimcomp2v2",
                    "casual",
                    "deathmatch",
                ];
                for (let i = 0; i < modes.length; i++) {
                    if (_IsGameModeAvailable(m_serverSetting, modes[i])) {
                        m_gameModeSetting = modes[i];
                        m_singleSkirmishMapGroup = null;
                        break;
                    }
                }
            }
        }
        if (!m_gameModeFlags[m_serverSetting + _RealGameMode()])
            _LoadGameModeFlagsFromSettings();
        if (GameModeFlags.DoesModeUseFlags(_RealGameMode())) {
            if (!GameModeFlags.AreFlagsValid(_RealGameMode(), m_gameModeFlags[m_serverSetting + _RealGameMode()])) {
                _setAndSaveGameModeFlags(0);
            }
        }
    }
    ;
    function _LoadGameModeFlagsFromSettings() {
        m_gameModeFlags[m_serverSetting + _RealGameMode()] = parseInt(GameInterfaceAPI.GetSettingString('ui_playsettings_flags_' + m_serverSetting + '_' + _RealGameMode()));
    }
    function _ApplySessionSettings() {
        if (m_serverSetting === 'official' && !m_isWorkshop && !inDirectChallenge()) {
            if (m_gameModeSetting === 'scrimcomp2v2') {
                MyPersonaAPI.HintLoadPipRanks('wingman');
            }
            else if (m_gameModeSetting === 'competitive') {
                MyPersonaAPI.HintLoadPipRanks('competitive');
            }
        }
        if (!LobbyAPI.BIsHost()) {
            return;
        }
        _ValidateSessionSettings();
        const serverType = m_serverSetting;
        let gameMode = _RealGameMode();
        let gameModeFlags = m_gameModeFlags[m_serverSetting + gameMode] ? m_gameModeFlags[m_serverSetting + gameMode] : 0;
        let primePreference = PartyListAPI.GetFriendPrimeEligible(MyPersonaAPI.GetXuid()) ? 1 : 0;
        let selectedMaps;
        if (m_isWorkshop)
            selectedMaps = _GetSelectedWorkshopMap();
        else if (inDirectChallenge()) {
            selectedMaps = 'mg_lobby_mapveto';
            gameModeFlags = 16;
            primePreference = 0;
        }
        else if (m_gameModeSetting === 'premier') {
            selectedMaps = 'mg_lobby_mapveto';
            primePreference = 1;
            m_challengeKey = '';
        }
        else if (m_singleSkirmishMapGroup) {
            selectedMaps = m_singleSkirmishMapGroup;
        }
        else {
            selectedMaps = _GetSelectedMapsForServerTypeAndGameMode(serverType, gameMode);
        }
        const settings = {
            update: {
                Options: {
                    action: "custommatch",
                    server: serverType,
                    challengekey: _GetDirectChallengeKey(),
                },
                Game: {
                    mode: gameMode,
                    mode_ui: m_gameModeSetting,
                    type: GetGameType(gameMode),
                    mapgroupname: selectedMaps,
                    gamemodeflags: gameModeFlags,
                    prime: primePreference,
                    map: ''
                }
            },
            delete: {}
        };
        if (!inDirectChallenge()) {
            settings.delete = {
                Options: {
                    challengekey: 1
                }
            };
        }
        if (selectedMaps.startsWith("random_")) {
            const arrMapGroups = _GetAvailableMapGroups(gameMode, false);
            const idx = 1 + Math.floor((Math.random() * (arrMapGroups.length - 1)));
            settings.update.Game.map = arrMapGroups[idx].substring(3);
        }
        if (m_isWorkshop) {
            GameInterfaceAPI.SetSettingString('ui_playsettings_maps_workshop', selectedMaps);
        }
        else {
            let singleSkirmishSuffix = '';
            if (m_singleSkirmishMapGroup) {
                singleSkirmishSuffix = '_' + _GetSingleSkirmishIdFromMapGroup(m_singleSkirmishMapGroup);
            }
            GameInterfaceAPI.SetSettingString('ui_playsettings_mode_' + serverType, m_gameModeSetting + singleSkirmishSuffix);
            if (!inDirectChallenge() && m_gameModeSetting !== 'premier') {
                GameInterfaceAPI.SetSettingString('ui_playsettings_maps_' + serverType + '_' + m_gameModeSetting + singleSkirmishSuffix, selectedMaps);
            }
        }
        LobbyAPI.UpdateSessionSettings(settings);
    }
    ;
    function _SessionSettingsUpdate(sessionState) {
        if (sessionState === "ready") {
            if (m_jsTimerUpdateHandle && typeof m_jsTimerUpdateHandle === "number") {
                $.CancelScheduled(m_jsTimerUpdateHandle);
                m_jsTimerUpdateHandle = false;
            }
            _Init();
        }
        else if (sessionState === "updated") {
            const settings = LobbyAPI.GetSessionSettings();
            _SyncDialogsFromSessionSettings(settings);
        }
        else if (sessionState === "closed") {
            m_jsTimerUpdateHandle = $.Schedule(0.5, _HalfSecondDelay_HideContentPanel);
        }
    }
    ;
    function _PipRankUpdate() {
        if (m_serverSetting == 'official' &&
            m_gameModeSetting === 'competitive') {
            const activeMapGroup = m_activeMapGroupSelectionPanelID;
            const btnSelectedMapGroup = m_mapSelectionButtonContainers[activeMapGroup].Children();
            btnSelectedMapGroup.forEach(function (elPanel) {
                const mapGroupName = elPanel.GetAttributeString('mapname', '').replace(/^mg_/, '');
                _UpdateRatingEmblem(elPanel, mapGroupName);
            });
        }
    }
    function _HalfSecondDelay_HideContentPanel() {
        m_jsTimerUpdateHandle = false;
        $.DispatchEvent('HideContentPanel');
    }
    ;
    function _ReadyForDisplay() {
        _StartRotatingMapGroupTimer();
        _m_inventoryUpdatedHandler = $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', PlayMenu.InventoryUpdated);
    }
    ;
    function _UnreadyForDisplay() {
        _CancelRotatingMapGroupSchedule();
        if (_m_inventoryUpdatedHandler) {
            $.UnregisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', _m_inventoryUpdatedHandler);
            _m_inventoryUpdatedHandler = null;
        }
    }
    ;
    function _OnHideMainMenu() {
        $('#MapSelectionList').FindChildrenWithClassTraverse("map-selection-btn__carousel").forEach(function (entry) {
            entry.SetAutoScrollEnabled(false);
        });
    }
    ;
    function _OnShowMainMenu() {
        $('#MapSelectionList').FindChildrenWithClassTraverse("map-selection-btn__carousel").forEach(function (entry) {
            entry.SetAutoScrollEnabled(true);
        });
    }
    ;
    function _GetPlayType() {
        const aEnabled = $('#PlayTypeTopNav').Children().filter(function (btn) {
            return btn.checked === true;
        });
        if (aEnabled.length > 0 && aEnabled[0]) {
            return aEnabled[0].GetAttributeString('data-type', '(not_found)');
        }
        return ('');
    }
    ;
    function _InitializeWorkshopTags(panel, mapInfo) {
        const mapTags = mapInfo.tags ? mapInfo.tags.split(",") : [];
        const rawModes = [];
        const modes = [];
        const tags = [];
        for (let i = 0; i < mapTags.length; ++i) {
            const modeTag = mapTags[i].toLowerCase().split(' ').join('').split('-').join('');
            if (modeTag in k_workshopModes) {
                const gameTypes = k_workshopModes[modeTag].split(',');
                for (let iType = 0; iType < gameTypes.length; ++iType) {
                    if (!rawModes.includes(gameTypes[iType]))
                        rawModes.push(gameTypes[iType]);
                }
                modes.push($.Localize('#CSGO_Workshop_Mode_' + modeTag));
            }
            else {
                tags.push($.HTMLEscape(mapTags[i]));
            }
        }
        let tooltip = mapInfo.desc ? $.HTMLEscape(mapInfo.desc) : '';
        if (modes.length > 0) {
            if (tooltip)
                tooltip += '<br><br>';
            tooltip += $.Localize("#CSGO_Workshop_Modes");
            tooltip += ' ';
            tooltip += modes.join(', ');
        }
        if (tags.length > 0) {
            if (tooltip)
                tooltip += '<br><br>';
            tooltip += $.Localize("#CSGO_Workshop_Tags");
            tooltip += ' ';
            tooltip += tags.join(', ');
        }
        panel.SetAttributeString('data-tooltip', tooltip);
        panel.SetAttributeString('data-workshop-modes', rawModes.join(','));
    }
    function _ShowWorkshopMapInfoTooltip(panel) {
        const text = panel.GetAttributeString('data-tooltip', '');
        if (text)
            UiToolkitAPI.ShowTextTooltip(panel.id, text);
    }
    ;
    function _HideWorkshopMapInfoTooltip() {
        UiToolkitAPI.HideTextTooltip();
    }
    ;
    function _LazyCreateWorkshopTab() {
        const panelId = k_workshopPanelId;
        if (panelId in m_mapSelectionButtonContainers)
            return panelId;
        const container = $.CreatePanel("Panel", $('#MapSelectionList'), panelId, {
            class: 'map-selection-list map-selection-list--inner hidden'
        });
        container.AddClass('map-selection-list--workshop');
        m_mapSelectionButtonContainers[panelId] = container;
        const arrMaps = WorkshopAPI.GetAvailableWorkshopMaps();
        for (let idxMap = 0; idxMap < arrMaps.length; ++idxMap) {
            const mapInfo = arrMaps[idxMap];
            if (typeof mapInfo !== 'object') {
                continue;
            }
            const p = $.CreatePanel('RadioButton', container, panelId + '_' + idxMap);
            p.BLoadLayoutSnippet('MapGroupSelection');
            p.SetAttributeString('group', 'radiogroup_' + panelId);
            if (!mapInfo.hasOwnProperty('imageUrl') || !mapInfo.imageUrl)
                mapInfo.imageUrl = 'file://{images}/map_icons/screenshots/360p/random.png';
            p.SetAttributeString('mapname', '@workshop/' + mapInfo.workshop_id + '/' + mapInfo.map);
            p.SetAttributeString('addon', mapInfo.workshop_id);
            p.SetPanelEvent('onactivate', _OnActivateMapOrMapGroupButton.bind(undefined, p));
            p.FindChildInLayoutFile('ActiveGroupIcon').visible = false;
            p.FindChildInLayoutFile('MapGroupName').text = mapInfo.name;
            const mapImage = $.CreatePanel('Panel', p.FindChildInLayoutFile('MapGroupImagesCarousel'), 'MapSelectionScreenshot0');
            mapImage.AddClass('map-selection-btn__screenshot');
            mapImage.style.backgroundImage = 'url("' + mapInfo.imageUrl + '")';
            mapImage.style.backgroundPosition = '50% 0%';
            mapImage.style.backgroundSize = 'auto 100%';
            _InitializeWorkshopTags(p, mapInfo);
            p.SetPanelEvent('onmouseover', _ShowWorkshopMapInfoTooltip.bind(null, p));
            p.SetPanelEvent('onmouseout', _HideWorkshopMapInfoTooltip.bind(null));
        }
        if (arrMaps.length == 0) {
            const p = $.CreatePanel('Panel', container, undefined);
            p.BLoadLayoutSnippet('NoWorkshopMaps');
        }
        _UpdateWorkshopMapFilter();
        return panelId;
    }
    ;
    function _SwitchToWorkshopTab(isEnabled) {
        const panelId = _LazyCreateWorkshopTab();
        m_activeMapGroupSelectionPanelID = panelId;
        _ShowActiveMapSelectionTab(isEnabled);
    }
    ;
    function _UpdateGameModeFlagsBtn() {
        const elPanel = $.GetContextPanel().FindChildTraverse('id-gamemode-flag-' + _RealGameMode());
        if (!elPanel || !GameModeFlags.DoesModeUseFlags(_RealGameMode()) || m_isWorkshop) {
            return;
        }
        else {
            let elFlag = (m_gameModeFlags[m_serverSetting + _RealGameMode()]) ? elPanel.FindChildInLayoutFile('id-gamemode-flag-' + _RealGameMode() + '-' + m_gameModeFlags[m_serverSetting + _RealGameMode()]) : null;
            if (elFlag && elFlag.IsValid()) {
                elFlag.checked = true;
            }
            else {
                elPanel.Children().forEach(element => {
                    element.checked = false;
                });
            }
        }
        elPanel.Children().forEach(element => {
            element.enabled = !inDirectChallenge() && !_IsSearching() && LobbyAPI.BIsHost();
        });
    }
    function _setAndSaveGameModeFlags(value) {
        m_gameModeFlags[m_serverSetting + _RealGameMode()] = value;
        _UpdateGameModeFlagsBtn();
        if (!inDirectChallenge())
            GameInterfaceAPI.SetSettingString('ui_playsettings_flags_' + m_serverSetting + '_' + _RealGameMode(), m_gameModeFlags[m_serverSetting + _RealGameMode()].toString());
    }
    function _OnGameModeFlagOptionActivate(value) {
        _setAndSaveGameModeFlags(value);
        _ApplySessionSettings();
    }
    function _OnGameModeFlagsBtnClicked(resumeMatchmakingHandle) {
        function _Callback(value, resumeMatchmakingHandle = '') {
            _setAndSaveGameModeFlags(parseInt(value));
            _ApplySessionSettings();
            if (resumeMatchmakingHandle) {
                UiToolkitAPI.InvokeJSCallback(parseInt(resumeMatchmakingHandle));
                UiToolkitAPI.UnregisterJSCallback(parseInt(resumeMatchmakingHandle));
            }
        }
        const callback = UiToolkitAPI.RegisterJSCallback(_Callback);
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_play_gamemodeflags.xml', '&callback=' + callback +
            '&searchfn=' + resumeMatchmakingHandle +
            '&textToken=' + '#play_settings_' + _RealGameMode() + '_dialog' +
            GameModeFlags.GetOptionsString(_RealGameMode()) +
            '&currentvalue=' + m_gameModeFlags[m_serverSetting + _RealGameMode()]);
    }
    function _OnPressOfficialServers() {
        m_isWorkshop = false;
        m_serverSetting = 'official';
        _TurnOffDirectChallenge();
        _ApplySessionSettings();
    }
    function _OnPressListenServers() {
        m_isWorkshop = false;
        m_serverSetting = 'listen';
        _TurnOffDirectChallenge();
        _ApplySessionSettings();
    }
    function _OnPressWorkshop() {
        _SetPlayDropdownToWorkshop();
        _TurnOffDirectChallenge();
        _UpdateDirectChallengePage(_IsSearching(), LobbyAPI.BIsHost());
        _UpdateGameModeFlagsBtn();
        _SelectActivePlayPlayTypeBtn();
    }
    function _OnPressServerBrowser() {
        if ('0' === GameInterfaceAPI.GetSettingString('player_nevershow_communityservermessage')) {
            UiToolkitAPI.ShowCustomLayoutPopup('server_browser_popup', 'file://{resources}/layout/popups/popup_serverbrowser.xml');
        }
        else {
            if (m_bPerfectWorld) {
                SteamOverlayAPI.OpenURL('https://csgo.wanmei.com/communityserver');
            }
            else {
                SteamOverlayAPI.OpenUrlInOverlayOrExternalBrowser('steam://open/servers');
            }
        }
    }
    function _UpdateBotDifficultyButton() {
        const playType = _GetPlayType();
        const elDropDown = $('#BotDifficultyDropdown');
        const bShowBotDifficultyButton = (playType === 'listen' || playType === 'workshop');
        elDropDown.SetHasClass("hidden", !bShowBotDifficultyButton);
        const botDiff = GameInterfaceAPI.GetSettingString('player_botdifflast_s');
        GameTypesAPI.SetCustomBotDifficulty(parseInt(botDiff));
        elDropDown.SetSelected(botDiff);
    }
    ;
    function _BotDifficultyChanged() {
        const elDropDownEntry = $('#BotDifficultyDropdown').GetSelected();
        const botDiff = elDropDownEntry.id;
        GameTypesAPI.SetCustomBotDifficulty(parseInt(botDiff));
        GameInterfaceAPI.SetSettingString('player_botdifflast_s', botDiff);
    }
    ;
    function _DisplayWorkshopModePopup() {
        const elSelectedMaps = _GetSelectedWorkshopMapButtons();
        let modes = [];
        if (elSelectedMaps.length === 0) {
            UiToolkitAPI.ShowGenericPopupTwoOptions($.Localize('#SFUI_Maps_Workshop_Title'), $.Localize('#SFUI_No_Subscribed_Maps_Desc'), '', '#CSGO_Workshop_Visit', 
            // @ts-ignore: Unreachable code error
            function () { $.DispatchEvent('CSGOOpenSteamWorkshop'); }, "OK", function () { });
            $('#StartMatchBtn').RemoveClass('pressed');
            return;
        }
        for (let iMap = 0; iMap < elSelectedMaps.length; ++iMap) {
            const mapModes = elSelectedMaps[iMap].GetAttributeString('data-workshop-modes', '').split(',');
            if (iMap == 0)
                modes = mapModes;
            else
                modes = modes.filter(function (mode) { return mapModes.includes(mode); });
        }
        const strModes = modes.join(',');
        UiToolkitAPI.ShowCustomLayoutPopupParameters('workshop_map_mode', 'file://{resources}/layout/popups/popup_workshop_mode_select.xml', 'workshop-modes=' + $.HTMLEscape(strModes));
        $('#StartMatchBtn').RemoveClass('pressed');
    }
    ;
    function _UpdateWorkshopMapFilter() {
        const elTextLabel = $('#WorkshopSearchTextEntry');
        const filter = $.HTMLEscape(elTextLabel.text).toLowerCase();
        const container = m_mapSelectionButtonContainers[k_workshopPanelId];
        const elCanelBtn = $('#WorkshopSearchTextEntryCanel');
        elCanelBtn.SetHasClass('hide', filter == '');
        elCanelBtn.SetPanelEvent('onactivate', () => { elTextLabel.text = '', _UpdateWorkshopMapFilter; });
        if (!container) {
            return;
        }
        const children = container.Children();
        for (let i = 0; i < children.length; ++i) {
            const panel = children[i];
            const mapname = panel.GetAttributeString('mapname', '');
            if (mapname === '')
                continue;
            if (filter === '') {
                panel.visible = true;
                continue;
            }
            if (mapname.toLowerCase().includes(filter)) {
                panel.visible = true;
                continue;
            }
            const modes = panel.GetAttributeString('data-workshop-modes', '');
            if (modes.toLowerCase().includes(filter)) {
                panel.visible = true;
                continue;
            }
            const tooltip = panel.GetAttributeString('data-tooltip', '');
            if (tooltip.toLowerCase().includes(filter)) {
                panel.visible = true;
                continue;
            }
            const elMapNameLabel = panel.FindChildTraverse('MapGroupName');
            if (elMapNameLabel && elMapNameLabel.text && elMapNameLabel.text.toLowerCase().includes(filter)) {
                panel.visible = true;
                continue;
            }
            panel.visible = false;
        }
    }
    ;
    function _SetPlayDropdownToWorkshop() {
        m_serverSetting = 'listen';
        m_isWorkshop = true;
        _UpdatePrimeBtn(false, LobbyAPI.BIsHost());
        _UpdatePracticeSettingsBtns(false, LobbyAPI.BIsHost());
        if (_GetSelectedWorkshopMap()) {
            _ApplySessionSettings();
        }
        else {
            _SwitchToWorkshopTab(true);
        }
        $.GetContextPanel().SwitchClass("gamemode", 'workshop');
        $.GetContextPanel().SwitchClass("serversetting", m_serverSetting);
    }
    ;
    function _WorkshopSubscriptionsChanged() {
        const panel = m_mapSelectionButtonContainers[k_workshopPanelId];
        if (panel) {
            panel.DeleteAsync(0.0);
            delete m_mapSelectionButtonContainers[k_workshopPanelId];
        }
        if (m_activeMapGroupSelectionPanelID != k_workshopPanelId) {
            return;
        }
        if (!LobbyAPI.IsSessionActive()) {
            m_activeMapGroupSelectionPanelID = null;
            return;
        }
        _SyncDialogsFromSessionSettings(LobbyAPI.GetSessionSettings());
        if (LobbyAPI.BIsHost()) {
            _ApplySessionSettings();
            _SetPlayDropdownToWorkshop();
        }
    }
    function _InventoryUpdated() {
        _UpdatePrimeBtn(_IsSearching(), LobbyAPI.BIsHost());
        _UpdatePracticeSettingsBtns(_IsSearching(), LobbyAPI.BIsHost());
    }
    function _RealGameMode() {
        return m_gameModeSetting === 'premier' ? 'competitive' : m_gameModeSetting;
    }
    function _OnClearFilterText() {
        const elTextLabel = $('#WorkshopSearchTextEntry');
        const elCanelBtn = $('#WorkshopSearchTextEntryCanel');
        elCanelBtn.SetPanelEvent('onactivate', () => { elTextLabel.text = '', _UpdateWorkshopMapFilter; });
    }
    return {
        Init: _Init,
        ClansInfoUpdated: _ClansInfoUpdated,
        SessionSettingsUpdate: _SessionSettingsUpdate,
        ReadyForDisplay: _ReadyForDisplay,
        UnreadyForDisplay: _UnreadyForDisplay,
        OnHideMainMenu: _OnHideMainMenu,
        OnShowMainMenu: _OnShowMainMenu,
        BotDifficultyChanged: _BotDifficultyChanged,
        WorkshopSubscriptionsChanged: _WorkshopSubscriptionsChanged,
        InventoryUpdated: _InventoryUpdated,
        SaveMapSelectionToCustomPreset: _SaveMapSelectionToCustomPreset,
        OnMapQuickSelect: _OnMapQuickSelect,
        OnDirectChallengeBtn: _OnDirectChallengeBtn,
        OnDirectChallengeRandom: _OnDirectChallengeRandom,
        OnDirectChallengeCopy: _OnDirectChallengeCopy,
        OnDirectChallengeEdit: _OnDirectChallengeEdit,
        OnClanChallengeKeySelected: _OnClanChallengeKeySelected,
        OnChooseClanKeyBtn: _OnChooseClanKeyBtn,
        OnPlayerNameChangedUpdate: _OnPlayerNameChangedUpdate,
        OnPrivateQueuesUpdate: _OnPrivateQueuesUpdate,
        OnGameModeFlagOptionActivate: _OnGameModeFlagOptionActivate,
        OnPressServerBrowser: _OnPressServerBrowser,
        OnPressOfficialServers: _OnPressOfficialServers,
        OnPressListenServers: _OnPressListenServers,
        OnPressWorkshop: _OnPressWorkshop,
        PipRankUpdate: _PipRankUpdate,
        OnClearFilterText: _OnClearFilterText
    };
})();
(function () {
    PlayMenu.Init();
    $.RegisterEventHandler("ReadyForDisplay", $.GetContextPanel(), PlayMenu.ReadyForDisplay);
    $.RegisterEventHandler("UnreadyForDisplay", $.GetContextPanel(), PlayMenu.UnreadyForDisplay);
    $.RegisterForUnhandledEvent("PanoramaComponent_Lobby_MatchmakingSessionUpdate", PlayMenu.SessionSettingsUpdate);
    $.RegisterForUnhandledEvent("CSGOHideMainMenu", PlayMenu.OnHideMainMenu);
    $.RegisterForUnhandledEvent("CSGOHidePauseMenu", PlayMenu.OnHideMainMenu);
    $.RegisterForUnhandledEvent("CSGOShowMainMenu", PlayMenu.OnShowMainMenu);
    $.RegisterForUnhandledEvent("CSGOShowPauseMenu", PlayMenu.OnShowMainMenu);
    $.RegisterForUnhandledEvent("CSGOWorkshopSubscriptionsChanged", PlayMenu.WorkshopSubscriptionsChanged);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_ClansInfoUpdated', PlayMenu.ClansInfoUpdated);
    $.RegisterForUnhandledEvent('PanoramaComponent_FriendsList_NameChanged', PlayMenu.OnPlayerNameChangedUpdate);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_PipRankUpdate', PlayMenu.PipRankUpdate);
    $.RegisterForUnhandledEvent('DirectChallenge_GenRandomKey', PlayMenu.OnDirectChallengeRandom);
    $.RegisterForUnhandledEvent('DirectChallenge_EditKey', PlayMenu.OnDirectChallengeEdit);
    $.RegisterForUnhandledEvent('DirectChallenge_CopyKey', PlayMenu.OnDirectChallengeCopy);
    $.RegisterForUnhandledEvent('DirectChallenge_ChooseClanKey', PlayMenu.OnChooseClanKeyBtn);
    $.RegisterForUnhandledEvent('DirectChallenge_ClanChallengeKeySelected', PlayMenu.OnClanChallengeKeySelected);
    $.RegisterForUnhandledEvent('PanoramaComponent_PartyBrowser_PrivateQueuesUpdate', PlayMenu.OnPrivateQueuesUpdate);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWFpbm1lbnVfcGxheS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL21haW5tZW51X3BsYXkudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUNsQyw0Q0FBNEM7QUFDNUMsa0NBQWtDO0FBQ2xDLDZDQUE2QztBQUM3Qyw4Q0FBOEM7QUFDOUMsNkNBQTZDO0FBQzdDLHVDQUF1QztBQUN2Qyw4Q0FBOEM7QUFDOUMsOENBQThDO0FBQzlDLGtEQUFrRDtBQUNsRCx5Q0FBeUM7QUFFekMsSUFBSSxRQUFRLEdBQUcsQ0FBRTtJQUVoQixNQUFNLGlCQUFpQixHQUFHLGtDQUFrQyxDQUFDO0lBQzdELElBQUksMEJBQXlDLENBQUM7SUFHOUMsTUFBTSw4QkFBOEIsR0FBb0MsRUFBRSxDQUFDO0lBRTNFLElBQUksaUJBQWlCLEdBQXVDLEVBQUUsQ0FBQztJQUUvRCxJQUFJLG1CQUFtQixHQUFjLEVBQUUsQ0FBQztJQUV4QyxJQUFJLFlBQTRDLENBQUM7SUFDakQsSUFBSSxXQUFtRCxDQUFDO0lBRXhELE1BQU0sZUFBZSxHQUFHLENBQUUsWUFBWSxDQUFDLGVBQWUsRUFBRSxLQUFLLGNBQWMsQ0FBRSxDQUFDO0lBQzlFLElBQUksZ0NBQWdDLEdBQWtCLElBQUksQ0FBQztJQUMzRCxJQUFJLGFBQWEsR0FBRyxFQUFFLENBQUM7SUFHdkIsSUFBSSxlQUFlLEdBQUcsRUFBRSxDQUFDO0lBQ3pCLElBQUksaUJBQWlCLEdBQUcsRUFBRSxDQUFDO0lBQzNCLElBQUksd0JBQXdCLEdBQWtCLElBQUksQ0FBQztJQUNuRCxJQUFJLDRCQUE0QixHQUFhLEVBQUUsQ0FBQztJQUdoRCxNQUFNLGVBQWUsR0FBZ0MsRUFBRSxDQUFDO0lBR3hELElBQUksWUFBWSxHQUFHLEtBQUssQ0FBQztJQUV6QixJQUFJLHFCQUFxQixHQUFxQixLQUFLLENBQUM7SUFHcEQsSUFBSSxjQUFjLEdB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