"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../popups/popup_capability_can_sticker.ts" />
/// <reference path="../popups/popup_can_apply_header.ts" />
var CanApplyPickSlot;
(function (CanApplyPickSlot) {
    function Init(oSettings) {
        ShowHideInfoPanel(oSettings.isRemove && oSettings.type === 'keychain', oSettings.infoPanel);
        if (oSettings.isRemove) {
            _ShowItemIconsToRemove(oSettings);
        }
        else {
            _AddItemImage(oSettings, oSettings.toolId);
        }
        _ShowHideApplyHints(oSettings);
        _BtnActions(oSettings);
    }
    CanApplyPickSlot.Init = Init;
    function UpdateSelectedRemoveForSticker(slotIndex, oSettings) {
        const elContainer = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons');
        let itemId = '';
        elContainer.Children().forEach(element => {
            element.SetHasClass('is_sticker_remove_unselected', element.Data().slot !== slotIndex);
            element.SetHasClass('is_sticker_remove_selected', element.Data().slot === slotIndex);
            element.checked = element.Data().slot === slotIndex;
            if (element.Data().slot === slotIndex) {
                itemId = element.Data().itemId;
                element.TriggerClass('popup-can-apply-item-image--anim');
            }
        });
        const elStickerScrapeLevelContainer = oSettings.infoPanel.FindChildInLayoutFile('StickerScrapeLevelContainer');
        if (elStickerScrapeLevelContainer) {
            elStickerScrapeLevelContainer.SetHasClass('StickerScrapeLevelContainerHidden', itemId ? false : true);
            const elStickerScrapeLevelSlider = elStickerScrapeLevelContainer.FindChildInLayoutFile('StickerScrapeLevelSlider');
            if (elStickerScrapeLevelSlider && itemId) {
                let valWear = InventoryAPI.GetItemAttributeValue(itemId, "sticker slot " + slotIndex + " wear");
                if (!valWear)
                    valWear = 0.0;
                valWear = Math.ceil(valWear * 100.0);
                elStickerScrapeLevelSlider.default = valWear;
                elStickerScrapeLevelSlider.SetValueNoEvents(valWear);
                if (oSettings.asyncBarPanel) {
                    const elGreenButton = oSettings.asyncBarPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm');
                    if (elGreenButton)
                        elGreenButton.SetHasClass('AsyncItemWorkAcceptConfirmDisabled', true);
                    InventoryAPI.HighlightStickerBySlot(slotIndex);
                    CapabilityCanSticker.SetStickerScrapeLevel(0, oSettings.contextPanel);
                }
            }
        }
    }
    CanApplyPickSlot.UpdateSelectedRemoveForSticker = UpdateSelectedRemoveForSticker;
    function _ShowHideApplyHints(oSettings) {
        oSettings.infoPanel.FindChildInLayoutFile('popup-capability-keychain-hints').SetHasClass('show-keychain-apply-hints', !oSettings.isRemove && oSettings.type === "keychain");
        oSettings.infoPanel.FindChildInLayoutFile('popup-capability-sticker-hints').SetHasClass('show-sticker-apply-hints', !oSettings.isRemove && oSettings.type === "sticker");
        oSettings.infoPanel.FindChildInLayoutFile('popup-capability-sticker-remove-hint').SetHasClass('show-sticker-remove-hints', oSettings.isRemove && oSettings.type === "sticker");
    }
    function ShowHideInfoPanel(bHide, elInfoPanel) {
        elInfoPanel.SetHasClass('hidden', bHide);
    }
    CanApplyPickSlot.ShowHideInfoPanel = ShowHideInfoPanel;
    function IsContinueEnabled(elInfoPanel) {
        if (elInfoPanel.FindChildInLayoutFile('CanApplyContinue')) {
            return elInfoPanel.FindChildInLayoutFile('CanApplyContinue').enabled;
        }
        return false;
    }
    CanApplyPickSlot.IsContinueEnabled = IsContinueEnabled;
    function _ShowItemIconsToRemove(oSettings) {
        const slotCount = InventoryAPI.GetItemStickerSlotCount(oSettings.itemId);
        const elContainer = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons');
        elContainer.RemoveAndDeleteChildren();
        for (let i = 0; i < slotCount; i++) {
            const imagePath = InventoryAPI.GetItemStickerImageBySlot(oSettings.itemId, i);
            if (imagePath) {
                const elPatch = $.CreatePanel('RadioButton', elContainer, imagePath, { group: "remove-btns" });
                elPatch.Data().slot = i;
                elPatch.Data().itemId = oSettings.itemId;
                elPatch.BLoadLayoutSnippet('RemoveBtn');
                const elImage = elPatch.FindChildInLayoutFile('RemoveImage');
                elImage.SetImage('file://{images}' + imagePath + '.png');
                elPatch.SetPanelEvent('onactivate', () => oSettings.funcOnSelectForRemove(i, oSettings));
            }
        }
    }
    function _AddItemImage(oSettings, itemid) {
        const elContainer = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons');
        let aItems;
        aItems = itemid.split(',');
        for (let itemId of aItems) {
            const elImage = elContainer.FindChildInLayoutFile(itemId);
            if (!elImage) {
                const elImage = $.CreatePanel('ItemImage', elContainer, itemId);
                elImage.itemid = itemId;
                elImage.AddClass('popup-can-apply-item-image');
            }
        }
    }
    function _BtnActions(oSettings) {
        const slotsCount = oSettings.isRemove ? InventoryAPI.GetItemStickerSlotCount(oSettings.itemId) : CanApplySlotInfo.GetEmptySlotList().length;
        const elContinueBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyContinue');
        const elNextSlotBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyNextPos');
        const elCancelBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyCancel');
        const worktype = InspectShared.GetPopupSetting('work_type', oSettings.contextPanel);
        if (elContinueBtn)
            elContinueBtn.SetHasClass('hidden', oSettings.isRemove || InspectShared.GetPopupSetting('is_workshop_preview', oSettings.contextPanel));
        if (elNextSlotBtn) {
            elNextSlotBtn.enabled = !(oSettings.isRemove);
            elNextSlotBtn.SetHasClass('hidden', oSettings.isRemove);
        }
        if (elCancelBtn) {
            elCancelBtn.SetHasClass('hidden', true);
            elCancelBtn.SetPanelEvent('onactivate', () => _OnCancel(elContinueBtn, elCancelBtn, elNextSlotBtn, oSettings));
        }
        const elStickerScrapeLevelContainer = oSettings.infoPanel.FindChildInLayoutFile('StickerScrapeLevelContainer');
        if (elStickerScrapeLevelContainer) {
            elStickerScrapeLevelContainer.visible = worktype === 'can_sticker' || worktype === 'remove_sticker';
            if (worktype === 'remove_sticker')
                elStickerScrapeLevelContainer.AddClass('StickerScrapeLevelContainerHidden');
            const elStickerScrapeLevelSlider = elStickerScrapeLevelContainer.FindChildInLayoutFile('StickerScrapeLevelSlider');
            if (elStickerScrapeLevelSlider) {
                elStickerScrapeLevelSlider.min = 0;
                elStickerScrapeLevelSlider.increment = 1;
                elStickerScrapeLevelSlider.max = 100;
                elStickerScrapeLevelSlider.default = 0;
                elStickerScrapeLevelSlider.SetValueNoEvents(0);
                const contextPanel = $.GetContextPanel();
                CapabilityCanSticker.SetStickerScrapeLevel(0, contextPanel);
                elStickerScrapeLevelSlider.SetPanelEvent('onvaluechanged', () => {
                    {
                        const elStickerScrapeLevelSlider = oSettings.infoPanel.FindChildInLayoutFile('StickerScrapeLevelSlider');
                        if (elStickerScrapeLevelSlider) {
                            const newvalue = elStickerScrapeLevelSlider.value;
                            if (worktype === 'can_sticker') {
                                $.DispatchEvent('CSGOPlaySoundEffect', 'UI.StickerScratch', 'MOUSE');
                                CapabilityCanSticker.SetStickerScrapeLevel(newvalue, contextPanel);
                            }
                            else if (worktype === 'remove_sticker') {
                                let bCanScrapeStickerToTargetWear = false;
                                if (oSettings.asyncBarPanel) {
                                    const elGreenButton = oSettings.asyncBarPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm');
                                    if (elGreenButton) {
                                        bCanScrapeStickerToTargetWear = (newvalue > elStickerScrapeLevelSlider.default);
                                        elGreenButton.SetHasClass('AsyncItemWorkAcceptConfirmDisabled', !bCanScrapeStickerToTargetWear);
                                        if (bCanScrapeStickerToTargetWear) {
                                            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.StickerScratch', 'MOUSE');
                                            CapabilityCanSticker.SetStickerScrapeLevel(newvalue, contextPanel);
                                        }
                                    }
                                }
                                if (!bCanScrapeStickerToTargetWear) {
                                    elStickerScrapeLevelSlider.SetValueNoEvents(elStickerScrapeLevelSlider.default);
                                    CapabilityCanSticker.SetStickerScrapeLevel(0, contextPanel);
                                }
                            }
                        }
                    }
                    ;
                });
            }
        }
        if (oSettings.isRemove) {
            return;
        }
        if (slotsCount >= 1 || worktype === 'can_keychain') {
            if (elContinueBtn)
                elContinueBtn.SetPanelEvent('onactivate', () => _OnContinue(elContinueBtn, elCancelBtn, elNextSlotBtn, oSettings));
            if (elNextSlotBtn)
                elNextSlotBtn.SetPanelEvent('onactivate', () => _NextSlot(elContinueBtn, oSettings));
        }
        if (oSettings.type === 'sticker' || oSettings.type === 'keychain') {
            elContinueBtn.enabled = false;
            $.Schedule(3.0, () => elContinueBtn.enabled = true);
        }
    }
    function DisableBtns(elPanel) {
        elPanel.FindChildInLayoutFile('CanApplyContinue').enabled = false;
        ;
        elPanel.FindChildInLayoutFile('CanApplyNextPos').enabled = false;
        elPanel.FindChildInLayoutFile('CanApplyCancel').enabled = false;
    }
    CanApplyPickSlot.DisableBtns = DisableBtns;
    function _OnContinue(elContinueBtn, elCancelBtn, elNextSlotBtn, oSettings) {
        oSettings.funcOnConfirm(oSettings);
        const elItemToApply = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons').Children()[0];
        elItemToApply.ToggleClass('popup-can-apply-item-image--anim');
        elCancelBtn.SetHasClass('hidden', false);
        elNextSlotBtn.SetHasClass('hidden', true);
        elContinueBtn.enabled = false;
        InspectAsyncActionBar.ZoomCamera(true, oSettings.contextPanel.FindChildInLayoutFile('PopUpInspectAsyncBar'));
        const elStickerScrapeLevelContainer = oSettings.infoPanel.FindChildInLayoutFile('StickerScrapeLevelContainer');
        if (elStickerScrapeLevelContainer) {
            elStickerScrapeLevelContainer.enabled = false;
        }
    }
    function _OnCancel(elContinueBtn, elCancelBtn, elNextSlotBtn, oSettings) {
        oSettings.funcOnCancel(oSettings);
        elContinueBtn.enabled = true;
        elNextSlotBtn.enabled = true;
        elNextSlotBtn.SetHasClass('hidden', false);
        elCancelBtn.SetHasClass('hidden', true);
        const elStickerScrapeLevelContainer = oSettings.infoPanel.FindChildInLayoutFile('StickerScrapeLevelContainer');
        if (elStickerScrapeLevelContainer) {
            elStickerScrapeLevelContainer.enabled = true;
        }
    }
    function _NextSlot(elContinueBtn, oSettings) {
        const delayTime = (oSettings.type === 'sticker' || oSettings.type === 'keychain') ? 0 : 1;
        CanApplySlotInfo.IncrementIndex();
        oSettings.funcOnNext(oSettings.toolId, CanApplySlotInfo.GetSelectedEmptySlot(), oSettings);
        const elNextSlotBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyNextPos');
        elNextSlotBtn.enabled = false;
        $.Schedule(delayTime, () => {
            if (elNextSlotBtn && elNextSlotBtn.IsValid()) {
                elNextSlotBtn.enabled = true;
            }
        });
        elContinueBtn.enabled = true;
    }
    function SelectFirstRemoveItem() {
        const elContainer = $.GetContextPanel().FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons');
        if (elContainer.Children()[0] !== undefined && elContainer.Children()[0].IsValid()) {
            $.DispatchEvent("Activated", elContainer.Children()[0], "mouse");
        }
    }
    CanApplyPickSlot.SelectFirstRemoveItem = SelectFirstRemoveItem;
})(CanApplyPickSlot || (CanApplyPickSlot = {}));
var CanApplySlotInfo;
(function (CanApplySlotInfo) {
    let m_emptySlotList = [];
    let m_slotIndex = 0;
    function ResetSlotIndex() {
        m_slotIndex = 0;
        m_emptySlotList = [];
    }
    CanApplySlotInfo.ResetSlotIndex = ResetSlotIndex;
    function UpdateEmptySlotList(itemId) {
        m_emptySlotList = _GetEmptySlots(_GetSlotInfo(itemId));
    }
    CanApplySlotInfo.UpdateEmptySlotList = UpdateEmptySlotList;
    function _GetSlotInfo(itemId) {
        let aSlotInfoList = [];
        let slotsCount = InventoryAPI.GetItemStickerSlotCount(itemId);
        for (let i = 0; i < slotsCount; i++) {
            let ImagePath = InventoryAPI.GetItemStickerImageBySlot(itemId, i);
            if (!ImagePath)
                ImagePath = 'empty';
            aSlotInfoList.push({ index: i, path: ImagePath });
        }
        return aSlotInfoList;
    }
    function _GetEmptySlots(slotInfoList) {
        return slotInfoList.filter(slot => slot.path === 'empty');
    }
    function GetSelectedEmptySlot() {
        const emptySlotCount = m_emptySlotList.length;
        if (emptySlotCount === 0) {
            return 0;
        }
        const activeIndex = (m_slotIndex % emptySlotCount);
        return m_emptySlotList[activeIndex].index;
    }
    CanApplySlotInfo.GetSelectedEmptySlot = GetSelectedEmptySlot;
    function GetSelectedRemoveSlot() {
        const elContainer = $.GetContextPanel().FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons');
        if (elContainer.IsValid() && elContainer.Children().length > 0) {
            const aSelected = elContainer.Children().filter(entry => (entry.checked === true));
            return aSelected.length > 0 ? aSelected[0].Data().slot : 0;
        }
    }
    CanApplySlotInfo.GetSelectedRemoveSlot = GetSelectedRemoveSlot;
    function IncrementIndex() {
        m_slotIndex++;
    }
    CanApplySlotInfo.IncrementIndex = IncrementIndex;
    function GetEmptySlotList() {
        return m_emptySlotList;
    }
    CanApplySlotInfo.GetEmptySlotList = GetEmptySlotList;
})(CanApplySlotInfo || (CanApplySlotInfo = {}));
