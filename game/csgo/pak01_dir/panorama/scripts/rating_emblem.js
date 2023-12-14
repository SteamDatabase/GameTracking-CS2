"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="mock_adapter.ts" />
/// <reference path="digitpanel.ts" />
/// <reference path="common/sessionutil.ts" />
var RatingEmblem;
(function (RatingEmblem) {
    function _msg(msg) {
    }
    function _GetMainPanel(root_panel) {
        if (root_panel &&
            root_panel.IsValid() &&
            root_panel.FindChildTraverse('jsPremierRating') &&
            root_panel.FindChildTraverse('jsPremierRating').IsValid()) {
            return root_panel.FindChildTraverse('jsPremierRating').GetParent();
        }
        else {
            return null;
        }
    }
    function GetRatingDesc(root_panel) {
        let elMain = _GetMainPanel(root_panel);
        return elMain ? elMain.Data().ratingDesc : '';
    }
    RatingEmblem.GetRatingDesc = GetRatingDesc;
    function GetTooltipText(root_panel) {
        let elMain = _GetMainPanel(root_panel);
        return elMain ? elMain.Data().tooltipText : '';
    }
    RatingEmblem.GetTooltipText = GetTooltipText;
    function GetTierColorClass(root_panel) {
        let elMain = _GetMainPanel(root_panel);
        return elMain ? elMain.Data().colorClassName : '';
    }
    RatingEmblem.GetTierColorClass = GetTierColorClass;
    function GetEomDescText(root_panel) {
        let elMain = _GetMainPanel(root_panel);
        return elMain ? elMain.Data().eomDescText : '';
    }
    RatingEmblem.GetEomDescText = GetEomDescText;
    function GetIntroText(root_panel) {
        let elMain = _GetMainPanel(root_panel);
        return elMain ? elMain.Data().introText : '';
    }
    RatingEmblem.GetIntroText = GetIntroText;
    function GetWinCountString(root_panel) {
        let elMain = _GetMainPanel(root_panel);
        return elMain ? elMain.Data().winCountText : '';
    }
    RatingEmblem.GetWinCountString = GetWinCountString;
    function GetPromotionState(root_panel) {
        let elMain = _GetMainPanel(root_panel);
        return elMain ? elMain.Data().promotionState : '';
    }
    RatingEmblem.GetPromotionState = GetPromotionState;
    function SetXuid(options) {
        let rating = undefined;
        let wins = undefined;
        let rank = undefined;
        let pct = undefined;
        let bFullDetails = options.hasOwnProperty('full_details') ? options.full_details : false;
        let source = options.api;
        let do_fx = options.do_fx;
        let rating_type = options.rating_type;
        let root_panel = _GetMainPanel(options.root_panel);
        if (!root_panel)
            return false;
        let debug_wins = false;
        if (!rating_type && options.xuid) {
            switch (source) {
                case 'friends':
                    rating_type = FriendsListAPI.GetFriendCompetitiveRankType(options.xuid);
                    break;
                case 'partylist':
                    rating_type = PartyListAPI.GetFriendCompetitiveRankType(options.xuid);
                    break;
                case 'gamestate':
                    rating_type = MockAdapter.GetPlayerCompetitiveRankType(options.xuid);
                    break;
                case 'mypersona':
                default:
                    rating_type = 'Premier';
                    break;
            }
        }
        if (options.xuid) {
            switch (source) {
                case 'friends':
                    rating = FriendsListAPI.GetFriendCompetitiveRank(options.xuid, rating_type);
                    wins = FriendsListAPI.GetFriendCompetitiveWins(options.xuid, rating_type);
                    break;
                case 'partylist':
                    rating = PartyListAPI.GetFriendCompetitiveRank(options.xuid);
                    wins = PartyListAPI.GetFriendCompetitiveWins(options.xuid);
                    break;
                case 'gamestate':
                    rating = MockAdapter.GetPlayerCompetitiveRanking(options.xuid);
                    wins = MockAdapter.GetPlayerCompetitiveWins(options.xuid);
                    break;
                case 'partybrowser':
                    rating = Number(PartyBrowserAPI.GetPartySessionSetting(options.xuid, 'game/ark'));
                    rating = Math.floor(rating / 10);
                    break;
                case 'mypersona':
                    if (rating_type === 'Competitive' && options.rating_map) {
                        let pmso = MyPersonaAPI.GetCompetitivePerMapStatsObject();
                        rating = pmso[options.rating_map] ? pmso[options.rating_map]["skillgroup"] : -1;
                        wins = pmso[options.rating_map] ? pmso[options.rating_map]["wins"] : -1;
                    }
                    else {
                        rating = MyPersonaAPI.GetPipRankCount(rating_type);
                        wins = MyPersonaAPI.GetPipRankWins(rating_type);
                    }
                    break;
            }
        }
        if (debug_wins) {
            wins = Math.floor(Math.random() * 20);
        }
        if (rating_type === 'Premier') {
            if (options.leaderboard_details && Object.keys(options.leaderboard_details).length > 0) {
                rating = options.leaderboard_details.score;
                wins = options.leaderboard_details.matchesWon;
                rank = options.leaderboard_details.rank;
                pct = options.leaderboard_details.pct;
                _msg('got data from leaderboard_details');
            }
        }
        _msg(rating_type + root_panel.id);
        root_panel.SwitchClass('type', rating_type);
        if (bFullDetails) {
            _msg('making strings');
            root_panel.SetDialogVariable('rating_type', rating_type);
        }
        let elSkillGroupImage = null;
        let imagePath = '';
        let winsNeededForRank = SessionUtil ? SessionUtil.GetNumWinsNeededForRank(rating_type) : 10;
        let isloading = (rating === undefined || rating < 0);
        let bRatingExpired = rating === 0;
        let bTooFewWins = bRatingExpired && !!wins && (wins < winsNeededForRank);
        let bHasRating = !bRatingExpired && !bTooFewWins && !isloading;
        let ratingDesc = '';
        let tooltipText = '';
        let eomDescText = '';
        let tooltipExtraText = '';
        let colorClassName = '';
        let introText = '';
        let promotionState = '';
        let winCountText = '';
        if (!wins || wins < 0) {
            wins = 0;
        }
        if (isloading) {
            ratingDesc = $.Localize('#SFUI_LOADING');
        }
        root_panel.SetDialogVariableInt("wins", wins);
        if (rating_type === 'Wingman' || rating_type === 'Competitive') {
            elSkillGroupImage = root_panel.FindChildTraverse('jsRating-' + rating_type);
            let locTypeModifer = rating_type === 'Competitive' ? '' : rating_type.toLowerCase();
            imagePath = locTypeModifer !== '' ? locTypeModifer : 'skillgroup';
            const elCompWinsNeeded = root_panel.FindChildTraverse('jsRating-CompetitiveWinsNeeded');
            elCompWinsNeeded.visible = bTooFewWins;
            if (bTooFewWins || isloading) {
                elSkillGroupImage.SetImage('file://{images}/icons/skillgroups/' + imagePath + '_none.svg');
                if (!isloading) {
                    const winsneeded = Math.max(0, winsNeededForRank - wins);
                    elSkillGroupImage.SetImage('file://{images}/icons/skillgroups/' + imagePath + '_need_wins.svg');
                    elSkillGroupImage.SetDialogVariableInt('wins', wins);
                    elSkillGroupImage.SetDialogVariableInt('wins-needed', winsneeded);
                    if (bFullDetails) {
                        ratingDesc = $.Localize('#skillgroup_0' + locTypeModifer);
                        root_panel.SetDialogVariableInt("winsneeded", winsneeded);
                        tooltipText = $.Localize('#tooltip_skill_group_none' + imagePath, root_panel);
                    }
                }
            }
            else if (bRatingExpired) {
                elSkillGroupImage.SetImage('file://{images}/icons/skillgroups/' + imagePath + '_expired.svg');
                if (bFullDetails) {
                    ratingDesc = $.Localize('#skillgroup_expired' + locTypeModifer);
                    tooltipText = $.Localize('#tooltip_skill_group_expired' + locTypeModifer);
                }
            }
            else {
                elSkillGroupImage.SetImage('file://{images}/icons/skillgroups/' + imagePath + rating + '.svg');
                if (bFullDetails) {
                    ratingDesc = $.Localize('#skillgroup_' + rating);
                    tooltipText = $.Localize('#tooltip_skill_group_generic' + locTypeModifer);
                }
            }
        }
        else if (rating_type === 'Premier') {
            let elPremierRating = root_panel.FindChildTraverse('jsPremierRating');
            let presentation = options.presentation ? options.presentation : 'simple';
            root_panel.FindChildTraverse('JsSimpleNumbers').visible = presentation === 'simple';
            root_panel.FindChildTraverse('JsDigitPanels').visible = presentation === 'digital';
            let majorRating = '';
            let minorRating = '';
            root_panel.SwitchClass('tier', 'tier-0');
            _SetPremierBackgroundImage(root_panel, rating);
            if (rating && rating > 0) {
                let remappedRating = Math.floor(rating / 1000.00 / 5);
                let clampedRating = Math.max(0, Math.min(remappedRating, 6));
                root_panel.SwitchClass('tier', 'tier-' + clampedRating);
                colorClassName = 'tier-' + clampedRating;
                let arrRating = SplitRating(rating);
                majorRating = arrRating[0];
                minorRating = arrRating[1];
                if (do_fx && rating) {
                    ratingParticleControls.UpdateRatingEffects(elPremierRating, majorRating, minorRating.slice(-3), parseInt(arrRating[2]));
                }
                if (bFullDetails) {
                    if (rank && rank <= LeaderboardsAPI.GetPremierLeaderboardTopBestCount()) {
                        root_panel.SetDialogVariableInt('rank', rank);
                        ratingDesc = $.Localize('#cs_rating_rank', root_panel);
                        eomDescText = ratingDesc;
                    }
                    else if (pct) {
                        root_panel.SetDialogVariable('percentile', pct.toFixed(2) + '');
                        ratingDesc = $.Localize('#cs_rating_percentile', root_panel);
                        eomDescText = ratingDesc;
                    }
                    else {
                        ratingDesc = $.Localize('#cs_rating_generic');
                    }
                    if (arrRating[2] === '2') {
                        tooltipExtraText = $.Localize('#cs_rating_relegation_nextmatch');
                        introText = $.Localize('#cs_rating_relegation_match');
                        eomDescText = $.Localize('#cs_rating_relegation_nextmatch');
                        ratingDesc = $.Localize('#cs_rating_relegation_nextmatch');
                        promotionState = 'relegation';
                    }
                    else if (arrRating[2] === '1') {
                        tooltipExtraText = $.Localize('#cs_rating_promotion_nextmatch');
                        introText = $.Localize('#cs_rating_promotion_match');
                        eomDescText = $.Localize('#cs_rating_promotion_nextmatch');
                        ratingDesc = $.Localize('#cs_rating_promotion_nextmatch');
                        promotionState = 'promotion';
                    }
                    tooltipText = $.Localize('#tooltip_cs_rating_generic');
                }
            }
            else {
                if (bFullDetails) {
                    if (isloading) {
                        ratingDesc = $.Localize('#skillgroup_loading');
                    }
                    else if (bTooFewWins) {
                        var winsneeded = (winsNeededForRank - wins);
                        root_panel.SetDialogVariableInt("winsneeded", winsneeded);
                        tooltipText = $.Localize('#tooltip_cs_rating_none', root_panel);
                        eomDescText = $.Localize('#cs_rating_wins_needed_verbose', root_panel);
                        introText = $.Localize('#cs_rating_wins_needed_verbose_intro', root_panel);
                        if (options.xuid && options.xuid === MyPersonaAPI.GetXuid()) {
                            ratingDesc = $.Localize('#cs_rating_wins_needed', root_panel);
                        }
                        else {
                            ratingDesc = $.Localize('#cs_rating_none');
                        }
                    }
                    else if (bRatingExpired) {
                        ratingDesc = $.Localize('#cs_rating_expired');
                        tooltipText = $.Localize('#tooltip_cs_rating_expired');
                        eomDescText = $.Localize('#eom-skillgroup-expired-premier', root_panel);
                        introText = $.Localize('#eom-skillgroup-expired-premier', root_panel);
                    }
                }
            }
            _SetEomStyleOverrides(options, root_panel);
            _SetPremierRatingValue(root_panel, majorRating, minorRating, presentation);
        }
        if (bFullDetails) {
            if (tooltipExtraText !== '') {
                tooltipText = tooltipText + '<br><br>' + tooltipExtraText;
            }
            if (wins) {
                root_panel.SetDialogVariableInt('wins', wins);
                let winText = $.Localize('#tooltip_skill_group_wins', root_panel);
                tooltipText = (tooltipText !== '') ? tooltipText + '<br><br>' + winText : winText;
                winCountText = $.Localize('#wins_count', root_panel);
            }
            root_panel.Data().ratingDesc = ratingDesc;
            root_panel.Data().tooltipText = tooltipText;
            root_panel.Data().colorClassName = colorClassName;
            root_panel.Data().eomDescText = eomDescText;
            root_panel.Data().introText = introText;
            root_panel.Data().promotionState = promotionState;
            root_panel.Data().winCountText = winCountText;
        }
        root_panel.SwitchClass('rating_type', rating_type);
        return bHasRating;
    }
    RatingEmblem.SetXuid = SetXuid;
    function _SetPremierBackgroundImage(root_panel, rating) {
        let bgImage = (rating && rating > 0) ? 'premier_rating_bg_large.svg' : 'premier_rating_bg_large_none.svg';
        let elImage = root_panel.FindChildInLayoutFile('jsPremierRatingBg');
        elImage.SetImage('file://{images}/icons/ui/' + bgImage);
    }
    function _SetEomStyleOverrides(options, root_panel) {
        root_panel.FindChildInLayoutFile('JsDigitPanels').SwitchClass('emblemstyle', options.eom_digipanel_class_override ? options.eom_digipanel_class_override : '');
    }
    function _SetPremierRatingValue(root_panel, major, minor, premierPresentation) {
        root_panel.SetDialogVariable('rating-major', major);
        root_panel.SetDialogVariable('rating-minor', minor);
        if (premierPresentation === 'digital') {
            const elMajor = $.GetContextPanel().FindChildTraverse('jsPremierRatingMajor');
            const elMinor = $.GetContextPanel().FindChildTraverse('jsPremierRatingMinor');
            let bFastSet = false;
            if (!$.GetContextPanel().FindChildTraverse('DigitPanel')) {
                DigitPanelFactory.MakeDigitPanel(elMajor, 2, '', 1, "#digitpanel_digits_premier");
                DigitPanelFactory.MakeDigitPanel(elMinor, 4, '', 1, "#digitpanel_digits_premier");
                bFastSet = true;
            }
            DigitPanelFactory.SetDigitPanelString(elMajor, major, bFastSet);
            DigitPanelFactory.SetDigitPanelString(elMinor, minor, bFastSet);
        }
    }
    function SplitRating(rating) {
        let matchType = '0';
        if (rating === 5000 || rating === 10000 || rating === 15000 ||
            rating === 20000 || rating === 25000 || rating === 30000)
            matchType = '2';
        else if (rating === 5000 - 1 || rating === 10000 - 1 || rating === 15000 - 1 ||
            rating === 20000 - 1 || rating === 25000 - 1 || rating === 30000 - 1)
            matchType = '1';
        rating = rating / 1000.00;
        let strRating = (String((rating).toFixed(3))).padStart(6, '0');
        let major = strRating.slice(0, 2);
        let minor = strRating.slice(-3);
        major = major.replace(/^00/g, '  ');
        major = major.replace(/^0/g, ' ');
        if (major === '  ') {
            minor = minor.replace(/^00/g, '  ');
            minor = minor.replace(/^0/g, ' ');
        }
        else {
            minor = ',' + minor;
        }
        return [major, minor, matchType];
    }
    RatingEmblem.SplitRating = SplitRating;
})(RatingEmblem || (RatingEmblem = {}));
var ratingParticleControls;
(function (ratingParticleControls) {
    function GetAllChildren(panel) {
        const children = panel.Children();
        return [...children, ...children.flatMap(GetAllChildren)];
    }
    function IsParticleScenePanel(panel) {
        return panel.type === "ParticleScenePanel";
    }
    function colorConvert(tier) {
        let rarityColors = [
            ["common", 176, 195, 217],
            ["uncommon", 94, 152, 217],
            ["rare", 75, 105, 255],
            ["mythical", 136, 71, 255],
            ["legendary", 211, 44, 230],
            ["ancient", 235, 75, 75],
            ["unusual", 255, 215, 0],
        ];
        if (tier < 0 || tier >= rarityColors.length)
            return { R: 0, G: 0, B: 0 };
        let R = rarityColors[tier][1];
        let G = rarityColors[tier][2];
        let B = rarityColors[tier][3];
        return { R, G, B };
    }
    ratingParticleControls.colorConvert = colorConvert;
    function UpdateRatingEffects(panelId, MajorRating, MinorRating, matchType) {
        const AllPanels = GetAllChildren(panelId);
        let ratingEffect = [
            "particles/ui/premier_ratings_bg.vpcf",
            "particles/ui/premier_ratings_promomatch.vpcf",
            "particles/ui/premier_ratings_relegation.vpcf"
        ];
        let tier = Math.floor(+MajorRating / 5.0);
        var tierColor = colorConvert(tier);
        for (const panel of AllPanels) {
            if (IsParticleScenePanel(panel)) {
                if (+MajorRating > 0) {
                    panel.StartParticles();
                    panel.SetParticleNameAndRefresh(ratingEffect[matchType]);
                    panel.SetControlPoint(16, tierColor.R, tierColor.G, tierColor.B);
                }
                else {
                    panel.StopParticlesImmediately(true);
                }
            }
        }
    }
    ratingParticleControls.UpdateRatingEffects = UpdateRatingEffects;
})(ratingParticleControls || (ratingParticleControls = {}));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicmF0aW5nX2VtYmxlbS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL3JhdGluZ19lbWJsZW0udHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGtDQUFrQztBQUNsQyx3Q0FBd0M7QUFDeEMsc0NBQXNDO0FBQ3RDLDhDQUE4QztBQXVCOUMsSUFBVSxZQUFZLENBd2dCckI7QUF4Z0JELFdBQVUsWUFBWTtJQUVyQixTQUFTLElBQUksQ0FBRyxHQUFXO0lBRzNCLENBQUM7SUFFRCxTQUFTLGFBQWEsQ0FBRyxVQUFtQjtRQUUzQyxJQUFLLFVBQVU7WUFDZCxVQUFVLENBQUMsT0FBTyxFQUFFO1lBQ3BCLFVBQVUsQ0FBQyxpQkFBaUIsQ0FBRSxpQkFBaUIsQ0FBRTtZQUNqRCxVQUFVLENBQUMsaUJBQWlCLENBQUUsaUJBQWlCLENBQUUsQ0FBQyxPQUFPLEVBQUUsRUFDNUQ7WUFDQyxPQUFPLFVBQVUsQ0FBQyxpQkFBaUIsQ0FBRSxpQkFBaUIsQ0FBRSxDQUFDLFNBQVMsRUFBRSxDQUFDO1NBQ3JFO2FBRUQ7WUFDQyxPQUFPLElBQUksQ0FBQztTQUNaO0lBQ0YsQ0FBQztJQUVELFNBQWdCLGFBQWEsQ0FBRyxVQUFtQjtRQUVsRCxJQUFJLE1BQU0sR0FBRyxhQUFhLENBQUUsVUFBVSxDQUFFLENBQUM7UUFDekMsT0FBTyxNQUFNLENBQUMsQ0FBQyxDQUFDLE1BQU0sQ0FBQyxJQUFJLEVBQUUsQ0FBQyxVQUFVLENBQUMsQ0FBQyxDQUFDLEVBQUUsQ0FBQztJQUMvQyxDQUFDO0lBSmUsMEJBQWEsZ0JBSTVCLENBQUE7SUFFRCxTQUFnQixjQUFjLENBQUcsVUFBbUI7UUFFbkQsSUFBSSxNQUFNLEdBQUcsYUFBYSxDQUFFLFVBQVUsQ0FBRSxDQUFDO1FBQ3pDLE9BQU8sTUFBTSxDQUFDLENBQUMsQ0FBQyxNQUFNLENBQUMsSUFBSSxFQUFFLENBQUMsV0FBVyxDQUFDLENBQUMsQ0FB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