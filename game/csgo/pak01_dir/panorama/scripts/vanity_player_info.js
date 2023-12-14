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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoidmFuaXR5X3BsYXllcl9pbmZvLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvdmFuaXR5X3BsYXllcl9pbmZvLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFDbEMsa0NBQWtDO0FBQ2xDLDhDQUE4QztBQUM5Qyx3Q0FBd0M7QUFDeEMseUNBQXlDO0FBYXpDLElBQVUsZ0JBQWdCLENBK1N6QjtBQS9TRCxXQUFVLGdCQUFnQjtJQUd6QixTQUFTLElBQUksQ0FBRyxJQUFZO0lBRzVCLENBQUM7SUFFRCxTQUFnQiw2QkFBNkIsQ0FBRyxXQUF5QixJQUFJLEVBQUUsWUFBNEMsSUFBSTtRQUc5SCxJQUFLLENBQUMsUUFBUSxFQUNkO1lBQ0MsUUFBUSxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQztTQUMvQjtRQUVELE1BQU0sUUFBUSxHQUFHLHdCQUF3QixHQUFHLFNBQVUsQ0FBQyxTQUFTLENBQUM7UUFDakUsSUFBSSxRQUFRLEdBQUcsUUFBUSxDQUFDLHFCQUFxQixDQUFFLFFBQVEsQ0FBRSxDQUFDO1FBRTFELElBQUssQ0FBQyxRQUFRLEVBQ2Q7WUFDQyxRQUFRLEdBQUcsQ0FBQyxDQUFDLFdBQVcsQ0FBRSxRQUFRLEVBQUUsUUFBUSxFQUFFLFFBQVEsQ0FBRSxDQUFDO1lBQ3pELFFBQVEsQ0FBQyxXQUFXLENBQUUsa0RBQWtELEVBQUUsS0FBSyxFQUFFLEtBQUssQ0FBRSxDQUFDO1lBQ3pGLFFBQVEsQ0FBQyxRQUFRLENBQUUsa0JBQWtCLEdBQUcsU0FBVSxDQUFDLFNBQVMsQ0FBRSxDQUFDO1lBQy9ELFFBQVEsQ0FBQyxRQUFRLENBQUUsTUFBTSxDQUFFLENBQUM7U0FDNUI7UUFJRCxRQUFRLENBQUUsUUFBUSxFQUFFLFNBQVUsQ0FBQyxJQUFJLENBQUUsQ0FBQztRQUN0QyxVQUFVLENBQUUsUUFBUSxFQUFFLFNBQVUsQ0FBQyxJQUFJLENBQUUsQ0FBQztRQUN4QyxRQUFRLENBQUUsUUFBUSxFQUFFLFNBQVUsQ0FBQyxJQUFJLEVBQUUsU0FBVSxDQUFDLGFBQWEsQ0FBRSxDQUFDO1FBQ2hFLGNBQWMsQ0FBRSxRQUFRLEVBQUUsU0FBVSxDQUFDLElBQUksRUFBRSxTQUFVLENBQUMsYUFBYSxDQUFFLENBQUM7UUFFdEUsU0FBUyxDQUFFLFFBQVEsRUFBRSxTQUFVLENBQUMsSUFBSSxFQUFFLFNBQVUsQ0FBQyxhQUFhLENBQUUsQ0FBQztRQUNqRSx3QkFBd0IsQ0FBRSxRQUFRLENBQUMscUJBQXFCLENBQUUsdUJBQXVCLENBQUUsRUFBRSxTQUFVLENBQUMsSUFBSSxDQUFFLENBQUM7UUFDdkcsZUFBZSxDQUFFLFFBQVEsRUFBRSxTQUFVLENBQUMsSUFBSSxDQUFFLENBQUM7UUFDN0MsZ0JBQWdCLENBQUUsUUFBUSxFQUFFLFNBQVUsQ0FBQyxJQUFJLENBQUUsQ0FBQztRQUU5QyxPQUFPLFFBQVEsQ0FBQztJQUNqQixDQUFDO0lBaENlLDhDQUE2QixnQ0FnQzVDLENBQUE7SUFBQSxDQUFDO0lBRUYsU0FBZ0IscUJBQXFCLENBQUcsUUFBaUIsRUFBRSxLQUFhO1FBRXZFLE1BQU0sUUFBUSxHQUFHLHdCQUF3QixHQUFHLEtBQUssQ0FBQztRQUNsRCxNQUFNLE9BQU8sR0FBRyxRQUFRLENBQUMscUJBQXFCLENBQUUsUUFBUSxDQUFFLENBQUM7UUFDM0QsSUFBSyxPQUFPLElBQUksT0FBTyxDQUFDLE9BQU8sRUFBRSxFQUNqQztZQUNDLE9BQU8sQ0FBQyxXQUFXLENBQUUsQ0FBQyxDQUFFLENBQUM7U0FDekI7SUFDRixDQUFDO0lBUmUsc0NBQXFCLHdCQVFwQyxDQUFBO0lBQUEsQ0FBQztJQUVGLFNBQVMsYUFBYSxDQUFHLE9BQWdCLEVBQUUsS0FBYSxFQUFFLElBQWU7UUFFeEUsTUFBTSxLQUFLLEdBQUcsSUFBSSxLQUFLLEdBQUcsQ0FBQyxDQUFDLENBQUMsT0FBTyxDQUFDLGVBQWUsQ0FBQyxDQUFDLENBQUMsT0FBTyxDQUFDLGVBQWUsQ0FBQztRQUMvRSxPQUFPLElBQUksQ0FBQyxLQUFLLENBQUUsS0FBSyxHQUFHLEtBQUssQ0FBRSxHQUFHLEtBQUssQ0FBQztJQUM1QyxDQUFDO0lBQUEsQ0FBQztJQUVGLFNBQWdCLHFCQUFxQixDQUFHLFFBQWlCLEVBQUUsS0FBYSxFQUFFLElBQWMsRUFBRSxRQUFvQjtRQUU3RyxNQUFNLFFBQVEsR0FBRyx3QkFBd0IsR0FBRyxLQUFLLENBQUM7UUFDbEQsTUFBTSxPQUFPLEdBQUcsUUFBUSxDQUFDLHFCQUFxQixDQUFFLFFBQVEsQ0FBRSxDQUFDO1FBQzNELElBQUssT0FBTyxJQUFJLE9BQU8sQ0FBQyxPQUFPLEVBQUUsRUFDakM7WUFDQyxRQUFTLFFBQVEsRUFDakI7Z0JBQ0MsS0FBSyxHQUFHO29CQUNQLE9BQU8sQ0FBQyxLQUFLLENBQUMsU0FBUyxHQUFHLGNBQWMsR0FBRyxJQUFJLENBQUMsQ0FBQyxHQUFHLE9BQU8sQ0FBQztvQkFDNUQsTUFBTTtnQkFFUCxLQUFLLEdBQUc7b0JBQ1AsT0FBTyxDQUFDLEtBQUssQ0FBQyxTQUFTLEdBQUcsY0FBYyxHQUFHLElBQUksQ0FBQyxDQUFDLEdBQUcsT0FBTyxDQUFDO29CQUM1RCxNQUFNO2dCQUVQO29CQUNDLE9BQU8sQ0FBQyxLQUFLLENBQUMsU0FBUyxHQUFHLGVBQWUsR0FBRyxhQUFhLENBQUUsUUFBUSxFQUFFLElBQUksQ0FBQyxDQUFDLEVBQUUsR0FBRyxDQUFFLEdBQUcsTUFBTSxHQUFHLGFBQWEsQ0FBRSxRQUFRLEVBQUUsSUFBSSxDQUFDLENBQUMsRUFBRSxHQUFHLENBQUUsR0FBRyxZQUFZLENBQUM7b0JBQ3BKLE1BQU07YUFFUDtTQUVEO0lBQ0YsQ0FBQztJQXZCZSxzQ0FBcUIsd0JBdUJwQyxDQUFBO0lBQUEsQ0FBQztJQUdGLFNBQVMsUUFBUSxDQUFHLFFBQWlCLEVBQUUsSUFBWTtRQUVsRCxNQUFNLElBQUksR0FBRyxXQUFXLENBQUMsWUFBWSxDQUFFLElBQUksQ0FBRTtZQUM1QyxDQUFDLENBQUMsV0FBVyxDQUFDLGFBQWEsQ0FBRSxJQUFJLENBQUU7WUFDbkMsQ0FBQyxDQUFDLGNBQWMsQ0FBQyxhQUFhLENBQUUsSUFBSSxDQUFFLENBQUM7UUFFeEMsUUFBUSxDQUFDLGlCQUFpQixDQUFFLGFBQWEsRUFBRSxJQUFJLENBQUUsQ0FBQztJQUVuRCxDQUFDO0lBQUEsQ0FBQztJQUVGLFNBQVMsVUFBVSxDQUFHLFFBQWlCLEVBQUUsSUFBWTtRQUVwRCxNQUFNLFFBQVEsR0FBRyxRQUFRLENBQUMscUJBQXFCLENBQUUseUJBQXlCLENBQUUsQ0FBQztRQUM3RSxJQUFJLFFBQVEsR0FBRyxRQUFRLENBQUMscUJBQXFCLENBQUUsdUJBQXVCLEdBQUcsSUFBSSxDQUFFLENBQUM7UUFFaEYsSUFBSyxDQUFDLFFBQVEsRUFDZDtZQUNDLFFBQVEsR0FBRyxDQUFDLENBQUMsV0FBVyxDQUFFLE9BQU8sRUFBRSxRQUFRLEVBQUUsdUJBQXVCLEdBQUcsSUFBSSxDQUFFLENBQUM7WUFDOUUsUUFBUSxDQUFDLGtCQUFrQixDQUFFLE1BQU0sRUFBRSxJQUFJLENBQUUsQ0FBQztZQUM1QyxRQUFRLENBQUMsV0FBVyxDQUFFLHNDQUFzQyxFQUFFLEtBQUssRUFBRSxLQUFLLENBQUUsQ0FBQztZQUM3RSxRQUFRLENBQUMsa0JBQWtCLENBQUUsa0JBQWtCLENBQUUsQ0FBQztZQUNsRCxRQUFRLENBQUMsUUFBUSxDQUFFLGdCQUFnQixDQUFFLENBQUM7U0FDdEM7UUFHRCxNQUFNLENBQUMsSUFBSSxDQUFFLFFBQVEsRUFBRSxJQUFJLEVBQUUsWUFBWSxDQUFFLENBQUM7UUFFNUMsSUFBSyxXQUFXLENBQUMsWUFBWSxDQUFFLElBQUksQ0FBRSxFQUNyQztZQUNDLE1BQU0sYUFBYSxHQUFHLFFBQVEsQ0FBQyxxQkFBcUIsQ0FBRSxlQUFlLENBQXVCLENBQUM7WUFDN0YsYUFBYSxDQUFDLHNCQUFzQixDQUFFLFdBQVcsQ0FBQyxhQUFhLENBQUUsSUFBSSxDQUFFLENBQUUsQ0FBQztTQUMxRTtJQUNGLENBQUM7SUFBQSxDQUFDO0lBRUYsU0FBUyxRQUFRLENBQUcsUUFBaUIsRUFBRSxJQUFZLEVBQUUsYUFBc0I7UUFNMUUsTUFBTSxVQUFVLEdBQUcsUUFBUSxDQUFDLHFCQUFxQixDQUFFLGtCQUFrQixDQUFhLENBQUM7UUFDbkYsTUFBTSxVQUFVLEdBQUcsUUFBUSxDQUFDLHFCQUFxQixDQUFFLGdCQUFnQixDQUFhLENBQUM7UUFDakYsTUFBTSxZQUFZLEdBQUcsUUFBUSxDQUFDLHFCQUFxQixDQUFFLHFCQUFxQixDQUFFLENBQUM7UUFTN0UsSUFBSyxDQUFDLGFBQWEsSUFBSSxDQUFDLFlBQVksQ0FBQyxnQkFBZ0IsRUFBRSxFQUN2RDtZQUNDLFFBQVEsQ0FBQyxxQkFBcUIsQ0FBRSxxQkFBcUIsQ0FBRSxDQUFDLE9BQU8sR0FBRyxLQUFLLENBQUM7WUFDeEUsT0FBTztTQUNQO1FBRUQsUUFBUSxDQUFDLHFCQUFxQixDQUFFLHFCQUFxQixDQUFFLENBQUMsT0FBTyxHQUFHLElBQUksQ0FBQztRQUN2RSxNQUFNLFVBQVUsR0FBRyxjQUFjLENBQUMsY0FBYyxDQUFFLElBQUksQ0FBRSxDQUFDO1FBR3pELElBQUssQ0FBQyxZQUFZLENBQUMsZ0JBQWdCLEVBQUU7WUFDcEMsQ0FBQyxVQUFVO1lBQ1gsQ0FBRSxDQUFDLHNCQUFzQixFQUFFLElBQUksQ0FBQyxjQUFjLENBQUUsSUFBSSxDQUFFLENBQUUsRUFHekQ7WUFDQyxRQUFRLENBQUMsUUFBUSxDQUFFLGFBQWEsQ0FBRSxDQUFDO1lBQ25DLE9BQU87U0FDUDtRQUVELE1BQU0sNkJBQTZCLEdBQUcsQ0FBRSxDQUFDLGNBQWMsQ0FBRSxJQUFJLENBQUUsSUFBSSxzQkFBc0IsRUFBRSxDQUFFLENBQUMsQ0FBQyxDQUFDLElBQUksQ0FBQyxDQUFDLENBQUMsS0FBSyxDQUFDO1FBRTdHLE1BQU0sYUFBYSxHQUFHLGNBQWMsQ0FBQyxXQUFXLENBQUUsSUFBSSxDQUFFLEVBQ3ZELGNBQWMsR0FBRyxZQUFZLENBQUMsYUFBYSxFQUFFLENBQUM7UUFHL0MsSUFBSyw2QkFBNkIsRUFDbEM7WUFDQyxZQUFZLENBQUMsU0FBUyxFQUFFLENBQUMsT0FBTyxHQUFHLEtBQUssQ0FBQztTQUN6QzthQUVEO1lBQ0MsTUFBTSxlQUFlLEdBQUcsQ0FBRSxhQUFhLEdBQUcsY0FBYyxDQUFFLEdBQUcsR0FBRyxDQUFDO1lBQ2pFLFlBQVksQ0FBQyxLQUFLLENBQUMsS0FBSyxHQUFHLGVBQWUsR0FBRyxHQUFHLENBQUM7WUFDakQsWUFBWSxDQUFDLFNBQVMsRUFBRSxDQUFDLE9BQU8sR0FBRyxJQUFJLENBQUM7U0FDeEM7UUFnQkQsVUFBVSxDQUFDLFFBQVEsQ0FBRSxnQ0FBZ0MsR0FBRyxVQUFVLEdBQUcsTUFBTSxDQUFFLENBQUM7UUFDOUUsUUFBUSxDQUFDLFdBQVcsQ0FBRSxhQUFhLENBQUUsQ0FBQztJQVd2QyxDQUFDO0lBQUEsQ0FBQztJQUVGLFNBQVMsaUJBQWlCLENBQUcsUUFBaUIsRUFBRSxVQUFtQixFQUFFLFVBQW1CLEVBQUUsWUFBcUIsRUFBRSxJQUFZO1FBRTVILE1BQU0sT0FBTyxHQUFHLFlBQVksQ0FBQyxjQUFjLENBQUUsSUFBSSxDQUFFLENBQUM7UUFDcEQsTUFBTSxRQUFRLEdBQUcsWUFBWSxDQUFDLFdBQVcsQ0FBRSxJQUFJLENBQUUsQ0FBQztRQUNsRCxNQUFNLGNBQWMsR0FBRyxZQUFZLENBQUMsYUFBYSxFQUFFLENBQUM7UUFFcEQsSUFBSyxDQUFDLE9BQU8sRUFDYjtZQUNDLFFBQVEsQ0FBQyxRQUFRLENBQUUsYUFBYSxDQUFFLENBQUM7WUFDbkMsT0FBTztTQUNQO1FBRUQsTUFBTSxlQUFlLEdBQUcsQ0FBRSxRQUFRLEdBQUcsY0FBYyxDQUFFLEdBQUcsR0FBRyxDQUFDO1FBQzVELFlBQVksQ0FBQyxLQUFLLENBQUMsS0FBSyxHQUFHLGVBQWUsR0FBRyxHQUFHLENBQUM7UUFDakQsWUFBWSxDQUFDLFNBQVMsRUFBRSxDQUFDLE9BQU8sR0FBRyxJQUFJLENBQUM7UUFFeEMsVUFBVSxDQUFDLFFBQVEsQ0FBRSxnQ0FBZ0MsR0FBRyxPQUFPLEdBQUcsTUFBTSxDQUFFLENBQUM7UUFFM0UsVUFBVSxDQUFDLGlCQUFpQixDQUFFLE1BQU0sRUFBRSxDQUFDLENBQUMsUUFBUSxDQUFFLG9CQUFvQixHQUFHLE9BQU8sQ0FBRSxDQUFFLENBQUM7UUFDckYsVUFBVSxDQUFDLG9CQUFvQixDQUFFLE9BQU8sRUFBRSxPQUFPLENBQUUsQ0FBQztRQUVwRCxRQUFRLENBQUMsV0FBVyxDQUFFLGFBQWEsQ0FBRSxDQUFDO0lBQ3ZDLENBQUM7SUFBQSxDQUFDO0lBRUYsU0FBUyxjQUFjLENBQUcsUUFBaUIsRUFBRSxJQUFZLEVBQUUsYUFBc0I7UUFFaEYsSUFBSSxPQUFPLEdBQ1g7WUFDQyxVQUFVLEVBQUUsUUFBUTtZQUNwQixJQUFJLEVBQUUsSUFBSTtZQUNWLEdBQUcsRUFBRSxXQUFxQztZQUUxQyxLQUFLLEVBQUUsSUFBSTtZQUNYLFlBQVksRUFBRSxLQUFLO1NBQ25CLENBQUM7UUFFRixJQUFLLGFBQWEsSUFBSSxDQUFDLFlBQVksQ0FBQyxvQkFBb0IsRUFBRSxFQUMxRDtZQUNDLE9BQU8sQ0FBQyxHQUFHLEdBQUcsV0FBcUMsQ0FBQztTQUNwRDtRQUVELElBQUksVUFBVSxHQUFHLFlBQVksQ0FBQyxPQUFPLENBQUUsT0FBTyxDQUFFLENBQUM7UUFLakQsUUFBUSxDQUFDLGlCQUFpQixDQUFFLGFBQWEsRUFBRSxZQUFZLENBQUMsYUFBYSxDQUFFLFFBQVEsQ0FBRSxDQUFFLENBQUM7SUFDckYsQ0FBQztJQUFBLENBQUM7SUFFRixTQUFTLFNBQVMsQ0FBRyxPQUFnQixFQUFFLElBQVksRUFBRSxhQUFzQjtRQUUxRSxNQUFNLE9BQU8sR0FBRyxPQUFPLENBQUMscUJBQXFCLENBQUUsbUJBQW1CLENBQUUsQ0FBQztRQUNyRSxPQUFPLENBQUMsT0FBTyxHQUFHLGFBQWEsQ0FBQyxDQUFDLENBQUMsY0FBYyxDQUFFLElBQUksQ0FBRSxDQUFDLENBQUMsQ0FBQyxZQUFZLENBQUMsc0JBQXNCLENBQUUsSUFBSSxDQUFFLENBQUM7SUFDeEcsQ0FBQztJQUFBLENBQUM7SUFFRixTQUFnQixlQUFlLENBQUcsUUFBaUIsRUFBRSxJQUFZO1FBRWhFLE1BQU0sQ0FBQyxrQkFBa0IsQ0FBRSxRQUFRLEVBQUUsSUFBSSxDQUFFLENBQUM7SUFDN0MsQ0FBQztJQUhlLGdDQUFlLGtCQUc5QixDQUFBO0lBQUEsQ0FBQztJQUVGLFNBQVMsc0JBQXNCO1FBRTlCLE9BQU8sWUFBWSxDQUFDLFdBQVcsRUFBRSxJQUFJLENBQUUsWUFBWSxDQUFDLGVBQWUsRUFBRSxHQUFHLENBQUMsQ0FBRSxDQUFDO0lBQzdFLENBQUM7SUFBQSxDQUFDO0lBRUYsU0FBUyxjQUFjLENBQUcsSUFBWTtRQUVyQyxPQUFPLGNBQWMsQ0FBQyxzQkFBc0IsQ0FBRSxJQUFJLENBQUUsQ0FBQztJQUN0RCxDQUFDO0lBQUEsQ0FBQztJQUVGLFNBQVMsZUFBZSxDQUFHLE9BQWdCLEVBQUUsSUFBWTtRQUV4RCxPQUFPLENBQUMsV0FBVyxDQUFFLGVBQWUsRUFBRSxRQUFRLENBQUMsY0FBYyxFQUFFLEtBQUssSUFBSSxDQUFFLENBQUM7SUFDNUUsQ0FBQztJQUFBLENBQUM7SUFFRixTQUFTLGdCQUFnQixDQUFFLE9BQWdCLEVBQUUsSUFBWTtRQUV4RCxPQUFPLENBQUMsV0FBVyxDQUFFLGVBQWUsRUFBRSxZQUFZLENBQUMsT0FBTyxFQUFFLEtBQUssSUFBSSxDQUFFLENBQUM7SUFDekUsQ0FBQztJQUVELFNBQVMsd0JBQXdCLENBQUcsT0FBZ0IsRUFBRSxJQUFZO1FBRWpFLFNBQVMsUUFBUSxDQUFHLElBQVk7WUFFL0IsSUFBSyxJQUFJLEtBQUssR0FBRyxFQUNqQjtnQkFDQyxNQUFNLGdCQUFnQixHQUFHLFlBQVksQ0FBQyxpREFBaUQsQ0FDdEYsRUFBRSxFQUNGLEVBQUUsRUFDRixxRUFBcUUsRUFDckUsT0FBTyxHQUFHLElBQUksRUFDZDtnQkFHQSxDQUFDLENBQ0QsQ0FBQztnQkFDRixnQkFBZ0IsQ0FBQyxRQUFRLENBQUUscUJBQXFCLENBQUUsQ0FBQzthQUNuRDtRQUNGLENBQUM7UUFBQSxDQUFDO1FBRUYsT0FBTyxDQUFDLGFBQWEsQ0FBRSxZQUFZLEVBQUUsUUFBUSxDQUFDLElBQUksQ0FBRSxTQUFTLEVBQUUsSUFBSSxDQUFFLENBQUUsQ0FBQztJQUN6RSxDQUFDO0lBQUEsQ0FBQztBQUVILENBQUMsRUEvU1MsZ0JBQWdCLEtBQWhCLGdCQUFnQixRQStTekI7QUFFRCxDQUFFO0lBRUQsSUFBSyxDQUFDLENBQUMsb0JBQW9CLEVBQUUsRUFDN0I7S0FFQztBQUNGLENBQUMsQ0FBRSxFQUFFLENBQUMifQ==