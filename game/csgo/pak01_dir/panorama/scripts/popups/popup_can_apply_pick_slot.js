"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../inspect.ts" />
/// <reference path="../common/iteminfo.ts" />
/// <reference path="../popups/popup_capability_can_sticker.ts" />
/// <reference path="../popups/popup_can_apply_header.ts" />
var CanApplyPickSlot;
(function (CanApplyPickSlot) {
    let m_elItemToApply;
    let m_infoPanel;
    let m_asyncbarPanel;
    let m_worktype;
    function Init(oSettings) {
        m_infoPanel = oSettings.infoPanel;
        m_asyncbarPanel = oSettings.asyncbarPanel;
        m_worktype = oSettings.worktype;
        ShowHideInfoPanel(oSettings.isRemove && oSettings.type === 'keychain');
        if (oSettings.isRemove) {
            _ShowItemIconsToRemove(oSettings);
        }
        else {
            _AddItemImage(oSettings, oSettings.toolId);
            m_elItemToApply = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons').Children()[0];
        }
        _ShowHideApplyHints(oSettings);
        _BtnActions(oSettings);
    }
    CanApplyPickSlot.Init = Init;
    function UpdateSelectedRemoveForSticker(slotIndex) {
        let elContainer = m_infoPanel.FindChildInLayoutFile('CanStickerItemIcons');
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
        let elStickerScrapeLevelContainer = m_infoPanel.FindChildInLayoutFile('StickerScrapeLevelContainer');
        if (elStickerScrapeLevelContainer) {
            elStickerScrapeLevelContainer.SetHasClass('StickerScrapeLevelContainerHidden', itemId ? false : true);
            let elStickerScrapeLevelSlider = elStickerScrapeLevelContainer.FindChildInLayoutFile('StickerScrapeLevelSlider');
            if (elStickerScrapeLevelSlider && itemId) {
                let valWear = InventoryAPI.GetItemAttributeValue(itemId, "sticker slot " + slotIndex + " wear");
                if (!valWear)
                    valWear = 0.0;
                valWear = Math.ceil(valWear * 100.0);
                elStickerScrapeLevelSlider.default = valWear;
                elStickerScrapeLevelSlider.SetValueNoEvents(valWear);
                if (m_asyncbarPanel) {
                    let elGreenButton = m_asyncbarPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm');
                    if (elGreenButton)
                        elGreenButton.SetHasClass('AsyncItemWorkAcceptConfirmDisabled', true);
                    InventoryAPI.HighlightStickerBySlot(slotIndex);
                    CapabilityCanSticker.SetStickerScrapeLevel(0);
                }
            }
        }
    }
    CanApplyPickSlot.UpdateSelectedRemoveForSticker = UpdateSelectedRemoveForSticker;
    function _ShowHideApplyHints(oSettings) {
        m_infoPanel.FindChildInLayoutFile('popup-capability-keychain-hints').SetHasClass('show-keychain-apply-hints', !oSettings.isRemove && oSettings.type === "keychain");
        m_infoPanel.FindChildInLayoutFile('popup-capability-sticker-hints').SetHasClass('show-sticker-apply-hints', !oSettings.isRemove && oSettings.type === "sticker");
        m_infoPanel.FindChildInLayoutFile('popup-capability-sticker-remove-hint').SetHasClass('show-sticker-remove-hints', oSettings.isRemove && oSettings.type === "sticker");
    }
    function ShowHideInfoPanel(bHide) {
        m_infoPanel.SetHasClass('hidden', bHide);
    }
    CanApplyPickSlot.ShowHideInfoPanel = ShowHideInfoPanel;
    function IsContinueEnabled() {
        if (m_infoPanel.FindChildInLayoutFile('CanApplyContinue')) {
            return m_infoPanel.FindChildInLayoutFile('CanApplyContinue').enabled;
        }
        return false;
    }
    CanApplyPickSlot.IsContinueEnabled = IsContinueEnabled;
    function _ShowItemIconsToRemove(oSettings) {
        let slotCount = InventoryAPI.GetItemStickerSlotCount(oSettings.itemId);
        let elContainer = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons');
        elContainer.RemoveAndDeleteChildren();
        for (let i = 0; i < slotCount; i++) {
            let imagePath = InventoryAPI.GetItemStickerImageBySlot(oSettings.itemId, i);
            if (imagePath) {
                let elPatch = $.CreatePanel('RadioButton', elContainer, imagePath, { group: "remove-btns" });
                elPatch.Data().slot = i;
                elPatch.Data().itemId = oSettings.itemId;
                elPatch.BLoadLayoutSnippet('RemoveBtn');
                let elImage = elPatch.FindChildInLayoutFile('RemoveImage');
                elImage.SetImage('file://{images}' + imagePath + '.png');
                elPatch.SetPanelEvent('onactivate', () => oSettings.funcOnSelectForRemove(i));
            }
        }
    }
    function _AddItemImage(oSettings, itemid) {
        let elContainer = oSettings.infoPanel.FindChildInLayoutFile('CanStickerItemIcons');
        let aItems;
        aItems = itemid.split(',');
        for (let itemId of aItems) {
            let elImage = elContainer.FindChildInLayoutFile(itemId);
            if (!elImage) {
                let elImage = $.CreatePanel('ItemImage', elContainer, itemId);
                elImage.itemid = itemId;
                elImage.AddClass('popup-can-apply-item-image');
            }
        }
    }
    function _OnStickerScrapeLevelSliderValueChanged() {
        let elStickerScrapeLevelSlider = m_infoPanel.FindChildInLayoutFile('StickerScrapeLevelSlider');
        if (elStickerScrapeLevelSlider) {
            let newvalue = elStickerScrapeLevelSlider.value;
            if (m_worktype === 'can_sticker') {
                $.DispatchEvent('CSGOPlaySoundEffect', 'UI.StickerScratch', 'MOUSE');
                CapabilityCanSticker.SetStickerScrapeLevel(newvalue);
            }
            else if (m_worktype === 'remove_sticker') {
                let bCanScrapeStickerToTargetWear = false;
                if (m_asyncbarPanel) {
                    let elGreenButton = m_asyncbarPanel.FindChildInLayoutFile('AsyncItemWorkAcceptConfirm');
                    if (elGreenButton) {
                        bCanScrapeStickerToTargetWear = (newvalue > elStickerScrapeLevelSlider.default);
                        elGreenButton.SetHasClass('AsyncItemWorkAcceptConfirmDisabled', !bCanScrapeStickerToTargetWear);
                        if (bCanScrapeStickerToTargetWear) {
                            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.StickerScratch', 'MOUSE');
                            CapabilityCanSticker.SetStickerScrapeLevel(newvalue);
                        }
                    }
                }
                if (!bCanScrapeStickerToTargetWear) {
                    elStickerScrapeLevelSlider.SetValueNoEvents(elStickerScrapeLevelSlider.default);
                    CapabilityCanSticker.SetStickerScrapeLevel(0);
                }
            }
        }
    }
    ;
    function _BtnActions(oSettings) {
        let slotsCount = oSettings.isRemove ? InventoryAPI.GetItemStickerSlotCount(oSettings.itemId) : CanApplySlotInfo.GetEmptySlotList().length;
        let elContinueBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyContinue');
        let elNextSlotBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyNextPos');
        let elCancelBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyCancel');
        if (elContinueBtn)
            elContinueBtn.SetHasClass('hidden', oSettings.isRemove || oSettings.isWorkshopPreview);
        if (elNextSlotBtn) {
            elNextSlotBtn.enabled = !(oSettings.isRemove);
            elNextSlotBtn.SetHasClass('hidden', oSettings.isRemove);
        }
        if (elCancelBtn) {
            elCancelBtn.SetHasClass('hidden', true);
            elCancelBtn.SetPanelEvent('onactivate', () => _OnCancel(elContinueBtn, elCancelBtn, elNextSlotBtn, oSettings));
        }
        let elStickerScrapeLevelContainer = oSettings.infoPanel.FindChildInLayoutFile('StickerScrapeLevelContainer');
        if (elStickerScrapeLevelContainer) {
            elStickerScrapeLevelContainer.visible = oSettings.worktype === 'can_sticker' || oSettings.worktype === 'remove_sticker';
            if (oSettings.worktype === 'remove_sticker')
                elStickerScrapeLevelContainer.AddClass('StickerScrapeLevelContainerHidden');
            let elStickerScrapeLevelSlider = elStickerScrapeLevelContainer.FindChildInLayoutFile('StickerScrapeLevelSlider');
            if (elStickerScrapeLevelSlider) {
                elStickerScrapeLevelSlider.min = 0;
                elStickerScrapeLevelSlider.increment = 1;
                elStickerScrapeLevelSlider.max = 100;
                elStickerScrapeLevelSlider.default = 0;
                elStickerScrapeLevelSlider.SetValueNoEvents(0);
                CapabilityCanSticker.SetStickerScrapeLevel(0);
                elStickerScrapeLevelSlider.SetPanelEvent('onvaluechanged', _OnStickerScrapeLevelSliderValueChanged);
            }
        }
        if (oSettings.isRemove) {
            return;
        }
        if (slotsCount >= 1 || oSettings.worktype === 'can_keychain') {
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
        oSettings.funcOnConfirm();
        m_elItemToApply.ToggleClass('popup-can-apply-item-image--anim');
        elCancelBtn.SetHasClass('hidden', false);
        elNextSlotBtn.SetHasClass('hidden', true);
        elContinueBtn.enabled = false;
        InspectAsyncActionBar.ZoomCamera(true);
        let elStickerScrapeLevelContainer = oSettings.infoPanel.FindChildInLayoutFile('StickerScrapeLevelContainer');
        if (elStickerScrapeLevelContainer) {
            elStickerScrapeLevelContainer.enabled = false;
        }
    }
    function _OnCancel(elContinueBtn, elCancelBtn, elNextSlotBtn, oSettings) {
        oSettings.funcOnCancel();
        elContinueBtn.enabled = true;
        elNextSlotBtn.enabled = true;
        elNextSlotBtn.SetHasClass('hidden', false);
        elCancelBtn.SetHasClass('hidden', true);
        let elStickerScrapeLevelContainer = oSettings.infoPanel.FindChildInLayoutFile('StickerScrapeLevelContainer');
        if (elStickerScrapeLevelContainer) {
            elStickerScrapeLevelContainer.enabled = true;
        }
    }
    function _NextSlot(elContinueBtn, oSettings) {
        let delayTime = (oSettings.type === 'sticker' || oSettings.type === 'keychain') ? 0 : 1;
        CanApplySlotInfo.IncrementIndex();
        oSettings.funcOnNext(oSettings.toolId, CanApplySlotInfo.GetSelectedEmptySlot());
        let elNextSlotBtn = oSettings.infoPanel.FindChildInLayoutFile('CanApplyNextPos');
        elNextSlotBtn.enabled = false;
        $.Schedule(delayTime, () => {
            if (elNextSlotBtn && elNextSlotBtn.IsValid()) {
                elNextSlotBtn.enabled = true;
            }
        });
        elContinueBtn.enabled = true;
    }
    function PanCamera(btnId) {
        let btnPanLeft = m_infoPanel.FindChildInLayoutFile('InspectPanLeft');
        let btnPanRight = m_infoPanel.FindChildInLayoutFile('InspectPanRight');
        btnPanLeft.enabled = btnPanLeft.id === btnId ? false : true;
        btnPanRight.enabled = btnPanRight.id === btnId ? false : true;
        InspectModelImage.PanCamera(btnId === 'InspectPanLeft');
    }
    CanApplyPickSlot.PanCamera = PanCamera;
    function ShowHidePanBtns(bShow) {
        if (!m_infoPanel || !m_infoPanel.IsValid())
            return;
        let btnPanRight = m_infoPanel.FindChildInLayoutFile('InspectPanRight');
        let btnPanLeft = m_infoPanel.FindChildInLayoutFile('InspectPanLeft');
        btnPanRight.SetHasClass('hidden', !bShow);
        btnPanLeft.SetHasClass('hidden', !bShow);
        btnPanRight.enabled = bShow ? false : false;
        btnPanLeft.enabled = bShow ? true : false;
    }
    CanApplyPickSlot.ShowHidePanBtns = ShowHidePanBtns;
    function SelectFirstRemoveItem() {
        let elContainer = $.GetContextPanel().FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons');
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
        let emptySlotCount = m_emptySlotList.length;
        if (emptySlotCount === 0) {
            return 0;
        }
        let activeIndex = (m_slotIndex % emptySlotCount);
        return m_emptySlotList[activeIndex].index;
    }
    CanApplySlotInfo.GetSelectedEmptySlot = GetSelectedEmptySlot;
    function GetSelectedRemoveSlot() {
        let elContainer = $.GetContextPanel().FindChildInLayoutFile('PopUpCanApplyPickSlot').FindChildInLayoutFile('CanStickerItemIcons');
        if (elContainer.IsValid() && elContainer.Children().length > 0) {
            let aSelected = elContainer.Children().filter(entry => (entry.checked === true));
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
