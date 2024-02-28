"use strict";
/// <reference path="common/characteranims.ts" />
/// <reference path="common/iteminfo.ts" />
/// <reference path="common/tint_spray_icon.ts" />
var InspectModelImage;
(function (InspectModelImage) {
    let m_elPanel = null;
    let m_elContainer = null;
    let m_useAcknowledge = false;
    let m_rarityColor = '';
    let m_isStickerApplyRemove = false;
    let m_isItemInLootlist = false;
    let m_strWorkType = '';
    let m_isWorkshopPreview = false;
    InspectModelImage.m_CameraSettingsPerWeapon = [
        { type: 'weapon_awp', camera: '7', zoom_camera: 'weapon_awp_zoom,weapon_awp_front_zoom' },
        { type: 'weapon_aug', camera: '3', zoom_camera: 'weapon_aug_zoom' },
        { type: 'weapon_sg556', camera: '4', zoom_camera: 'weapon_ak47_zoom,weapon_ak47_front_zoom' },
        { type: 'weapon_ssg08', camera: '6', zoom_camera: 'weapon_ssg08_zoom,weapon_ssg08_front_zoom' },
        { type: 'weapon_ak47', camera: '4', zoom_camera: 'weapon_ak47_zoom,weapon_ak47_front_zoom' },
        { type: 'weapon_m4a1_silencer', camera: '6', zoom_camera: 'weapon_m4a1_silencer_zoom,weapon_m4a1_silencer_front_zoom' },
        { type: 'weapon_famas', camera: '4' },
        { type: 'weapon_g3sg1', camera: '5', zoom_camera: 'weapon_g3sg1_zoom,weapon_g3sg1_front_zoom' },
        { type: 'weapon_galilar', camera: '3', zoom_camera: 'weapon_galilar_zoom' },
        { type: 'weapon_m4a1', camera: '4', zoom_camera: 'weapon_ak47_zoom,weapon_ak47_front_zoom' },
        { type: 'weapon_scar20', camera: '5', zoom_camera: 'weapon_g3sg1_zoom,weapon_g3sg1_front_zoom' },
        { type: 'weapon_mp5sd', camera: '3' },
        { type: 'weapon_xm1014', camera: '4', zoom_camera: 'weapon_xm1014_zoom' },
        { type: 'weapon_m249', camera: '6', zoom_camera: 'weapon_m249_zoom' },
        { type: 'weapon_ump45', camera: '3' },
        { type: 'weapon_bizon', camera: '3' },
        { type: 'weapon_mag7', camera: '3' },
        { type: 'weapon_nova', camera: '5', zoom_camera: 'weapon_g3sg1_zoom,weapon_g3sg1_front_zoom' },
        { type: 'weapon_sawedoff', camera: '3' },
        { type: 'weapon_negev', camera: '5', zoom_camera: 'weapon_negev_zoom' },
        { type: 'weapon_usp_silencer', camera: '2', zoom_camera: '0' },
        { type: 'weapon_elite', camera: '2' },
        { type: 'weapon_tec9', camera: '2' },
        { type: 'weapon_revolver', camera: '1' },
        { type: 'weapon_c4', camera: '3' },
        { type: 'weapon_taser', camera: '0' },
    ];
    function Init(elContainer, itemId, funcGetSettingCallback) {
        const strViewFunc = funcGetSettingCallback ? funcGetSettingCallback('viewfunc', '') : '';
        m_isWorkshopPreview = funcGetSettingCallback ? funcGetSettingCallback('workshopPreview', 'false') === 'true' : false;
        m_isStickerApplyRemove = funcGetSettingCallback ? funcGetSettingCallback('stickerApplyRemove', 'false') === 'true' : false;
        m_isItemInLootlist = funcGetSettingCallback ? funcGetSettingCallback('isItemInLootlist', 'false') === 'true' : false;
        if (ItemInfo.ItemDefinitionNameSubstrMatch(itemId, 'tournament_journal_'))
            itemId = (strViewFunc === 'primary') ? itemId : ItemInfo.GetFauxReplacementItemID(itemId, 'graffiti');
        if (!InventoryAPI.IsValidItemID(itemId)) {
            return '';
        }
        m_strWorkType = funcGetSettingCallback ? funcGetSettingCallback('asyncworktype', '') : '';
        m_elContainer = elContainer;
        m_useAcknowledge = m_elContainer.Data().useAcknowledge ? m_elContainer.Data().useAcknowledge : false;
        m_rarityColor = InventoryAPI.GetItemRarityColor(itemId);
        const model = ItemInfo.GetModelPathFromJSONOrAPI(itemId);
        _InitSceneBasedOnItemType(model, itemId);
        return model;
    }
    InspectModelImage.Init = Init;
    function _InitSceneBasedOnItemType(model, itemId) {
        if (ItemInfo.IsCharacter(itemId)) {
            m_elPanel = _InitCharScene(itemId);
        }
        else if (InventoryAPI.GetLoadoutCategory(itemId) == "melee") {
            m_elPanel = _InitMeleeScene(itemId);
        }
        else if (ItemInfo.IsWeapon(itemId)) {
            DeleteExistingItemPanel(itemId, 'ItemPreviewPanel');
            m_elPanel = _InitWeaponScene(itemId);
        }
        else if (ItemInfo.IsDisplayItem(itemId)) {
            DeleteExistingItemPanel(itemId, 'ItemPreviewPanel');
            m_elPanel = _InitDisplayScene(itemId);
        }
        else if (InventoryAPI.GetLoadoutCategory(itemId) == "musickit") {
            m_elPanel = _InitMusicKitScene(itemId);
        }
        else if (ItemInfo.IsSprayPaint(itemId) || ItemInfo.IsSpraySealed(itemId)) {
            DeleteExistingItemPanel(itemId, 'ItemPreviewPanel');
            m_elPanel = _InitSprayScene(itemId);
        }
        else if (ItemInfo.IsCase(itemId)) {
            m_elPanel = _InitCaseScene(itemId);
        }
        else if (ItemInfo.IsNameTag(itemId)) {
            m_elPanel = _InitNametagScene(itemId);
        }
        else if (ItemInfo.IsSticker(itemId) || ItemInfo.IsPatch(itemId)) {
            DeleteExistingItemPanel(itemId, 'ItemPreviewPanel');
            m_elPanel = _InitStickerScene(itemId);
        }
        else if (model) {
            if (InventoryAPI.GetLoadoutCategory(itemId) === 'clothing') {
                m_elPanel = _InitGlovesScene(itemId);
            }
            else if (model.includes('models/props/crates/')) {
                m_elPanel = _InitCaseScene(itemId);
            }
        }
        else if (!model) {
            m_elPanel = _SetImage(itemId);
        }
        return m_elPanel;
    }
    function _InitCharScene(itemId, bHide = false, weaponItemId = '') {
        let elPanel = GetExistingItemPanel('CharPreviewPanel');
        let active_item_idx = 5;
        let mapName = _GetBackGroundMap();
        if (!elPanel) {
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
            elPanel.Data().loadedMap = mapName;
        }
        elPanel.Data().itemId = itemId;
        const settings = ItemInfo.GetOrUpdateVanityCharacterSettings(itemId);
        elPanel.SetActiveCharacter(active_item_idx);
        settings.panel = elPanel;
        settings.weaponItemId = weaponItemId ? weaponItemId : settings.weaponItemId ? settings.weaponItemId : '';
        CharacterAnims.PlayAnimsOnPanel(settings);
        if (m_strWorkType !== 'can_patch' && m_strWorkType !== 'remove_patch') {
            _TransitionCamera(elPanel, 'char_inspect_wide');
        }
        if (!bHide) {
            elPanel.RemoveClass('hidden');
        }
        _AdditionalMapLoadSettings(elPanel, active_item_idx, mapName);
        let elInspectPanel = GetExistingItemPanel('ItemPreviewPanel');
        if (elInspectPanel) {
            settings.panel = elInspectPanel;
            CharacterAnims.PlayAnimsOnPanel(settings);
        }
        return elPanel;
    }
    function StartWeaponLookat() {
        let elInspectPanel = GetExistingItemPanel('ItemPreviewPanel');
        if (elInspectPanel) {
            elInspectPanel.StartWeaponLookat();
        }
    }
    InspectModelImage.StartWeaponLookat = StartWeaponLookat;
    function EndWeaponLookat() {
        let elInspectPanel = GetExistingItemPanel('ItemPreviewPanel');
        if (elInspectPanel) {
            elInspectPanel.EndWeaponLookat();
        }
    }
    InspectModelImage.EndWeaponLookat = EndWeaponLookat;
    function _SetCSMSplitPlane0DistanceOverride(elPanel, backgroundMap) {
        let flSplitPlane0Distance = 0.0;
        if (backgroundMap === 'de_ancient_vanity') {
            flSplitPlane0Distance = 180.0;
        }
        else if (backgroundMap === 'de_anubis_vanity') {
            flSplitPlane0Distance = 180.0;
        }
        else if (backgroundMap === 'ar_baggage_vanity') {
            flSplitPlane0Distance = 200.0;
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
    function _InitWeaponScene(itemId) {
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
        SetItemCameraByWeaponType(itemId, panel, false);
        const settings = ItemInfo.GetOrUpdateVanityCharacterSettings();
        settings.panel = panel;
        settings.weaponItemId = '';
        return panel;
    }
    function _InitMeleeScene(itemId) {
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
        _TransitionCamera(panel, 'melee');
        return panel;
    }
    function _InitStickerScene(itemId) {
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
        _TransitionCamera(panel, 'sticker_close');
        return panel;
    }
    function _InitSprayScene(itemId) {
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
        _TransitionCamera(panel, 'path_spray', true, 0);
        return panel;
    }
    function _InitDisplayScene(itemId) {
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
        _TransitionCamera(panel, 'display_close');
        return panel;
    }
    function _InitMusicKitScene(itemId) {
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
        _TransitionCamera(panel, 'musickit_close');
        return panel;
    }
    function _InitCaseScene(itemId) {
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
        _TransitionCamera(panel, m_useAcknowledge ? 'case_new_item' : 'case', m_useAcknowledge ? true : false);
        return panel;
    }
    function _InitGlovesScene(itemId) {
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
        _TransitionCamera(panel, 'gloves', true);
        return panel;
    }
    function _InitNametagScene(itemId) {
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
        _TransitionCamera(panel, 'nametag_close');
        return panel;
    }
    function _GetBackGroundMap() {
        if (m_useAcknowledge) {
            return 'ui/acknowledge_item';
        }
        let backgroundMap = GameInterfaceAPI.GetSettingString('ui_inspect_bkgnd_map');
        if (backgroundMap == 'mainmenu') {
            backgroundMap = GameInterfaceAPI.GetSettingString('ui_mainmenu_bkgnd_movie');
        }
        backgroundMap = !backgroundMap ? backgroundMap : backgroundMap + '_vanity';
        return backgroundMap;
    }
    function _LoadInspectMap(itemId, oSettings) {
        let mapName = _GetBackGroundMap();
        let elPanel = GetExistingItemPanel('ItemPreviewPanel');
        if (!elPanel) {
            elPanel = $.CreatePanel(oSettings.panel_type, m_elContainer, 'ItemPreviewPanel', {
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
                workshop_preview: m_isWorkshopPreview,
                sticker_application_mode: $.GetContextPanel().GetAttributeString("asyncworktype", "") === "can_sticker",
                sticker_scrape_mode: $.GetContextPanel().GetAttributeString("asyncworktype", "") === "remove_sticker",
            });
        }
        elPanel.Data().itemId = itemId;
        elPanel.Data().active_item_idx = oSettings.active_item_idx;
        elPanel.Data().loadedMap = mapName;
        elPanel.SetActiveItem(oSettings.active_item_idx);
        elPanel.SetItemItemId(itemId);
        elPanel.RemoveClass('inspect-model-image-panel--hidden');
        _AdditionalMapLoadSettings(elPanel, oSettings.active_item_idx, mapName);
        _SetParticlesBg(elPanel);
        return elPanel;
    }
    function GetExistingItemPanel(panelId) {
        for (let elChild of m_elContainer.Children()) {
            if (elChild && elChild.IsValid() && elChild.id === panelId && !elChild.Data().bPreviousLootlistItemPanel) {
                return elChild;
            }
        }
        return null;
    }
    function DeleteExistingItemPanel(itemId, panelType) {
        let elExistingItemPanel = GetExistingItemPanel(panelType);
        if (!elExistingItemPanel)
            return;
        if (elExistingItemPanel.Data().itemId !== itemId) {
            elExistingItemPanel.Data().bPreviousLootlistItemPanel = true;
            elExistingItemPanel.AddClass('inspect-model-image-panel--hidden');
            elExistingItemPanel.DeleteAsync(.5);
        }
    }
    function _AdditionalMapLoadSettings(elPanel, active_item_idx, mapName) {
        if (elPanel.id === 'CharPreviewPanel') {
            HidePanelItemEntities(elPanel);
            _HidePanelCharEntities(elPanel, true);
            _SetCSMSplitPlane0DistanceOverride(elPanel, mapName);
        }
        else if (elPanel.id === 'id-inspect-image-bg-map') {
            HidePanelItemEntities(elPanel);
            _HidePanelCharEntities(elPanel, false);
        }
        else {
            _HidePanelCharEntities(elPanel, false);
            _HideItemEntities(active_item_idx, elPanel);
            if (mapName === 'de_nuke_vanity') {
                _SetSpotlightBrightness(elPanel);
            }
            else {
                _SetSunBrightness(elPanel);
            }
        }
        _SetWorkshopPreviewPanelProperties(elPanel);
    }
    function _SetWorkshopPreviewPanelProperties(elItemPanel) {
        if (m_isWorkshopPreview) {
            let sTransparentBackground = InventoryAPI.GetPreviewSceneStateAttribute("transparent_background");
            let sBackgroundColor = InventoryAPI.GetPreviewSceneStateAttribute("background_color");
            let sPreviewIdleAnimation = InventoryAPI.GetPreviewSceneStateAttribute("idle_animation");
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
            if (sPreviewIdleAnimation === "1") {
                elItemPanel.SetWorkshopPreviewIdleAnimation(true);
            }
            else {
                elItemPanel.SetWorkshopPreviewIdleAnimation(false);
            }
        }
    }
    function SetItemCameraByWeaponType(itemId, elItemPanel, bSkipIntro) {
        const category = InventoryAPI.GetLoadoutCategory(itemId);
        const defName = InventoryAPI.GetItemDefinitionName(itemId);
        let strCamera = '3';
        let result = InspectModelImage.m_CameraSettingsPerWeapon.find(({ type }) => type === defName);
        if (result) {
            strCamera = result.camera;
        }
        else {
            switch (category) {
                case 'secondary':
                    strCamera = '0';
                    break;
                case 'smg':
                    strCamera = '2';
                    break;
            }
        }
        _TransitionCamera(elItemPanel, strCamera, bSkipIntro);
    }
    InspectModelImage.SetItemCameraByWeaponType = SetItemCameraByWeaponType;
    let m_scheduleHandle = 0;
    function _TransitionCamera(elPanel, strCamera, bSkipIntro = false, nDuration = 0) {
        elPanel.Data().camera = strCamera;
        if (m_isWorkshopPreview) {
            elPanel.TransitionToCamera('cam_' + strCamera, 0);
            return;
        }
        if (bSkipIntro || m_isItemInLootlist) {
            elPanel.TransitionToCamera('cam_' + strCamera, nDuration);
            return;
        }
        elPanel.TransitionToCamera('cam_' + strCamera + '_intro', 0);
        if (m_scheduleHandle === 0) {
            m_scheduleHandle = $.Schedule(.25, () => {
                if (elPanel.IsValid() && elPanel) {
                    elPanel.TransitionToCamera('cam_' + strCamera, 1);
                }
            });
        }
    }
    function ZoomCamera(bZoom) {
        let elPanel = m_elPanel;
        const defName = InventoryAPI.GetItemDefinitionName(m_elPanel.Data().itemId);
        let result = InspectModelImage.m_CameraSettingsPerWeapon.find(({ type }) => type === defName);
        let strCamera = bZoom ? result?.zoom_camera : result?.camera;
        if (!strCamera || strCamera === '')
            return;
        let aCameras = strCamera.split(',');
        elPanel.SetRotation(0, 0, 1);
        _TransitionCamera(elPanel, aCameras[0], true, .75);
    }
    InspectModelImage.ZoomCamera = ZoomCamera;
    function PanCamera(bPanLeft) {
        let elPanel = m_elPanel;
        const defName = InventoryAPI.GetItemDefinitionName(elPanel.Data().itemId);
        let result = InspectModelImage.m_CameraSettingsPerWeapon.find(({ type }) => type === defName);
        let strCamera = result?.zoom_camera;
        if (!strCamera || strCamera === '')
            return;
        let aCameras = strCamera.split(',');
        let strCameraToUse = bPanLeft ? aCameras[1] : aCameras[0];
        elPanel.SetRotation(0, 0, 1);
        _TransitionCamera(elPanel, strCameraToUse, true, .75);
    }
    InspectModelImage.PanCamera = PanCamera;
    function _SetImage(itemId) {
        let elPanel = GetExistingItemPanel('InspectItemImage');
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
    }
    function _SetImageBackgroundMap() {
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
        _TransitionCamera(elPanel, "default", true, 0);
        _AdditionalMapLoadSettings(elPanel, 0, mapName);
    }
    function _TintSprayImage(id, elImage) {
        TintSprayIcon.CheckIsSprayAndTint(id, elImage);
    }
    function SetCharScene(characterItemId, weaponItemId) {
        ItemInfo.GetOrUpdateVanityCharacterSettings(characterItemId);
        _InitCharScene(characterItemId, true, weaponItemId);
    }
    InspectModelImage.SetCharScene = SetCharScene;
    function ShowHideItemPanel(bshow) {
        if (!m_elContainer.IsValid())
            return;
        const elItemPanel = GetExistingItemPanel('ItemPreviewPanel');
        elItemPanel.SetHasClass('hidden', !bshow);
        if (bshow)
            $.DispatchEvent("CSGOPlaySoundEffect", "weapon_showSolo", "MOUSE");
    }
    InspectModelImage.ShowHideItemPanel = ShowHideItemPanel;
    function ShowHideCharPanel(bshow) {
        if (!m_elContainer.IsValid())
            return;
        const elCharPanel = GetExistingItemPanel('CharPreviewPanel');
        if (elCharPanel)
            elCharPanel.SetHasClass('hidden', !bshow);
        if (bshow)
            $.DispatchEvent("CSGOPlaySoundEffect", "weapon_showOnChar", "MOUSE");
    }
    InspectModelImage.ShowHideCharPanel = ShowHideCharPanel;
    function GetModelPanel() {
        return m_elPanel;
    }
    InspectModelImage.GetModelPanel = GetModelPanel;
    function UpdateModelOnly(itemId) {
        let elpanel = m_elPanel;
        if (elpanel && elpanel.IsValid()) {
            elpanel.SetItemItemId(itemId);
        }
    }
    InspectModelImage.UpdateModelOnly = UpdateModelOnly;
    function SwitchMap(elParent) {
        for (let element of ['ItemPreviewPanel', 'CharPreviewPanel', 'id-inspect-image-bg-map']) {
            let elPanel = elParent.FindChildTraverse(element);
            if (elPanel && elPanel.IsValid()) {
                let mapName = _GetBackGroundMap();
                if (mapName !== elPanel.Data().loadedMap) {
                    elPanel.SwitchMap(mapName);
                    elPanel.Data().loadedMap = mapName;
                    _AdditionalMapLoadSettings(elPanel, elPanel.Data().active_item_idx, elPanel.Data().loadedMap);
                    if (ItemInfo.IsWeapon(elPanel.Data().itemId)) {
                        SetItemCameraByWeaponType(elPanel.Data().itemId, elPanel, true);
                    }
                    else {
                        _TransitionCamera(elPanel, elPanel.Data().camera, true);
                    }
                }
            }
        }
    }
    InspectModelImage.SwitchMap = SwitchMap;
    function _HidePanelCharEntities(elPanel, bIsPlayerInspect = false) {
        elPanel.FireEntityInput('vanity_character', 'Alpha');
        elPanel.FireEntityInput('vanity_character1', 'Alpha');
        elPanel.FireEntityInput('vanity_character2', 'Alpha');
        elPanel.FireEntityInput('vanity_character3', 'Alpha');
        elPanel.FireEntityInput('vanity_character4', 'Alpha');
        if (!bIsPlayerInspect) {
            elPanel.FireEntityInput('vanity_character5', 'Alpha');
        }
    }
    function HidePanelItemEntities(elPanel) {
        _HideItemEntities(-1, elPanel);
    }
    InspectModelImage.HidePanelItemEntities = HidePanelItemEntities;
    function _HideItemEntities(indexShow, elPanel) {
        let numItemEntitiesInMap = 8;
        for (let i = 0; i <= numItemEntitiesInMap; i++) {
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
    }
    function _SetParticlesBg(elPanel) {
        if (!m_useAcknowledge) {
            return;
        }
        const oColor = _HexColorToRgb(m_rarityColor);
        const sColor = `${oColor.r} ${oColor.g} ${oColor.b}`;
        elPanel.FireEntityInput('acknowledge_particle', 'SetControlPoint', '16: ' + sColor);
    }
    function _SetRimLight(indexShow, elPanel) {
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
    }
    function _SetSunBrightness(elPanel) {
        elPanel.FireEntityInput('sun', 'SetLightBrightness', '1.1');
    }
    function _SetSpotlightBrightness(elPanel) {
        elPanel.FireEntityInput('main_light', 'SetBrightness', '1.1');
    }
    function _HexColorToRgb(hex) {
        const r = parseInt(hex.slice(1, 3), 16);
        const g = parseInt(hex.slice(3, 5), 16);
        const b = parseInt(hex.slice(5, 7), 16);
        return { r, g, b };
    }
})(InspectModelImage || (InspectModelImage = {}));
