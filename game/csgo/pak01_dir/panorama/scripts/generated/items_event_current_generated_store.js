"use strict";
/// <reference path="items_event_current_generated_store.d.ts" />
var g_ActiveTournamentInfo = {
    eventid: 25,
    organization: 'star',
    location: 'bud2025',
    stickerid_graffiti: 9653,
    itemid_pass: 5209,
    itemid_coins: [
        5210, 5211, 5212, 5213
    ],
    itemid_pack: 5214,
    itemid_charge: 5215,
    souvenirs: {
        de_inferno: 5219,
        de_mirage: 5220,
        de_overpass: 5221,
        de_dust2: 5222,
        de_ancient: 5223,
        de_nuke: 5224,
        de_train: 5225,
    },
    num_global_offerings: 1,
    num_stages_with_swiss: 3,
    active: false,
};
var g_ActiveTournamentTeams = [
    {
        teamid: 85,
        team: 'furi',
        stickerid_graffiti: 9621,
        team_group: 'legends',
    },
    {
        teamid: 89,
        team: 'vita',
        stickerid_graffiti: 9622,
        team_group: 'legends',
    },
    {
        teamid: 139,
        team: 'fal',
        stickerid_graffiti: 9623,
        team_group: 'legends',
    },
    {
        teamid: 122,
        team: 'mngz',
        stickerid_graffiti: 9624,
        team_group: 'legends',
    },
    {
        teamid: 106,
        team: 'mouz',
        stickerid_graffiti: 9625,
        team_group: 'legends',
    },
    {
        teamid: 81,
        team: 'spir',
        stickerid_graffiti: 9626,
        team_group: 'legends',
    },
    {
        teamid: 59,
        team: 'g2',
        stickerid_graffiti: 9627,
        team_group: 'legends',
    },
    {
        teamid: 102,
        team: 'pain',
        stickerid_graffiti: 9628,
        team_group: 'legends',
    },
    {
        teamid: 134,
        team: 'aura',
        stickerid_graffiti: 9629,
        team_group: 'challengers',
    },
    {
        teamid: 12,
        team: 'navi',
        stickerid_graffiti: 9630,
        team_group: 'challengers',
    },
    {
        teamid: 48,
        team: 'liq',
        stickerid_graffiti: 9631,
        team_group: 'challengers',
    },
    {
        teamid: 28,
        team: '3dm',
        stickerid_graffiti: 9632,
        team_group: 'challengers',
    },
    {
        teamid: 60,
        team: 'astr',
        stickerid_graffiti: 9633,
        team_group: 'challengers',
    },
    {
        teamid: 74,
        team: 'tyl',
        stickerid_graffiti: 9634,
        team_group: 'challengers',
    },
    {
        teamid: 80,
        team: 'mibr',
        stickerid_graffiti: 9635,
        team_group: 'challengers',
    },
    {
        teamid: 133,
        team: 'psnu',
        stickerid_graffiti: 9636,
        team_group: 'challengers',
    },
    {
        teamid: 126,
        team: 'lgcy',
        stickerid_graffiti: 9637,
        team_group: 'contenders',
    },
    {
        teamid: 61,
        team: 'faze',
        stickerid_graffiti: 9638,
        team_group: 'contenders',
    },
    {
        teamid: 135,
        team: 'b8',
        stickerid_graffiti: 9639,
        team_group: 'contenders',
    },
    {
        teamid: 115,
        team: 'gl',
        stickerid_graffiti: 9640,
        team_group: 'contenders',
    },
    {
        teamid: 6,
        team: 'fntc',
        stickerid_graffiti: 9641,
        team_group: 'contenders',
    },
    {
        teamid: 142,
        team: 'pari',
        stickerid_graffiti: 9642,
        team_group: 'contenders',
    },
    {
        teamid: 1,
        team: 'nip',
        stickerid_graffiti: 9643,
        team_group: 'contenders',
    },
    {
        teamid: 113,
        team: 'imp',
        stickerid_graffiti: 9644,
        team_group: 'contenders',
    },
    {
        teamid: 132,
        team: 'fq',
        stickerid_graffiti: 9645,
        team_group: 'contenders',
    },
    {
        teamid: 127,
        team: 'lynn',
        stickerid_graffiti: 9646,
        team_group: 'contenders',
    },
    {
        teamid: 140,
        team: 'm80',
        stickerid_graffiti: 9647,
        team_group: 'contenders',
    },
    {
        teamid: 121,
        team: 'flux',
        stickerid_graffiti: 9648,
        team_group: 'contenders',
    },
    {
        teamid: 144,
        team: 'redc',
        stickerid_graffiti: 9649,
        team_group: 'contenders',
    },
    {
        teamid: 143,
        team: 'huns',
        stickerid_graffiti: 9650,
        team_group: 'contenders',
    },
    {
        teamid: 87,
        team: 'nrg',
        stickerid_graffiti: 9651,
        team_group: 'contenders',
    },
    {
        teamid: 131,
        team: 'ratm',
        stickerid_graffiti: 9652,
        team_group: 'contenders',
    },
];
var g_ActiveTournamentStoreLayout = [
    [
        g_ActiveTournamentInfo.itemid_pass,
        g_ActiveTournamentInfo.itemid_pack,
        '#CSGO_TournamentPass_bud2025_pack_tinyname'
    ],
    [
        5216,
        5230,
        '#CSGO_crate_store_pack_bud2025_legends_groupname'
    ],
    [
        5217,
        5231,
        '#CSGO_crate_store_pack_bud2025_challengers_groupname'
    ],
    [
        5218,
        5232,
        '#CSGO_crate_store_pack_bud2025_contenders_groupname'
    ],
    [
        5233,
        '#CSGO_crate_store_pack_bud2025_signatures_groupname'
    ],
];
var g_ActiveTournamentPasses = [
    g_ActiveTournamentInfo.itemid_pass,
    g_ActiveTournamentInfo.itemid_pack,
];
