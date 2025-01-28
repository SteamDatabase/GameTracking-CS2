"use strict";
/// <reference path="../rating_emblem.ts" />
function setupTooltip() {
    var rank = $.GetContextPanel().GetAttributeString("rank", "not-found");
    var week_name = $.GetContextPanel().GetAttributeString("week_name", "not-found");
    var week_idx = $.GetContextPanel().GetAttributeString("week_idx", "not-found");
    if (week_name) {
        $.GetContextPanel().SetDialogVariable('week-name', week_name);
        $.GetContextPanel().SetDialogVariable('week-id', week_idx);
    }
    if (!rank || rank === "not-found") {
        $.GetContextPanel().FindChildInLayoutFile('id-tooltip-premier-rating').SetHasClass('show', false);
        return;
    }
    const options = {
        root_panel: $.GetContextPanel().FindChildInLayoutFile('id-tooltip-premier-rating'),
        do_fx: false,
        full_details: false,
        rating_type: 'Premier',
        leaderboard_details: { score: parseInt(rank) },
        local_player: false
    };
    $.GetContextPanel().FindChildInLayoutFile('id-tooltip-premier-rating').SetHasClass('show', true);
    RatingEmblem.SetXuid(options);
}
