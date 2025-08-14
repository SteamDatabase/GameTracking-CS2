"use strict";
/// <reference path="items_event_current_generated_store.d.ts" />
var g_ActiveTournamentInfo = {
    eventid: 24,
    organization: 'blst',
    location: 'aus2025',
    stickerid_graffiti: 8718,
    itemid_pass: 5110,
    itemid_coins: [
        5111, 5112, 5113, 5114
    ],
    itemid_pack: 5115,
    itemid_charge: 5116,
    souvenirs: {
        de_inferno: 5120,
        de_mirage: 5121,
        de_anubis: 5122,
        de_dust2: 5123,
        de_ancient: 5124,
        de_nuke: 5125,
        de_train: 5126,
    },
    num_global_offerings: 1,
    num_stages_with_swiss: 3,
    active: false,
};
var g_ActiveTournamentTeams = [
    {
        teamid: 89,
        team: 'vita',
        stickerid_graffiti: 8686,
        team_group: 'legends',
    },
    {
        teamid: 106,
        team: 'mouz',
        stickerid_graffiti: 8687,
        team_group: 'legends',
    },
    {
        teamid: 81,
        team: 'spir',
        stickerid_graffiti: 8688,
        team_group: 'legends',
    },
    {
        teamid: 122,
        team: 'mngz',
        stickerid_graffiti: 8689,
        team_group: 'legends',
    },
    {
        teamid: 134,
        team: 'aura',
        stickerid_graffiti: 8690,
        team_group: 'legends',
    },
    {
        teamid: 12,
        team: 'navi',
        stickerid_graffiti: 8691,
        team_group: 'legends',
    },
    {
        teamid: 59,
        team: 'g2',
        stickerid_graffiti: 8692,
        team_group: 'legends',
    },
    {
        teamid: 48,
        team: 'liq',
        stickerid_graffiti: 8693,
        team_group: 'legends',
    },
    {
        teamid: 139,
        team: 'fal',
        stickerid_graffiti: 8694,
        team_group: 'challengers',
    },
    {
        teamid: 61,
        team: 'faze',
        stickerid_graffiti: 8695,
        team_group: 'challengers',
    },
    {
        teamid: 28,
        team: '3dm',
        stickerid_graffiti: 8696,
        team_group: 'challengers',
    },
    {
        teamid: 31,
        team: 'vp',
        stickerid_graffiti: 8697,
        team_group: 'challengers',
    },
    {
        teamid: 102,
        team: 'pain',
        stickerid_graffiti: 8698,
        team_group: 'challengers',
    },
    {
        teamid: 85,
        team: 'furi',
        stickerid_graffiti: 8699,
        team_group: 'challengers',
    },
    {
        teamid: 80,
        team: 'mibr',
        stickerid_graffiti: 8700,
        team_group: 'challengers',
    },
    {
        teamid: 140,
        team: 'm80',
        stickerid_graffiti: 8701,
        team_group: 'challengers',
    },
    {
        teamid: 111,
        team: 'cplx',
        stickerid_graffiti: 8702,
        team_group: 'contenders',
    },
    {
        teamid: 130,
        team: 'wcrd',
        stickerid_graffiti: 8703,
        team_group: 'contenders',
    },
    {
        teamid: 95,
        team: 'hero',
        stickerid_graffiti: 8704,
        team_group: 'contenders',
    },
    {
        teamid: 135,
        team: 'b8',
        stickerid_graffiti: 8705,
        team_group: 'contenders',
    },
    {
        teamid: 96,
        team: 'og',
        stickerid_graffiti: 8706,
        team_group: 'contenders',
    },
    {
        teamid: 107,
        team: 'nemi',
        stickerid_graffiti: 8707,
        team_group: 'contenders',
    },
    {
        teamid: 137,
        team: 'bb',
        stickerid_graffiti: 8708,
        team_group: 'contenders',
    },
    {
        teamid: 113,
        team: 'imp',
        stickerid_graffiti: 8709,
        team_group: 'contenders',
    },
    {
        teamid: 87,
        team: 'nrg',
        stickerid_graffiti: 8710,
        team_group: 'contenders',
    },
    {
        teamid: 132,
        team: 'fq',
        stickerid_graffiti: 8711,
        team_group: 'contenders',
    },
    {
        teamid: 141,
        team: 'meti',
        stickerid_graffiti: 8712,
        team_group: 'contenders',
    },
    {
        teamid: 74,
        team: 'tyl',
        stickerid_graffiti: 8713,
        team_group: 'contenders',
    },
    {
        teamid: 121,
        team: 'flux',
        stickerid_graffiti: 8714,
        team_group: 'contenders',
    },
    {
        teamid: 138,
        team: 'chin',
        stickerid_graffiti: 8715,
        team_group: 'contenders',
    },
    {
        teamid: 127,
        team: 'lynn',
        stickerid_graffiti: 8716,
        team_group: 'contenders',
    },
    {
        teamid: 126,
        team: 'lgcy',
        stickerid_graffiti: 8717,
        team_group: 'contenders',
    },
];
var g_ActiveTournamentStoreLayout = [
    [
        g_ActiveTournamentInfo.itemid_pass,
        g_ActiveTournamentInfo.itemid_pack,
        '#CSGO_TournamentPass_aus2025_pack_tinyname'
    ],
    [
        5117,
        5131,
        '#CSGO_crate_store_pack_aus2025_legends_groupname'
    ],
    [
        5118,
        5132,
        '#CSGO_crate_store_pack_aus2025_challengers_groupname'
    ],
    [
        5119,
        5133,
        '#CSGO_crate_store_pack_aus2025_contenders_groupname'
    ],
    [
        5134,
        '#CSGO_crate_store_pack_aus2025_signatures_groupname'
    ],
];
var g_ActiveTournamentPasses = [
    g_ActiveTournamentInfo.itemid_pass,
    g_ActiveTournamentInfo.itemid_pack,
];
