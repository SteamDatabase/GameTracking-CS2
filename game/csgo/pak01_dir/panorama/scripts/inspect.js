"use strict";
/// <reference path="common/characteranims.ts" />
/// <reference path="common/iteminfo.ts" />
/// <reference path="common/tint_spray_icon.ts" />
var InspectModelImage = (function () {
    let m_elPanel = null;
    let m_elContainer = null;
    let m_useAcknowledge = false;
    let m_rarityColor = '';
    let m_isStickerApplyRemove = false;
    let m_strWorkType = '';
    let m_isWorkshopPreview = false;
    let m_previousDisplayedItemId = '';
    const _Init = function (elContainer, itemId, funcGetSettingCallback) {
        const strViewFunc = funcGetSettingCallback ? funcGetSettingCallback('viewfunc', '') : '';
        m_isWorkshopPreview = funcGetSettingCallback ? funcGetSettingCallback('workshopPreview', 'false') === 'true' : false;
        m_isStickerApplyRemove = funcGetSettingCallback ? funcGetSettingCallback('stickerApplyRemove', 'false') === 'true' : false;
        if (ItemInfo.ItemDefinitionNameSubstrMatch(itemId, 'tournament_journal_'))
            itemId = (strViewFunc === 'primary') ? itemId : ItemInfo.GetFauxReplacementItemID(itemId, 'graffiti');
        if (!InventoryAPI.IsValidItemID(itemId)) {
            return '';
        }
        m_strWorkType = funcGetSettingCallback ? funcGetSettingCallback('asyncworktype', '') : '';
        m_elContainer = elContainer;
        m_useAcknowledge = m_elContainer.Data().useAcknowledge ? m_elContainer.Data().useAcknowledge : false;
        m_rarityColor = ItemInfo.GetRarityColor(itemId);
        const model = ItemInfo.GetModelPathFromJSONOrAPI(itemId);
        _InitSceneBasedOnItemType(model, itemId);
        m_previousDisplayedItemId = itemId;
        return model;
    };
    const _InitSceneBasedOnItemType = function (model, itemId) {
        if (ItemInfo.IsCharacter(itemId)) {
            m_elPanel = _InitCharScene('character', itemId);
        }
        else if (ItemInfo.GetLoadoutCategory(itemId) == "melee") {
            m_elPanel = _InitMeleeScene('melee', itemId);
        }
        else if (ItemInfo.IsWeapon(itemId)) {
            m_elPanel = _InitWeaponScene('weapon', itemId);
        }
        else if (ItemInfo.IsDisplayItem(itemId)) {
            m_elPanel = _InitDisplayScene('flair', itemId);
        }
        else if (ItemInfo.GetLoadoutCategory(itemId) == "musickit") {
            m_elPanel = _InitMusicKitScene('musickit', itemId);
        }
        else if (ItemInfo.IsSprayPaint(itemId) || ItemInfo.IsSpraySealed(itemId)) {
            m_elPanel = _InitSprayScene('spray', itemId);
        }
        else if (ItemInfo.IsCase(itemId)) {
            m_elPanel = _InitCaseScene('case', itemId);
        }
        else if (ItemInfo.ItemMatchDefName(itemId, 'name tag')) {
            m_elPanel = _InitNametagScene('nametag', itemId);
        }
        else if (ItemInfo.IsSticker(itemId) || ItemInfo.IsPatch(itemId)) {
            m_elPanel = _InitStickerScene('sticker', itemId);
        }
        else if (model) {
            if (ItemInfo.GetLoadoutCategory(itemId) === 'clothing') {
                m_elPanel = _InitGlovesScene('gloves', itemId);
            }
            else if (model.includes('models/props/crates/')) {
                m_elPanel = _InitCaseScene('case', itemId);
            }
        }
        else if (!model) {
            m_elPanel = _SetImage(itemId);
        }
        return m_elPanel;
    };
    function _InitCharScene(name, itemId, bHide = false, weaponItemId = '') {
        let elPanel = m_elContainer.FindChildTraverse('CharPreviewPanel');
        let active_item_idx = 5;
        if (!elPanel) {
            let mapName = _GetBackGroundMap();
            elPanel = $.CreatePanel('MapPlayerPreviewPanel', m_elContainer, 'CharPreviewPanel', {
                "require-composition-layer": "true",
                "pin-fov": "vertical",
                class: 'full-width full-height hidden',
                camera: 'cam_char_inspect_wide_intro',
                player: "true",
                map: mapName,
                initial_entity: 'item',
                mouse_rotate: false,
                playername: "vanity_character",
                animgraphcharactermode: "inventory-inspect",
                animgraphturns: "false",
                workshop_preview: m_isWorkshopPreview
            });
        }
        const settings = ItemInfo.GetOrUpdateVanityCharacterSettings(itemId);
        elPanel.SetActiveCharacter(active_item_idx);
        settings.panel = elPanel;
        settings.weaponItemId = weaponItemId ? weaponItemId : settings.weaponItemId ? settings.weaponItemId : '';
        CharacterAnims.PlayAnimsOnPanel(settings);
        if (m_strWorkType !== 'can_patch' && m_strWorkType !== 'remove_patch') {
            _AnimateIntroCamera(elPanel, 'char_inspect_wide', .5, false);
        }
        if (!bHide) {
            elPanel.RemoveClass('hidden');
        }
        _HidePanelItemEntities(elPanel);
        _HidePanelCharEntities(elPanel, true);
        _SetParticlesBg(elPanel);
        _SetWorkshopPreviewPanelProperties(elPanel);
        let mapName = _GetBackGroundMap();
        _SetCSMSplitPlane0DistanceOverride(elPanel, mapName);
        return elPanel;
    }
    function _SetCSMSplitPlane0DistanceOverride(elPanel, backgroundMap) {
        let flSplitPlane0Distance = 0.0;
        if (backgroundMap === 'de_ancient_vanity') {
            flSplitPlane0Distance = 180.0;
        }
        else if (backgroundMap === 'de_anubis_vanity') {
            flSplitPlane0Distance = 180.0;
        }
        else if (backgroundMap === 'de_dust2_vanity') {
            flSplitPlane0Distance = 160.0;
        }
        else if (backgroundMap === 'de_inferno_vanity') {
            flSplitPlane0Distance = 140.0;
        }
        else if (backgroundMap === 'cs_italy_vanity') {
            flSplitPlane0Distance = 200.0;
        }
        else if (backgroundMap === 'de_mirage_vanity') {
            flSplitPlane0Distance = 180.0;
        }
        else if (backgroundMap === 'de_overpass_vanity') {
            flSplitPlane0Distance = 150.0;
        }
        else if (backgroundMap === 'de_vertigo_vanity') {
            flSplitPlane0Distance = 190.0;
        }
        else if (backgroundMap === 'ui/acknowledge_item') {
            flSplitPlane0Distance = 200.0;
        }
        if (flSplitPlane0Distance > 0.0) {
            elPanel.SetCSMSplitPlane0DistanceOverride(flSplitPlane0Distance);
        }
    }
    function _InitWeaponScene(name, itemId) {
        let oSettings = {
            panel_type: "MapItemPreviewPanel",
            active_item_idx: 0,
            camera: 'cam_default',
            initial_entity: 'item',
            mouse_rotate: "true",
            rotation_limit_x: "360",
            rotation_limit_y: "90",
            auto_rotate_x: m_isStickerApplyRemove ? "2" : "35",
            auto_rotate_y: m_isStickerApplyRemove ? "3" : "10",
            auto_rotate_period_x: m_isStickerApplyRemove ? "10" : "15",
            auto_rotate_period_y: m_isStickerApplyRemove ? "10" : "25",
            auto_recenter: false,
            player: "false",
        };
        const panel = _LoadInspectMap(itemId, oSettings);
        _SetParticlesBg(panel);
        _SetItemCameraByWeaponType(itemId, panel, '', false);
        if (!m_useAcknowledge) {
            _InitCharScene(name, itemId, true);
        }
        return panel;
    }
    function _InitMeleeScene(name, itemId) {
        let oSettings = {
            panel_type: "MapItemPreviewPanel",
            active_item_idx: 8,
            camera: 'cam_melee_intro',
            initial_entity: 'item',
            mouse_rotate: "true",
            rotation_limit_x: "360",
            rotation_limit_y: "90",
            auto_rotate_x: "35",
            auto_rotate_y: "10",
            auto_rotate_period_x: "15",
            auto_rotate_period_y: "25",
            auto_recenter: false,
            player: "false",
        };
        const panel = _LoadInspectMap(itemId, oSettings);
        _SetParticlesBg(panel);
        _AnimateIntroCamera(panel, 'melee', .2, false);
        if (!m_useAcknowledge) {
            _InitCharScene(name, itemId, true);
        }
        return panel;
    }
    function _InitStickerScene(name, itemId) {
        let oSettings = {
            panel_type: "MapItemPreviewPanel",
            active_item_idx: 1,
            camera: 'cam_sticker_close_intro',
            initial_entity: 'item',
            mouse_rotate: "true",
            rotation_limit_x: "70",
            rotation_limit_y: "60",
            auto_rotate_x: "20",
            auto_rotate_y: "0",
            auto_rotate_period_x: "10",
            auto_rotate_period_y: "10",
            auto_recenter: false,
            player: "false",
        };
        const panel = _LoadInspectMap(itemId, oSettings);
        _SetParticlesBg(panel);
        _AnimateIntroCamera(panel, 'sticker_close', .2, false);
        return panel;
    }
    function _InitSprayScene(name, itemId) {
        let oSettings = {
            panel_type: "MapItemPreviewPanel",
            active_item_idx: 2,
            camera: 'camera_path_spray',
            initial_entity: 'item',
            mouse_rotate: "false",
            rotation_limit_x: "",
            rotation_limit_y: "",
            auto_rotate_x: "",
            auto_rotate_y: "",
            auto_rotate_period_x: "",
            auto_rotate_period_y: "",
            auto_recenter: false,
            player: "false",
        };
        const panel = _LoadInspectMap(itemId, oSettings);
        panel.TransitionToCamera('camera_path_spray', 0);
        return panel;
    }
    function _InitDisplayScene(name, itemId) {
        let bOverrideItem = InventoryAPI.GetItemDefinitionIndex(itemId) === 996;
        let rotationOverrideX = bOverrideItem ? "360" : "70";
        let autoRotateOverrideX = bOverrideItem ? "180" : "45";
        let autoRotateTimeOverrideX = bOverrideItem ? "100" : "20";
        let oSettings = {
            panel_type: "MapItemPreviewPanel",
            active_item_idx: 3,
            camera: 'cam_display_close_intro',
            initial_entity: 'item',
            mouse_rotate: "true",
            rotation_limit_x: rotationOverrideX,
            rotation_limit_y: "60",
            auto_rotate_x: autoRotateOverrideX,
            auto_rotate_y: "12",
            auto_rotate_period_x: autoRotateTimeOverrideX,
            auto_rotate_period_y: "20",
            auto_recenter: false,
            player: "false",
        };
        const panel = _LoadInspectMap(itemId, oSettings);
        _SetParticlesBg(panel);
        _AnimateIntroCamera(panel, 'display_close', .2, false);
        return panel;
    }
    function _InitMusicKitScene(name, itemId) {
        let oSettings = {
            panel_type: "MapItemPreviewPanel",
            active_item_idx: 4,
            camera: 'cam_musickit_intro',
            initial_entity: 'item',
            mouse_rotate: "true",
            rotation_limit_x: "55",
            rotation_limit_y: "55",
            auto_rotate_x: "10",
            auto_rotate_y: "0",
            auto_rotate_period_x: "20",
            auto_rotate_period_y: "20",
            auto_recenter: false,
            player: "false",
        };
        const panel = _LoadInspectMap(itemId, oSettings);
        _SetParticlesBg(panel);
        _AnimateIntroCamera(panel, 'musickit_close', .2, false);
        return panel;
    }
    function _InitCaseScene(name, itemId) {
        let oSettings = {
            panel_type: "MapItemPreviewPanel",
            active_item_idx: 6,
            camera: 'cam_case_intro',
            initial_entity: 'item',
            mouse_rotate: "false",
            rotation_limit_x: "",
            rotation_limit_y: "",
            auto_rotate_x: "",
            auto_rotate_y: "",
            auto_rotate_period_x: "",
            auto_rotate_period_y: "",
            auto_recenter: false,
            player: "false",
        };
        const panel = _LoadInspectMap(itemId, oSettings);
        _SetParticlesBg(panel);
        _AnimateIntroCamera(panel, 'case', .2, false);
        return panel;
    }
    function _InitGlovesScene(name, itemId) {
        let oSettings = {
            panel_type: "MapItemPreviewPanel",
            active_item_idx: 7,
            camera: 'cam_gloves',
            initial_entity: 'item',
            mouse_rotate: "false",
            rotation_limit_x: "",
            rotation_limit_y: "",
            auto_rotate_x: "",
            auto_rotate_y: "",
            auto_rotate_period_x: "",
            auto_rotate_period_y: "",
            auto_recenter: false,
            player: "false",
        };
        const panel = _LoadInspectMap(itemId, oSettings);
        _SetParticlesBg(panel);
        return panel;
    }
    function _InitNametagScene(name, itemId) {
        let oSettings = {
            panel_type: "MapItemPreviewPanel",
            active_item_idx: 1,
            camera: 'cam_nametag_close_intro',
            initial_entity: 'item',
            mouse_rotate: "true",
            rotation_limit_x: "70",
            rotation_limit_y: "60",
            auto_rotate_x: "20",
            auto_rotate_y: "0",
            auto_rotate_period_x: "10",
            auto_rotate_period_y: "10",
            auto_recenter: false,
            player: "false",
        };
        const panel = _LoadInspectMap(itemId, oSettings);
        _SetParticlesBg(panel);
        _AnimateIntroCamera(panel, 'nametag_close', .2, false);
        return panel;
    }
    function _GetBackGroundMap() {
        if (m_useAcknowledge) {
            return 'ui/acknowledge_item';
        }
        let backgroundMap = GameInterfaceAPI.GetSettingString('ui_mainmenu_bkgnd_movie');
        backgroundMap = !backgroundMap ? backgroundMap : backgroundMap + '_vanity';
        return backgroundMap;
    }
    function _LoadInspectMap(itemId, oSettings) {
        let elPanelOld = m_elContainer.FindChildTraverse('ItemPreviewPanel') || null;
        if (elPanelOld) {
            if (m_previousDisplayedItemId !== itemId) {
                elPanelOld.GetParent().Children().forEach((el) => {
                    if (el.Data().itemId !== itemId && el.id === 'ItemPreviewPanel') {
                        el.AddClass('inspect-model-image-panel--hidden');
                        el.DeleteAsync(0.25);
                    }
                });
            }
            else {
                elPanelOld.AddClass('inspect-model-image-panel--hidden');
                elPanelOld.DeleteAsync(0.25);
            }
        }
        let mapName = _GetBackGroundMap();
        let elPanel = $.CreatePanel(oSettings.panel_type, m_elContainer, 'ItemPreviewPanel', {
            "require-composition-layer": "true",
            'transparent-background': 'false',
            'disable-depth-of-field': m_useAcknowledge ? 'true' : 'false',
            "pin-fov": "vertical",
            class: 'inspect-model-image-panel inspect-model-image-panel--hidden',
            camera: oSettings.camera,
            player: "true",
            map: mapName,
            initial_entity: 'item',
            mouse_rotate: oSettings.mouse_rotate,
            rotation_limit_x: oSettings.rotation_limit_x,
            rotation_limit_y: oSettings.rotation_limit_y,
            auto_rotate_x: oSettings.auto_rotate_x,
            auto_rotate_y: oSettings.auto_rotate_y,
            auto_rotate_period_x: oSettings.auto_rotate_period_x,
            auto_rotate_period_y: oSettings.auto_rotate_period_y,
            auto_recenter: oSettings.auto_recenter,
            workshop_preview: m_isWorkshopPreview
        });
        elPanel.Data().itemId = itemId;
        elPanel.SetActiveItem(oSettings.active_item_idx);
        elPanel.SetItemItemId(itemId);
        elPanel.RemoveClass('inspect-model-image-panel--hidden');
        _HidePanelCharEntities(elPanel);
        _HideItemEntities(oSettings.active_item_idx, elPanel);
        if (mapName === 'de_nuke_vanity') {
            _SetSpotlightBrightness(elPanel);
        }
        else {
            _SetSunBrightness(elPanel);
        }
        _SetWorkshopPreviewPanelProperties(elPanel);
        return elPanel;
    }
    function _SetWorkshopPreviewPanelProperties(elItemPanel) {
        if (m_isWorkshopPreview) {
            let sTransparentBackground = InventoryAPI.GetPreviewSceneStateAttribute("transparent_background");
            let sBackgroundColor = InventoryAPI.GetPreviewSceneStateAttribute("background_color");
            if (sTransparentBackground === "1") {
                elItemPanel.SetHideStaticGeometry(true);
                elItemPanel.SetHideParticles(true);
                elItemPanel.SetTransparentBackground(true);
            }
            else if (sBackgroundColor) {
                const oColor = _HexColorToRgb(sBackgroundColor);
                elItemPanel.SetHideStaticGeometry(true);
                elItemPanel.SetHideParticles(true);
                elItemPanel.SetBackgroundColor(oColor.r, oColor.g, oColor.b, 0);
                elItemPanel.SetTransparentBackground(false);
            }
            else {
                elItemPanel.SetHideStaticGeometry(false);
                elItemPanel.SetHideParticles(false);
                elItemPanel.SetBackgroundColor(0, 0, 0, 255);
                elItemPanel.SetTransparentBackground(false);
            }
        }
    }
    ;
    function _SetItemCameraByWeaponType(itemId, elItemPanel, cameraOverride, bSkipInto) {
        if (cameraOverride) {
            elItemPanel.TransitionToCamera(cameraOverride, 1);
            return;
        }
        const category = InventoryAPI.GetLoadoutCategory(itemId);
        const defName = InventoryAPI.GetItemDefinitionName(itemId);
        var strCamera = 'wide';
        switch (category) {
            case 'secondary':
                strCamera = 'close';
                break;
            case 'smg':
                strCamera = 'mid_close';
                break;
        }
        switch (defName) {
            case 'weapon_awp':
                strCamera = 'far';
                break;
            case 'weapon_usp_silencer':
                strCamera = 'mid_close';
                break;
            case 'weapon_ssg08':
                strCamera = 'far';
                break;
            case 'weapon_galilar':
                strCamera = 'mid';
                break;
            case 'weapon_aug':
                strCamera = 'mid';
                break;
            case 'weapon_mp5sd':
                strCamera = 'mid';
                break;
            case 'weapon_m249':
                strCamera = 'far';
                break;
            case 'weapon_elite':
                strCamera = 'mid_close';
                break;
            case 'weapon_nova':
                strCamera = 'mid';
                break;
            case 'weapon_tec9':
                strCamera = 'mid_close';
                break;
            case 'weapon_ump45':
                strCamera = "mid";
                break;
            case 'weapon_bizon':
                strCamera = "mid";
                break;
            case 'weapon_mag7':
                strCamera = "mid";
                break;
            case 'weapon_c4':
                strCamera = "mid_close";
                break;
            case 'weapon_knife':
                strCamera = "mid_close";
                break;
            case 'weapon_taser':
                strCamera = "close";
                break;
        }
        _AnimateIntroCamera(elItemPanel, strCamera, .5, bSkipInto);
    }
    ;
    let m_scheduleHandle = 0;
    function _AnimateIntroCamera(elPanel, strCamera, nDelay, bSkipInto) {
        if (bSkipInto) {
            elPanel.TransitionToCamera('cam_' + strCamera, 1);
            return;
        }
        elPanel.TransitionToCamera('cam_' + strCamera + '_intro', 0);
        if (m_scheduleHandle === 0) {
            m_scheduleHandle = $.Schedule(nDelay, function () {
                if (elPanel.IsValid() && elPanel) {
                    elPanel.TransitionToCamera('cam_' + strCamera, 1.5);
                }
            });
        }
    }
    const _ResetCameraScheduleHandle = function () {
        if (m_scheduleHandle != 0) {
            $.CancelScheduled(m_scheduleHandle);
            m_scheduleHandle = 0;
        }
    };
    const _SetImage = function (itemId) {
        let elPanel = m_elContainer.FindChildTraverse('InspectItemImage');
        if (!elPanel) {
            _SetImageBackgroundMap();
            elPanel = $.CreatePanel('Panel', m_elContainer, 'InspectItemImage');
            elPanel.BLoadLayoutSnippet("snippet-image");
        }
        const elImagePanel = elPanel.FindChildTraverse('ImagePreviewPanel');
        elImagePanel.itemid = itemId;
        elImagePanel.RemoveClass('hidden');
        _TintSprayImage(itemId, elImagePanel);
        return elImagePanel;
    };
    const _SetImageBackgroundMap = function () {
        let mapName = _GetBackGroundMap();
        let elPanel = $.CreatePanel('MapPlayerPreviewPanel', m_elContainer, 'id-inspect-image-bg-map', {
            "require-composition-layer": "true",
            'transparent-background': 'false',
            'disable-depth-of-field': 'false',
            "pin-fov": "vertical",
            class: 'full-width full-height',
            camera: "cam_default",
            player: "false",
            map: mapName
        });
        _HidePanelItemEntities(elPanel);
        _HidePanelCharEntities(elPanel, false);
    };
    const _TintSprayImage = function (id, elImage) {
        TintSprayIcon.CheckIsSprayAndTint(id, elImage);
    };
    const _SetCharScene = function (elPanel, characterItemId, weaponItemId) {
        const settings = ItemInfo.GetOrUpdateVanityCharacterSettings(characterItemId);
        _InitCharScene("character", characterItemId, true, weaponItemId);
    };
    const _CancelCharAnim = function (elContainer) {
    };
    const _ShowHideItemPanel = function (bshow) {
        if (!m_elContainer.IsValid())
            return;
        const elItemPanel = m_elContainer.FindChildTraverse('ItemPreviewPanel');
        elItemPanel.SetHasClass('hidden', !bshow);
        if (bshow)
            $.DispatchEvent("CSGOPlaySoundEffect", "weapon_showSolo", "MOUSE");
    };
    const _ShowHideCharPanel = function (bshow) {
        if (!m_elContainer.IsValid())
            return;
        const elCharPanel = m_elContainer.FindChildTraverse('CharPreviewPanel');
        if (elCharPanel && elCharPanel.IsValid())
            elCharPanel.SetHasClass('hidden', !bshow);
        if (bshow)
            $.DispatchEvent("CSGOPlaySoundEffect", "weapon_showOnChar", "MOUSE");
    };
    const _GetModelPanel = function () {
        return m_elPanel;
    };
    const _UpdateModelOnly = function (itemId) {
        var elpanel = m_elPanel;
        if (elpanel && elpanel.IsValid()) {
            elpanel.SetItemItemId(itemId);
        }
    };
    const _HidePanelCharEntities = function (elPanel, bIsPlayerInspect = false) {
        elPanel.FireEntityInput('vanity_character', 'Alpha');
        elPanel.FireEntityInput('vanity_character1', 'Alpha');
        elPanel.FireEntityInput('vanity_character2', 'Alpha');
        elPanel.FireEntityInput('vanity_character3', 'Alpha');
        elPanel.FireEntityInput('vanity_character4', 'Alpha');
        if (!bIsPlayerInspect) {
            elPanel.FireEntityInput('vanity_character5', 'Alpha');
        }
    };
    const _HidePanelItemEntities = function (elPanel) {
        _HideItemEntities(-1, elPanel);
    };
    const _HideItemEntities = function (indexShow, elPanel) {
        let numItemEntitiesInMap = 8;
        for (var i = 0; i <= numItemEntitiesInMap; i++) {
            let itemIndexMod = i === 0 ? '' : i.toString();
            if (indexShow !== i) {
                elPanel.FireEntityInput('item' + itemIndexMod, 'Alpha');
                elPanel.FireEntityInput('light_item' + itemIndexMod, 'Disable');
                elPanel.FireEntityInput('light_item_new' + itemIndexMod, 'Disable');
            }
            else {
                _SetRimLight(itemIndexMod, elPanel);
            }
        }
    };
    const _SetParticlesBg = function (elPanel) {
        if (!m_useAcknowledge) {
            return;
        }
        const oColor = _HexColorToRgb(m_rarityColor);
        const sColor = `${oColor.r} ${oColor.g} ${oColor.b}`;
        elPanel.FireEntityInput('acknowledge_particle', 'SetControlPoint', '16: ' + sColor);
    };
    const _SetRimLight = function (indexShow, elPanel) {
        if (m_useAcknowledge) {
            elPanel.FireEntityInput('light_item' + indexShow, 'Disable');
            const oColor = _HexColorToRgb(m_rarityColor);
            const sColor = `${oColor.r} ${oColor.g} ${oColor.b}`;
            let lightNameInMap = "light_item_new" + indexShow;
            elPanel.FireEntityInput(lightNameInMap, 'SetColor', sColor);
        }
        else {
            elPanel.FireEntityInput('light_item_new' + indexShow, 'Disable');
        }
    };
    const _SetSunBrightness = function (elPanel) {
        elPanel.FireEntityInput('sun', 'SetLightBrightness', '1.1');
    };
    const _SetSpotlightBrightness = function (elPanel) {
        elPanel.FireEntityInput('main_light', 'SetBrightness', '1.1');
    };
    const _HexColorToRgb = (hex) => {
        const r = parseInt(hex.slice(1, 3), 16);
        const g = parseInt(hex.slice(3, 5), 16);
        const b = parseInt(hex.slice(5, 7), 16);
        return { r, g, b };
    };
    const _Refresh = function () {
        if (!m_elContainer || !m_elContainer.IsValid()) {
            return;
        }
        if (!InventoryAPI.IsValidItemID(m_previousDisplayedItemId)) {
            return;
        }
        const model = ItemInfo.GetModelPathFromJSONOrAPI(m_previousDisplayedItemId);
        _InitSceneBasedOnItemType(model, m_previousDisplayedItemId);
    };
    return {
        Init: _Init,
        SetCharScene: _SetCharScene,
        CancelCharAnim: _CancelCharAnim,
        ShowHideItemPanel: _ShowHideItemPanel,
        ShowHideCharPanel: _ShowHideCharPanel,
        GetModelPanel: _GetModelPanel,
        UpdateModelOnly: _UpdateModelOnly,
        HidePanelItemEntities: _HidePanelItemEntities,
        HidePanelCharEntities: _HidePanelCharEntities,
        SetItemCameraByWeaponType: _SetItemCameraByWeaponType,
        ResetCameraScheduleHandle: _ResetCameraScheduleHandle
    };
})();
(function () {
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5zcGVjdC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2luc3BlY3QudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGlEQUFpRDtBQUNqRCwyQ0FBMkM7QUFDM0Msa0RBQWtEO0FBRWxELElBQUksaUJBQWlCLEdBQUcsQ0FBRTtJQUV6QixJQUFJLFNBQVMsR0FBa0UsSUFBSyxDQUFDO0lBQ3JGLElBQUksYUFBYSxHQUFZLElBQUssQ0FBQztJQUNuQyxJQUFJLGdCQUFnQixHQUFZLEtBQUssQ0FBQztJQUN0QyxJQUFJLGFBQWEsR0FBVyxFQUFFLENBQUM7SUFDL0IsSUFBSSxzQkFBc0IsR0FBWSxLQUFLLENBQUM7SUFDNUMsSUFBSSxhQUFhLEdBQVcsRUFBRSxDQUFDO0lBQy9CLElBQUksbUJBQW1CLEdBQVksS0FBSyxDQUFDO0lBQ3pDLElBQUkseUJBQXlCLEdBQVcsRUFBRSxDQUFDO0lBbUIzQyxNQUFNLEtBQUssR0FBRyxVQUFXLFdBQW9CLEVBQUUsTUFBYyxFQUFFLHNCQUE0RTtRQUkxSSxNQUFNLFdBQVcsR0FBRyxzQkFBc0IsQ0FBQyxDQUFDLENBQUMsc0JBQXNCLENBQUUsVUFBVSxFQUFFLEVBQUUsQ0FBRSxDQUFDLENBQUMsQ0FBQyxFQUFFLENBQUM7UUFFM0YsbUJBQW1CLEdBQUcsc0JBQXNCLENBQUMsQ0FBQyxDQUFDLHNCQUFzQixDQUFFLGlCQUFpQixFQUFFLE9BQU8sQ0FBRSxLQUFLLE1BQU0sQ0FBQyxDQUFDLENBQUMsS0FBSyxDQUFDO1FBQ3ZILHNCQUFzQixHQUFHLHNCQUFzQixDQUFDLENBQUMsQ0FBQyxzQkFBc0IsQ0FBRSxvQkFBb0IsRUFBRSxPQUFPLENBQUUsS0FBSyxNQUFNLENBQUMsQ0FBQyxDQUFDLEtBQUssQ0FBQztRQUU3SCxJQUFLLFFBQVEsQ0FBQyw2QkFBNkIsQ0FBRSxNQUFNLEVBQUUscUJBQXFCLENBQUU7WUFDM0UsTUFB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