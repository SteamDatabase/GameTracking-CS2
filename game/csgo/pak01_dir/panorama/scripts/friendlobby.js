"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="rating_emblem.ts" />
/// <reference path="common/commonutil.ts" />
var friendLobby;
(function (friendLobby) {
    let _m_xuid = '';
    let _m_isInPopup = false;
    function Init(elTile) {
        const _m_isPerfectWorld = MyPersonaAPI.GetLauncherType() === "perfectworld" ? true : false;
        _m_xuid = elTile.GetAttributeString('xuid', '(not found)');
        if (_m_xuid === '(not found)') {
            return;
        }
        _m_isInPopup = elTile.GetAttributeString('showinpopup', 'false') === 'true' ? true : false;
        let lobbyType = PartyBrowserAPI.GetPartyType(_m_xuid);
        let gameMode = PartyBrowserAPI.GetPartySessionSetting(_m_xuid, 'game/mode');
        elTile.SetHasClass('playerforhire', (lobbyType === 'nearby'));
        _SetLobbyLeaderNameAvatar(elTile, lobbyType);
        _SetGroupNameLink(elTile, lobbyType);
        _SetPrime(elTile);
        if (!_m_isPerfectWorld) {
            _SetRegion(elTile);
        }
        _SetSkillGroup(elTile, gameMode);
        _SetLobbySettings(elTile, gameMode);
        _SetLobbyPlayerSlots(elTile, gameMode, lobbyType);
        _SetUpJoinBtn(elTile, lobbyType);
        _SetUpLobbiesPopupBtn(elTile);
        _SetDismissButton(elTile, lobbyType);
        elTile.SetHasClass('friendlobby--is-in-popup', _m_isInPopup);
    }
    friendLobby.Init = Init;
    function _SetLobbyLeaderNameAvatar(elTile, lobbyType) {
        let xuidLobbyLeader = PartyBrowserAPI.GetPartyMemberXuid(_m_xuid, 0);
        let rawName = FriendsListAPI.GetFriendName(xuidLobbyLeader);
        elTile.SetDialogVariable('friendname', $.HTMLEscape(rawName));
        let nameString = (lobbyType === 'invited') ? '#tooltip_friend_invited_you' : "#tooltip_lobby_leader_name";
        elTile.FindChildTraverse('JsFriendLobbyLeaderName').text = nameString;
        elTile.FindChildTraverse('JsFriendLobbyLeaderAvatar').PopulateFromSteamID(xuidLobbyLeader);
        elTile.FindChildTraverse('JsFriendLobbyLeaderBtn').SetPanelEvent('onactivate', _OpenContextMenu.bind(undefined, xuidLobbyLeader));
    }
    ;
    function _SetPrime(elTile) {
        let primeValue = PartyBrowserAPI.GetPartySessionSetting(_m_xuid, 'game/apr');
        elTile.FindChildTraverse('JsFriendLobbyPrime').visible = (primeValue && primeValue != '0') ? true : false;
    }
    ;
    function _SetRegion(elTile) {
        let countryCode = PartyBrowserAPI.GetPartySessionSetting(_m_xuid, 'game/loc');
        CommonUtil.SetRegionOnLabel(countryCode, elTile);
    }
    ;
    function _SetSkillGroup(elTile, gameMode) {
        let szSkillGroupType = "Competitive";
        if (gameMode === 'scrimcomp2v2') {
            szSkillGroupType = 'Wingman';
        }
        else {
            szSkillGroupType = 'Premier';
        }
        const options = {
            root_panel: elTile.FindChildTraverse('jsRatingEmblem'),
            xuid: _m_xuid,
            do_fx: true,
            full_details: false,
            api: 'partybrowser',
            rating_type: szSkillGroupType
        };
        RatingEmblem.SetXuid(options);
    }
    ;
    function _SetLobbySettings(elTile, gameMode) {
        let gameModeType = GameTypesAPI.GetGameModeType(gameMode);
        let gameModeDisplay = GameTypesAPI.GetGameModeAttribute(gameModeType, gameMode, 'nameID');
        elTile.SetDialogVariable('lobby-mode', $.Localize(gameModeDisplay));
        elTile.SetDialogVariable('lobby-maps', _GetMapNames(gameMode));
    }
    ;
    function _GetMapNames(gameMode) {
        let mapGroups = PartyBrowserAPI.GetPartySessionSetting(_m_xuid, 'game/mapgroupname');
        if (mapGroups == 'workshop')
            return $.Localize('#SFUI_Groups_workshop');
        if (gameMode === 'cooperative') {
            let questId = PartyBrowserAPI.GetPartySessionSetting(_m_xuid, 'game/questid');
            if (questId && questId != '0')
                return $.Localize(MissionsAPI.GetQuestDefinitionField(parseInt(questId), "loc_name"));
        }
        if (!mapGroups)
            mapGroups = '';
        let mapsList = mapGroups.split(',');
        let mapsNiceNamesList = [];
        for (let i = 0; i < mapsList.length; i++) {
            if (i < 4) {
                let mapNiceName = GameTypesAPI.GetMapGroupAttribute(mapsList[i], 'nameID');
                mapsNiceNamesList.push($.Localize(mapNiceName));
            }
        }
        return mapsNiceNamesList.join(', ');
    }
    ;
    function _SetLobbyPlayerSlots(elTile, gameMode, lobbyType) {
        if (lobbyType === 'nearby')
            return;
        let count = PartyBrowserAPI.GetPartyMembersCount(_m_xuid);
        let numSlotsToShow = SessionUtil.GetMaxLobbySlotsForGameMode(gameMode) - 1;
        let elAvatarRow = elTile.FindChildTraverse('JsFriendLobbyAvatars');
        for (let i = 1; i <= numSlotsToShow; i++) {
            let xuid = PartyBrowserAPI.GetPartyMemberXuid(_m_xuid, i);
            let slotId = _m_xuid + ':' + i;
            let playerSlot = elAvatarRow.FindChild(slotId);
            if (!playerSlot) {
                playerSlot = $.CreatePanel('Panel', elAvatarRow, slotId);
                playerSlot.BLoadLayoutSnippet('FriendLobbyAvatarSlot');
            }
            if (i === 1)
                playerSlot.AddClass('friendlobby__slot--first');
            let elEmpty = playerSlot.FindChildTraverse('JsFriendAvatarEmpty');
            let elAvatar = playerSlot.FindChildTraverse('JsFriendAvatar');
            if (xuid) {
                elAvatar.PopulateFromSteamID(xuid);
                playerSlot.FindChild('JsFriendAvatarBtn').SetPanelEvent('onactivate', _OpenContextMenu.bind(undefined, xuid));
                elEmpty.visible = false;
                elAvatar.visible = true;
            }
            else {
                elEmpty.visible = true;
                elAvatar.visible = false;
            }
        }
    }
    ;
    function _SetUpJoinBtn(elTile, lobbyType) {
        let elJoinBtn = elTile.FindChildInLayoutFile('JsFriendLobbyJoinBtn');
        let clientInLobby = false;
        let clientXuid = MyPersonaAPI.GetXuid();
        let count = PartyBrowserAPI.GetPartyMembersCount(_m_xuid);
        for (let i = 0; i <= count; i++) {
            if (clientXuid === PartyBrowserAPI.GetPartyMemberXuid(_m_xuid, i)) {
                clientInLobby = true;
                break;
            }
        }
        if (clientInLobby || lobbyType === 'suggested') {
            elJoinBtn.AddClass('hidden');
            return;
        }
        elJoinBtn.RemoveClass('hidden');
        var onMouseOver = function (id, tooltipText) {
            UiToolkitAPI.ShowTextTooltip(id, tooltipText);
        };
        let tooltipText = $.Localize((lobbyType === 'invited') ? '#tooltip_accept_invite' : '#tooltip_join_public_lobby');
        elJoinBtn.SetPanelEvent('onmouseover', onMouseOver.bind(undefined, 'JsFriendLobbyJoinBtn', tooltipText));
        elJoinBtn.SetPanelEvent('onmouseout', function () {
            UiToolkitAPI.HideTextTooltip();
        });
        let onActivate = function (lobbyLeaderXuid) {
            $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'PanoramaUI.Lobby.Joined', 'MOUSE', 1.0);
            PartyBrowserAPI.ActionJoinParty(lobbyLeaderXuid);
        };
        elJoinBtn.SetPanelEvent('onactivate', onActivate.bind(undefined, _m_xuid));
    }
    function _SetGroupNameLink(elTile, lobbyType) {
        let elGroupLBtn = elTile.FindChildTraverse('JsFriendLobbyGroupBtn');
        let elGroupLabel = elTile.FindChildTraverse('JsFriendLobbyGroupTxt');
        if (lobbyType === 'invited') {
            elGroupLabel.visible = false;
            elGroupLBtn.visible = false;
        }
        if (lobbyType === 'nearby') {
            elGroupLabel.text = $.Localize('#SFUI_Lobby_GroupsNearby');
            elGroupLBtn.enabled = false;
        }
        else {
            let clanId = PartyBrowserAPI.GetPartySessionSetting(_m_xuid, "game/clanid");
            let clanName = PartyBrowserAPI.GetPartySessionSetting(_m_xuid, "game/clantag");
            if (lobbyType === 'suggested') {
                elGroupLabel.SetDialogVariable('group', clanName);
                elGroupLabel.text = $.Localize('#FriendsLobby_GroupsSuggested', elGroupLabel);
            }
            else {
                elGroupLabel.SetDialogVariable('group', clanName);
                elGroupLabel.text = $.Localize('#FriendsLobby_GroupName', elGroupLabel);
            }
            let onActivate = _GetClanLink(clanId);
            elGroupLBtn.SetPanelEvent('onactivate', onActivate);
            elGroupLBtn.enabled = true;
        }
    }
    ;
    function _SetDismissButton(elTile, lobbyType) {
        if (lobbyType === 'invited') {
            var elCloseButton = elTile.FindChildInLayoutFile('FriendLobbyCloseButton');
            elCloseButton.RemoveClass('hidden');
            elCloseButton.SetPanelEvent("onactivate", function () {
                $.DispatchEvent('CSGOPlaySoundEffectMuteBypass', 'PanoramaUI.Lobby.Left', 'MOUSE', 1.0);
                PartyBrowserAPI.ClearInvite(elTile.GetAttributeString('xuid', '(not found)'));
            });
            elCloseButton.SetPanelEvent('onmouseover', function () {
                UiToolkitAPI.ShowTextTooltip('FriendLobbyCloseButton', $.Localize('#tooltip_discard_invite'));
            });
            elCloseButton.SetPanelEvent('onmouseout', function () {
                UiToolkitAPI.HideTextTooltip();
            });
        }
    }
    function _SetUpLobbiesPopupBtn(elTile) {
        let elAlert = elTile.FindChildInLayoutFile('JsFriendLobbyCount');
        let nLobbies = PartyBrowserAPI.GetInvitesCount();
        if (nLobbies < 2) {
            elTile.FindChildInLayoutFile('JsFriendLobbySeeAllInvites').visible = false;
            return;
        }
        if (elAlert && elAlert.IsValid()) {
            elAlert.SetDialogVariable("lobby_count", (nLobbies - 1).toString());
            elAlert.SetDialogVariable("alert_value", $.Localize('#friends_lobby_count', elAlert));
        }
        let elBtn = elTile.FindChildInLayoutFile('JsFriendLobbySeeAllInvitesBtn');
        elBtn.SetPanelEvent('onmouseover', function () {
            UiToolkitAPI.ShowTextTooltip('JsFriendLobbySeeAllInvitesBtn', $.Localize('#tooltip_lobby_count'));
        });
        elBtn.SetPanelEvent('onmouseout', function () {
            UiToolkitAPI.HideTextTooltip();
        });
        elBtn.SetPanelEvent('onactivate', OpenLobbiesContextMenu);
    }
    function OpenLobbiesContextMenu() {
        var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenu('', '', 'file://{resources}/layout/context_menus/context_menu_lobbies.xml');
        contextMenuPanel.AddClass("ContextMenu_NoArrow");
    }
    ;
    function _GetClanLink(clanId) {
        return function () {
            let link = '';
            if (SteamOverlayAPI.GetAppID() == 710)
                link = "http://beta.steamcommunity.com/gid/" + clanId;
            else
                link = "http://steamcommunity.com/gid/" + clanId;
            SteamOverlayAPI.OpenURL(link);
        };
    }
    ;
    function _OpenContextMenu(xuid) {
        $.DispatchEvent('SidebarContextMenuActive', true);
        var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent('', '', 'file://{resources}/layout/context_menus/context_menu_playercard.xml', 'xuid=' + xuid, function () {
            $.DispatchEvent('SidebarContextMenuActive', false);
        });
        contextMenuPanel.AddClass("ContextMenu_NoArrow");
    }
    ;
})(friendLobby || (friendLobby = {}));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJpZW5kbG9iYnkuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9mcmllbmRsb2JieS50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsa0NBQWtDO0FBQ2xDLHlDQUF5QztBQUN6Qyw2Q0FBNkM7QUFFN0MsSUFBVSxXQUFXLENBcVdwQjtBQXJXRCxXQUFVLFdBQVc7SUFFcEIsSUFBSSxPQUFPLEdBQUcsRUFBRSxDQUFDO0lBQ2pCLElBQUksWUFBWSxHQUFXLEtBQUssQ0FBQztJQUVqQyxTQUFnQixJQUFJLENBQUUsTUFBYztRQUVuQyxNQUFNLGlCQUFpQixHQUFHLFlBQVksQ0FBQyxlQUFlLEVBQUUsS0FBSyxjQUFjLENBQUMsQ0FBQyxDQUFDLElBQUksQ0FBQyxDQUFDLENBQUMsS0FBSyxDQUFDO1FBRTNGLE9BQU8sR0FBRyxNQUFNLENBQUMsa0JBQWtCLENBQUUsTUFBTSxFQUFFLGFBQWEsQ0FBRSxDQUFDO1FBRTdELElBQUksT0FBTyxLQUFJLGFBQWEsRUFDNUI7WUFDQyxPQUFPO1NBQ1A7UUFFRCxZQUFZLEdBQUcsTUFBTSxDQUFDLGtCQUFrQixDQUFFLGFBQWEsRUFBRSxPQUFPLENBQUUsS0FBSyxNQUFNLENBQUMsQ0FBQyxDQUFDLElBQUksQ0FBQyxDQUFDLENBQUMsS0FBSyxDQUFDO1FBQzdGLElBQUksU0FBUyxHQUFVLGVBQWUsQ0FBQyxZQUFZLENBQUUsT0FBTyxDQUFFLENBQUM7UUFDL0QsSUFBSSxRQUFRLEdBQVUsZUFBZSxDQUFDLHNCQUFzQixDQUFFLE9BQU8sRUFBQyxXQUFXLENBQUUsQ0FBQztRQUdwRixNQUFNLENBQUMsV0FBVyxDQUFFLGVBQWUsRUFBRSxDQUFFLFNBQVMsS0FBSyxRQUFRLENBQUUsQ0FBRSxDQUFDO1FBRWxFLHlCQUF5QixDQUFFLE1BQU0sRUFBRSxTQUFTLENBQUUsQ0FBQztRQUMvQyxpQkFBaUIsQ0FBRSxNQUFNLEVBQUUs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