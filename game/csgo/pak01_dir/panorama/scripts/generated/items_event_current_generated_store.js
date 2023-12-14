"use strict";
/// <reference path="items_event_current_generated_store.d.ts" />
var g_ActiveTournamentInfo = {
    eventid: 21,
    organization: 'blst',
    location: 'paris2023',
    stickerid_graffiti: 6732,
    itemid_pass: 4883,
    itemid_coins: [
        4884, 4885, 4886, 4887
    ],
    itemid_pack: 4888,
    itemid_charge: 4889,
    num_global_offerings: 1,
    active: false,
};
var g_ActiveTournamentTeams = [
    {
        teamid: 6,
        team: 'fntc',
        stickerid_graffiti: 6708,
        team_group: 'legends',
    },
    {
        teamid: 12,
        team: 'navi',
        stickerid_graffiti: 6709,
        team_group: 'legends',
    },
    {
        teamid: 85,
        team: 'furi',
        stickerid_graffiti: 6710,
        team_group: 'legends',
    },
    {
        teamid: 89,
        team: 'vita',
        stickerid_graffiti: 6711,
        team_group: 'legends',
    },
    {
        teamid: 95,
        team: 'hero',
        stickerid_graffiti: 6712,
        team_group: 'legends',
    },
    {
        teamid: 114,
        team: 'bne',
        stickerid_graffiti: 6713,
        team_group: 'legends',
    },
    {
        teamid: 118,
        team: 'itb',
        stickerid_graffiti: 6714,
        team_group: 'legends',
    },
    {
        teamid: 120,
        team: 'nein',
        stickerid_graffiti: 6715,
        team_group: 'legends',
    },
    {
        teamid: 1,
        team: 'nip',
        stickerid_graffiti: 6716,
        team_group: 'challengers',
    },
    {
        teamid: 59,
        team: 'g2',
        stickerid_graffiti: 6717,
        team_group: 'challengers',
    },
    {
        teamid: 90,
        team: 'forz',
        stickerid_graffiti: 6718,
        team_group: 'challengers',
    },
    {
        teamid: 96,
        team: 'og',
        stickerid_graffiti: 6719,
        team_group: 'challengers',
    },
    {
        teamid: 102,
        team: 'pain',
        stickerid_graffiti: 6720,
        team_group: 'challengers',
    },
    {
        teamid: 115,
        team: 'gl',
        stickerid_graffiti: 6721,
        team_group: 'challengers',
    },
    {
        teamid: 117,
        team: 'apex',
        stickerid_graffiti: 6722,
        team_group: 'challengers',
    },
    {
        teamid: 119,
        team: 'mont',
        stickerid_graffiti: 6723,
        team_group: 'challengers',
    },
    {
        teamid: 48,
        team: 'liq',
        stickerid_graffiti: 6724,
        team_group: 'contenders',
    },
    {
        teamid: 61,
        team: 'faze',
        stickerid_graffiti: 6725,
        team_group: 'contenders',
    },
    {
        teamid: 84,
        team: 'ence',
        stickerid_graffiti: 6726,
        team_group: 'contenders',
    },
    {
        teamid: 86,
        team: 'gray',
        stickerid_graffiti: 6727,
        team_group: 'contenders',
    },
    {
        teamid: 106,
        team: 'mouz',
        stickerid_graffiti: 6728,
        team_group: 'contenders',
    },
    {
        teamid: 111,
        team: 'cplx',
        stickerid_graffiti: 6729,
        team_group: 'contenders',
    },
    {
        teamid: 121,
        team: 'flux',
        stickerid_graffiti: 6730,
        team_group: 'contenders',
    },
    {
        teamid: 122,
        team: 'mngz',
        stickerid_graffiti: 6731,
        team_group: 'contenders',
    },
];
var g_ActiveTournamentStoreLayout = [
    [
        g_ActiveTournamentInfo.itemid_pass,
        g_ActiveTournamentInfo.itemid_pack,
        '#CSGO_TournamentPass_paris2023_pack_tinyname'
    ],
    [
        4890,
        4900,
        '#CSGO_crate_store_pack_paris2023_legends_groupname'
    ],
    [
        4891,
        4901,
        '#CSGO_crate_store_pack_paris2023_challengers_groupname'
    ],
    [
        4892,
        4902,
        '#CSGO_crate_store_pack_paris2023_contenders_groupname'
    ],
    [
        4903,
        '#CSGO_crate_store_pack_paris2023_signatures_groupname'
    ],
];
var g_ActiveTournamentPasses = [
    g_ActiveTournamentInfo.itemid_pass,
    g_ActiveTournamentInfo.itemid_pack,
];
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaXRlbXNfZXZlbnRfY3VycmVudF9nZW5lcmF0ZWRfc3RvcmUuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9nZW5lcmF0ZWQvaXRlbXNfZXZlbnRfY3VycmVudF9nZW5lcmF0ZWRfc3RvcmUudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLGlFQUFpRTtBQVlqRSxJQUFJLHNCQUFzQixHQUMxQjtJQUNDLE9BQU8sRUFBRSxFQUFFO0lBQ1gsWUFBWSxFQUFFLE1BQU07SUFDcEIsUUFBUSxFQUFFLFdBQVc7SUFDckIsa0JBQWtCLEVBQUUsSUFBSTtJQUN4QixXQUFXLEVBQUUsSUFBSTtJQUNqQixZQUFZLEVBQUU7UUFDYixJQUFJLEVBQUUsSUFBSSxFQUFFLElBQUksRUFBRSxJQUFJO0tBQ3RCO0lBQ0QsV0FBVyxFQUFFLElBQUk7SUFDakIsYUFBYSxFQUFFLElBQUk7SUFDbkIsb0JBQW9CLEVBQUUsQ0FBQztJQUN2QixNQUFNLEVBQUUsS0FBSztDQUNiLENBQUM7QUFLRixJQUFJLHVCQUF1QixHQUMzQjtJQUVDO1FBQ0MsTUFBTSxFQUFFLENBQUM7UUFDVCxJQUFJLEVBQUUsTUFBTTtRQUNaLGtCQUFrQixFQUFFLElBQUk7UUFDeEIsVUFBVSxFQUFFLFNBQVM7S0FDckI7SUFFRDtRQUNDLE1BQU0sRUFBRSxFQUFFO1FBQ1YsSUFBSSxFQUFFLE1BQU07UUFDWixrQkFBa0IsRUFBRSxJQUFJO1FBQ3hCLFVBQVUsRUFBRSxTQUFTO0tBQ3JCO0lBRUQ7UUFDQyxNQUFNLEVBQUUsRUFBRTtRQUNWLElBQUksRUFBRSxNQUFNO1FBQ1osa0JBQWtCLEVBQUUsSUFBSTtRQUN4QixVQUFVLEVBQUUsU0FBUztLQUNyQjtJQUVEO1FBQ0MsTUFBTSxFQUFFLEVBQUU7UUFDVixJQUFJLEVBQUUsTUFBTTtRQUNaLGtCQUFrQixFQUFFLElBQUk7UUFDeEIsVUFBVSxFQUFFLFNBQVM7S0FDckI7SUFFRDtRQUNDLE1BQU0sRUFBRSxFQUFFO1FBQ1YsSUFBSSxFQUFFLE1BQU07UUFDWixrQkFBa0IsRUFBRSxJQUFJO1FBQ3hCLFVBQVUsRUFBRSxTQUFTO0tBQ3JCO0lBRUQ7UUFDQyxNQUFNLEVBQUUsR0FBRztRQUNYLElBQUksRUFBRSxLQUFLO1FBQ1gsa0JBQWtCLEVBQUUsSUFBSTtRQUN4QixVQUFVLEVBQUUsU0FBUztLQUNyQjtJQUVEO1FBQ0MsTUFBTSxFQUFFLEdBQUc7UUFDWCxJQUFJLEVBQUUsS0FBSztRQUNYLGtCQUFrQixFQUFFLElBQUk7UUFDeEIsVUFBVSxFQUFFLFNBQVM7S0FDckI7SUFFRDtRQUNDLE1BQU0sRUFBRSxHQUFHO1FBQ1gsSUFBSSxFQUFFLE1BQU07UUFDWixrQkFBa0IsRUFBRSxJQUFJO1FBQ3hCLFVBQVUsRUFBRSxTQUFTO0tBQ3JCO0lBRUQ7UUFDQyxNQUFNLEVBQUUsQ0FBQztRQUNULElBQUksRUFBRSxLQUFLO1FBQ1gsa0JBQWtCLEVBQUUsSUFBSTtRQUN4QixVQUFVLEVBQUUsYUFBYTtLQUN6QjtJQUVEO1FBQ0MsTUFBTSxFQUFFLEVBQUU7UUFDVixJQUFJLEVBQUUsSUFBSTtRQUNWLGtCQUFrQixFQUFFLElBQUk7UUFDeEIsVUFBVSxFQUFFLGFBQWE7S0FDekI7SUFFRDtRQUNDLE1BQU0sRUFBRSxFQUFFO1FBQ1YsSUFBSSxFQUFFLE1BQU07UUFDWixrQkFBa0IsRUFBRSxJQUFJO1FBQ3hCLFVBQVUsRUFBRSxhQUFhO0tBQ3pCO0lBRUQ7UUFDQyxNQUFNLEVBQUUsRUFBRTtRQUNWLElBQUksRUFBRSxJQUFJO1FBQ1Ysa0JBQWtCLEVBQUUsSUFBSTtRQUN4QixVQUFVLEVBQUUsYUFBYTtLQUN6QjtJQUVEO1FBQ0MsTUFBTSxFQUFFLEdBQUc7UUFDWCxJQUFJLEVBQUUsTUFBTTtRQUNaLGtCQUFrQixFQUFFLElBQUk7UUFDeEIsVUFBVSxFQUFFLGFBQWE7S0FDekI7SUFFRDtRQUNDLE1BQU0sRUFBRSxHQUFHO1FBQ1gsSUFBSSxFQUFFLElBQUk7UUFDVixrQkFBa0IsRUFBRSxJQUFJO1FBQ3hCLFVBQVUsRUFBRSxhQUFhO0tBQ3pCO0lBRUQ7UUFDQyxNQUFNLEVBQUUsR0FBRztRQUNYLElBQUksRUFBRSxNQUFNO1FBQ1osa0JBQWtCLEVBQUUsSUFBSTtRQUN4QixVQUFVLEVBQUUsYUFBYTtLQUN6QjtJQUVEO1FBQ0MsTUFBTSxFQUFFLEdBQUc7UUFDWCxJQUFJLEVBQUUsTUFBTTtRQUNaLGtCQUFrQixFQUFFLElBQUk7UUFDeEIsVUFBVSxFQUFFLGFBQWE7S0FDekI7SUFFRDtRQUNDLE1BQU0sRUFBRSxFQUFFO1FBQ1YsSUFBSSxFQUFFLEtBQUs7UUFDWCxrQkFBa0IsRUFBRSxJQUFJO1FBQ3hCLFVBQVUsRUFBRSxZQUFZO0tBQ3hCO0lBRUQ7UUFDQyxNQUFNLEVBQUUsRUFBRTtRQUNWLElBQUksRUFBRSxNQUFNO1FBQ1osa0JBQWtCLEVBQUUsSUFBSTtRQUN4QixVQUFVLEVBQUUsWUFBWTtLQUN4QjtJQUVEO1FBQ0MsTUFBTSxFQUFFLEVBQUU7UUFDVixJQUFJLEVBQUUsTUFBTTtRQUNaLGtCQUFrQixFQUFFLElBQUk7UUFDeEIsVUFBVSxFQUFFLFlBQVk7S0FDeEI7SUFFRDtRQUNDLE1BQU0sRUFBRSxFQUFFO1FBQ1YsSUFBSSxFQUFFLE1BQU07UUFDWixrQkFBa0IsRUFBRSxJQUFJO1FBQ3hCLFVBQVUsRUFBRSxZQUFZO0tBQ3hCO0lBRUQ7UUFDQyxNQUFNLEVBQUUsR0FBRztRQUNYLElBQUksRUFBRSxNQUFNO1FBQ1osa0JBQWtCLEVBQUUsSUFBSTtRQUN4QixVQUFVLEVBQUUsWUFBWTtLQUN4QjtJQUVEO1FBQ0MsTUFBTSxFQUFFLEdBQUc7UUFDWCxJQUFJLEVBQUUsTUFBTTtRQUNaLGtCQUFrQixFQUFFLElBQUk7UUFDeEIsVUFBVSxFQUFFLFlBQVk7S0FDeEI7SUFFRDtRQUNDLE1BQU0sRUFBRSxHQUFHO1FBQ1gsSUFBSSxFQUFFLE1BQU07UUFDWixrQkFBa0IsRUFBRSxJQUFJO1FBQ3hCLFVBQVUsRUFBRSxZQUFZO0tBQ3hCO0lBRUQ7UUFDQyxNQUFNLEVBQUUsR0FBRztRQUNYLElBQUksRUFBRSxNQUFNO1FBQ1osa0JBQWtCLEVBQUUsSUFBSTtRQUN4QixVQUFVLEVBQUUsWUFBWTtLQUN4QjtDQUNELENBQUM7QUFNRixJQUFJLDZCQUE2QixHQUNqQztJQUNDO1FBQ0Esc0JBQXNCLENBQUMsV0FBVztRQUNsQyxzQkFBc0IsQ0FBQyxXQUFXO1FBQ2xDLDhDQUE4QztLQUM3QztJQUNEO1FBQ0EsSUFBSTtRQUNKLElBQUk7UUFDSixvREFBb0Q7S0FDbkQ7SUFDRDtRQUNBLElBQUk7UUFDSixJQUFJO1FBQ0osd0RBQXdEO0tBQ3ZEO0lBQ0Q7UUFDQSxJQUFJO1FBQ0osSUFBSTtRQUNKLHVEQUF1RDtLQUN0RDtJQUNEO1FBQ0EsSUFBSTtRQUNKLHVEQUF1RDtLQUN0RDtDQUNELENBQUM7QUFFRixJQUFJLHdCQUF3QixHQUM1QjtJQUNDLHNCQUFzQixDQUFDLFdBQVc7SUFDbEMsc0JBQXNCLENBQUMsV0FBVztDQUNsQyxDQUFDIn0=