"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/item_context_entries.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../characterbuttons.ts" />
var InspectActionBar = (function () {
    let m_modelImagePanel = null;
    let m_itemId = '';
    let m_callbackHandle = -1;
    let m_showCert = true;
    let m_showEquip = true;
    let m_insideCasketID = '';
    let m_capability = '';
    let m_showSave = true;
    let m_showMarketLink = false;
    let m_showCharSelect = true;
    let m_blurOperationPanel = false;
    let m_previewingMusic = false;
    let m_isSelected = false;
    let m_schfnMusicMvpPreviewEnd = null;
    const _Init = function (elPanel, itemId, funcGetSettingCallback, funcGetSettingCallbackInt, elItemModelImagePanel) {
        if (funcGetSettingCallback('inspectonly', 'false') === 'false')
            return;
        elPanel.RemoveClass('hidden');
        m_modelImagePanel = elItemModelImagePanel;
        m_itemId = itemId;
        m_callbackHandle = funcGetSettingCallbackInt('callback', -1);
        m_showCert = (funcGetSettingCallback('showitemcert', 'true') === 'false');
        m_showEquip = (funcGetSettingCallback('showequip', 'true') === 'false');
        m_insideCasketID = funcGetSettingCallback('insidecasketid', '');
        m_capability = funcGetSettingCallback('capability', '');
        m_showSave = (funcGetSettingCallback('allowsave', 'true') === 'true');
        m_showMarketLink = (funcGetSettingCallback('showmarketlink', 'false') === 'true');
        m_showCharSelect = (funcGetSettingCallback('showcharselect', 'true') === 'true');
        m_isSelected = (funcGetSettingCallback('isselected', 'false') === 'true');
        m_blurOperationPanel = ($.GetContextPanel().GetAttributeString('bluroperationpanel', 'false') === 'true') ? true : false;
        _SetUpItemCertificate(elPanel, itemId);
        _SetupEquipItemBtns(elPanel, itemId);
        _ShowButtonsForWeaponInspect(elPanel, itemId);
        _ShowButtonsForCharacterInspect(elPanel, itemId);
        _SetCloseBtnAction(elPanel);
        _SetUpMarketLink(elPanel, itemId);
        const category = ItemInfo.GetLoadoutCategory(itemId);
        if (category == "musickit") {
            InventoryAPI.PlayItemPreviewMusic(itemId, '');
            m_previewingMusic = true;
            const elMusicBtn = elPanel.FindChildInLayoutFile('InspectPlayMvpBtn');
            elMusicBtn.SetHasClass('hidden', (InventoryAPI.GetItemRarity(itemId) <= 0));
        }
    };
    const _SetUpItemCertificate = function (elPanel, id) {
        const elCert = elPanel.FindChildInLayoutFile('InspectItemCert');
        if (!elCert || !elCert.IsValid()) {
            return;
        }
        const certData = InventoryAPI.GetItemCertificateInfo(id);
        if (!certData || m_showCert) {
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
        elCert.SetPanelEvent('onmouseover', function () {
            UiToolkitAPI.ShowTextTooltip('InspectItemCert', strLine);
        });
        elCert.SetPanelEvent('onmouseout', function () {
            UiToolkitAPI.HideTextTooltip();
        });
    };
    const _SetUpMarketLink = function (elPanel, id) {
        const elMarketLinkBtn = elPanel.FindChildInLayoutFile('InspectMarketLink');
        elMarketLinkBtn.SetHasClass('hidden', !m_showMarketLink);
        if (!m_showMarketLink) {
            return;
        }
        elMarketLinkBtn.SetPanelEvent('onmouseover', function () {
            UiToolkitAPI.ShowTextTooltip('InspectMarketLink', '#SFUI_Store_Market_Link');
        });
        elMarketLinkBtn.SetPanelEvent('onmouseout', function () {
            UiToolkitAPI.HideTextTooltip();
        });
        elMarketLinkBtn.SetPanelEvent('onactivate', function () {
            SteamOverlayAPI.OpenURL(ItemInfo.GetMarketLinkForLootlistItem(id));
            StoreAPI.RecordUIEvent("ViewOnMarket");
        });
    };
    const _SetupEquipItemBtns = function (elPanel, id) {
        const elMoreActionsBtn = elPanel.FindChildInLayoutFile('InspectActionsButton');
        const elSingleActionBtn = elPanel.FindChildInLayoutFile('SingleAction');
        if (m_insideCasketID) {
            elMoreActionsBtn.AddClass('hidden');
            elSingleActionBtn.RemoveClass('hidden');
            elSingleActionBtn.text = !m_isSelected ? '#UI_Select' : '#UI_Unselect';
            elSingleActionBtn.SetPanelEvent('onactivate', _OnActivateUpdateSelectionForMultiSelect.bind(undefined, id));
            return;
        }
        if (m_showEquip) {
            elMoreActionsBtn.AddClass('hidden');
            elSingleActionBtn.AddClass('hidden');
            return;
        }
        const isFanToken = ItemInfo.ItemDefinitionNameSubstrMatch(id, 'tournament_pass_');
        const isSticker = ItemInfo.ItemMatchDefName(id, 'sticker');
        const isPatch = ItemInfo.ItemMatchDefName(id, 'patch');
        const isSpraySealed = ItemInfo.IsSpraySealed(id);
        const isEquipped = (ItemInfo.IsEquippedForT(id) || ItemInfo.IsEquippedForCT(id) || ItemInfo.IsEquippedForNoTeam(id)) ? true : false;
        if (ItemInfo.IsEquippalbleButNotAWeapon(id) ||
            isSticker ||
            isSpraySealed ||
            isFanToken ||
            isPatch ||
            isEquipped) {
            elMoreActionsBtn.AddClass('hidden');
            if (!isEquipped) {
                elSingleActionBtn.RemoveClass('hidden');
                _SetUpSingleActionBtn(elPanel, id, (isSticker || isSpraySealed || isFanToken || isPatch));
            }
            return;
        }
        else {
            elMoreActionsBtn.RemoveClass('hidden');
            elSingleActionBtn.AddClass('hidden');
        }
    };
    const _SetUpSingleActionBtn = function (elPanel, id, closeInspect) {
        const validEntries = ItemContextEntires.FilterEntries('inspect');
        const elSingleActionBtn = elPanel.FindChildInLayoutFile('SingleAction');
        for (let i = 0; i < validEntries.length; i++) {
            const entry = validEntries[i];
            if (entry.AvailableForItem(id)) {
                let displayName = '';
                if (entry.name instanceof Function) {
                    displayName = entry.name(id);
                }
                else {
                    displayName = entry.name;
                }
                elSingleActionBtn.text = '#inv_context_' + displayName;
                elSingleActionBtn.SetPanelEvent('onactivate', () => _OnSingleAction(entry, id, closeInspect));
                elSingleActionBtn.RemoveClass('hidden');
            }
        }
    };
    const _OnSingleAction = function (entry, id, closeInspect) {
        if (closeInspect) {
            _CloseBtnAction();
        }
        entry.OnSelected(id);
    };
    const _OnActivateUpdateSelectionForMultiSelect = function (idSubjectItem) {
        _CloseBtnAction();
        $.DispatchEvent('UpdateSelectItemForCapabilityPopup', m_capability, idSubjectItem, !m_isSelected);
    };
    const _ShowButtonsForWeaponInspect = function (elPanel, id) {
        if (m_showCharSelect === false) {
            return;
        }
        const hasAnims = ItemInfo.IsCharacter(id) || ItemInfo.IsWeapon(id);
        if (hasAnims &&
            !ItemInfo.IsEquippalbleButNotAWeapon(id) &&
            !ItemInfo.ItemMatchDefName(id, 'sticker') &&
            !ItemInfo.IsSpraySealed(id) &&
            !ItemInfo.ItemDefinitionNameSubstrMatch(id, "tournament_journal_") &&
            !ItemInfo.ItemDefinitionNameSubstrMatch(id, "tournament_pass_")) {
            elPanel.FindChildInLayoutFile('InspectCharBtn').SetHasClass('hidden', !hasAnims);
            elPanel.FindChildInLayoutFile('InspectWeaponBtn').SetHasClass('hidden', !hasAnims);
            const list = CharacterAnims.GetValidCharacterModels(true).filter(function (entry) {
                return (ItemInfo.IsItemCt(id) && (entry.team === 'ct' || entry.team === 'any')) ||
                    (ItemInfo.IsItemT(id) && (entry.team === 't' || entry.team === 'any')) ||
                    ItemInfo.IsItemAnyTeam(id);
            });
            if (list && (list.length > 0) && !elPanel.FindChildInLayoutFile('InspectDropdownCharModels').Data().selectedId)
                _SetDropdown(elPanel, list, id);
        }
    };
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
    const _SetDropdown = function (elPanel, validEntiresList, id) {
        const currentMainMenuVanitySettings = ItemInfo.GetOrUpdateVanityCharacterSettings(ItemInfo.IsItemAnyTeam(id) ? null
            : LoadoutAPI.GetItemID(ItemInfo.IsItemCt(id) ? 'ct' : 't', 'customplayer'));
        const elDropdown = elPanel.FindChildInLayoutFile('InspectDropdownCharModels');
        validEntiresList.forEach(function (entry) {
            const rarityColor = ItemInfo.GetRarityColor(entry.itemId);
            const newEntry = $.CreatePanel('Label', elDropdown, entry.itemId, {
                'class': 'DropDownMenu',
                'html': 'true',
                'text': "<font color='" + rarityColor + "'>•</font> " + entry.label,
                'data-team': (entry.team === 'any') ? ((ItemInfo.IsItemT(id) || ItemInfo.IsItemAnyTeam(id)) ? 't' : 'ct') : entry.team
            });
            elDropdown.AddOption(newEntry);
        });
        elDropdown.SetPanelEvent('oninputsubmit', () => InspectActionBar.OnUpdateCharModel(false, elDropdown, id));
        elDropdown.SetSelected(currentMainMenuVanitySettings.charItemId);
        elDropdown.SetPanelEvent('oninputsubmit', () => InspectActionBar.OnUpdateCharModel(true, elDropdown, id));
    };
    const _OnUpdateCharModel = function (bPlaySound, elDropdown, weaponItemId) {
        const characterItemId = elDropdown.GetSelected().id;
        elDropdown.Data().selectedId = elDropdown.GetSelected().id;
        InspectModelImage.SetCharScene(m_modelImagePanel, characterItemId, weaponItemId);
    };
    const _NavigateModelPanel = function (type) {
        InspectModelImage.ShowHideItemPanel((type !== 'InspectModelChar'));
        InspectModelImage.ShowHideCharPanel((type === 'InspectModelChar'));
        $.GetContextPanel().FindChildTraverse('InspectCharModelsControls').SetHasClass('hidden', type !== 'InspectModelChar');
    };
    const _InspectPlayMusic = function (type) {
        if (!m_previewingMusic)
            return;
        if (type === 'mvp') {
            if (m_schfnMusicMvpPreviewEnd)
                return;
            InventoryAPI.StopItemPreviewMusic();
            InventoryAPI.PlayItemPreviewMusic(m_itemId, 'MVPPreview');
            m_schfnMusicMvpPreviewEnd = $.Schedule(6.8, InspectActionBar.InspectPlayMusic.bind(null, 'schfn'));
        }
        else if (type === 'schfn') {
            m_schfnMusicMvpPreviewEnd = null;
            InventoryAPI.StopItemPreviewMusic();
            InventoryAPI.PlayItemPreviewMusic(m_itemId, '');
        }
    };
    const _ShowContextMenu = function () {
        const elBtn = $.GetContextPanel().FindChildTraverse('InspectActionsButton');
        const id = m_itemId;
        const contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent(elBtn.id, '', 'file://{resources}/layout/context_menus/context_menu_inventory_item.xml', 'itemid=' + id + '&populatefiltertext=inspect', function () {
            $.DispatchEvent("CSGOPlaySoundEffect", "weapon_selectReplace", "MOUSE");
        });
        contextMenuPanel.AddClass("ContextMenu_NoArrow");
    };
    const _SetCloseBtnAction = function (elPanel) {
        const elBtn = elPanel.FindChildInLayoutFile('InspectCloseBtn');
        elBtn.SetPanelEvent('onactivate', _CloseBtnAction);
    };
    const _CloseBtnAction = function () {
        $.DispatchEvent("CSGOPlaySoundEffect", "inventory_inspect_close", "MOUSE");
        if (m_modelImagePanel && m_modelImagePanel.IsValid()) {
            InspectModelImage.CancelCharAnim(m_modelImagePanel);
        }
        $.DispatchEvent('UIPopupButtonClicked', '');
        const callbackFunc = m_callbackHandle;
        if (callbackFunc != -1) {
            UiToolkitAPI.InvokeJSCallback(callbackFunc);
        }
        if (m_blurOperationPanel) {
            $.DispatchEvent('UnblurOperationPanel');
        }
        if (m_previewingMusic) {
            InventoryAPI.StopItemPreviewMusic();
            m_previewingMusic = false;
            if (m_schfnMusicMvpPreviewEnd) {
                $.CancelScheduled(m_schfnMusicMvpPreviewEnd);
                m_schfnMusicMvpPreviewEnd = null;
            }
        }
    };
    return {
        Init: _Init,
        ShowContextMenu: _ShowContextMenu,
        CloseBtnAction: _CloseBtnAction,
        NavigateModelPanel: _NavigateModelPanel,
        InspectPlayMusic: _InspectPlayMusic,
        OnUpdateCharModel: _OnUpdateCharModel
    };
})();
(function () {
})();
