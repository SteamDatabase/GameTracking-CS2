"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="rating_emblem.ts" />
var SeasonProgress;
(function (SeasonProgress) {
    function _Init() {
        SetRating();
    }
    function SetRating() {
        let elRatingEmblem = $.GetContextPanel().FindChildInLayoutFile('js-highest-rating');
        let rating = MyPersonaAPI.GetPipRankHighest("Premier");
        let options;
        options = {
            root_panel: elRatingEmblem,
            rating_type: 'Premier',
            leaderboard_details: { score: rating },
            do_fx: true,
            full_details: false,
            local_player: true
        };
        RatingEmblem.SetXuid(options);
        _SetProgressBar(rating);
    }
    SeasonProgress.SetRating = SetRating;
    function _SetProgressBar(rating) {
        let nWins = MyPersonaAPI.GetPipRankWins("Premier");
        let clampedRating = RatingEmblem.GetClampedRating(rating);
        let color = clampedRating;
        let nBars = nWins > 24 && nWins < 50 ? 1 :
            nWins > 49 && nWins < 75 ? 2 :
                nWins > 74 && nWins < 100 ? 3 :
                    nWins > 99 && nWins < 125 ? 4 :
                        nWins > 124 ? 5 :
                            0;
        nBars = nBars < 5 ? nBars + 1 : 5;
        let elPips = $.GetContextPanel().FindChildInLayoutFile('id-premier-season-pips');
        elPips.SwitchClass('scale', (nBars === 4) ? 'four-medals' : (nBars === 5) ? 'five-medals' : (nBars === 2) ? 'two-medals' : '');
        let nTotalBars = nBars * 25;
        let nTotalPips = nTotalBars < 126 ? nTotalBars + 1 : nTotalBars;
        let nSinglePipWidth = (nTotalPips < 27) ? 17 :
            (nTotalPips > 27 && nTotalPips < 52) ? 7 :
                (nTotalPips > 52 && nTotalPips < 77) ? 4 :
                    (nTotalPips > 77 && nTotalPips < 102) ? 3 :
                        (nTotalPips > 102 && nTotalPips < 127) ? 2 :
                            4;
        for (let i = 1; i < nTotalPips; i++) {
            let elPip = elPips.FindChild('pip-' + i);
            if (!elPip) {
                elPip = $.CreatePanel('Panel', elPips, 'pip-' + i, { clampfractionalpixelpositions: "false", class: 'premier-season-progress-pip' });
                let isMedalPip = (i % 25 === 0 && i !== 0);
                elPip.SetHasClass('premier-season-progress-pip-medal', isMedalPip);
                if (!isMedalPip)
                    elPip.style.width = nSinglePipWidth + 'px;';
            }
            if (i <= nWins) {
                elPip.SwitchClass('tier', 'tier-' + color);
            }
            else {
                elPip.SwitchClass('tier', 'tier-none');
            }
        }
        clampedRating = clampedRating < 1 ? 1 : clampedRating + 1;
        let itemDef = InventoryAPI.GetItemDefinitionIndexFromDefinitionName('premier season coin s=2 c=' + clampedRating + ' b=' + nBars);
        let itemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(itemDef, 0);
        $.GetContextPanel().FindChildInLayoutFile('id-medal-end').itemid = itemId;
        $.GetContextPanel().SetDialogVariableInt('wins', nWins);
        $.GetContextPanel().SetDialogVariableInt('threshold', nBars * 25);
    }
    function ReadyForDisplay() {
        SetRating();
    }
    SeasonProgress.ReadyForDisplay = ReadyForDisplay;
    function UnReadyForDisplay() {
    }
    SeasonProgress.UnReadyForDisplay = UnReadyForDisplay;
    function PipRankUpdate() {
        SetRating();
    }
    SeasonProgress.PipRankUpdate = PipRankUpdate;
    {
        $.RegisterEventHandler('ReadyForDisplay', $.GetContextPanel(), SeasonProgress.ReadyForDisplay);
        $.RegisterEventHandler('UnreadyForDisplay', $.GetContextPanel(), SeasonProgress.UnReadyForDisplay);
        $.RegisterForUnhandledEvent('PanoramaComponent_MyPersona_PipRankUpdate', PipRankUpdate);
        _Init();
    }
})(SeasonProgress || (SeasonProgress = {}));
