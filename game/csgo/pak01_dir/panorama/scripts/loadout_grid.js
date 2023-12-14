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
            UpdateItemList;
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
            else
                elBtn.SetPanelEvent('oncontextmenu', () => { });
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
        if (group != 'all')
            loadoutSlotParams += ',flexible_loadout_group:' + group;
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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibG9hZG91dF9ncmlkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvbG9hZG91dF9ncmlkLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFDbEMsbUNBQW1DO0FBQ25DLDJDQUEyQztBQUMzQyxrREFBa0Q7QUFFbEQsSUFBVSxXQUFXLENBbXNDcEI7QUFuc0NELFdBQVUsV0FBVztJQUVwQixJQUFJLGlCQUFpQixHQUFHLEtBQUssQ0FBQztJQUM5QixJQUFJLHlCQUF3QyxDQUFDO0lBQzdDLElBQUksMEJBQXlDLENBQUM7SUFDOUMsSUFBSSx5QkFBd0MsQ0FBQztJQUM3QyxJQUFJLGNBQTBCLENBQUM7SUFDL0IsSUFBSSxlQUF1QixDQUFDO0lBQzVCLElBQUksY0FBdUIsQ0FBQztJQUM1QixJQUFJLFlBQW9CLENBQUM7SUFDekIsSUFBSSxjQUFjLEdBQVcsRUFBRSxDQUFDO0lBQ2hDLElBQUksOEJBQThCLEdBQVksS0FBSyxDQUFDO0lBRXBELElBQUksZUFBZSxHQUFHO1FBQ3JCLENBQUMsRUFBRSxFQUFFO1FBQ0wsRUFBRSxFQUFFLEVBQUU7UUFDTixNQUFNLEVBQUUsRUFBRTtLQUNWLENBQUM7SUFFRixJQUFJLHFCQUFxQixHQUFHO1FBQzNCLENBQUMsRUFBRSxFQUFFO1FBQ0wsRUFBRSxFQUFFLEVBQUU7UUFDTixNQUFNLEVBQUUsRUFBRTtLQUNWLENBQUM7SUFFRixJQUFJLHFCQUFxQixHQUFHO1FBQzNCLENBQUMsRUFBRSxFQUFFO1FBQ0wsRUFBRSxFQUFFLEVBQUU7UUFDTixNQUFNLEVBQUUsRUFBRTtLQUNWLENBQUM7SUFHRixNQUFNLGdDQUFnQyxHQUFHO1FBQ3hDLEVBQUUsSUFBSSxFQUFFLGNBQWMsRUFBRSxRQUFRLEVBQUUsY0FBYyxFQUFFO1FBQ2xELEVBQUUsSUFBSSxFQUFFLGdCQUFnQixFQUFFLFFBQVEsRUFBRSxVQUFVLEVBQUU7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