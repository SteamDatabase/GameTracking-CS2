"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/teamcolor.ts" />
var CAvatar = class {
    Init(elAvatar, xuid, type) {
        const sXuid = xuid.toString();
        switch (type) {
            case 'playercard':
                this.SetImage(elAvatar, sXuid);
                this.SetFlair(elAvatar, sXuid);
                this.SetTeamColor(elAvatar, sXuid);
                this.SetLobbyLeader(elAvatar);
                break;
            case 'flair':
                this.SetImage(elAvatar, sXuid);
                this.SetFlair(elAvatar, sXuid);
                break;
            default:
                this.SetImage(elAvatar, sXuid);
                this.SetTeamColor(elAvatar, sXuid);
        }
    }
    UpdateTalkingState(elAvatar, xuid, bCalledFromScheduledFunction) {
        if (!elAvatar || !elAvatar.IsValid())
            return;
        const elSpeaking = elAvatar.FindChildTraverse('JsAvatarSpeaking');
        if (!elSpeaking)
            return;
        const bFriendIsTalking = PartyListAPI.GetFriendIsTalking(xuid);
        elSpeaking.SetHasClass('hidden', !bFriendIsTalking);
        if (bFriendIsTalking && (bCalledFromScheduledFunction || !elAvatar.GetAttributeString('updatetalkingstate', ''))) {
            const schfn = $.Schedule(.1, () => this.UpdateTalkingState(elAvatar, xuid, true));
            elAvatar.SetAttributeString('updatetalkingstate', '' + schfn);
        }
        if (!bFriendIsTalking) {
            elAvatar.SetAttributeString('updatetalkingstate', '');
        }
    }
    ;
    SetImage(elAvatar, xuid) {
        const elImage = elAvatar.FindChildTraverse('JsAvatarImage');
        if (xuid === '' || xuid === '0') {
            elImage.AddClass('hidden');
            return;
        }
        elImage.PopulateFromSteamID(xuid);
        elImage.RemoveClass('hidden');
    }
    ;
    SetFlair(elAvatar, xuid) {
        const elFlair = elAvatar.FindChildTraverse('JsAvatarFlair');
        if (xuid === '' || xuid === '0') {
            elFlair.AddClass('hidden');
            return;
        }
        let flairItemId = InventoryAPI.GetFlairItemId(xuid);
        if (flairItemId === "0" || !flairItemId) {
            const flairDefIdx = FriendsListAPI.GetFriendDisplayItemDefFeatured(xuid);
            flairItemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(flairDefIdx, 0);
            if (flairItemId === "0" || !flairItemId) {
                elFlair.AddClass('hidden');
                return;
            }
        }
        const imagePath = InventoryAPI.GetItemInventoryImage(flairItemId);
        elFlair.SetImage('file://{images}' + imagePath + '_small.png');
        elFlair.RemoveClass('hidden');
    }
    ;
    SetTeamColor(elAvatar, xuid) {
        const teamColor = PartyListAPI.GetPartyMemberSetting(xuid, 'game/teamcolor');
        const elTeamColor = elAvatar.FindChildTraverse('JsAvatarTeamColor');
        if (!teamColor) {
            if (elTeamColor)
                elTeamColor.AddClass('hidden');
            return;
        }
        if (typeof TeamColor !== 'undefined') {
            const rgbColor = TeamColor.GetTeamColor(Number(teamColor));
            elTeamColor.RemoveClass('hidden');
            elTeamColor.style.washColor = 'rgb(' + rgbColor + ')';
        }
    }
    ;
    SetLobbyLeader(elAvatar) {
        if (!elAvatar.hasOwnProperty("GetAttributeString"))
            return;
        const show = elAvatar.GetAttributeString('showleader', '');
        const elLeader = elAvatar.FindChildTraverse('JsAvatarLeader');
        if (elLeader) {
            if (show === 'show')
                elLeader.RemoveClass('hidden');
            else
                elLeader.AddClass('hidden');
        }
    }
    ;
};
var Avatar = Avatar ?? new CAvatar();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiYXZhdGFyLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvYXZhdGFyLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFDbEMsNENBQTRDO0FBRTVDLElBQUksT0FBTyxHQUFHO0lBRWIsSUFBSSxDQUFHLFFBQWlCLEVBQUUsSUFBcUIsRUFBRSxJQUE2QjtRQUc3RSxNQUFNLEtBQUssR0FBRyxJQUFJLENBQUMsUUFBUSxFQUFFLENBQUM7UUFDOUIsUUFBUyxJQUFJLEVBQ2I7WUFDQyxLQUFLLFlBQVk7Z0JBQ2hCLElBQUksQ0FBQyxRQUFRLENBQUUsUUFBUSxFQUFFLEtBQUssQ0FBRSxDQUFDO2dCQUNqQyxJQUFJLENBQUMsUUFBUSxDQUFFLFFBQVEsRUFBRSxLQUFLLENBQUUsQ0FBQztnQkFDakMsSUFBSSxDQUFDLFlBQVksQ0FBRSxRQUFRLEVBQUUsS0FBSyxDQUFFLENBQUM7Z0JBQ3JDLElBQUksQ0FBQyxjQUFjLENBQUUsUUFBUSxDQUFFLENBQUM7Z0JBQ2hDLE1BQU07WUFDUCxLQUFLLE9BQU87Z0JBQ1gsSUFBSSxDQUFDLFFBQVEsQ0FBRSxRQUFRLEVBQUUsS0FBSyxDQUFFLENBQUM7Z0JBQ2pDLElBQUksQ0FBQyxRQUFRLENBQUUsUUFBUSxFQUFFLEtBQUssQ0FBRSxDQUFDO2dCQUNqQyxNQUFNO1lBQ1A7Z0JBQ0MsSUFBSSxDQUFDLFFBQVEsQ0FBRSxRQUFRLEVBQUUsS0FBSyxDQUFFLENBQUM7Z0JBQ2pDLElBQUksQ0FBQyxZQUFZLENBQUUsUUFBUSxFQUFFLEtBQUssQ0FBRSxDQUFDO1NBQ3RDO0lBQ0YsQ0FBQztJQUVELGtCQUFrQixDQUFHLFFBQWlCLEVBQUUsSUFBWSxFQUFFLDRCQUFzQztRQUUzRixJQUFLLENBQUMsUUFBUSxJQUFJLENBQUMsUUFBUSxDQUFDLE9BQU8sRUFBRTtZQUNwQyxPQUFPO1FBRVIsTUFBTSxVQUFVLEdBQUcs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