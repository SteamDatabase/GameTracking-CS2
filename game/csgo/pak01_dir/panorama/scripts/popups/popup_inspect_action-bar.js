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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfaW5zcGVjdF9hY3Rpb24tYmFyLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvcG9wdXBzL3BvcHVwX2luc3BlY3RfYWN0aW9uLWJhci50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBQ3JDLDBEQUEwRDtBQUMxRCxzQ0FBc0M7QUFDdEMsK0NBQStDO0FBRS9DLElBQUksZ0JBQWdCLEdBQUcsQ0FBRTtJQUd4QixJQUFJLGlCQUFpQixHQUFtQixJQUFJLENBQUM7SUFDN0MsSUFBSSxRQUFRLEdBQUcsRUFBRSxDQUFDO0lBQ2xCLElBQUksZ0JBQWdCLEdBQUcsQ0FBQyxDQUFDLENBQUM7SUFHMUIsSUFBSSxVQUFVLEdBQUcsSUFBSSxDQUFDO0lBQ3RCLElBQUksV0FBVyxHQUFHLElBQUksQ0FBQztJQUN2QixJQUFJLGdCQUFnQixHQUFHLEVBQUUsQ0FBQztJQUMxQixJQUFJLFlBQVksR0FBRyxFQUFFLENBQUM7SUFDdEIsSUFBSSxVQUFVLEdBQUcsSUFBSSxDQUFDO0lBQ3RCLElBQUksZ0JBQWdCLEdBQUcsS0FBSyxDQUFDO0lBQzdCLElBQUksZ0JBQWdCLEdBQUcsSUFBSSxDQUFDO0lBQzVCLElBQUksb0JBQW9CLEdBQUcsS0FBSyxDQUFDO0lBQ2pDLElBQUksaUJBQWlCLEdBQUcsS0FBSyxDQUFDO0lBQzlCLElBQUksWUFBWSxHQUFHLEtBQUssQ0FBQztJQUN6QixJQUFJLHlCQUF5QixHQUFrQixJQUFJLENBQUM7SUFFcEQsTUFBTSxLQUFLLEdBQUcsVUFBVyxPQUFnQixFQUFFLE1BQWMsRUFBRSxzQkFBd0UsRUFBRSx5QkFBMkUsRUFBRSxxQkFBOEI7UUFFL08sSUFBSyxzQkFBc0IsQ0FBRSxhQUFhLEVBQUUsT0FBTyxDQUFFLEtBQUssT0FBTztZQUNoRSxPQUFPO1FBRVIsT0FBTyxDQUFDLFdBQVcsQ0FBRSxRQUFRLENBQUUsQ0FB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