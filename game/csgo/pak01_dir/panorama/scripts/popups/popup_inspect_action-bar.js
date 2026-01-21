"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/item_context_entries.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../characterbuttons.ts" />
var InspectActionBar;
(function (InspectActionBar) {
    function Init() {
        const elActionBar = $.GetContextPanel().FindChildInLayoutFile('PopUpInspectActionBar');
        if (!InspectShared.GetPopupSetting('inspect_only')) {
            elActionBar.AddClass('hidden');
            return;
        }
        elActionBar.Data().schfnMusicMvpPreviewEnd = null;
        elActionBar.Data().previewingMusic = false;
        elActionBar.RemoveClass('hidden');
        elActionBar.Data().panelRegisteredForEvents = false;
        const itemId = InspectShared.GetPopupSetting('item_id');
        _SetUpItemCertificate(elActionBar, itemId);
        _SetupEquipItemBtns(elActionBar, itemId);
        _ShowButtonsForWeaponInspect(elActionBar, itemId);
        _ShowButtonsForCharacterInspect(elActionBar, itemId);
        _SetCloseBtnAction(elActionBar, $.GetContextPanel());
        _SetUpMarketLink(elActionBar, itemId);
        _SetUpOpenSeasonStatsAction(elActionBar, $.GetContextPanel(), itemId);
        _SetUpViewHighlightReelAction(elActionBar, itemId);
        if (!elActionBar.Data().panelRegisteredForEvents) {
            elActionBar.Data().panelRegisteredForEvents = true;
            $.RegisterForUnhandledEvent('PanoramaComponent_Loadout_EquipSlotChanged', () => _SetupEquipItemBtns(elActionBar, itemId));
        }
        const contentPanel = $.GetContextPanel();
        elActionBar.FindChildInLayoutFile('InspectPlayMvpBtn').SetPanelEvent('onactivate', () => InspectPlayMusic('mvp', contentPanel));
        const category = InventoryAPI.GetLoadoutCategory(itemId);
        if (category == "musickit") {
            InventoryAPI.PlayItemPreviewMusic(itemId, '');
            elActionBar.Data().previewingMusic = true;
            const elMusicBtn = elActionBar.FindChildInLayoutFile('InspectPlayMvpBtn');
            elMusicBtn.SetHasClass('hidden', (InventoryAPI.GetItemRarity(itemId) <= 0));
        }
        const bisItemInLootlist = InspectShared.GetPopupSetting('is_item_in_lootlist');
        elActionBar.FindChildInLayoutFile('InspectWeaponBtn').checked =
            (!elActionBar.FindChildInLayoutFile('InspectCharBtn').checked &&
                !elActionBar.FindChildInLayoutFile('LookatWeaponBtn').checked) ||
                bisItemInLootlist;
        if (bisItemInLootlist) {
            $.DispatchEvent("Activated", elActionBar.FindChildInLayoutFile('InspectWeaponBtn'), "mouse");
        }
    }
    InspectActionBar.Init = Init;
    function _SetUpItemCertificate(elPanel, id) {
        const elCert = elPanel.FindChildInLayoutFile('InspectItemCert');
        if (!elCert || !elCert.IsValid()) {
            return;
        }
        const certData = InventoryAPI.GetItemCertificateInfo(id);
        if (!certData || InspectShared.GetPopupSetting('hide_item_cert')) {
            elCert.visible = false;
            return;
        }
        const aCertData = certData.split("\n");
        let strLine = "";
        for (let i = 0; i < aCertData.length - 1; i++) {
            if (i % 2 == 0) {
                strLine = strLine + "<b>" + aCertData[i] + "</b>" + ": " + aCertData[i + 1] + "<br><br>";
            }
        }
        elCert.visible = true;
        elCert.SetPanelEvent('onmouseover', () => UiToolkitAPI.ShowTextTooltip('InspectItemCert', strLine));
        elCert.SetPanelEvent('onmouseout', () => UiToolkitAPI.HideTextTooltip());
    }
    function _SetUpMarketLink(elPanel, id) {
        const elMarketLinkBtn = elPanel.FindChildInLayoutFile('InspectMarketLink');
        const bMarketLink = InspectShared.GetPopupSetting('show_market_link');
        elMarketLinkBtn.SetHasClass('hidden', !bMarketLink);
        if (!bMarketLink) {
            return;
        }
        elMarketLinkBtn.SetPanelEvent('onmouseover', () => UiToolkitAPI.ShowTextTooltip('InspectMarketLink', '#SFUI_Store_Market_Link'));
        elMarketLinkBtn.SetPanelEvent('onmouseout', () => UiToolkitAPI.HideTextTooltip());
        elMarketLinkBtn.SetPanelEvent('onactivate', () => {
            SteamOverlayAPI.OpenURL(ItemInfo.GetMarketLinkForLootlistItem(id));
        });
    }
    function _SetUpOpenSeasonStatsAction(elPanel, contextPanel, id) {
        if (InspectShared.GetPopupSetting('hide_all_action_items'))
            return;
        const elOpenSeasonPanel = elPanel.FindChildInLayoutFile('OpenSeasonStats');
        if (ItemInfo.ItemDefinitionNameStartsWith(id, 'premier season coin')) {
            const season = InventoryAPI.GetItemAttributeValue(id, 'premier season');
            elOpenSeasonPanel.SetPanelEvent('onactivate', () => {
                UiToolkitAPI.ShowCustomLayoutPopupParameters('id-popup-season-stats', 'file://{resources}/layout/popups/popup_season_stats.xml', 'seasonid=' + season + '&' +
                    'itemid=' + id);
                CloseBtnAction(_GetSettingCallback(contextPanel), elPanel);
            });
            $.DispatchEvent('ContextMenuEvent', '');
            elOpenSeasonPanel.SetHasClass('hidden', false);
        }
    }
    function _SetUpViewHighlightReelAction(elPanel, id) {
        const reelId = InventoryAPI.GetItemAttributeValue(id, '{uint32}keychain slot 0 highlight');
        if (!reelId)
            return;
        const elViewHighlightReelAction = elPanel.FindChildInLayoutFile('ViewHighlightReelAction');
        elViewHighlightReelAction.SetPanelEvent('onactivate', () => {
            UiToolkitAPI.ShowCustomLayoutPopupParameters('popup-videoclip-' + reelId, 'file://{resources}/layout/popups/popup_videoclip.xml', 'reelid=' + reelId + '&' +
                'itemid=' + id);
        });
        elViewHighlightReelAction.SetHasClass('hidden', false);
    }
    function _SetupEquipItemBtns(elPanel, id) {
        const elMoreActionsBtn = elPanel.FindChildInLayoutFile('InspectActionsButton');
        const contextPanel = $.GetContextPanel();
        elMoreActionsBtn.SetPanelEvent('onactivate', () => ShowContextMenu(contextPanel));
        const elSingleActionBtn = elPanel.FindChildInLayoutFile('SingleAction');
        if (InspectShared.GetPopupSetting('is_inside_casket')) {
            elMoreActionsBtn.AddClass('hidden');
            elSingleActionBtn.RemoveClass('hidden');
            elSingleActionBtn.text = !InspectShared.GetPopupSetting('is_selected') ? '#UI_Select' : '#UI_Unselect';
            elSingleActionBtn.SetPanelEvent('onactivate', () => _OnActivateUpdateSelectionForMultiSelect(id, contextPanel));
            return;
        }
        if (InspectShared.GetPopupSetting('hide_all_action_items')) {
            elMoreActionsBtn.AddClass('hidden');
            elSingleActionBtn.AddClass('hidden');
            _TrySetUpSingleActionPreviewBtn(elPanel, id);
            return;
        }
        const isFanToken = ItemInfo.ItemDefinitionNameSubstrMatch(id, 'tournament_pass_');
        const isStickerDisplaySleeve = InventoryAPI.DoesItemMatchDefinitionByName(id, 'sticker_display_case');
        const isSticker = ItemInfo.IsSticker(id);
        const isPatch = ItemInfo.IsPatch(id);
        const isKeychain = ItemInfo.IsKeychain(id);
        const isSpraySealed = ItemInfo.IsSpraySealed(id);
        const isEquipped = InventoryAPI.IsEquipped(id, 't') || InventoryAPI.IsEquipped(id, 'ct') || InventoryAPI.IsEquipped(id, "noteam");
        let bCloseInspectOnSingleAction = (isSticker || isSpraySealed || isFanToken || isPatch || isKeychain || isStickerDisplaySleeve);
        if (ItemInfo.IsEquippalbleButNotAWeapon(id) ||
            bCloseInspectOnSingleAction ||
            isEquipped) {
            elMoreActionsBtn.AddClass('hidden');
            if (!isEquipped) {
                elSingleActionBtn.RemoveClass('hidden');
                _SetUpSingleActionBtn(elPanel, id, bCloseInspectOnSingleAction, contextPanel);
            }
            return;
        }
        else {
            elMoreActionsBtn.RemoveClass('hidden');
            elSingleActionBtn.AddClass('hidden');
        }
    }
    function _SetUpSingleActionBtn(elPanel, id, closeInspect, contextPanel) {
        const validEntries = ItemContextEntries.FilterEntries(id, 'inspect');
        const elSingleActionBtn = elPanel.FindChildInLayoutFile('SingleAction');
        for (let i = 0; i < validEntries.length; i++) {
            const entry = validEntries[i];
            let displayName = '';
            if (entry.name instanceof Function) {
                displayName = entry.name(id);
            }
            else {
                displayName = entry.name;
            }
            elSingleActionBtn.text = '#inv_context_' + displayName;
            elSingleActionBtn.SetPanelEvent('onactivate', () => _OnSingleAction(entry, id, closeInspect, contextPanel));
            elSingleActionBtn.RemoveClass('hidden');
        }
    }
    function _TrySetUpSingleActionPreviewBtn(elPanel, id) {
        const validEntries = ItemContextEntries.FilterEntries(id, 'preview');
        const elSingleActionBtn = elPanel.FindChildInLayoutFile('SingleAction');
        for (let i = 0; i < validEntries.length; i++) {
            const entry = validEntries[i];
            let displayName = '';
            if (entry.name instanceof Function) {
                displayName = entry.name(id);
            }
            else {
                displayName = entry.name;
            }
            const previewActionPrefix = displayName.startsWith('preview_') ? '' : 'preview_';
            const bisItemInLootlist = InspectShared.GetPopupSetting('is_item_in_lootlist');
            const contextPanel = $.GetContextPanel();
            elSingleActionBtn.text = '#inv_context_' + previewActionPrefix + displayName;
            elSingleActionBtn.SetPanelEvent('onactivate', () => {
                const bCloseInspect = (bisItemInLootlist && contextPanel.IsValid()) ? false : true;
                _OnSingleAction(entry, id, bCloseInspect, contextPanel);
                if (!bCloseInspect) {
                    $.DispatchEvent('BlurPopupPanel', contextPanel.id, true);
                }
            });
            elSingleActionBtn.RemoveClass('hidden');
        }
    }
    function _OnSingleAction(entry, id, closeInspect, contextPanel) {
        if (closeInspect) {
            CloseBtnAction(_GetSettingCallback(contextPanel), contextPanel);
        }
        entry.OnSelected(id);
    }
    function _OnActivateUpdateSelectionForMultiSelect(idSubjectItem, contextPanel) {
        CloseBtnAction(_GetSettingCallback(contextPanel), contextPanel);
        $.DispatchEvent('UpdateSelectItemForCapabilityPopup', InspectShared.GetPopupSetting('capability', contextPanel), idSubjectItem, !InspectShared.GetPopupSetting('is_selected', contextPanel));
    }
    function _ShowButtonsForWeaponInspect(elPanel, id) {
        const hasAnims = ItemInfo.IsCharacter(id) || ItemInfo.IsWeapon(id) || ItemInfo.IsMelee(id);
        if (InspectShared.GetPopupSetting('hide_char_select')) {
            return;
        }
        if (hasAnims &&
            !ItemInfo.IsEquippalbleButNotAWeapon(id) &&
            !ItemInfo.IsSticker(id) &&
            !ItemInfo.IsSpraySealed(id) &&
            !ItemInfo.ItemDefinitionNameSubstrMatch(id, "tournament_journal_") &&
            !ItemInfo.ItemDefinitionNameSubstrMatch(id, "tournament_pass_")) {
            elPanel.FindChildInLayoutFile('InspectCharBtn').SetHasClass('hidden', !hasAnims);
            elPanel.FindChildInLayoutFile('InspectWeaponBtn').SetHasClass('hidden', !hasAnims);
            elPanel.FindChildInLayoutFile('LookatWeaponBtn').SetHasClass('hidden', !(ItemInfo.IsWeapon(id) || ItemInfo.IsMelee(id)));
            const list = CharacterAnims.GetValidCharacterModels(true).filter((entry) => {
                return (ItemInfo.IsItemCt(id) && (entry.team === 'ct' || entry.team === 'any')) ||
                    (ItemInfo.IsItemT(id) && (entry.team === 't' || entry.team === 'any')) ||
                    ItemInfo.IsItemAnyTeam(id);
            });
            if (list && (list.length > 0) && !elPanel.FindChildInLayoutFile('InspectDropdownCharModels').Data().selectedId)
                _SetDropdown(elPanel, list, id);
        }
        elPanel.FindChildInLayoutFile('ChangeScenery').SetHasClass('hidden', ItemInfo.IsCharacter(id));
    }
    function _ShowButtonsForCharacterInspect(elPanel, id) {
        const elPreviewPanel = InspectModelImage.GetModelPanel();
        if (!ItemInfo.IsCharacter(id))
            return;
        elPanel.FindChildInLayoutFile('id-character-button-container').SetHasClass('hidden', false);
        const inspectCameraPresets = {
            "AspectRatio4x3": [16, 17],
            "AspectRatio16x9": [26, 27],
            "AspectRatio21x9": [28, 29]
        };
        let arrCameraSetToUse = inspectCameraPresets.AspectRatio4x3;
        if ($.GetContextPanel().BAscendantHasClass("AspectRatio16x9") ||
            $.GetContextPanel().BAscendantHasClass("AspectRatio16x10")) {
            arrCameraSetToUse = inspectCameraPresets.AspectRatio16x9;
        }
        else if ($.GetContextPanel().BAscendantHasClass("AspectRatio21x9")) {
            arrCameraSetToUse = inspectCameraPresets.AspectRatio21x9;
        }
        const characterToolbarButtonSettings = {
            charItemId: id,
            cameraPresetUnzoomed: arrCameraSetToUse[0],
            cameraPresetZoomed: arrCameraSetToUse[1]
        };
        const elCharacterButtons = elPanel.FindChildInLayoutFile('id-character-buttons');
        CharacterButtons.InitCharacterButtons(elCharacterButtons, elPreviewPanel, characterToolbarButtonSettings);
    }
    function _SetDropdown(elPanel, validEntiresList, id) {
        const currentMainMenuVanitySettings = ItemInfo.GetOrUpdateVanityCharacterSettings(ItemInfo.IsItemAnyTeam(id) ? null
            : LoadoutAPI.GetItemID(ItemInfo.IsItemCt(id) ? 'ct' : 't', 'customplayer'));
        const elDropdown = elPanel.FindChildInLayoutFile('InspectDropdownCharModels');
        for (let entry of validEntiresList) {
            const rarityColor = InventoryAPI.GetItemRarityColor(entry.itemId);
            const newEntry = $.CreatePanel('Label', elDropdown, entry.itemId, {
                'class': 'DropDownMenu',
                'html': 'true',
                'text': "<font color='" + rarityColor + "'>•</font> " + entry.label,
                'data-team': (entry.team === 'any') ? ((ItemInfo.IsItemT(id) || ItemInfo.IsItemAnyTeam(id)) ? 't' : 'ct') : entry.team
            });
            elDropdown.AddOption(newEntry);
        }
        const itemId = InspectShared.GetPopupSetting('item_id');
        elDropdown.SetPanelEvent('oninputsubmit', () => InspectActionBar.OnUpdateCharModel(elDropdown, itemId));
        elDropdown.SetSelected(currentMainMenuVanitySettings.charItemId);
    }
    function OnUpdateCharModel(elDropdown, weaponItemId) {
        const characterItemId = elDropdown.GetSelected().id;
        elDropdown.Data().selectedId = elDropdown.GetSelected().id;
        InspectModelImage.SetCharScene(characterItemId, weaponItemId);
    }
    InspectActionBar.OnUpdateCharModel = OnUpdateCharModel;
    function NavigateModelPanel(type, bEndWeaponLookat = true) {
        InspectModelImage.ShowHideItemPanel((type !== 'InspectModelChar'));
        InspectModelImage.ShowHideCharPanel((type === 'InspectModelChar'));
        $.GetContextPanel().FindChildTraverse('InspectCharModelsControls').SetHasClass('hidden', type !== 'InspectModelChar');
        if (bEndWeaponLookat) {
            InspectModelImage.EndWeaponLookat();
        }
        const elDesc = $.GetContextPanel().GetParent().FindChildInLayoutFile('InspectItemDesc');
        if (elDesc && elDesc.IsValid()) {
            elDesc.SetHasClass('hidden', false);
        }
    }
    InspectActionBar.NavigateModelPanel = NavigateModelPanel;
    function InspectPlayMusic(type, contentPanel) {
        const elActionBar = contentPanel.FindChildInLayoutFile('PopUpInspectActionBar');
        if (!elActionBar.Data().previewingMusic)
            return;
        const itemId = InspectShared.GetPopupSetting('item_id', contentPanel);
        if (type === 'mvp') {
            if (elActionBar.Data().schfnMusicMvpPreviewEnd)
                return;
            InventoryAPI.StopItemPreviewMusic();
            InventoryAPI.PlayItemPreviewMusic(itemId, 'MVPPreview');
            elActionBar.Data().schfnMusicMvpPreviewEnd = $.Schedule(6.8, () => InspectActionBar.InspectPlayMusic('schfn', contentPanel));
        }
        else if (type === 'schfn') {
            elActionBar.Data().schfnMusicMvpPreviewEnd = null;
            InventoryAPI.StopItemPreviewMusic();
            InventoryAPI.PlayItemPreviewMusic(itemId, '');
        }
    }
    InspectActionBar.InspectPlayMusic = InspectPlayMusic;
    function ShowContextMenu(contextPanel) {
        const elBtn = contextPanel.FindChildTraverse('InspectActionsButton');
        const id = InspectShared.GetPopupSetting('item_id', contextPanel);
        const contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent(elBtn.id, '', 'file://{resources}/layout/context_menus/context_menu_inventory_item.xml', 'itemid=' + id + '&populatefiltertext=inspect', () => $.DispatchEvent("CSGOPlaySoundEffect", "weapon_selectReplace", "MOUSE"));
        contextMenuPanel.AddClass("ContextMenu_NoArrow");
    }
    InspectActionBar.ShowContextMenu = ShowContextMenu;
    function _SetCloseBtnAction(elPanel, contextPanel) {
        const elBtn = elPanel.FindChildInLayoutFile('InspectCloseBtn');
        elBtn.SetPanelEvent('onactivate', () => CloseBtnAction(_GetSettingCallback(contextPanel), elPanel));
    }
    function _GetSettingCallback(contextPanel) {
        let callbackFromPopup = InspectShared.GetPopupSetting('callback_handle', contextPanel);
        return !callbackFromPopup ? -1 : callbackFromPopup;
    }
    function UpdateScenery() {
        UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('id-inspect-contextmenu-maps', '', 'file://{resources}/layout/context_menus/context_menu_mainmenu_vanity.xml', 'type=maps' +
            '&' + 'inspect-map=true', () => $.DispatchEvent('ContextMenuEvent', ''));
    }
    InspectActionBar.UpdateScenery = UpdateScenery;
    function LookatWeapon() {
        const bEndWeaponLookat = false;
        NavigateModelPanel('InspectModel', bEndWeaponLookat);
        const elDesc = $.GetContextPanel().GetParent().FindChildInLayoutFile('InspectItemDesc');
        if (elDesc && elDesc.IsValid()) {
            elDesc.SetHasClass('hidden', true);
        }
        InspectModelImage.StartWeaponLookat();
    }
    InspectActionBar.LookatWeapon = LookatWeapon;
    function CloseBtnAction(callbackHandle = -1, elActionBar) {
        $.DispatchEvent("CSGOPlaySoundEffect", "inventory_inspect_close", "MOUSE");
        $.DispatchEvent('UIPopupButtonClicked', '');
        if (callbackHandle != -1) {
            UiToolkitAPI.InvokeJSCallback(callbackHandle);
        }
        if (elActionBar.Data().previewingMusic) {
            InventoryAPI.StopItemPreviewMusic();
            elActionBar.Data().previewingMusic = false;
            if (elActionBar.Data().schfnMusicMvpPreviewEnd) {
                $.CancelScheduled(elActionBar.Data().schfnMusicMvpPreviewEnd);
                elActionBar.Data().schfnMusicMvpPreviewEnd = null;
            }
        }
    }
    InspectActionBar.CloseBtnAction = CloseBtnAction;
})(InspectActionBar || (InspectActionBar = {}));
