"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/iteminfo.ts" />
var CharacterButtons = (function () {
    function _PopulateWeaponDropdownForCharacter(elDropdown, modelPanelSettings) {
        const list = ItemInfo.GetLoadoutWeapons(modelPanelSettings.team);
        if (!list || list.length == 0) {
            return;
        }
        elDropdown.RemoveAllOptions();
        list.forEach(function (entry) {
            const newEntry = $.CreatePanel('Panel', elDropdown, entry[1], {
                'class': 'DropDownMenu'
            });
            newEntry.SetAcceptsFocus(true);
            const elRarity = $.CreatePanel('Label', newEntry, 'rarity');
            elRarity.style.width = '100%';
            elRarity.style.height = '100%';
            elRarity.style.padding = '0px 0px';
            const rarityColor = ItemInfo.GetRarityColor(entry[1]);
            elRarity.style.backgroundColor = "gradient( linear, 0% 0%, 100% 0%, from(" + rarityColor + " ),  color-stop( 0.0125, #00000000 ), to( #00000000 ) );";
            const elLabel = $.CreatePanel('Label', newEntry, 'label', {
                'text': ItemInfo.GetName(entry[1])
            });
            elDropdown.AddOption(newEntry);
        });
        elDropdown.SetPanelEvent('oninputsubmit', () => _OnUpdateWeaponSelection(elDropdown, modelPanelSettings));
        elDropdown.SetSelected(modelPanelSettings.weaponItemId);
    }
    const _OnUpdateWeaponSelection = function (elDropdown, modelPanelSettings) {
        modelPanelSettings.weaponItemId = elDropdown.GetSelected() ? elDropdown.GetSelected().id : "";
        modelPanelSettings.panel.SetActiveCharacter(5);
        CharacterAnims.PlayAnimsOnPanel(modelPanelSettings);
    };
    function _ZoomCamera() {
        const data = $.GetContextPanel().Data();
        const elZoomButton = $.GetContextPanel().FindChildInLayoutFile('LoadoutSingleItemModelZoom');
        if (elZoomButton.checked) {
            data.m_modelPanelSettings.panel.TransitionToCamera('cam_char_inspect_closeup', 0.5);
        }
        else {
            data.m_modelPanelSettings.panel.TransitionToCamera('cam_char_inspect_wide', 0.5);
        }
    }
    function _PlayCheer() {
        const elZoomButton = $.GetContextPanel().FindChildInLayoutFile('LoadoutSingleItemModelZoom');
        if (elZoomButton.checked)
            elZoomButton.checked = false;
        const data = $.GetContextPanel().Data();
        data.m_modelPanelSettings.cameraPreset = data.m_characterToolbarButtonSettings.cameraPresetUnzoomed;
        const modelRenderSettingsOneOffTempCopy = ItemInfo.DeepCopyVanityCharacterSettings(data.m_modelPanelSettings);
        modelRenderSettingsOneOffTempCopy.cheer = InventoryAPI.GetCharacterDefaultCheerByItemId(modelRenderSettingsOneOffTempCopy.charItemId);
        CharacterAnims.PlayAnimsOnPanel(modelRenderSettingsOneOffTempCopy);
        StoreAPI.RecordUIEvent("PlayCheer", 1);
    }
    function _PreviewModelVoice() {
        const data = $.GetContextPanel().Data();
        InventoryAPI.PreviewModelVoice(data.m_modelPanelSettings.charItemId);
        StoreAPI.RecordUIEvent("PlayCheer", 2);
    }
    function _InitCharacterButtons(elButtons, elPreviewpanel, characterButtonSettings) {
        if (!elButtons)
            return;
        elButtons.Children().forEach(el => el.enabled = true);
        if (!elPreviewpanel)
            return;
        const elZoomButton = elButtons.FindChildInLayoutFile('LoadoutSingleItemModelZoom');
        const modelPanelSettings = ItemInfo.GetOrUpdateVanityCharacterSettings(characterButtonSettings.charItemId);
        modelPanelSettings.panel = elPreviewpanel;
        modelPanelSettings.cameraPreset = elZoomButton.checked ? characterButtonSettings.cameraPresetZoomed : characterButtonSettings.cameraPresetUnzoomed;
        const elDropdown = elButtons.FindChildInLayoutFile('LoadoutSingleItemModelWeaponChoice');
        _PopulateWeaponDropdownForCharacter(elDropdown, modelPanelSettings);
        const cheer = ItemInfo.GetDefaultCheer(modelPanelSettings.charItemId);
        const elCheer = elButtons.FindChildInLayoutFile('PlayCheer');
        elCheer.enabled = cheer != undefined && cheer != "";
        elButtons.Data().m_characterToolbarButtonSettings = characterButtonSettings;
        elButtons.Data().m_modelPanelSettings = modelPanelSettings;
    }
    return {
        InitCharacterButtons: _InitCharacterButtons,
        PlayCheer: _PlayCheer,
        PreviewModelVoice: _PreviewModelVoice,
        ZoomCamera: _ZoomCamera,
    };
})();
(function () {
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY2hhcmFjdGVyYnV0dG9ucy5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2NoYXJhY3RlcmJ1dHRvbnMudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUNsQywyQ0FBMkM7QUFFM0MsSUFBSSxnQkFBZ0IsR0FBRyxDQUFFO0lBZXhCLFNBQVMsbUNBQW1DLENBQUcsVUFBc0IsRUFBRSxrQkFBc0U7UUFFNUksTUFBTSxJQUFJLEdBQUcsUUFBUSxDQUFDLGlCQUFpQixDQUFFLGtCQUFrQixDQUFDLElBQUksQ0FBRSxDQUFDO1FBRW5FLElBQUssQ0FBQyxJQUFJLElBQUksSUFBSSxDQUFDLE1BQU0sSUFBSSxDQUFDLEVBQzlCO1lBQ0MsT0FBTztTQUNQO1FBRUQsVUFBVSxDQUFDLGdCQUFnQixFQUFFLENBQUM7UUFFOUIsSUFBSSxDQUFDLE9BQU8sQ0FBRSxVQUFXLEtBQUs7WUFFN0IsTUFBTSxRQUFRLEdBQUcsQ0FBQyxDQUFDLFdBQVcsQ0FBRSxPQUFPLEVBQUUsVUFBVSxFQUFFLEtBQUssQ0FBQyxDQUFDLENBQUMsRUFBRTtnQkFDOUQsT0FBTyxFQUFFLGNBQWM7YUFDdkIsQ0FBRSxDQUFDO1lBQ0osUUFBUSxDQUFDLGVBQWUsQ0FBRSxJQUFJLENBQUUsQ0FBQztZQUVqQyxNQUFNLFFBQVEsR0FBRyxDQUFDLENBQUMsV0FBVyxDQUFFLE9BQU8sRUFBRSxRQUFRLEVBQUUsUUFBUSxDQUFFLENBQUM7WUFDOUQsUUFBUSxDQUFDLEtBQUssQ0FBQyxLQUFLLEdBQUcsTUFBTSxDQUFDO1lBQzlCLFFBQVEsQ0FBQyxLQUFLLENBQUMsTUFBTSxHQUFHLE1BQU0sQ0FBQztZQUMvQixRQUFRLENBQUMsS0FBSyxDQUFDLE9BQU8sR0FBRyxTQUFTLENBQUM7WUFDbkMsTUFBTSxXQUFXLEdBQUcsUUFBUSxDQUFDLGNBQWMsQ0FBRSxLQUFLLENBQUMsQ0FBQyxDQUFD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