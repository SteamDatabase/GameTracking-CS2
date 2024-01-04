"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="inspect.ts" />
/// <reference path="common/iteminfo.ts" />
/// <reference path="common/tint_spray_icon.ts" />
var LoadoutGrid;
(function (LoadoutGrid) {
    let m_hasRunFirstTime = false;
    let m_equipSlotChangedHandler;
    let m_setShuffleEnabledHandler;
    let m_inventoryUpdatedHandler;
    let m_selectedTeam;
    let m_mouseOverSlot;
    let m_elDragSource;
    let m_dragItemId;
    let m_filterItemId = '';
    let m_updatedFromShowItemInLoadout = false;
    let m_currentCharId = {
        t: '',
        ct: '',
        noteam: '',
    };
    let m_currentCharGlovesId = {
        t: '',
        ct: '',
        noteam: '',
    };
    let m_currentCharWeaponId = {
        t: '',
        ct: '',
        noteam: '',
    };
    const m_arrGenericCharacterGlobalSlots = [
        { slot: 'customplayer', category: 'customplayer' },
        { slot: 'clothing_hands', category: 'clothing' },
        { slot: 'melee', category: 'melee', equip_on_hover: true },
        { slot: 'c4', category: 'c4', required_team: 't', equip_on_hover: true },
        { slot: 'musickit', category: 'musickit' },
        { slot: 'flair0', category: 'flair0' },
        { slot: 'spray0', category: 'spray' },
    ];
    function _BCanFitIntoNonWeaponSlot(category, team) {
        return m_arrGenericCharacterGlobalSlots.find((entry) => { return entry.category === category && (!entry.required_team || (entry.required_team === team)); })
            ? true
            : false;
    }
    function _BIsSlotAndTeamConfigurationValid(slot, team) {
        return m_arrGenericCharacterGlobalSlots.find((entry) => { return entry.slot === slot && entry.required_team && (entry.required_team !== team); })
            ? false
            : true;
    }
    function OnReadyForDisplay() {
        if (!m_hasRunFirstTime) {
            m_hasRunFirstTime = true;
            Init();
        }
        else {
            FillOutRowItems('ct');
            FillOutRowItems('t');
            UpdateGridFilterIcons();
            UpdateGridShuffleIcons();
            UpdateItemList();
            UpdateCharModel('ct');
            UpdateCharModel('t');
            FillOutGridItems('ct');
            FillOutGridItems('t');
            m_updatedFromShowItemInLoadout = m_updatedFromShowItemInLoadout ? false : false;
        }
        m_equipSlotChangedHandler = $.RegisterForUnhandledEvent('PanoramaComponent_Loadout_EquipSlotChanged', OnEquipSlotChanged);
        m_setShuffleEnabledHandler = $.RegisterForUnhandledEvent('PanoramaComponent_Loadout_SetShuffleEnabled', UpdateGridShuffleIcons);
        m_inventoryUpdatedHandler = $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', () => {
            UpdateItemList();
        });
    }
    LoadoutGrid.OnReadyForDisplay = OnReadyForDisplay;
    function OnUnreadyForDisplay() {
        if (m_equipSlotChangedHandler) {
            $.UnregisterForUnhandledEvent('PanoramaComponent_Loadout_EquipSlotChanged', m_equipSlotChangedHandler);
            m_equipSlotChangedHandler = null;
        }
        if (m_setShuffleEnabledHandler) {
            $.UnregisterForUnhandledEvent('PanoramaComponent_Loadout_SetShuffleEnabled', m_setShuffleEnabledHandler);
            m_setShuffleEnabledHandler = null;
        }
        if (m_inventoryUpdatedHandler) {
            $.UnregisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', m_inventoryUpdatedHandler);
            m_inventoryUpdatedHandler = null;
        }
        UiToolkitAPI.HideCustomLayoutTooltip('JsLoadoutItemTooltip');
    }
    LoadoutGrid.OnUnreadyForDisplay = OnUnreadyForDisplay;
    function OnEquipSlotChanged(team, slot, oldItemId, newItemId, bNew) {
        if (team == 't' || team == 'ct') {
            FillOutGridItems(team);
            if (['melee', 'secondary', 'smg', 'rifle', 'c4'].includes(InventoryAPI.GetLoadoutCategory(newItemId)))
                UpdateCharModel(team, newItemId);
            else
                UpdateCharModel(team);
        }
        FillOutRowItems('ct');
        FillOutRowItems('t');
        UpdateGridFilterIcons();
    }
    function Init() {
        UpdateCharModel('ct');
        UpdateCharModel('t');
        SetUpTeamSelectBtns();
        InitSortDropDown();
        UpdateGridShuffleIcons();
        $.DispatchEvent("Activated", $.GetContextPanel().FindChildInLayoutFile('id-loadout-select-team-btn-t'), "mouse");
        $.DispatchEvent("Activated", $.GetContextPanel().FindChildInLayoutFile('id-loadout-select-team-btn-ct'), "mouse");
        let elItemList = $('#id-loadout-item-list');
        elItemList.SetAttributeInt('DragScrollSpeedHorizontal', 0);
        elItemList.SetAttributeInt('DragScrollSpeedVertical', 0);
    }
    function SetUpTeamSelectBtns() {
        let aSectionSuffexes = ['ct', 't'];
        aSectionSuffexes.forEach(suffex => {
            let elSection = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-section-' + suffex);
            let elBtn = elSection.FindChildInLayoutFile('id-loadout-select-team-btn-' + suffex);
            elBtn.Data().team = suffex;
            ItemDragTargetEvents(elBtn);
            elBtn.SetPanelEvent('onactivate', ChangeSelectedTeam);
            elBtn.SetPanelEvent('onmouseover', () => { UiToolkitAPI.HideCustomLayoutTooltip('JsLoadoutItemTooltip'); });
        });
    }
    function ChangeSelectedTeam() {
        let suffex = (m_selectedTeam == 't' ? 'ct' : 't');
        let elSection = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-section-' + suffex);
        $.GetContextPanel().SetHasClass('loadout_t_selected', suffex === 't');
        elSection.FindChildInLayoutFile('id-loadout-grid-slots-' + suffex).hittest = true;
        let oppositeTeam = suffex === 't' ? 'ct' : 't';
        let elOppositeSection = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-section-' + oppositeTeam);
        elOppositeSection.FindChildInLayoutFile('id-loadout-grid-slots-' + oppositeTeam).hittest = false;
        m_selectedTeam = suffex;
        FillOutGridItems(m_selectedTeam);
        FillOutRowItems(m_selectedTeam);
        if (!_BIsSlotAndTeamConfigurationValid(GetSelectedGroup(), m_selectedTeam)) {
            let elGroupDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-group');
            elGroupDropdown.SetSelected('all');
        }
        else {
            UpdateFilters();
        }
        UiToolkitAPI.HideCustomLayoutTooltip('JsLoadoutItemTooltip');
        $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.submenu_select', 'MOUSE');
    }
    function OnActivateSideItem(slotName, TeamName) {
        if (m_selectedTeam !== TeamName) {
            ChangeSelectedTeam();
            ToggleGroupDropdown(slotName, true);
        }
        else {
            ClearItemIdFilter();
            ToggleGroupDropdown(slotName, false);
        }
    }
    function UpdateCharModel(team, weaponId = '') {
        let elPanel = $.GetContextPanel().FindChildInLayoutFile('id-loadout-agent-' + team);
        if (!elPanel)
            return;
        let charId = LoadoutAPI.GetItemID(team, 'customplayer');
        let glovesId = LoadoutAPI.GetItemID(team, 'clothing_hands');
        const settings = ItemInfo.GetOrUpdateVanityCharacterSettings(charId);
        if (team == m_selectedTeam) {
            let selectedGroup = GetSelectedGroup();
            if (['melee', 'secondary0'].includes(selectedGroup)) {
                weaponId = LoadoutAPI.GetItemID(team, selectedGroup);
            }
            else if (['secondary', 'smg', 'rifle'].includes(selectedGroup)) {
                let selectedItemDef = GetSelectedItemDef();
                if (selectedItemDef != 'all') {
                    let itemDefIndex = InventoryAPI.GetItemDefinitionIndexFromDefinitionName(selectedItemDef);
                    if (LoadoutAPI.IsItemDefEquipped(team, itemDefIndex)) {
                        let slot = LoadoutAPI.GetSlotEquippedWithDefIndex(team, itemDefIndex);
                        weaponId = LoadoutAPI.GetItemID(team, slot);
                    }
                }
            }
        }
        if (!weaponId || weaponId == '0') {
            weaponId = m_currentCharWeaponId[team];
            if (!weaponId || weaponId == '0')
                weaponId = LoadoutAPI.GetItemID(team, 'melee');
        }
        if (charId != m_currentCharId[team] || glovesId != m_currentCharGlovesId[team] || weaponId != m_currentCharWeaponId[team]) {
            m_currentCharId[team] = charId;
            m_currentCharGlovesId[team] = glovesId;
            m_currentCharWeaponId[team] = weaponId;
            settings.panel = elPanel;
            settings.weaponItemId = weaponId;
            CharacterAnims.PlayAnimsOnPanel(settings);
        }
    }
    function FillOutGridItems(team) {
        let elSection = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-section-' + team);
        let elGrid = elSection.FindChildInLayoutFile('id-loadout-grid-slots-' + team);
        elGrid.Children().forEach(column => {
            let aPanels = column.Children().filter(panel => panel.GetAttributeString('data-slot', '') !== '');
            for (let i = 0; i < aPanels.length; i++) {
                if (column.GetAttributeString('data-slot', '') === 'equipment' ||
                    column.GetAttributeString('data-slot', '') === 'grenade') {
                    UpdateSlotItemImage(team, aPanels[i], true, false, true);
                }
                else {
                    UpdateSlotItemImage(team, aPanels[i], false, true);
                    UpdateName(aPanels[i]);
                    UpdateMoney(aPanels[i], team);
                    LoadoutSlotItemTileEvents(aPanels[i]);
                    ItemDragTargetEvents(aPanels[i]);
                }
            }
        });
    }
    function FillOutRowItems(team) {
        let elSection = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-section-' + team);
        let elRow = elSection.FindChildInLayoutFile('id-loadout-row-slots-' + team);
        m_arrGenericCharacterGlobalSlots.forEach(entry => {
            if (entry.required_team && entry.required_team !== team)
                return;
            let panelId = 'id-loadout-row-slots-' + entry.slot + '-' + team;
            let elBtn = elRow.FindChild(panelId);
            if (!elBtn) {
                elBtn = $.CreatePanel('ItemImage', elRow, panelId, {
                    class: 'loadout-model-panel__slot'
                });
                elBtn.SetAttributeString('data-slot', entry.slot);
            }
            let slotName = entry.slot;
            let itemid = LoadoutAPI.GetItemID(OverrideTeam(team, slotName), slotName);
            let bUseIcon = (slotName === 'musickit' || slotName === 'spray0' || slotName === 'flair0') && itemid === '0' ? true : false;
            UpdateSlotItemImage(team, elBtn, bUseIcon, true);
            if (itemid && itemid != '0' && elBtn) {
                elBtn.SetPanelEvent('oncontextmenu', () => {
                    if (LoadoutAPI.IsShuffleEnabled(OverrideTeam(team, slotName), slotName))
                        OpenContextMenu(elBtn, 'shuffle_slot_' + team);
                    else
                        OpenContextMenu(elBtn, 'loadout_slot_' + team);
                });
                elBtn.SetPanelEvent('onmouseover', () => {
                    if (team == m_selectedTeam && entry.equip_on_hover)
                        UpdateCharModel(team, LoadoutAPI.GetItemID(team, slotName));
                    UiToolkitAPI.ShowCustomLayoutParametersTooltip(panelId, 'JsLoadoutItemTooltip', 'file://{resources}/layout/tooltips/tooltip_loadout_item.xml', 'itemid=' + elBtn.Data().itemid +
                        '&' + 'slot=' + slotName +
                        '&' + 'team=' + m_selectedTeam);
                });
                elBtn.SetPanelEvent('onmouseout', () => { UiToolkitAPI.HideCustomLayoutTooltip('JsLoadoutItemTooltip'); });
            }
            else {
                elBtn.ClearPanelEvent('oncontextmenu');
                elBtn.ClearPanelEvent('onmouseover');
                elBtn.ClearPanelEvent('onmouseout');
            }
            elBtn.SetPanelEvent('onactivate', () => OnActivateSideItem(slotName, team));
        });
    }
    function UpdateSlotItemImage(team, elPanel, bUseIcon, bReplacable, bIsEquipment = false) {
        let slot = elPanel.GetAttributeString('data-slot', '');
        team = OverrideTeam(team, slot);
        let itemImage = elPanel.FindChild('loudout-item-image-' + slot);
        let itemid = LoadoutAPI.GetItemID(team, slot);
        let elRarity = elPanel.FindChild('id-loadout-item-rarity');
        if (!itemImage) {
            itemImage = $.CreatePanel('ItemImage', elPanel, 'loudout-item-image-' + slot, {
                class: 'loadout-slot__image'
            });
            if (!bUseIcon) {
                elRarity = $.CreatePanel('Panel', elPanel, 'id-loadout-item-rarity', {
                    class: 'loadout-slot-rarity'
                });
            }
            if (bReplacable) {
                $.CreatePanel('Image', elPanel, 'id-loadout-item-filter-icon', {
                    class: 'loadout-slot-filter-icon'
                });
                let elShuffleIcon = $.CreatePanel('Image', elPanel, 'id-loadout-item-shuffle-icon', {
                    class: 'loadout-slot-shuffle-icon'
                });
                elShuffleIcon.visible = LoadoutAPI.IsShuffleEnabled(team, slot);
            }
        }
        itemImage.SetHasClass('loadout-slot__image', !bUseIcon);
        itemImage.SetHasClass('loadout-slot-svg__image', bUseIcon);
        if (!bIsEquipment) {
            TintSprayImage(itemImage, itemid);
        }
        if (bUseIcon) {
            itemImage.itemid = 0;
            itemImage.SetImage('file://{images}/icons/equipment/' + GetDefName(itemid, slot) + '.svg');
        }
        else {
            itemImage.itemid = itemid;
        }
        if (LoadoutAPI.IsShuffleEnabled(team, slot)) {
            let sShuffleIds = GetShuffleItems(team, slot);
            let elContainer = elPanel.FindChild('loudout-item-image-' + slot + '-shuffle');
            if (!elContainer) {
                elContainer = $.CreatePanel('Panel', elPanel, 'loudout-item-image-' + slot + '-shuffle', {});
            }
            sShuffleIds.forEach(element => {
                let elShufffleItem = $.CreatePanel('ItemImage', elContainer, 'loudout-item-image-' + slot, {
                    class: 'loadout-slot__image'
                });
            });
        }
        elPanel.Data().itemid = itemid;
        var color = ItemInfo.GetRarityColor(itemid);
        if (elRarity) {
            elRarity.visible = color ? true : false;
            if (color)
                elRarity.style.backgroundColor = color;
            return;
        }
    }
    function ShuffleImages() {
    }
    function TintSprayImage(itemImage, itemId) {
        TintSprayIcon.CheckIsSprayAndTint(itemId, itemImage);
    }
    ;
    function UpdateName(elPanel) {
        let elName = elPanel.FindChild('id-loadout-item-name');
        if (!elName) {
            elName = $.CreatePanel('Label', elPanel, 'id-loadout-item-name', {
                class: 'loadout-slot__name stratum-regular',
                text: '{s:item-name}'
            });
        }
        elPanel.SetDialogVariable('item-name', $.Localize(InventoryAPI.GetItemBaseName(elPanel.Data().itemid)));
    }
    function UpdateMoney(elPanel, team) {
        let elMoney = elPanel.FindChild('id-loadout-item-money');
        if (!elMoney) {
            elMoney = $.CreatePanel('Label', elPanel, 'id-loadout-item-money', {
                class: 'loadout-slot__money stratum-regular',
                text: '{d:money}'
            });
        }
        elPanel.SetDialogVariableInt('money', LoadoutAPI.GetItemGamePrice(team, elPanel.GetAttributeString('data-slot', '')));
        elMoney.text = $.Localize("#buymenu_money", elPanel);
    }
    function GetDefName(itemid, slot) {
        let defName = InventoryAPI.GetItemDefinitionName(itemid);
        let aDefName = [];
        if (slot === 'clothing_hands' || slot === 'melee' || slot === 'customplayer' || itemid === '0') {
            return slot;
        }
        else {
            aDefName = defName ? defName.split('_') : [];
            return aDefName[1];
        }
    }
    function OverrideTeam(team, slot) {
        return slot === 'musickit' || slot === 'spray0' || slot === 'flair0' ? 'noteam' : team;
    }
    function LoadoutSlotItemTileEvents(elPanel) {
        elPanel.SetPanelEvent('onactivate', () => {
            ClearItemIdFilter();
            FilterByItemType(elPanel.Data().itemid, true);
        });
        elPanel.SetPanelEvent('onmouseover', () => {
            m_mouseOverSlot = elPanel.GetAttributeString('data-slot', '');
            UpdateCharModel(m_selectedTeam, LoadoutAPI.GetItemID(m_selectedTeam, m_mouseOverSlot));
            UiToolkitAPI.ShowCustomLayoutParametersTooltip('loudout-item-image-' + m_mouseOverSlot, 'JsLoadoutItemTooltip', 'file://{resources}/layout/tooltips/tooltip_loadout_item.xml', 'itemid=' + elPanel.Data().itemid +
                '&' + 'slot=' + m_mouseOverSlot +
                '&' + 'team=' + m_selectedTeam +
                '&' + 'nameonly=' + 'true');
        });
        elPanel.SetPanelEvent('onmouseout', () => {
            m_mouseOverSlot = '';
            elPanel.SetPanelEvent('onmouseout', () => { UiToolkitAPI.HideCustomLayoutTooltip('JsLoadoutItemTooltip'); });
        });
        elPanel.SetPanelEvent('oncontextmenu', () => {
            let slot = elPanel.GetAttributeString('data-slot', '');
            if (LoadoutAPI.IsShuffleEnabled(m_selectedTeam, slot))
                OpenContextMenu(elPanel, 'shuffle_slot_' + m_selectedTeam);
            else
                OpenContextMenu(elPanel, 'loadout_slot_' + m_selectedTeam);
        });
        elPanel.SetDraggable(true);
        $.RegisterEventHandler('DragStart', elPanel, (elPanel, drag) => {
            if (m_mouseOverSlot !== null) {
                let itemid = LoadoutAPI.GetItemID(m_selectedTeam, m_mouseOverSlot);
                let bShuffle = LoadoutAPI.IsShuffleEnabled(m_selectedTeam, m_mouseOverSlot);
                OnDragStart(elPanel, drag, itemid, bShuffle);
            }
        });
        $.RegisterEventHandler('DragEnd', elPanel, (elRadial, elDragImage) => {
            OnDragEnd(elDragImage);
        });
    }
    function OpenContextMenu(elPanel, filterValue) {
        UiToolkitAPI.HideCustomLayoutTooltip('JsLoadoutItemTooltip');
        var filterForContextMenuEntries = '&populatefiltertext=' + filterValue;
        var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('', '', 'file://{resources}/layout/context_menus/context_menu_inventory_item.xml', 'itemid=' + elPanel.Data().itemid + filterForContextMenuEntries, function () {
        });
        contextMenuPanel.AddClass("ContextMenu_NoArrow");
    }
    function ItemDragTargetEvents(elPanel) {
        $.RegisterEventHandler('DragEnter', elPanel, () => {
            elPanel.AddClass('loadout-drag-enter');
            m_mouseOverSlot = elPanel.GetAttributeString('data-slot', '');
        });
        $.RegisterEventHandler('DragLeave', elPanel, () => {
            elPanel.RemoveClass('loadout-drag-enter');
            m_mouseOverSlot = '';
        });
        $.RegisterEventHandler('DragDrop', elPanel, function (dispayId, elDragImage) {
            OnDragDrop(elPanel, elDragImage);
        });
    }
    function OnDragStart(elDragSource, drag, itemid, bShuffle) {
        let elDragImage = $.CreatePanel('ItemImage', $.GetContextPanel(), '', {
            class: 'loadout-drag-icon',
            textureheight: '128',
            texturewidth: '128'
        });
        elDragImage.itemid = itemid;
        elDragImage.Data().bShuffle = bShuffle;
        TintSprayImage(elDragImage, itemid);
        drag.displayPanel = elDragImage;
        drag.offsetX = 96;
        drag.offsetY = 64;
        drag.removePositionBeforeDrop = false;
        elDragImage.AddClass('drag-start');
        m_elDragSource = elDragSource;
        m_elDragSource.AddClass('dragged-away');
        m_dragItemId = itemid;
        UpdateValidDropTargets();
        let elItemList = $('#id-loadout-item-list');
        elItemList.hittest = false;
        elItemList.hittestchildren = false;
        $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.inventory_item_pickup', 'MOUSE');
    }
    function OnDragEnd(elDragImage) {
        elDragImage.DeleteAsync(0.1);
        elDragImage.AddClass('drag-end');
        m_elDragSource.RemoveClass('dragged-away');
        m_dragItemId = '';
        UpdateValidDropTargets();
        let elItemList = $('#id-loadout-item-list');
        elItemList.hittest = true;
        elItemList.hittestchildren = true;
    }
    function OnDragDrop(elPanel, elDragImage) {
        let newSlot = elPanel.GetAttributeString('data-slot', '');
        if (newSlot !== null) {
            if (newSlot === 'side_slots' && m_selectedTeam === elPanel.GetAttributeString('data-team', '')) {
                let itemId = elDragImage.itemid;
                let bShuffle = elDragImage.Data().bShuffle;
                if (ItemInfo.ItemMatchDefName(itemId, 'spray')) {
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_capability_decodable.xml', 'key-and-case=,' + itemId +
                        '&' + 'asyncworktype=decodeable');
                }
                else {
                    let category = InventoryAPI.GetLoadoutCategory(itemId);
                    if (_BCanFitIntoNonWeaponSlot(category, m_selectedTeam)) {
                        let slot = category === 'spray' ? 'spray0' : category === 'clothing' ? 'clothing_hands' : category;
                        let team = OverrideTeam(m_selectedTeam, slot);
                        let elRow = $.GetContextPanel().FindChildInLayoutFile('id-loadout-row-slots-' + m_selectedTeam);
                        let elItemPanel = elRow.FindChildInLayoutFile('id-loadout-row-slots-' + slot + '-' + m_selectedTeam);
                        let isSameId = elDragImage.itemid === elItemPanel.Data().itemid ? true : false;
                        let equipSuccess = LoadoutAPI.EquipItemInSlot(team, itemId, slot);
                        PlayDropSounds(equipSuccess, isSameId);
                        if (equipSuccess && bShuffle) {
                            LoadoutAPI.SetShuffleEnabled(team, slot, true);
                        }
                    }
                }
                return;
            }
            let canEquip = LoadoutAPI.CanEquipItemInSlot(m_selectedTeam, elDragImage.itemid, newSlot);
            if (canEquip) {
                let itemId = elDragImage.itemid;
                let bShuffle = elDragImage.Data().bShuffle;
                if (InventoryAPI.IsValidItemID(itemId)) {
                    let itemDefIndex = InventoryAPI.GetItemDefinitionIndex(itemId);
                    let oldSlot = LoadoutAPI.GetSlotEquippedWithDefIndex(m_selectedTeam, itemDefIndex);
                    let isSameId = elDragImage.itemid === elPanel.Data().itemid ? true : false;
                    let equipSuccess = LoadoutAPI.EquipItemInSlot(m_selectedTeam, itemId, newSlot);
                    PlayDropSounds(equipSuccess, isSameId);
                    if (equipSuccess && bShuffle) {
                        LoadoutAPI.SetShuffleEnabled(m_selectedTeam, newSlot, true);
                    }
                    elPanel.TriggerClass('drop-target');
                    $.Schedule(.5, () => { if (elPanel) {
                        elPanel.RemoveClass('drop-target');
                    } });
                    elPanel.hittestchildren = false;
                    $.Schedule(1, () => { elPanel.hittestchildren = true; });
                    let oldTile = FindGridTile(oldSlot);
                    if (oldTile) {
                        oldTile.AddClass('old-item-slot');
                        $.Schedule(.5, () => { if (oldTile) {
                            oldTile.RemoveClass('old-item-slot');
                        } });
                    }
                }
            }
        }
    }
    function PlayDropSounds(equipSuccess, isSameId) {
        if (equipSuccess && !isSameId) {
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.inventory_item_putdown', 'MOUSE');
        }
        else {
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.inventory_item_notequipped', 'MOUSE');
        }
    }
    const m_aActiveUsedColumns = [
        'id-loadout-column1',
        'id-loadout-column2',
        'id-loadout-column3',
    ];
    function UpdateValidDropTargets() {
        if (m_dragItemId && InventoryAPI.IsValidItemID(m_dragItemId)) {
            let category = InventoryAPI.GetLoadoutCategory(m_dragItemId);
            if (!category || _BCanFitIntoNonWeaponSlot(category, m_selectedTeam)) {
                let elBtn = $.GetContextPanel().FindChildInLayoutFile('id-loadout-agent-' + m_selectedTeam);
                elBtn.SetHasClass('loadout-valid-target', true);
                return;
            }
        }
        let aSectionSuffexes = ['ct', 't'];
        aSectionSuffexes.forEach(suffex => {
            let elBtn = $.GetContextPanel().FindChildInLayoutFile('id-loadout-agent-' + suffex);
            elBtn.SetHasClass('loadout-valid-target', false);
        });
        let elSection = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-section-' + m_selectedTeam);
        let elGrid = elSection.FindChildInLayoutFile('id-loadout-grid-slots-' + m_selectedTeam);
        for (let columnId of m_aActiveUsedColumns) {
            let elColumn = elGrid.FindChildInLayoutFile(columnId);
            for (let elPanel of elColumn.Children()) {
                let slot = elPanel.GetAttributeString('data-slot', '');
                let canEquip = LoadoutAPI.CanEquipItemInSlot(m_selectedTeam, m_dragItemId, slot);
                elPanel.SetHasClass('loadout-valid-target', canEquip);
            }
        }
    }
    function FindGridTile(oldSlot) {
        let elGrid = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-slots-' + m_selectedTeam);
        {
            for (let columnId of m_aActiveUsedColumns) {
                let elColumn = elGrid.FindChildInLayoutFile(columnId);
                for (let elPanel of elColumn.Children()) {
                    let slot = elPanel.GetAttributeString('data-slot', '');
                    if (slot === oldSlot) {
                        return elPanel;
                    }
                }
            }
        }
        return null;
    }
    function InitSortDropDown() {
        let elDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-sort');
        let count = InventoryAPI.GetSortMethodsCount();
        for (let i = 0; i < count; i++) {
            let id = InventoryAPI.GetSortMethodByIndex(i);
            let newEntry = $.CreatePanel('Label', elDropdown, id, { class: 'DropDownMenu' });
            newEntry.text = $.Localize('#' + id);
            elDropdown.AddOption(newEntry);
        }
        elDropdown.SetSelected(GameInterfaceAPI.GetSettingString("cl_loadout_saved_sort"));
    }
    function UpdateFilters() {
        let group = GetSelectedGroup();
        if (!_BIsSlotAndTeamConfigurationValid(group, m_selectedTeam)) {
            $.DispatchEvent("Activated", $.GetContextPanel().FindChildInLayoutFile('id-loadout-select-team-btn-t'), "mouse");
            return;
        }
        let elClearBtn = $.GetContextPanel().FindChildInLayoutFile('id-loadout-clear-filters');
        elClearBtn.visible = (group != 'all' || m_filterItemId !== '');
        let itemDefNames = null;
        if (['secondary', 'smg', 'rifle'].includes(group)) {
            itemDefNames = JSON.parse(LoadoutAPI.GetGroupItemDefNames(m_selectedTeam, group));
            itemDefNames.sort();
        }
        let elItemDefDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-itemdef');
        if (itemDefNames) {
            let prevSelected = GetSelectedItemDef();
            elItemDefDropdown.RemoveAllOptions();
            {
                let elOption = $.CreatePanel('Label', elItemDefDropdown, 'all', { class: 'DropDownMenu' });
                elOption.text = $.Localize('#inv_filter_all_' + group);
                elItemDefDropdown.AddOption(elOption);
            }
            let itemDefNames = JSON.parse(LoadoutAPI.GetGroupItemDefNames(m_selectedTeam, group)).sort();
            for (let itemDefName of itemDefNames) {
                let itemDefIndex = InventoryAPI.GetItemDefinitionIndexFromDefinitionName(itemDefName);
                let itemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(itemDefIndex, 0);
                let elOption = $.CreatePanel('Label', elItemDefDropdown, itemDefName, { class: 'DropDownMenu' });
                elOption.text = $.Localize(InventoryAPI.GetItemBaseName(itemId));
                elItemDefDropdown.AddOption(elOption);
                ;
            }
            elItemDefDropdown.visible = true;
            if (elItemDefDropdown.HasOption(prevSelected))
                elItemDefDropdown.SetSelected(prevSelected);
            else
                elItemDefDropdown.SetSelected('all');
        }
        else {
            elItemDefDropdown.visible = false;
            elItemDefDropdown.SetSelected('all');
            UpdateItemList();
        }
        UpdateGridFilterIcons();
    }
    LoadoutGrid.UpdateFilters = UpdateFilters;
    function UpdateItemList() {
        let loadoutSlotParams = m_selectedTeam;
        let group = GetSelectedGroup();
        loadoutSlotParams += ',flexible_loadout_group:' + (group == 'all' ? 'any' : group);
        let elItemDefDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-itemdef');
        if (elItemDefDropdown.visible) {
            let itemDefName = GetSelectedItemDef();
            if (itemDefName != 'all')
                loadoutSlotParams += ',item_definition:' + itemDefName;
        }
        let elSortDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-sort');
        let sortType = elSortDropdown.GetSelected().id;
        if (GameInterfaceAPI.GetSettingString("cl_loadout_saved_sort") != sortType) {
            GameInterfaceAPI.SetSettingString("cl_loadout_saved_sort", sortType);
            GameInterfaceAPI.ConsoleCommand("host_writeconfig");
        }
        if (m_filterItemId !== '' &&
            InventoryAPI.IsValidItemID(m_filterItemId) &&
            group === InventoryAPI.GetRawDefinitionKey(m_filterItemId, 'flexible_loadout_group') &&
            m_updatedFromShowItemInLoadout) {
            loadoutSlotParams += ',item_id:' + m_filterItemId;
        }
        else if (m_filterItemId) {
            ClearItemIdFilter();
        }
        let elItemList = $.GetContextPanel().FindChildInLayoutFile('id-loadout-item-list');
        $.DispatchEvent('SetInventoryFilter', elItemList, 'any', 'any', 'any', sortType, loadoutSlotParams, '');
        UpdateGridFilterIcons();
        ShowHideItemFilterText(m_filterItemId != '');
    }
    LoadoutGrid.UpdateItemList = UpdateItemList;
    function ClearFilters() {
        let elGroupDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-group');
        if ($.GetContextPanel().FindChildInLayoutFile('id-loadout-clear-filters-label').visible) {
            ShowHideItemFilterText(false);
            ClearItemIdFilter();
            UpdateItemList();
            return;
        }
        elGroupDropdown.SetSelected('all');
    }
    LoadoutGrid.ClearFilters = ClearFilters;
    function ShowHideItemFilterText(bShow) {
        $.GetContextPanel().FindChildInLayoutFile('id-loadout-clear-filters-label').visible = bShow;
    }
    ;
    function FilterByItemType(itemId, bToggle = false) {
        let group = InventoryAPI.GetRawDefinitionKey(itemId, 'flexible_loadout_group');
        let elGroupDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-group');
        let elItemDefDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-itemdef');
        if (bToggle && GetSelectedGroup() == group && !elItemDefDropdown.visible) {
            elGroupDropdown.SetSelected('all');
            return;
        }
        elGroupDropdown.SetSelected(group);
        if (elItemDefDropdown.visible) {
            let itemDefName = InventoryAPI.GetItemDefinitionName(itemId);
            if (bToggle && GetSelectedItemDef() == itemDefName)
                elItemDefDropdown.SetSelected('all');
            else
                elItemDefDropdown.SetSelected(itemDefName);
        }
    }
    LoadoutGrid.FilterByItemType = FilterByItemType;
    function ToggleGroupDropdown(group, bDisallowToggle = false) {
        let elGroupDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-group');
        let elItemDefDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-itemdef');
        if (GetSelectedGroup() == group && !bDisallowToggle) {
            if (GetSelectedItemDef() != 'all')
                elItemDefDropdown.SetSelected('all');
            else
                elGroupDropdown.SetSelected('all');
        }
        else {
            elGroupDropdown.SetSelected(group);
            if (elItemDefDropdown.visible)
                elItemDefDropdown.SetSelected('all');
        }
    }
    LoadoutGrid.ToggleGroupDropdown = ToggleGroupDropdown;
    function OnItemTileLoaded(elItemTile) {
        elItemTile.SetPanelEvent('onactivate', () => { });
        elItemTile.SetDraggable(true);
        $.RegisterEventHandler('DragStart', elItemTile, (elItemTile, drag) => {
            $.DispatchEvent('CSGOInventoryHideTooltip', elItemTile);
            OnDragStart(elItemTile, drag, elItemTile.GetAttributeString('itemid', '0'), false);
        });
        $.RegisterEventHandler('DragEnd', elItemTile, (elItemTile, elDragImage) => {
            OnDragEnd(elDragImage);
        });
    }
    LoadoutGrid.OnItemTileLoaded = OnItemTileLoaded;
    function ShowLoadoutForItem(itemId) {
        if (!DoesItemTeamMatchTeamRequired(m_selectedTeam, itemId)) {
            ChangeSelectedTeam();
        }
        m_filterItemId = itemId;
        m_updatedFromShowItemInLoadout = true;
        let elClearBtn = $.GetContextPanel().FindChildInLayoutFile('id-loadout-clear-filters');
        elClearBtn.SetDialogVariable('item_name', InventoryAPI.GetItemName(m_filterItemId));
        ShowHideItemFilterText(true);
        FilterByItemType(itemId);
    }
    LoadoutGrid.ShowLoadoutForItem = ShowLoadoutForItem;
    function ClearItemIdFilter() {
        m_filterItemId = m_filterItemId !== '' ? '' : '';
    }
    function DoesItemTeamMatchTeamRequired(team, id) {
        if (team === 't') {
            return ItemInfo.IsItemT(id) || ItemInfo.IsItemAnyTeam(id);
        }
        if (team === 'ct') {
            return ItemInfo.IsItemCt(id) || ItemInfo.IsItemAnyTeam(id);
        }
        return false;
    }
    function UpdateGridFilterIcons() {
        let selectedGroup = GetSelectedGroup();
        let selectedItemDef = GetSelectedItemDef();
        let elGrid = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-slots-' + m_selectedTeam);
        if (elGrid) {
            for (let group of ['secondary0', 'secondary', 'smg', 'rifle']) {
                let btn = elGrid.FindChildInLayoutFile('id-loadout-btn-' + group);
                if (btn) {
                    btn.checked = (group == selectedGroup && (!selectedItemDef || selectedItemDef == 'all'));
                }
            }
            for (let columnId of m_aActiveUsedColumns) {
                let elColumn = elGrid.FindChildInLayoutFile(columnId);
                for (let elPanel of elColumn.Children()) {
                    let elFilterIcon = elPanel.FindChildInLayoutFile('id-loadout-item-filter-icon');
                    if (elFilterIcon) {
                        let slot = elPanel.GetAttributeString('data-slot', '');
                        let itemId = LoadoutAPI.GetItemID(m_selectedTeam, slot);
                        let itemDef = InventoryAPI.GetItemDefinitionName(itemId);
                        elFilterIcon.visible = (itemDef == selectedItemDef);
                    }
                }
            }
        }
        for (let team of ['ct', 't']) {
            let elSection = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-section-' + team);
            let elRow = elSection.FindChildInLayoutFile('id-loadout-row-slots-' + team);
            for (let elPanel of elRow.Children()) {
                let elFilterIcon = elPanel.FindChildInLayoutFile('id-loadout-item-filter-icon');
                if (elFilterIcon) {
                    if (team == m_selectedTeam) {
                        let slot = elPanel.GetAttributeString('data-slot', '');
                        elFilterIcon.visible = (slot == selectedGroup);
                    }
                    else {
                        elFilterIcon.visible = false;
                    }
                }
            }
        }
        UpdateCharModel(m_selectedTeam);
    }
    function UpdateGridShuffleIcons() {
        let elGrid = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-slots-' + m_selectedTeam);
        if (elGrid) {
            for (let columnId of m_aActiveUsedColumns) {
                let elColumn = elGrid.FindChildInLayoutFile(columnId);
                for (let elPanel of elColumn.Children()) {
                    let elShuffleIcon = elPanel.FindChildInLayoutFile('id-loadout-item-shuffle-icon');
                    if (elShuffleIcon) {
                        let slot = elPanel.GetAttributeString('data-slot', '');
                        elShuffleIcon.visible = LoadoutAPI.IsShuffleEnabled(OverrideTeam(m_selectedTeam, slot), slot);
                    }
                }
            }
        }
        for (let team of ['ct', 't']) {
            let elSection = $.GetContextPanel().FindChildInLayoutFile('id-loadout-grid-section-' + team);
            let elRow = elSection.FindChildInLayoutFile('id-loadout-row-slots-' + team);
            for (let elPanel of elRow.Children()) {
                let elShuffleIcon = elPanel.FindChildInLayoutFile('id-loadout-item-shuffle-icon');
                if (elShuffleIcon) {
                    let slot = elPanel.GetAttributeString('data-slot', '');
                    elShuffleIcon.visible = LoadoutAPI.IsShuffleEnabled(OverrideTeam(team, slot), slot);
                }
            }
        }
    }
    function GetSelectedGroup() {
        let elDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-group');
        return (elDropdown?.visible ? elDropdown.GetSelected()?.id : null) ?? 'all';
    }
    function GetSelectedItemDef() {
        let elDropdown = $.GetContextPanel().FindChildInLayoutFile('id-loadout-filter-itemdef');
        return (elDropdown?.visible ? elDropdown.GetSelected()?.id : null) ?? 'all';
    }
    function GetShuffleItems(team, slot) {
        return JSON.parse(LoadoutAPI.GetShuffleItems(team, slot));
    }
})(LoadoutGrid || (LoadoutGrid = {}));
(function () {
    $.RegisterEventHandler('ReadyForDisplay', $.GetContextPanel(), LoadoutGrid.OnReadyForDisplay);
    $.RegisterEventHandler('UnreadyForDisplay', $.GetContextPanel(), LoadoutGrid.OnUnreadyForDisplay);
    $.RegisterForUnhandledEvent('LoadoutFilterByItemType', LoadoutGrid.FilterByItemType);
    $.RegisterEventHandler('CSGOInventoryItemLoaded', $.GetContextPanel(), LoadoutGrid.OnItemTileLoaded);
    $.RegisterForUnhandledEvent('ShowLoadoutForItem', LoadoutGrid.ShowLoadoutForItem);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibG9hZG91dF9ncmlkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvbG9hZG91dF9ncmlkLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFDbEMsbUNBQW1DO0FBQ25DLDJDQUEyQztBQUMzQyxrREFBa0Q7QUFFbEQsSUFBVSxXQUFXLENBdXNDcEI7QUF2c0NELFdBQVUsV0FBVztJQUVwQixJQUFJLGlCQUFpQixHQUFHLEtBQUssQ0FBQztJQUM5QixJQUFJLHlCQUF3QyxDQUFDO0lBQzdDLElBQUksMEJBQXlDLENBQUM7SUFDOUMsSUFBSSx5QkFBd0MsQ0FBQztJQUM3QyxJQUFJLGNBQTBCLENBQUM7SUFDL0IsSUFBSSxlQUF1QixDQUFDO0lBQzVCLElBQUksY0FBdUIsQ0FBQztJQUM1QixJQUFJLFlBQW9CLENBQUM7SUFDekIsSUFBSSxjQUFjLEdBQVcsRUFBRSxDQUFDO0lBQ2hDLElBQUksOEJBQThCLEdBQVksS0FBSyxDQUFDO0lBRXBELElBQUksZUFBZSxHQUFHO1FBQ3JCLENBQUMsRUFBRSxFQUFFO1FBQ0wsRUFBRSxFQUFFLEVBQUU7UUFDTixNQUFNLEVBQUUsRUFBRTtLQUNWLENBQUM7SUFFRixJQUFJLHFCQUFxQixHQUFHO1FBQzNCLENBQUMsRUFBRSxFQUFFO1FBQ0wsRUFBRSxFQUFFLEVBQUU7UUFDTixNQUFNLEVBQUUsRUFBRTtLQUNWLENBQUM7SUFFRixJQUFJLHFCQUFxQixHQUFHO1FBQzNCLENBQUMsRUFBRSxFQUFFO1FBQ0wsRUFBRSxFQUFFLEVBQUU7UUFDTixNQUFNLEVBQUUsRUFBRTtLQUNWLENBQUM7SUFHRixNQUFNLGdDQUFnQyxHQUFHO1FBQ3hDLEVBQUUsSUFBSSxFQUFFLGNBQWMsRUFBRSxRQUFRLEVBQUUsY0FBYyxFQUFFO1FBQ2xELEVBQUUsSUFBSSxFQUFFLGdCQUFnQixFQUFFLFFBQVEsRUFBRSxVQUFVLEVBQUU7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