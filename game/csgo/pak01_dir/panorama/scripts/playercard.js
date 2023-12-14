"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/sessionutil.ts" />
/// <reference path="rating_emblem.ts" />
/// <reference path="avatar.ts" />
var playerCard;
(function (playerCard) {
    let _m_xuid = '';
    let _m_currentLvl = null;
    let _m_isSelf = false;
    let _m_bShownInFriendsList = false;
    let _m_tooltipDelayHandle = null;
    let _m_arrAdditionalSkillGroups = ['Wingman'];
    let _m_InventoryUpdatedHandler = null;
    let _m_ShowLockedRankSkillGroupState = false;
    let _m_cp = $.GetContextPanel();
    function _msg(text) {
    }
    function Init() {
        _m_xuid = $.GetContextPanel().GetAttributeString('xuid', 'no XUID found');
        _m_isSelf = _m_xuid === MyPersonaAPI.GetXuid() ? true : false;
        _m_bShownInFriendsList = $.GetContextPanel().GetAttributeString('data-slot', '') !== '';
        $("#AnimBackground").PopulateFromSteamID(_m_xuid);
        _RegisterForInventoryUpdate();
        if (!_m_isSelf)
            FriendsListAPI.RequestFriendProfileUpdateFromScript(_m_xuid);
        FillOutFriendCard();
    }
    playerCard.Init = Init;
    ;
    function _RegisterForInventoryUpdate() {
        _m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', UpdateAvatar);
        _m_cp.RegisterForReadyEvents(true);
        $.RegisterEventHandler('ReadyForDisplay', _m_cp, function () {
            if (!_m_InventoryUpdatedHandler) {
                _m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', UpdateAvatar);
            }
        });
        $.RegisterEventHandler('UnreadyForDisplay', _m_cp, function () {
            if (_m_InventoryUpdatedHandler) {
                $.UnregisterForUnhandledEvent('PanoramaComponent_MyPersona_InventoryUpdated', _m_InventoryUpdatedHandler);
                _m_InventoryUpdatedHandler = null;
            }
        });
    }
    ;
    function FillOutFriendCard() {
        if (_m_xuid) {
            _m_currentLvl = FriendsListAPI.GetFriendLevel(_m_xuid);
            _m_ShowLockedRankSkillGroupState = !_IsPlayerPrime() && _HasXpProgressToFreeze();
            UpdateName();
            _SetAvatar();
            _SetFlairItems();
            _SetPlayerBackground();
            _SetRank();
            _SetPrimeUpsell();
            if (_m_isSelf) {
                if (MyPersonaAPI.GetPipRankWins("Premier") >= 0) {
                    if (_m_bShownInFriendsList)
                        _SetSkillGroup('Premier');
                    else
                        SetAllSkillGroups();
                }
                else {
                    let elToggleBtn = $.GetContextPanel().FindChildInLayoutFile('SkillGroupExpand');
                    elToggleBtn.visible = false;
                }
            }
            else {
                SetAllSkillGroups();
            }
            if (_m_bShownInFriendsList) {
                $.GetContextPanel().FindChildInLayoutFile('JsPlayerCommendations').AddClass('hidden');
                $.GetContextPanel().FindChildInLayoutFile('JsPlayerPrime').AddClass('hidden');
                _SetTeam();
            }
            else {
                let bHasNoCommendsToShow = _SetCommendations();
                _SetPrime(bHasNoCommendsToShow);
            }
        }
    }
    playerCard.FillOutFriendCard = FillOutFriendCard;
    ;
    function ProfileUpdated(xuid) {
        if (_m_xuid === xuid)
            FillOutFriendCard();
    }
    playerCard.ProfileUpdated = ProfileUpdated;
    ;
    function UpdateName() {
        let elNameLabel = $.GetContextPanel().FindChildInLayoutFile('JsPlayerName');
        elNameLabel.text = FriendsListAPI.GetFriendName(_m_xuid);
    }
    playerCard.UpdateName = UpdateName;
    ;
    function _SetAvatar() {
        let elAvatarExisting = $.GetContextPanel().FindChildInLayoutFile('JsPlayerCardAvatar');
        if (!elAvatarExisting) {
            let elParent = $.GetContextPanel().FindChildInLayoutFile('JsPlayerCardTop');
            let elAvatar = $.CreatePanel("Panel", elParent, 'JsPlayerCardAvatar');
            elAvatar.SetAttributeString('xuid', _m_xuid);
            elAvatar.BLoadLayout('file://{resources}/layout/avatar.xml', false, false);
            elAvatar.BLoadLayoutSnippet("AvatarPlayerCard");
            Avatar.Init(elAvatar, _m_xuid, 'playercard');
            elParent.MoveChildBefore(elAvatar, $.GetContextPanel().FindChildInLayoutFile('JsPlayerCardName'));
        }
        else {
            Avatar.Init(elAvatarExisting, _m_xuid, 'playercard');
        }
    }
    ;
    function _SetPlayerBackground() {
        let flairDefIdx = FriendsListAPI.GetFriendDisplayItemDefFeatured(_m_xuid);
        let flairItemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(flairDefIdx, 0);
        let imagePath = InventoryAPI.GetItemInventoryImage(flairItemId);
        let elBgImage = $.GetContextPanel().FindChildInLayoutFile('AnimBackground');
        elBgImage.style.backgroundImage = (imagePath) ? 'url("file://{images}' + imagePath + '_large.png")' : 'none';
        elBgImage.style.backgroundPosition = '50% 50%';
        elBgImage.style.backgroundSize = '115% auto';
        elBgImage.style.backgroundRepeat = 'no-repeat';
        elBgImage.AddClass('player-card-bg-anim');
    }
    ;
    function _SetRank() {
        let elRank = $.GetContextPanel().FindChildInLayoutFile('JsPlayerXp');
        if (!MyPersonaAPI.IsInventoryValid() || !_m_currentLvl || (!_HasXpProgressToFreeze() && !_IsPlayerPrime())) {
            elRank.AddClass('hidden');
            return;
        }
        if (!_IsPlayerPrime() && !_m_isSelf) {
            elRank.AddClass('hidden');
            return;
        }
        let bHasRankToFreezeButNoPrestige = (_m_ShowLockedRankSkillGroupState) ? true : false;
        let currentPoints = FriendsListAPI.GetFriendXp(_m_xuid), pointsPerLevel = MyPersonaAPI.GetXpPerLevel();
        let elXpBar = $.GetContextPanel().FindChildInLayoutFile('JsPlayerXpBarInner');
        let elXpBarInner = $.GetContextPanel().FindChildInLayoutFile('JsPlayerXpBarInner');
        if (bHasRankToFreezeButNoPrestige) {
            elXpBarInner.GetParent().visible = false;
        }
        else {
            let percentComplete = (currentPoints / pointsPerLevel) * 100;
            elXpBarInner.style.width = percentComplete + '%';
            elXpBarInner.GetParent().visible = true;
        }
        if (_m_isSelf) {
            const xpBonuses = MyPersonaAPI.GetActiveXpBonuses();
            const bEligibleForCarePackage = xpBonuses.split(',').includes('2');
            $.GetContextPanel().SetHasClass('care-package-eligible', bEligibleForCarePackage);
        }
        let elRankText = $.GetContextPanel().FindChildInLayoutFile('JsPlayerRankName');
        elRankText.SetHasClass('player-card-prime-text', bHasRankToFreezeButNoPrestige);
        elRank.SetHasClass('player-card-nonprime-locked-xp-row', bHasRankToFreezeButNoPrestige);
        if (bHasRankToFreezeButNoPrestige) {
            elRankText.text = $.Localize('#Xp_RankName_Locked');
        }
        else {
            elRankText.SetDialogVariable('name', $.Localize('#SFUI_XP_RankName_' + _m_currentLvl));
            elRankText.SetDialogVariableInt('level', _m_currentLvl);
        }
        let elRankIcon = $.GetContextPanel().FindChildInLayoutFile('JsPlayerXpIcon');
        elRankIcon.SetImage('file://{images}/icons/xp/level' + _m_currentLvl + '.png');
        elRank.RemoveClass('hidden');
        let bPrestigeAvailable = _m_isSelf && (_m_currentLvl >= InventoryAPI.GetMaxLevel());
        $.GetContextPanel().FindChildInLayoutFile('GetPrestigeButton').SetHasClass('hidden', !bPrestigeAvailable);
        if (bPrestigeAvailable) {
            $.GetContextPanel().FindChildInLayoutFile('GetPrestigeButtonClickable').SetPanelEvent('onactivate', _OnActivateGetPrestigeButtonClickable);
        }
    }
    ;
    function _OnActivateGetPrestigeButtonClickable() {
        UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_inventory_inspect.xml', 'itemid=' + '0' +
            '&' + 'asyncworkitemwarning=no' +
            '&' + 'asyncworktype=prestigecheck');
    }
    ;
    function SetAllSkillGroups() {
        let elSkillGroupContainer = $.GetContextPanel().FindChildInLayoutFile('JsPlayerCardSkillGroupContainer');
        if (!_HasXpProgressToFreeze() && !_IsPlayerPrime()) {
            elSkillGroupContainer.AddClass('hidden');
            return;
        }
        _SetSkillGroup('Premier');
        _m_arrAdditionalSkillGroups.forEach(type => { _SetSkillGroup(type); });
        elSkillGroupContainer.RemoveClass('hidden');
    }
    playerCard.SetAllSkillGroups = SetAllSkillGroups;
    ;
    let _SetSkillForLobbyTeammates = function () {
        let skillgroupType = "competitive";
        let skillGroup = 0;
        let wins = 0;
    };
    function _SetSkillGroup(type) {
        _UpdateSkillGroup(_LoadSkillGroupSnippet(type), type);
    }
    ;
    function _LoadSkillGroupSnippet(type) {
        let id = 'JsPlayerCardSkillGroup-' + type;
        let elParent = $.GetContextPanel().FindChildInLayoutFile('SkillGroupContainer');
        let elSkillGroup = elParent.FindChildInLayoutFile(id);
        if (!elSkillGroup) {
            elSkillGroup = $.CreatePanel("Panel", elParent, id);
            elSkillGroup.BLoadLayoutSnippet('PlayerCardRatingEmblem');
            _ShowOtherRanksByDefault(elSkillGroup, type);
        }
        return elSkillGroup;
    }
    ;
    function _ShowOtherRanksByDefault(elSkillGroup, type) {
        let elToggleBtn = $.GetContextPanel().FindChildInLayoutFile('SkillGroupExpand');
        if (type !== 'Competitive' && _m_bShownInFriendsList) {
            elSkillGroup.AddClass('collapsed');
            return;
        }
        elToggleBtn.visible = _m_bShownInFriendsList ? true : false;
        if (!_m_bShownInFriendsList && _m_isSelf) {
            _AskForLocalPlayersAdditionalSkillGroups();
        }
    }
    ;
    function _AskForLocalPlayersAdditionalSkillGroups() {
        let hintLoadSkillGroups = '';
        _m_arrAdditionalSkillGroups.forEach(type => {
            if (FriendsListAPI.GetFriendCompetitiveRank(_m_xuid, type) === -1) {
                hintLoadSkillGroups += (hintLoadSkillGroups ? ',' : '') + type;
            }
        });
        if (hintLoadSkillGroups) {
            MyPersonaAPI.HintLoadPipRanks(hintLoadSkillGroups);
        }
        _m_arrAdditionalSkillGroups.forEach(type => {
            _SetSkillGroup(type);
        });
    }
    ;
    function _UpdateSkillGroup(elSkillGroup, type) {
        let options = {
            root_panel: elSkillGroup,
            xuid: _m_xuid,
            api: 'friends',
            rating_type: type,
            do_fx: true,
            full_details: true,
        };
        let haveRating = RatingEmblem.SetXuid(options);
        let showRating = haveRating || MyPersonaAPI.GetXuid() === _m_xuid;
        elSkillGroup.SetHasClass('hidden', !showRating);
        elSkillGroup.SetDialogVariable('rating-text', RatingEmblem.GetRatingDesc(elSkillGroup));
        let tooltipText = RatingEmblem.GetTooltipText(elSkillGroup);
        elSkillGroup.SetPanelEvent('onmouseover', ShowSkillGroupTooltip.bind(undefined, elSkillGroup.id, tooltipText));
        elSkillGroup.SetPanelEvent('onmouseout', HideSkillGroupTooltip);
    }
    function GetMatchWinsText(elSkillGroup, wins) {
        elSkillGroup.SetDialogVariableInt('wins', wins);
        return $.Localize('#tooltip_skill_group_wins', elSkillGroup);
    }
    ;
    function _SetPrimeUpsell() {
        let elUpsellPanel = $.GetContextPanel().FindChildInLayoutFile('JsPlayerCardPrimeUpsell');
        elUpsellPanel.SetHasClass('hidden', !MyPersonaAPI.IsInventoryValid() || _IsPlayerPrime() || !_m_isSelf);
        elUpsellPanel.FindChildInLayoutFile("id-player-card-prime-upsell-xp").visible = !_HasXpProgressToFreeze() && !_IsPlayerPrime();
        elUpsellPanel.FindChildInLayoutFile("id-player-card-prime-upsell-skillgroup").visible = !_HasXpProgressToFreeze() && !_IsPlayerPrime();
    }
    ;
    function _SetCommendations() {
        let catagories = [
            { key: 'friendly', value: 0 },
            { key: 'teaching', value: 0 },
            { key: 'leader', value: 0 }
        ];
        let catagoriesCount = catagories.length;
        let hasAnyCommendations = false;
        let countHiddenCommends = 0;
        let elCommendsBlock = $.GetContextPanel().FindChildInLayoutFile('JsPlayerCommendations');
        for (let i = 0; i < catagoriesCount; i++) {
            catagories[i].value = FriendsListAPI.GetFriendCommendations(_m_xuid, catagories[i].key);
            let elCommend = $.GetContextPanel().FindChildInLayoutFile('JsPlayer' + catagories[i].key);
            if (!catagories[i].value || catagories[i].value === 0) {
                elCommend.AddClass('hidden');
                countHiddenCommends++;
            }
            else {
                if (elCommendsBlock.BHasClass('hidden'))
                    elCommendsBlock.RemoveClass('hidden');
                elCommend.RemoveClass('hidden');
                elCommend.FindChild('JsCommendLabel').text = String(catagories[i].value);
            }
        }
        elCommendsBlock.SetHasClass('hidden', countHiddenCommends === catagoriesCount && !_IsPlayerPrime());
        return countHiddenCommends === catagoriesCount;
    }
    ;
    function _SetPrime(bHasNoCommendsToShow) {
        let elPrime = $.GetContextPanel().FindChildInLayoutFile('JsPlayerPrime');
        if (!MyPersonaAPI.IsInventoryValid())
            elPrime.AddClass('hidden');
        if (_IsPlayerPrime()) {
            elPrime.RemoveClass('hidden');
            elPrime.FindChildInLayoutFile('JsCommendLabel').visible = bHasNoCommendsToShow;
            return;
        }
        else
            elPrime.AddClass('hidden');
    }
    ;
    function _IsPlayerPrime() {
        return FriendsListAPI.GetFriendPrimeEligible(_m_xuid);
    }
    function _HasXpProgressToFreeze() {
        return (MyPersonaAPI.HasPrestige() || (MyPersonaAPI.GetCurrentLevel() > 2)) ? true : false;
    }
    function _SetTeam() {
        if (!_m_isSelf)
            return;
        let teamName = MyPersonaAPI.GetMyOfficialTeamName(), tournamentName = MyPersonaAPI.GetMyOfficialTournamentName();
        let showTeam = !teamName ? false : true;
        if (!teamName || !tournamentName) {
            $.GetContextPanel().FindChildInLayoutFile('JsPlayerTeam').AddClass('hidden');
            return;
        }
        $.GetContextPanel().FindChildInLayoutFile('JsPlayerXp').AddClass('hidden');
        $.GetContextPanel().FindChildInLayoutFile('JsPlayerCardSkillGroupContainer').AddClass('hidden');
        $.GetContextPanel().FindChildInLayoutFile('JsPlayerTeam').RemoveClass('hidden');
        let teamTag = MyPersonaAPI.GetMyOfficialTeamTag();
        $.GetContextPanel().FindChildInLayoutFile('JsTeamIcon').SetImage('file://{images}/tournaments/teams/' + teamTag + '.svg');
        $.GetContextPanel().FindChildInLayoutFile('JsTeamLabel').text = teamName;
        $.GetContextPanel().FindChildInLayoutFile('JsTournamentLabel').text = tournamentName;
    }
    ;
    function _SetFlairItems() {
        let flairItems = FriendsListAPI.GetFriendDisplayItemDefCount(_m_xuid);
        let flairItemIdList = [];
        let elFlairPanal = $.GetContextPanel().FindChildInLayoutFile('FlairCarouselAndControls');
        if (!flairItems) {
            elFlairPanal.AddClass('hidden');
            return;
        }
        for (let i = 0; i < flairItems; i++) {
            let flairDefIdx = FriendsListAPI.GetFriendDisplayItemDefByIndex(_m_xuid, i);
            let flairItemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(flairDefIdx, 0);
            flairItemIdList.push(flairItemId);
        }
        $.GetContextPanel().FindChildInLayoutFile('FlairCarousel').RemoveAndDeleteChildren();
        _MakeFlairCarouselPages(elFlairPanal, flairItemIdList);
        elFlairPanal.RemoveClass('hidden');
    }
    ;
    function _MakeFlairCarouselPages(elFlairPanal, flairItemIdList) {
        let flairsPerPage = 5;
        let countFlairItems = flairItemIdList.length;
        let elFlairCarousel = $.GetContextPanel().FindChildInLayoutFile('FlairCarousel');
        let elCarouselPage = null;
        for (let i = 0; i < countFlairItems; i++) {
            if (i % 5 === 0) {
                elCarouselPage = $.CreatePanel('Panel', elFlairCarousel, '', { class: 'playercard-flair-carousel__page' });
            }
            function onMouseOver(flairItemId, idForTooltipLocaation) {
                let tooltipText = InventoryAPI.GetItemName(flairItemId);
                UiToolkitAPI.ShowTextTooltip(idForTooltipLocaation, tooltipText);
            }
            ;
            let imagePath = InventoryAPI.GetItemInventoryImage(flairItemIdList[i]);
            let panelName = _m_xuid + flairItemIdList[i];
            if (elCarouselPage) {
                let elFlair = $.CreatePanel('Image', elCarouselPage, panelName, {
                    class: 'playercard-flair__icon',
                    src: 'file://{images}' + imagePath + '_small.png',
                    scaling: 'stretch-to-fit-preserve-aspect'
                });
                elFlair.SetPanelEvent('onmouseover', onMouseOver.bind(undefined, flairItemIdList[i], panelName));
                elFlair.SetPanelEvent('onmouseout', function () {
                    UiToolkitAPI.HideTextTooltip();
                });
            }
        }
    }
    ;
    function ShowXpTooltip() {
        if (_m_ShowLockedRankSkillGroupState) {
            ShowSkillGroupTooltip('JsPlayerXpIcon', '#tooltip_xp_locked');
            return;
        }
        function ShowTooltip() {
            _m_tooltipDelayHandle = null;
            if (!_m_isSelf)
                return;
            if (_m_currentLvl && _m_currentLvl > 0)
                UiToolkitAPI.ShowCustomLayoutParametersTooltip('JsPlayerXpIcon', 'XpToolTip', 'file://{resources}/layout/tooltips/tooltip_player_xp.xml', 'xuid=' + _m_xuid);
        }
        ;
        _m_tooltipDelayHandle = $.Schedule(0.3, ShowTooltip);
    }
    playerCard.ShowXpTooltip = ShowXpTooltip;
    ;
    function HideXpTooltip() {
        if (_m_ShowLockedRankSkillGroupState) {
            HideSkillGroupTooltip();
            return;
        }
        if (_m_tooltipDelayHandle) {
            $.CancelScheduled(_m_tooltipDelayHandle);
            _m_tooltipDelayHandle = null;
        }
        UiToolkitAPI.HideCustomLayoutTooltip('XpToolTip');
    }
    playerCard.HideXpTooltip = HideXpTooltip;
    ;
    function ShowSkillGroupTooltip(id, tooltipText) {
        function ShowTooltipSkill() {
            _m_tooltipDelayHandle = null;
            UiToolkitAPI.ShowTextTooltip(id, tooltipText);
        }
        ;
        _m_tooltipDelayHandle = $.Schedule(0.3, ShowTooltipSkill);
    }
    playerCard.ShowSkillGroupTooltip = ShowSkillGroupTooltip;
    ;
    function HideSkillGroupTooltip() {
        if (_m_tooltipDelayHandle) {
            $.CancelScheduled(_m_tooltipDelayHandle);
            _m_tooltipDelayHandle = null;
        }
        UiToolkitAPI.HideTextTooltip();
    }
    playerCard.HideSkillGroupTooltip = HideSkillGroupTooltip;
    ;
    function UpdateAvatar() {
        _SetAvatar();
        _SetPlayerBackground();
        _SetFlairItems();
        _SetPrimeUpsell();
        _SetRank();
    }
    playerCard.UpdateAvatar = UpdateAvatar;
    ;
    function ShowHideAdditionalRanks() {
        let elToggleBtn = $.GetContextPanel().FindChildInLayoutFile('SkillGroupExpand');
        if (elToggleBtn.checked) {
            _AskForLocalPlayersAdditionalSkillGroups();
        }
        _m_arrAdditionalSkillGroups.forEach(type => {
            $.GetContextPanel().FindChildInLayoutFile('JsPlayerCardSkillGroup-' + type).SetHasClass('collapsed', !elToggleBtn.checked);
        });
    }
    playerCard.ShowHideAdditionalRanks = ShowHideAdditionalRanks;
    ;
    function FriendsListUpdateName(xuid) {
        if (xuid === _m_xuid) {
            UpdateName();
        }
    }
    playerCard.FriendsListUpdateName = FriendsListUpdateName;
    ;
})(playerCard || (playerCard = {}));
(function () {
    if ($.DbgIsReloadingScript()) {
    }
    playerCard.Init();
    $.RegisterForUnhandledEvent('PanoramaComponent_GC_Hello', playerCard.FillOutFriendCard);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_NameChanged', playerCard.UpdateName);
    $.RegisterForUnhandledEvent('PanoramaComponent_FriendsList_ProfileUpdated', playerCard.ProfileUpdated);
    $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_PipRankUpdate', playerCard.SetAllSkillGroups);
    $.RegisterForUnhandledEvent("PanoramaComponent_Lobby_PlayerUpdated", playerCard.UpdateAvatar);
    $.RegisterForUnhandledEvent('PanoramaComponent_FriendsList_NameChanged', playerCard.FriendsListUpdateName);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicGxheWVyY2FyZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL3BsYXllcmNhcmQudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUNsQyw4Q0FBOEM7QUFDOUMseUNBQXlDO0FBQ3pDLGtDQUFrQztBQUVsQyxJQUFVLFVBQVUsQ0F1ckJuQjtBQXZyQkQsV0FBVSxVQUFVO0lBR25CLElBQUksT0FBTyxHQUFHLEVBQUUsQ0FBQztJQUNqQixJQUFJLGFBQWEsR0FBa0IsSUFBSSxDQUFDO0lBQ3hDLElBQUksU0FBUyxHQUFHLEtBQUssQ0FBQztJQUN0QixJQUFJLHNCQUFzQixHQUFHLEtBQUssQ0FBQztJQUNuQyxJQUFJLHFCQUFxQixHQUFlLElBQUksQ0FBQztJQUM3QyxJQUFJLDJCQUEyQixHQUFHLENBQUUsU0FBUyxDQUFFLENBQUM7SUFDaEQsSUFBSSwwQkFBMEIsR0FBa0IsSUFBSSxDQUFDO0lBQ3JELElBQUksZ0NBQWdDLEdBQUcsS0FBSyxDQUFDO0lBQzdDLElBQUksS0FBSyxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQztJQUdoQyxTQUFTLElBQUksQ0FBRyxJQUFXO0lBRzNCLENBQUM7SUFFRCxTQUFnQixJQUFJO1FBRW5CLE9BQU8sR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsa0JBQWtCLENBQUUsTUFBTSxFQUFFLGVBQWUsQ0FBRSxDQUFDO1FBQzVFLFNBQVMsR0FBRyxPQUFPLEtBQUssWUFBWSxDQUFDLE9BQU8sRUFBRSxDQUFDLENBQUMsQ0FBQyxJQUFJLENBQUMsQ0FBQyxDQUFDLEtBQUssQ0FBQztRQUM5RCxzQkFBc0IsR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsa0JBQWtCLENBQUUsV0FBVyxFQUFFLEVBQUUsQ0FBRSxLQUFLLEVBQUUsQ0FBQztRQUV4RixDQUFDLENBQUMsaUJBQWlCLENBQWtDLENBQUMs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