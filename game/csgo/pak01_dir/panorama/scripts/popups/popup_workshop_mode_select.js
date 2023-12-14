"use strict";
/// <reference path="..//csgo.d.ts" />
var PopupWorkshopModeSelect;
(function (PopupWorkshopModeSelect) {
    let m_elPopup = null;
    let m_elButtonContainer;
    let m_elButtons = [];
    function Init() {
        m_elButtons = [];
        m_elPopup = $.GetContextPanel();
        m_elButtonContainer = m_elPopup.FindChildTraverse('popup-workshop-mode-items');
        m_elPopup.FindChildTraverse('GoButton').SetPanelEvent('onactivate', _Apply);
        m_elPopup.FindChildTraverse('CancelButton').SetPanelEvent('onactivate', _Cancel);
        let strModes = m_elPopup.GetAttributeString('workshop-modes', '');
        if (!strModes)
            strModes = 'casual';
        let modes = [];
        modes = strModes.split(',');
        if (modes.length <= 1) {
            _Apply(modes[0]);
            return;
        }
        _InitModes(modes);
    }
    PopupWorkshopModeSelect.Init = Init;
    ;
    function _InitAllModes() {
        _InitModes(['casual', 'competitive', 'scrimcomp2v2', 'deathmatch', 'coopmission', 'flyingscoutsman', 'retakes', 'custom']);
    }
    function _InitModes(modes) {
        m_elButtons.forEach(function (elButton) { elButton.DeleteAsync(0.0); });
        m_elButtons = [];
        for (let i = 0; i < modes.length; ++i) {
            let strMode = modes[i];
            if (!strMode) {
                continue;
            }
            let elButton = $.CreatePanel('RadioButton', m_elButtonContainer, undefined);
            elButton.BLoadLayoutSnippet('workshop-mode-item');
            elButton.SetAttributeString('data-mode', strMode);
            elButton.SetDialogVariable('workshop-mode-item-name', $.Localize('#CSGO_Workshop_Mode_' + strMode));
            if (i === 0)
                elButton.checked = true;
            m_elButtons.push(elButton);
        }
    }
    function _Apply(singleModeOverride = '') {
        let strGameMode = 'casual';
        let nSkirmishId = 0;
        if (singleModeOverride !== '') {
            strGameMode = singleModeOverride;
        }
        else {
            let elSelectedButton = m_elButtons.find(function (elButton) { return elButton.checked; });
            if (elSelectedButton)
                strGameMode = elSelectedButton.GetAttributeString('data-mode', strGameMode);
        }
        let strGameType = GameTypesAPI.GetGameModeType(strGameMode);
        if (!strGameType) {
            nSkirmishId = GameTypesAPI.GetSkirmishIdFromInternalName(strGameMode);
            if (nSkirmishId !== 0) {
                strGameMode = 'skirmish';
                strGameType = 'skirmish';
            }
        }
        if (!strGameType) {
            strGameType = 'classic';
            strGameMode = 'casual';
        }
        let settings = {
            update: {
                Game: {
                    type: strGameType,
                    mode: strGameMode,
                }
            }
        };
        if (nSkirmishId !== 0) {
            // @ts-ignore 
            settings.update.Game.skirmishmode = nSkirmishId;
        }
        else {
            // @ts-ignore 
            settings.delete = {
                Game: {
                    skirmishmode: '#empty#'
                }
            };
        }
        $.DispatchEvent('UIPopupButtonClicked', '');
        LobbyAPI.UpdateSessionSettings(settings);
        LobbyAPI.StartMatchmaking("", "", "", "");
    }
    ;
    function _Cancel() {
        $.DispatchEvent('UIPopupButtonClicked', '');
    }
    ;
})(PopupWorkshopModeSelect || (PopupWorkshopModeSelect = {}));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicG9wdXBfd29ya3Nob3BfbW9kZV9zZWxlY3QuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9wb3B1cHMvcG9wdXBfd29ya3Nob3BfbW9kZV9zZWxlY3QudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHNDQUFzQztBQUV0QyxJQUFVLHVCQUF1QixDQXVJaEM7QUF2SUQsV0FBVSx1QkFBdUI7SUFFN0IsSUFBSSxTQUFTLEdBQUcsSUFBSSxDQUFDO0lBQ3JCLElBQUksbUJBQTJCLENBQUM7SUFDaEMsSUFBSSxXQUFXLEdBQW1CLEVBQUUsQ0FBQztJQUVyQyxTQUFnQixJQUFJO1FBRWhCLFdBQVcsR0FBRyxFQUFFLENBQUM7UUFDakIsU0FBUyxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQztRQUNoQyxtQkFBbUIsR0FBRyxTQUFTLENBQUMsaUJBQWlCLENBQUUsMkJBQTJCLENBQUUsQ0FBQztRQUdqRixTQUFTLENBQUMsaUJBQWlCLENBQUUsVUFBVSxDQUFFLENBQUMsYUFBYSxDQUFFLFlBQVksRUFBRSxNQUFNLENBQUUsQ0FBQztRQUNoRixTQUFTLENBQUMsaUJBQWlCLENBQUUsY0FBYyxDQUFFLENBQUMsYUFBYSxDQUFFLFlBQVksRUFBRSxPQUFPLENBQUUsQ0FBQztRQUVyRixJQUFJLFFBQVEsR0FBRyxTQUFTLENBQUMsa0JBQWtCLENBQUUsZ0JBQWdCLEVBQUUsRUFBRSxDQUFFLENBQUM7UUFDcEUsSUFBSyxDQUFDLFFBQVE7WUFDVixRQUFRLEdBQUcsUUFBUSxDQUFDO1FBRXhCLElBQUksS0FBSyxHQUFZLEVBQUUsQ0FBQztRQUN4QixLQUFLLEdBQUcsUUFBUSxDQUFDLEtBQUssQ0FBRSxHQUFHLENBQUUsQ0FBQztRQUU5QixJQUFHLEtBQUssQ0FBQyxNQUFNLElBQUksQ0FBQyxFQUNwQjtZQUNJLE1BQU0sQ0FBRSxLQUFLLENBQUMsQ0FBQyxDQUFD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