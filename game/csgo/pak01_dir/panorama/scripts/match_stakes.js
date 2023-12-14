"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="rating_emblem.ts" />
/// <reference path="mock_adapter.ts" />
var MatchStakes;
(function (MatchStakes) {
    var m_elMatchStakes = undefined;
    function _msg(msg) {
    }
    function _GetRootPanel() {
        let parent = $.GetContextPanel().GetParent();
        let newParent;
        while (newParent = parent.GetParent())
            parent = newParent;
        return parent;
    }
    function _GetMatchStakesPanel() {
        if (!m_elMatchStakes) {
            _msg('getting matchstakes panel');
            let elHud = _GetRootPanel();
            m_elMatchStakes = elHud.FindChildTraverse('MatchStakes');
        }
        return m_elMatchStakes;
    }
    function ShowWithScoreboard(bShow = true) {
        const type = MockAdapter.GetPlayerCompetitiveRankType(GameStateAPI.GetLocalPlayerXuid());
        if (type !== 'Premier')
            return;
        let elMatchStakes = _GetMatchStakesPanel();
        if (!elMatchStakes.Data().teamIntroInProgress) {
            elMatchStakes.style.visibility = bShow ? 'visible' : 'collapse';
            elMatchStakes.SetHasClass('scoreboard', bShow);
        }
    }
    MatchStakes.ShowWithScoreboard = ShowWithScoreboard;
    function EndTeamIntro() {
        const type = MockAdapter.GetPlayerCompetitiveRankType(GameStateAPI.GetLocalPlayerXuid());
        if (type !== 'Premier')
            return;
        let elMatchStakes = _GetMatchStakesPanel();
        elMatchStakes.style.visibility = 'collapse';
        elMatchStakes.Data().teamIntroInProgress = false;
    }
    MatchStakes.EndTeamIntro = EndTeamIntro;
    function StartTeamIntro() {
        const mysteamid = GameStateAPI.GetLocalPlayerXuid();
        let rankStats = MockAdapter.GetPlayerPremierRankStatsObject(mysteamid);
        if (!rankStats || rankStats.rankType !== 'Premier')
            return;
        let elMatchStakes = _GetMatchStakesPanel();
        elMatchStakes.style.visibility = 'visible';
        elMatchStakes.Data().teamIntroInProgress = true;
        elMatchStakes.SetHasClass('no-rating', rankStats.score === 0);
        let elWin = elMatchStakes.FindChildTraverse('jsMatchStakesWin');
        let elLoss = elMatchStakes.FindChildTraverse('jsMatchStakesLoss');
        let elPfx = elMatchStakes.FindChildTraverse('jsMatchStakes_pfx');
        let options = {
            api: 'gamestate',
            xuid: mysteamid,
            root_panel: elMatchStakes,
            rating_type: 'Premier',
            do_fx: false,
            full_details: true,
        };
        RatingEmblem.SetXuid(options);
        let introText = RatingEmblem.GetIntroText(elMatchStakes);
        elMatchStakes.SetHasClass('show-intro-text', introText !== '');
        elMatchStakes.SetDialogVariable('introtext', introText);
        elMatchStakes.TriggerClass('reveal-stakes');
        let promotionState = RatingEmblem.GetPromotionState(elMatchStakes);
        let ParticleEffect = '';
        let majorRating = '';
        let arrRating = RatingEmblem.SplitRating(rankStats.score);
        majorRating = arrRating[0];
        let tier = Math.floor(+majorRating / 5.0);
        var tierColor = ratingParticleControls.colorConvert(tier);
        if (promotionState === 'relegation') {
            ParticleEffect = "particles/ui/premier_ratings_matchstakes_relegation.vpcf";
        }
        else if (promotionState === 'promotion') {
            ParticleEffect = "particles/ui/premier_ratings_matchstakes_promo.vpcf";
        }
        function _SetDelta(panel, prediction, score, promotionState, bLoss) {
            let delta = prediction - score;
            let deltaStr;
            let arrPrediction = RatingEmblem.SplitRating(prediction);
            if (arrPrediction[2] === '2') {
                deltaStr = $.Localize('#cs_rating_relegation_match');
            }
            else if (arrPrediction[2] === '1') {
                deltaStr = $.Localize('#cs_rating_promotion_match');
            }
            else if (delta === 0) {
                deltaStr = bLoss ? '-0' : '+0';
            }
            else if (delta < 0) {
                deltaStr = String(delta);
            }
            else {
                deltaStr = String('+' + delta);
            }
            panel.SetDialogVariable('delta', deltaStr);
            panel.SetHasClass('animate', true);
            panel.AddClass('reveal-stakes');
        }
        _SetDelta(elWin, rankStats.predictedRankingIfWin, rankStats.score, promotionState, false);
        _SetDelta(elLoss, rankStats.predictedRankingIfLoss, rankStats.score, promotionState, true);
        if (promotionState) {
            elPfx.SetParticleNameAndRefresh(ParticleEffect);
            elPfx.SetControlPoint(16, tierColor.R, tierColor.G, tierColor.B);
        }
    }
    MatchStakes.StartTeamIntro = StartTeamIntro;
})(MatchStakes || (MatchStakes = {}));
(function () {
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWF0Y2hfc3Rha2VzLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvbWF0Y2hfc3Rha2VzLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFDbEMseUNBQXlDO0FBQ3pDLHdDQUF3QztBQUV4QyxJQUFVLFdBQVcsQ0FrTXBCO0FBbE1ELFdBQVUsV0FBVztJQUVwQixJQUFJLGVBQWUsR0FBd0IsU0FBUyxDQUFDO0lBRXJELFNBQVMsSUFBSSxDQUFHLEdBQVc7SUFHM0IsQ0FBQztJQUVELFNBQVMsYUFBYTtRQUVyQixJQUFJLE1BQU0sR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsU0FBUyxFQUFFLENBQUM7UUFFN0MsSUFBSSxTQUFTLENBQUM7UUFDZCxPQUFRLFNBQVMsR0FBRyxNQUFNLENBQUMsU0FBUyxFQUFFO1lBQ3JDLE1BQU0sR0FBRyxTQUFTLENBQUM7UUFFcEIsT0FBTyxNQUFNLENBQUM7SUFDZixDQUFDO0lBRUQsU0FBUyxvQkFBb0I7UUFFNUIsSUFBSyxDQUFDLGVBQWUsRUFDckI7WUFDQyxJQUFJLENBQUUsMkJBQTJCLENBQUUsQ0FBQztZQUNwQyxJQUFJLEtBQUssR0FBRyxhQUFhLEVBQUUsQ0FBQztZQUM1QixlQUFlLEdBQUcsS0FBSyxDQUFDLGlCQUFpQixDQUFFLGFBQWEsQ0FBRSxDQUFDO1NBQzNEO1FBRUQsT0FBTyxlQUFlLENBQUM7SUFDeEIsQ0FBQztJQUVELFNBQWdCLGtCQUFrQixDQUFHLEtBQUssR0FBRyxJQUFJO1FBRWhELE1BQU0sSUFBSSxHQUFHLFdBQVcsQ0FBQyw0QkFBNEIsQ0FBRSxZQUFZLENBQUMsa0JBQWtCLEVBQUUsQ0FBRSxDQUFDO1FBQzNGLElBQUssSUFBSSxLQUFLLFNBQVM7WUFDdEIsT0FBTztRQUVSLElBQUksYUFBYSxHQUFHLG9CQUFvQixFQUFFLENBQUM7UUFFM0MsSUFBSyxDQUFDLGFBQWEsQ0FBQyxJQUFJLEVBQUUsQ0FBQyxtQkFBbUIsRUFDOUM7WUFDQyxhQUFhLENBQUMsS0FBSyxDQUFDLFVBQVUsR0FBRyxLQUFLLENBQUMsQ0FBQyxDQUFDLFNBQVMsQ0FBQyxDQUFDLENBQUMsVUFBVSxDQUFDO1lBQ2hFLGFBQWEsQ0FBQyxXQUFXLENBQUUsWUFBWSxFQUFFLEtBQUssQ0FBRSxDQUFDO1NBQ2pEO0lBQ0YsQ0FBQztJQWJlLDhCQUFrQixxQkFhakMsQ0FBQTtJQUVELFNBQWdCLFlBQVk7UUFFM0IsTUFBTSxJQUFJLEdBQUcsV0FBVyxDQUFDLDRCQUE0QixDQUFFLFlBQVksQ0FBQyxrQkFBa0IsRUFBRSxDQUFFLENBQUM7UUFDM0YsSUFBSyxJQUFJLEtBQUssU0FBUztZQUN0QixPQUFPO1FBRVIsSUFBSSxhQUFhLEdBQUcsb0JBQW9CLEVBQUUsQ0FBQztRQUUzQyxhQUFhLENBQUMsS0FBSyxDQUFDLFVBQVUsR0FBRyxVQUFVLENBQUM7UUFDNUMsYUFBYSxDQUFDLElBQUksRUFBRSxDQUFDLG1CQUFtQixHQUFHLEtBQUssQ0FBQztJQUVsRCxDQUFDO0lBWGUsd0JBQVksZUFXM0IsQ0FBQTtJQU1FLFNBQWdCLGNBQWM7UUE4QmhDLE1BQU0sU0FBUyxHQUFHLFlBQVksQ0FBQyxrQkFBa0IsRUFBRSxDQUFDO1FBRXBELElBQUksU0FBUyxHQUEyQixXQUFXLENBQUMsK0JBQStCLENBQUUsU0FBUyxDQUFFLENBQUM7UUFDakcsSUFBSyxDQUFDLFNBQVMsSUFBSSxTQUFTLENBQUMsUUFBUSxLQUFLLFNBQVM7WUFDbEQsT0FBTztRQUVSLElBQUksYUFBYSxHQUFHLG9CQUFvQixFQUFFLENBQUM7UUFFM0MsYUFBYSxDQUFDLEtBQUssQ0FBQyxVQUFVLEdBQUcsU0FBUyxDQUFDO1FBQzNDLGFBQWEsQ0FBQyxJQUFJLEVBQUUsQ0FBQyxtQkFBbUIsR0FBRyxJQUFJLENBQUM7UUFDaEQsYUFBYSxDQUFDLFdBQVcsQ0FBRSxXQUFXLEVBQUUsU0FBUyxDQUFDLEtBQUssS0FBSyxDQUFDLENBQUUsQ0FBQztRQUVoRSxJQUFJLEtBQUssR0FBRyxhQUFhLENBQUMsaUJBQWlCLENBQUUsa0JBQWtCLENBQUUsQ0FBQztRQUNsRSxJQUFJLE1BQU0sR0FBRyxhQUFhLENBQUMsaUJBQWlCLENBQUUsbUJBQW1CLENBQUUsQ0FBQztRQUNwRSxJQUFJLEtBQUssR0FBRyxhQUFhLENBQUMsaUJBQWlCLENBQUUsbUJBQW1CLENBQTBCLENBQUM7UUFFckYsSUFBSSxPQUFPLEdBQ2pCO1lBQ0MsR0FBRyxFQUFFLFdBQVc7WUFDaEIsSUFBSSxFQUFFLFNBQVM7WUFDZixVQUFVLEVBQUUsYUFBYTtZQUNoQixXQUFXLEVBQUUsU0FBUztZQUMvQixLQUFLLEVBQUUsS0FBSztZQUNaLFlBQVksRUFBRSxJQUFJO1NBSWxCLENBQUM7UUFFRixZQUFZLENBQUMsT0FBTyxDQUFFLE9BQU8sQ0FBRSxDQUFDO1FBR2hDLElBQUksU0FBUyxHQUFHLFlBQVksQ0FBQyxZQUFZLENBQUUsYUFBYSxDQUFFLENBQUM7UUFDM0QsYUFBYSxDQUFDLFdBQVcsQ0FBRSxpQkFBaUIsRUFBRSxTQUFTLEtBQUssRUFBRSxDQUFFLENBQUM7UUFDakUsYUFBYSxDQUFDLGlCQUFpQixDQUFFLFdBQVcsRUFBRSxTQUFTLENBQUUsQ0FBQztRQUMxRCxhQUFhLENBQUMsWUFBWSxDQUFFLGVBQWUsQ0FBRSxDQUFDO1FBRTlDLElBQUksY0FBYyxHQUFHLFlBQVksQ0FBQyxpQkFBaUIsQ0FBRSxhQUFhLENBQUUsQ0FBQztRQUNyRSxJQUFJLGNBQWMsR0FBRyxFQUFFLENBQUM7UUFHeEIsSUFBSSxXQUFXLEdBQUcsRUFBRSxDQUFDO1FBQ3JCLElBQUksU0FBUyxHQUFHLFlBQVksQ0FBQyxXQUFXLENBQUUsU0FBUyxDQUFDLEtBQU0sQ0FBRSxDQUFDO1FBQzdELFdBQVcsR0FBRyxTQUFTLENBQUUsQ0FBQyxDQUFFLENBQUM7UUFDN0IsSUFBSSxJQUFJLEdBQUcsSUFBSSxDQUFDLEtBQUssQ0FBRSxDQUFDLFdBQVcsR0FBRyxHQUFHLENBQUUsQ0FBQztRQUU1QyxJQUFJLFNBQVMsR0FBRyxzQkFBc0IsQ0FBQyxZQUFZLENBQUMsSUFBSSxDQUFDLENBQUM7UUFFMUQsSUFBSyxjQUFjLEtBQUssWUFBWSxFQUNwQztZQUNDLGNBQWMsR0FBRywwREFBMEQsQ0FBQztTQUM1RTthQUNJLElBQUssY0FBYyxLQUFLLFdBQVcsRUFDeEM7WUFDQyxjQUFjLEdBQUcscURBQXFELENBQUM7U0FDdkU7UUFFRCxTQUFTLFNBQVMsQ0FBRyxLQUFjLEVBQUUsVUFBa0IsRUFBRSxLQUFhLEVBQUUsY0FBdUMsRUFBRSxLQUFjO1lBRTlILElBQUksS0FBSyxHQUFHLFVBQVUsR0FBRyxLQUFLLENBQUM7WUFFL0IsSUFBSSxRQUFnQixDQUFDO1lBRXJCLElBQUksYUFBYSxHQUFHLFlBQVksQ0FBQyxXQUFXLENBQUUsVUFBVyxDQUFFLENBQUM7WUFFNUQsSUFBSyxhQUFhLENBQUMsQ0FBQyxDQUFDLEtBQUssR0FBRyxFQUM3QjtnQkFDQyxRQUFRLEdBQUcsQ0FBQyxDQUFDLFFBQVEsQ0FBRSw2QkFBNkIsQ0FBRSxDQUFDO2FBQ3ZEO2lCQUNJLElBQUssYUFBYSxDQUFDLENBQUMsQ0FBQyxLQUFLLEdBQUcsRUFDbEM7Z0JBQ0MsUUFBUSxHQUFHLENBQUMsQ0FBQyxRQUFRLENBQUUsNEJBQTRCLENBQUUsQ0FBQzthQUN0RDtpQkFDSSxJQUFLLEtBQUssS0FBSyxDQUFDLEVBQ3JCO2dCQUNDLFFBQVEsR0FBRyxLQUFLLENBQUMsQ0FBQyxDQUFDLElBQUksQ0FBQyxDQUFDLENBQUMsSUFBSSxDQUFDO2FBQy9CO2lCQUNJLElBQUssS0FBSyxHQUFHLENBQUMsRUFDbkI7Z0JBQ0MsUUFBUSxHQUFHLE1BQU0sQ0FBRSxLQUFLLENBQUUsQ0FBQzthQUMzQjtpQkFFRDtnQkFDQyxRQUFRLEdBQUcsTUFBTSxDQUFFLEdBQUcsR0FBRyxLQUFLLENBQUUsQ0FBQzthQUNqQztZQUVELEtBQUssQ0FBQyxpQkFBaUIsQ0FBRSxPQUFPLEVBQUUsUUFBUSxDQUFFLENBQUM7WUFDN0MsS0FBSyxDQUFDLFdBQVcsQ0FBRSxTQUFTLEVBQUUsSUFBSSxDQUFFLENBQUM7WUFDckMsS0FBSyxDQUFDLFFBQVEsQ0FBRSxlQUFlLENBQUUsQ0FBQztRQUNuQyxDQUFDO1FBRUQsU0FBUyxDQUFFLEtBQUssRUFBRSxTQUFTLENBQUMscUJBQXFCLEVBQUUsU0FBUyxDQUFDLEtBQUssRUFBRSxjQUFjLEVBQUUsS0FBSyxDQUFFLENBQUM7UUFDNUYsU0FBUyxDQUFFLE1BQU0sRUFBRSxTQUFTLENBQUMsc0JBQXNCLEVBQUUsU0FBUyxDQUFDLEtBQUssRUFBRSxjQUFjLEVBQUUsSUFBSSxDQUFFLENBQUM7UUFFN0YsSUFBSyxjQUFjLEVBQ25CO1lBQ0MsS0FBSyxDQUFDLHlCQUF5QixDQUFFLGNBQWMsQ0FBRSxDQUFDO1lBQ2xELEtBQUssQ0FBQyxlQUFlLENBQUUsRUFBRSxFQUFFLFNBQVMsQ0FBQyxDQUFDLEVBQUUsU0FBUyxDQUFDLENBQUMsRUFBRSxTQUFTLENBQUMsQ0FBQyxDQUFFLENBQUM7U0FDbkU7SUFDQyxDQUFDO0lBakllLDBCQUFjLGlCQWlJN0IsQ0FBQTtBQUNMLENBQUMsRUFsTVMsV0FBVyxLQUFYLFdBQVcsUUFrTXBCO0FBRUQsQ0FBRTtBQUVGLENBQUMsQ0FBRSxFQUFFLENBQUMifQ==