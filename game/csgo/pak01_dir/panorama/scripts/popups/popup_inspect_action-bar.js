"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../common/item_context_entries.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../characterbuttons.ts" />
var InspectActionBar;
(function (InspectActionBar) {
    let m_modelImagePanel = null;
    let m_itemId = '';
    let m_callbackHandle = -1;
    let m_doNotShowCert = true;
    let m_showEquip = true;
    let m_insideCasketID = '';
    let m_capability = '';
    let m_showMarketLink = false;
    let m_showCharSelect = true;
    let m_previewingMusic = false;
    let m_isSelected = false;
    let m_schfnMusicMvpPreviewEnd = null;
    let m_isItemInLootlist = false;
    function Init(elPanel, itemId, funcGetSettingCallback, funcGetSettingCallbackInt, elItemModelImagePanel) {
        if (funcGetSettingCallback('inspectonly', 'false') === 'false')
            return;
        elPanel.RemoveClass('hidden');
        m_modelImagePanel = elItemModelImagePanel;
        m_itemId = itemId;
        m_callbackHandle = funcGetSettingCallbackInt('callback', -1);
        m_doNotShowCert = (funcGetSettingCallback('showitemcert', 'true') === 'false');
        m_showEquip = (funcGetSettingCallback('showequip', 'true') === 'false');
        m_insideCasketID = funcGetSettingCallback('insidecasketid', '');
        m_capability = funcGetSettingCallback('capability', '');
        m_showMarketLink = (funcGetSettingCallback('showmarketlink', 'false') === 'true');
        m_showCharSelect = (funcGetSettingCallback('showcharselect', 'true') === 'true');
        m_isSelected = (funcGetSettingCallback('isselected', 'false') === 'true');
        m_isItemInLootlist = funcGetSettingCallback ? funcGetSettingCallback('isItemInLootlist', 'false') === 'true' : false;
        _SetUpItemCertificate(elPanel, itemId);
        _SetupEquipItemBtns(elPanel, itemId);
        _ShowButtonsForWeaponInspect(elPanel, itemId);
        _ShowButtonsForCharacterInspect(elPanel, itemId);
        _SetCloseBtnAction(elPanel);
        _SetUpMarketLink(elPanel, itemId);
        const category = InventoryAPI.GetLoadoutCategory(itemId);
        if (category == "musickit") {
            InventoryAPI.PlayItemPreviewMusic(itemId, '');
            m_previewingMusic = true;
            const elMusicBtn = elPanel.FindChildInLayoutFile('InspectPlayMvpBtn');
            elMusicBtn.SetHasClass('hidden', (InventoryAPI.GetItemRarity(itemId) <= 0));
        }
        elPanel.FindChildInLayoutFile('InspectWeaponBtn').checked =
            (!elPanel.FindChildInLayoutFile('InspectCharBtn').checked &&
                !elPanel.FindChildInLayoutFile('LookatWeaponBtn').checked) ||
                m_isItemInLootlist;
        if (m_isItemInLootlist) {
            $.DispatchEvent("Activated", elPanel.FindChildInLayoutFile('InspectWeaponBtn'), "mouse");
        }
    }
    InspectActionBar.Init = Init;
    function _SetUpItemCertificate(elPanel, id) {
        const elCert = elPanel.FindChildInLayoutFile('InspectItemCert');
        if (!elCert || !elCert.IsValid()) {
            return;
        }
        const certData = InventoryAPI.GetItemCertificateInfo(id);
        if (!certData || m_doNotShowCert) {
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
        elMarketLinkBtn.SetHasClass('hidden', !m_showMarketLink);
        if (!m_showMarketLink) {
            return;
        }
        elMarketLinkBtn.SetPanelEvent('onmouseover', () => UiToolkitAPI.ShowTextTooltip('InspectMarketLink', '#SFUI_Store_Market_Link'));
        elMarketLinkBtn.SetPanelEvent('onmouseout', () => UiToolkitAPI.HideTextTooltip());
        elMarketLinkBtn.SetPanelEvent('onactivate', () => {
            SteamOverlayAPI.OpenURL(ItemInfo.GetMarketLinkForLootlistItem(id));
            StoreAPI.RecordUIEvent("ViewOnMarket");
        });
    }
    function _SetupEquipItemBtns(elPanel, id) {
        const elMoreActionsBtn = elPanel.FindChildInLayoutFile('InspectActionsButton');
        const elSingleActionBtn = elPanel.FindChildInLayoutFile('SingleAction');
        if (m_insideCasketID) {
            elMoreActionsBtn.AddClass('hidden');
            elSingleActionBtn.RemoveClass('hidden');
            elSingleActionBtn.text = !m_isSelected ? '#UI_Select' : '#UI_Unselect';
            elSingleActionBtn.SetPanelEvent('onactivate', () => _OnActivateUpdateSelectionForMultiSelect(id));
            return;
        }
        if (m_showEquip) {
            elMoreActionsBtn.AddClass('hidden');
            elSingleActionBtn.AddClass('hidden');
            return;
        }
        const isFanToken = ItemInfo.ItemDefinitionNameSubstrMatch(id, 'tournament_pass_');
        const isSticker = ItemInfo.IsSticker(id);
        const isPatch = ItemInfo.IsPatch(id);
        const isSpraySealed = ItemInfo.IsSpraySealed(id);
        const isEquipped = InventoryAPI.IsEquipped(id, 't') || InventoryAPI.IsEquipped(id, 'ct') || InventoryAPI.IsEquipped(id, "noteam");
        let bCloseInspectOnSingleAction = (isSticker || isSpraySealed || isFanToken || isPatch);
        if (ItemInfo.IsEquippalbleButNotAWeapon(id) ||
            bCloseInspectOnSingleAction ||
            isEquipped) {
            elMoreActionsBtn.AddClass('hidden');
            if (!isEquipped) {
                elSingleActionBtn.RemoveClass('hidden');
                _SetUpSingleActionBtn(elPanel, id, bCloseInspectOnSingleAction);
            }
            return;
        }
        else {
            elMoreActionsBtn.RemoveClass('hidden');
            elSingleActionBtn.AddClass('hidden');
        }
    }
    function _SetUpSingleActionBtn(elPanel, id, closeInspect) {
        const validEntries = ItemContextEntries.FilterEntries('inspect');
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
    }
    function _OnSingleAction(entry, id, closeInspect) {
        if (closeInspect) {
            CloseBtnAction();
        }
        entry.OnSelected(id);
    }
    function _OnActivateUpdateSelectionForMultiSelect(idSubjectItem) {
        CloseBtnAction();
        $.DispatchEvent('UpdateSelectItemForCapabilityPopup', m_capability, idSubjectItem, !m_isSelected);
    }
    function _ShowButtonsForWeaponInspect(elPanel, id) {
        if (m_showCharSelect === false) {
            return;
        }
        const hasAnims = ItemInfo.IsCharacter(id) || ItemInfo.IsWeapon(id);
        if (hasAnims &&
            !ItemInfo.IsEquippalbleButNotAWeapon(id) &&
            !ItemInfo.IsSticker(id) &&
            !ItemInfo.IsSpraySealed(id) &&
            !ItemInfo.ItemDefinitionNameSubstrMatch(id, "tournament_journal_") &&
            !ItemInfo.ItemDefinitionNameSubstrMatch(id, "tournament_pass_")) {
            elPanel.FindChildInLayoutFile('InspectCharBtn').SetHasClass('hidden', !hasAnims);
            elPanel.FindChildInLayoutFile('InspectWeaponBtn').SetHasClass('hidden', !hasAnims);
            elPanel.FindChildInLayoutFile('LookatWeaponBtn').SetHasClass('hidden', !ItemInfo.IsWeapon(id));
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
        elDropdown.SetPanelEvent('oninputsubmit', () => InspectActionBar.OnUpdateCharModel(elDropdown, m_itemId));
        elDropdown.SetSelected(currentMainMenuVanitySettings.charItemId);
    }
    function OnUpdateCharModel(elDropdown, weaponItemId) {
        const characterItemId = elDropdown.GetSelected().id;
        elDropdown.Data().selectedId = elDropdown.GetSelected().id;
        InspectModelImage.SetCharScene(characterItemId, weaponItemId);
    }
    InspectActionBar.OnUpdateCharModel = OnUpdateCharModel;
    function NavigateModelPanel(type) {
        InspectModelImage.ShowHideItemPanel((type !== 'InspectModelChar'));
        InspectModelImage.ShowHideCharPanel((type === 'InspectModelChar'));
        $.GetContextPanel().FindChildTraverse('InspectCharModelsControls').SetHasClass('hidden', type !== 'InspectModelChar');
        InspectModelImage.EndWeaponLookat();
        let elDesc = $.GetContextPanel().GetParent().FindChildInLayoutFile('InspectItemDesc');
        if (elDesc && elDesc.IsValid()) {
            elDesc.SetHasClass('hidden', false);
        }
    }
    InspectActionBar.NavigateModelPanel = NavigateModelPanel;
    function InspectPlayMusic(type) {
        if (!m_previewingMusic)
            return;
        if (type === 'mvp') {
            if (m_schfnMusicMvpPreviewEnd)
                return;
            InventoryAPI.StopItemPreviewMusic();
            InventoryAPI.PlayItemPreviewMusic(m_itemId, 'MVPPreview');
            m_schfnMusicMvpPreviewEnd = $.Schedule(6.8, () => InspectActionBar.InspectPlayMusic('schfn'));
        }
        else if (type === 'schfn') {
            m_schfnMusicMvpPreviewEnd = null;
            InventoryAPI.StopItemPreviewMusic();
            InventoryAPI.PlayItemPreviewMusic(m_itemId, '');
        }
    }
    InspectActionBar.InspectPlayMusic = InspectPlayMusic;
    function ShowContextMenu() {
        const elBtn = $.GetContextPanel().FindChildTraverse('InspectActionsButton');
        const id = m_itemId;
        const contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent(elBtn.id, '', 'file://{resources}/layout/context_menus/context_menu_inventory_item.xml', 'itemid=' + id + '&populatefiltertext=inspect', () => $.DispatchEvent("CSGOPlaySoundEffect", "weapon_selectReplace", "MOUSE"));
        contextMenuPanel.AddClass("ContextMenu_NoArrow");
    }
    InspectActionBar.ShowContextMenu = ShowContextMenu;
    function _SetCloseBtnAction(elPanel) {
        const elBtn = elPanel.FindChildInLayoutFile('InspectCloseBtn');
        elBtn.SetPanelEvent('onactivate', CloseBtnAction);
    }
    function UpdateScenery() {
        UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('id-inspect-contextmenu-maps', '', 'file://{resources}/layout/context_menus/context_menu_mainmenu_vanity.xml', 'type=maps' +
            '&' + 'inspect-map=true', () => $.DispatchEvent('ContextMenuEvent', ''));
    }
    InspectActionBar.UpdateScenery = UpdateScenery;
    function LookatWeapon() {
        NavigateModelPanel('InspectModel');
        let elDesc = $.GetContextPanel().GetParent().FindChildInLayoutFile('InspectItemDesc');
        if (elDesc && elDesc.IsValid()) {
            elDesc.SetHasClass('hidden', true);
        }
        InspectModelImage.StartWeaponLookat();
    }
    InspectActionBar.LookatWeapon = LookatWeapon;
    function CloseBtnAction() {
        $.DispatchEvent("CSGOPlaySoundEffect", "inventory_inspect_close", "MOUSE");
        $.DispatchEvent('UIPopupButtonClicked', '');
        const callbackFunc = m_callbackHandle;
        if (callbackFunc != -1) {
            UiToolkitAPI.InvokeJSCallback(callbackFunc);
        }
        if (m_previewingMusic) {
            InventoryAPI.StopItemPreviewMusic();
            m_previewingMusic = false;
            if (m_schfnMusicMvpPreviewEnd) {
                $.CancelScheduled(m_schfnMusicMvpPreviewEnd);
                m_schfnMusicMvpPreviewEnd = null;
            }
        }
    }
    InspectActionBar.CloseBtnAction = CloseBtnAction;
    function fnItemSelected(itemid) {
    }
    function SelectItemPopup() {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('Inspect_SelectItem', 'file://{resources}/layout/popups/popup_select_inventory_item.xml', 'associated_item=' + m_itemId +
            '&filter_category=can_sticker:' + m_itemId);
    }
    InspectActionBar.SelectItemPopup = SelectItemPopup;
    {
        $.RegisterForUnhandledEvent("OnInventoryItemSelected", fnItemSelected);
    }
})(InspectActionBar || (InspectActionBar = {}));
