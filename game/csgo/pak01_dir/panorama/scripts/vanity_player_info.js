"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="avatar.ts" />
/// <reference path="common/sessionutil.ts" />
/// <reference path="mock_adapter.ts" />
/// <reference path="rating_emblem.ts" />
var VanityPlayerInfo;
(function (VanityPlayerInfo) {
    function _msg(text) {
    }
    function CreateOrUpdateVanityInfoPanel(elParent = null, oSettings = null) {
        if (!elParent) {
            elParent = $.GetContextPanel();
        }
        const idPrefix = "id-player-vanity-info-" + oSettings.playeridx;
        let newPanel = elParent.FindChildInLayoutFile(idPrefix);
        if (!newPanel) {
            newPanel = $.CreatePanel('Button', elParent, idPrefix);
            newPanel.BLoadLayout('file://{resources}/layout/vanity_player_info.xml', false, false);
            newPanel.AddClass('vanity-info-loc-' + oSettings.playeridx);
            newPanel.AddClass('show');
        }
        _SetName(newPanel, oSettings.xuid);
        _SetAvatar(newPanel, oSettings.xuid);
        _SetRank(newPanel, oSettings.xuid, oSettings.isLocalPlayer);
        _SetSkillGroup(newPanel, oSettings.xuid, oSettings.isLocalPlayer);
        _SetPrime(newPanel, oSettings.xuid, oSettings.isLocalPlayer);
        _AddOpenPlayerCardAction(newPanel.FindChildInLayoutFile('vanity-info-container'), oSettings.xuid);
        _SetLobbyLeader(newPanel, oSettings.xuid);
        _ShowSettingsBtn(newPanel, oSettings.xuid);
        return newPanel;
    }
    VanityPlayerInfo.CreateOrUpdateVanityInfoPanel = CreateOrUpdateVanityInfoPanel;
    ;
    function DeleteVanityInfoPanel(elParent, index) {
        const idPrefix = "id-player-vanity-info-" + index;
        const elPanel = elParent.FindChildInLayoutFile(idPrefix);
        if (elPanel && elPanel.IsValid()) {
            elPanel.DeleteAsync(0);
        }
    }
    VanityPlayerInfo.DeleteVanityInfoPanel = DeleteVanityInfoPanel;
    ;
    function _RoundToPixel(context, value, axis) {
        const scale = axis === "x" ? context.actualuiscale_x : context.actualuiscale_y;
        return Math.round(value * scale) / scale;
    }
    ;
    function SetVanityInfoPanelPos(elParent, index, oPos, OnlyXOrY) {
        const idPrefix = "id-player-vanity-info-" + index;
        const elPanel = elParent.FindChildInLayoutFile(idPrefix);
        if (elPanel && elPanel.IsValid()) {
            switch (OnlyXOrY) {
                case 'x':
                    elPanel.style.transform = 'translateX( ' + oPos.x + 'px );';
                    break;
                case 'y':
                    elPanel.style.transform = 'translateY( ' + oPos.x + 'px );';
                    break;
                default:
                    elPanel.style.transform = 'translate3d( ' + _RoundToPixel(elParent, oPos.x, "x") + 'px, ' + _RoundToPixel(elParent, oPos.y, "y") + 'px, 0px );';
                    break;
            }
        }
    }
    VanityPlayerInfo.SetVanityInfoPanelPos = SetVanityInfoPanelPos;
    ;
    function _SetName(newPanel, xuid) {
        const name = MockAdapter.IsFakePlayer(xuid)
            ? MockAdapter.GetPlayerName(xuid)
            : FriendsListAPI.GetFriendName(xuid);
        newPanel.SetDialogVariable('player_name', name);
    }
    ;
    function _SetAvatar(newPanel, xuid) {
        const elParent = newPanel.FindChildInLayoutFile('vanity-avatar-container');
        let elAvatar = elParent.FindChildInLayoutFile('JsPlayerVanityAvatar-' + xuid);
        if (!elAvatar) {
            elAvatar = $.CreatePanel("Panel", elParent, 'JsPlayerVanityAvatar-' + xuid);
            elAvatar.SetAttributeString('xuid', xuid);
            elAvatar.BLoadLayout('file://{resources}/layout/avatar.xml', false, false);
            elAvatar.BLoadLayoutSnippet("AvatarPlayerCard");
            elAvatar.AddClass('avatar--vanity');
        }
        Avatar.Init(elAvatar, xuid, 'playercard');
        if (MockAdapter.IsFakePlayer(xuid)) {
            const elAvatarImage = elAvatar.FindChildInLayoutFile("JsAvatarImage");
            elAvatarImage.PopulateFromPlayerSlot(MockAdapter.GetPlayerSlot(xuid));
        }
    }
    ;
    function _SetRank(newPanel, xuid, isLocalPlayer) {
        const elRankText = newPanel.FindChildInLayoutFile('vanity-rank-name');
        const elRankIcon = newPanel.FindChildInLayoutFile('vanity-xp-icon');
        const elXpBarInner = newPanel.FindChildInLayoutFile('vanity-xp-bar-inner');
        if (!isLocalPlayer || !MyPersonaAPI.IsInventoryValid()) {
            newPanel.FindChildInLayoutFile('vanity-xp-container').visible = false;
            return;
        }
        newPanel.FindChildInLayoutFile('vanity-xp-container').visible = true;
        const currentLvl = FriendsListAPI.GetFriendLevel(xuid);
        if (!MyPersonaAPI.IsInventoryValid() ||
            !currentLvl ||
            (!_HasXpProgressToFreeze() && !_IsPlayerPrime(xuid))) {
            newPanel.AddClass('no-valid-xp');
            return;
        }
        const bHasRankToFreezeButNoPrestige = (!_IsPlayerPrime(xuid) && _HasXpProgressToFreeze()) ? true : false;
        const currentPoints = FriendsListAPI.GetFriendXp(xuid), pointsPerLevel = MyPersonaAPI.GetXpPerLevel();
        if (bHasRankToFreezeButNoPrestige) {
            elXpBarInner.GetParent().visible = false;
        }
        else {
            const percentComplete = (currentPoints / pointsPerLevel) * 100;
            elXpBarInner.style.width = percentComplete + '%';
            elXpBarInner.GetParent().visible = true;
        }
        elRankIcon.SetImage('file://{images}/icons/xp/level' + currentLvl + '.png');
        newPanel.RemoveClass('no-valid-xp');
    }
    ;
    function _SetRankFromParty(newPanel, elRankText, elRankIcon, elXpBarInner, xuid) {
        const rankLvl = PartyListAPI.GetFriendLevel(xuid);
        const xpPoints = PartyListAPI.GetFriendXp(xuid);
        const pointsPerLevel = MyPersonaAPI.GetXpPerLevel();
        if (!rankLvl) {
            newPanel.AddClass('no-valid-xp');
            return;
        }
        const percentComplete = (xpPoints / pointsPerLevel) * 100;
        elXpBarInner.style.width = percentComplete + '%';
        elXpBarInner.GetParent().visible = true;
        elRankIcon.SetImage('file://{images}/icons/xp/level' + rankLvl + '.png');
        elRankText.SetDialogVariable('name', $.Localize('#SFUI_XP_RankName_' + rankLvl));
        elRankText.SetDialogVariableInt('level', rankLvl);
        newPanel.RemoveClass('no-valid-xp');
    }
    ;
    function _SetSkillGroup(newPanel, xuid, isLocalPlayer) {
        let options = {
            root_panel: newPanel,
            xuid: xuid,
            api: 'partylist',
            do_fx: true,
            full_details: false,
        };
        if (isLocalPlayer && !PartyListAPI.IsPartySessionActive()) {
            options.api = 'mypersona';
        }
        let haveRating = RatingEmblem.SetXuid(options);
        newPanel.SetDialogVariable('rating-text', RatingEmblem.GetRatingDesc(newPanel));
    }
    ;
    function _SetPrime(elPanel, xuid, isLocalPlayer) {
        const elPrime = elPanel.FindChildInLayoutFile('vanity-prime-icon');
        elPrime.visible = isLocalPlayer ? _IsPlayerPrime(xuid) : PartyListAPI.GetFriendPrimeEligible(xuid);
    }
    ;
    function UpdateVoiceIcon(elAvatar, xuid) {
        Avatar.UpdateTalkingState(elAvatar, xuid);
    }
    VanityPlayerInfo.UpdateVoiceIcon = UpdateVoiceIcon;
    ;
    function _HasXpProgressToFreeze() {
        return MyPersonaAPI.HasPrestige() || (MyPersonaAPI.GetCurrentLevel() > 2);
    }
    ;
    function _IsPlayerPrime(xuid) {
        return FriendsListAPI.GetFriendPrimeEligible(xuid);
    }
    ;
    function _SetLobbyLeader(elPanel, xuid) {
        elPanel.SetHasClass('is-not-leader', LobbyAPI.GetHostSteamID() !== xuid);
    }
    ;
    function _ShowSettingsBtn(elPanel, xuid) {
        elPanel.SetHasClass("show-controls", MyPersonaAPI.GetXuid() === xuid);
    }
    function _AddOpenPlayerCardAction(elPanel, xuid) {
        function openCard(xuid) {
            if (xuid !== "0") {
                const contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('', '', 'file://{resources}/layout/context_menus/context_menu_playercard.xml', 'xuid=' + xuid, function () {
                });
                contextMenuPanel.AddClass("ContextMenu_NoArrow");
            }
        }
        ;
        elPanel.SetPanelEvent("onactivate", openCard.bind(undefined, xuid));
    }
    ;
})(VanityPlayerInfo || (VanityPlayerInfo = {}));
(function () {
    if ($.DbgIsReloadingScript()) {
    }
})();
