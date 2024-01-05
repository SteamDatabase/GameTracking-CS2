"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../popups/popup_capability_can_sticker.ts" />
var CanApplyPickSlot = (function () {
    let m_elItemToApply;
    const _Init = function (oSettings) {
        oSettings.infoPanel.RemoveClass('hidden');
        if (oSettings.isRemove) {
            _ShowItemIconsToRemove(oSettings);
        }
        else {
            _AddItemImage(oSettings, oSettings.toolId);
            m_elItemToApply = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons').Children()[0];
        }
        _BtnActions(oSettings);
    };
    const _ShowItemIconsToRemove = function (oSettings) {
        let slotCount = InventoryAPI.GetItemStickerSlotCount(oSettings.itemId);
        let elContainer = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons');
        elContainer.RemoveAndDeleteChildren();
        for (let i = 0; i < slotCount; i++) {
            let imagePath = InventoryAPI.GetItemStickerImageBySlot(oSettings.itemId, i);
            if (imagePath) {
                let elPatch = $.CreatePanel('RadioButton', elContainer, imagePath, { group: "remove-btns" });
                elPatch.Data().slot = i;
                elPatch.BLoadLayoutSnippet('RemoveBtn');
                let elImage = elPatch.FindChildInLayoutFile('RemoveImage');
                elImage.SetImage('file://{images}' + imagePath + '_large.png');
                elPatch.SetPanelEvent('onactivate', oSettings.funcOnSelectForRemove.bind(undefined, i));
            }
        }
    };
    const _AddItemImage = function (oSettings, itemid) {
        let elContainer = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons');
        let aItems;
        aItems = itemid.split(',');
        aItems.forEach(itemId => {
            let elImage = elContainer.FindChildInLayoutFile(itemId);
            if (!elImage) {
                let elImage = $.CreatePanel('ItemImage', elContainer, itemId);
                elImage.itemid = Number(itemId);
                elImage.AddClass('popup-can-apply-item-image');
            }
        });
    };
    const _BtnActions = function (oSettings) {
        let slotsCount = oSettings.isRemove ? InventoryAPI.GetItemStickerSlotCount(oSettings.itemId) : CanApplySlotInfo.GetEmptySlotList().length;
        let elContinueBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyContinue');
        let elNextSlotBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyNextPos');
        if (elContinueBtn)
            elContinueBtn.SetHasClass('hidden', oSettings.isRemove);
        if (elNextSlotBtn) {
            elNextSlotBtn.enabled = !(oSettings.isRemove || slotsCount == 1);
            elNextSlotBtn.SetHasClass('hidden', oSettings.isRemove);
        }
        if (oSettings.isRemove) {
            return;
        }
        if (slotsCount >= 1) {
            if (elContinueBtn)
                elContinueBtn.SetPanelEvent('onactivate', () => _OnContinue(elContinueBtn, oSettings));
            if (elNextSlotBtn)
                elNextSlotBtn.SetPanelEvent('onactivate', () => _NextSlot(elContinueBtn, oSettings));
        }
    };
    const _DisableBtns = function (elPanel) {
        elPanel.FindChildInLayoutFile('CanApplyContinue').enabled = false;
        ;
        elPanel.FindChildInLayoutFile('CanApplyNextPos').enabled = false;
    };
    const _OnContinue = function (elContinueBtn, oSettings) {
        oSettings.funcOnConfirm();
        elContinueBtn.enabled = false;
        m_elItemToApply.ToggleClass('popup-can-apply-item-image--anim');
    };
    const _NextSlot = function (elContinueBtn, oSettings) {
        CanApplySlotInfo.IncrementIndex();
        oSettings.funcOnNext(oSettings.toolId, CanApplySlotInfo.GetSelectedEmptySlot());
        let elNextSlotBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyNextPos');
        elNextSlotBtn.enabled = false;
        $.Schedule(1, () => {
            if (elNextSlotBtn && elNextSlotBtn.IsValid()) {
                elNextSlotBtn.enabled = true;
            }
        });
        elContinueBtn.enabled = true;
    };
    const _SelectFirstRemoveItem = function () {
        let elContainer = $.GetContextPanel().FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons');
        if (elContainer.Children()[0] !== undefined && elContainer.Children()[0].IsValid()) {
            $.DispatchEvent("Activated", elContainer.Children()[0], "mouse");
        }
    };
    return {
        Init: _Init,
        DisableBtns: _DisableBtns,
        SelectFirstRemoveItem: _SelectFirstRemoveItem,
        ShowItemIconsToRemove: _ShowItemIconsToRemove
    };
})();
var CanApplySlotInfo = (function () {
    let m_emptySlotList = [];
    let m_slotIndex = 0;
    const _ResetSlotIndex = function () {
        m_slotIndex = 0;
        m_emptySlotList = [];
    };
    const _UpdateEmptySlotList = function (itemId) {
        m_emptySlotList = _GetEmptySlots(_GetSlotInfo(itemId));
    };
    const _GetSlotInfo = function (itemId) {
        let aSlotInfoList = [];
        let slotsCount = InventoryAPI.GetItemStickerSlotCount(itemId);
        for (let i = 0; i < slotsCount; i++) {
            let ImagePath = InventoryAPI.GetItemStickerImageBySlot(itemId, i);
            aSlotInfoList.push({ index: i, path: !ImagePath ? 'empty' : ImagePath });
        }
        return aSlotInfoList;
    };
    const _GetEmptySlots = function (slotInfoList) {
        return slotInfoList.filter(function (slot) {
            if (slot.path === 'empty')
                return true;
        });
    };
    const _GetSelectedEmptySlot = function () {
        let emptySlotCount = m_emptySlotList.length;
        if (emptySlotCount === 0) {
            return 0;
        }
        let activeIndex = (m_slotIndex % emptySlotCount);
        return m_emptySlotList[activeIndex].index;
    };
    const _GetSelectedRemoveSlot = function () {
        let elContainer = $.GetContextPanel().FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons');
        if (elContainer.IsValid() && elContainer.Children().length > 0) {
            let aSelected = elContainer.Children().filter(entry => (entry.checked === true));
            return aSelected.length > 0 ? aSelected[0].Data().slot : 0;
        }
        return;
    };
    const _IncrementIndex = function () {
        m_slotIndex++;
    };
    const _GetIndex = function () {
        return m_slotIndex;
    };
    const _GetEmptySlotList = function () {
        return m_emptySlotList;
    };
    return {
        UpdateEmptySlotList: _UpdateEmptySlotList,
        GetEmptySlotList: _GetEmptySlotList,
        GetSelectedEmptySlot: _GetSelectedEmptySlot,
        GetSelectedRemoveSlot: _GetSelectedRemoveSlot,
        IncrementIndex: _IncrementIndex,
        GetIndex: _GetIndex,
        ResetSlotIndex: _ResetSlotIndex
    };
})();
