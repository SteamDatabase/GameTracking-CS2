import { Instance } from "csdeathmatchscript";
Instance.Msg("starting cs_deathmatch.ts");
// TODO: expose consts to SourceTS
const MAX_PLAYERS = 64;
const TEAM_INVALID = -1;
const TEAM_UNASSIGNED = 0;
const TEAM_TERRORIST = 2;
const TEAM_CT = 3;
const INVALID_PLAYERSLOT = -1;
const OBS_MODE_NONE = 0; // not in spectator mode
const OBS_MODE_FIXED = 1; // view from a fixed camera position
const OBS_MODE_IN_EYE = 2; // follow a player in first person view
const OBS_MODE_CHASE = 3; // follow a player in third person view
const OBS_MODE_ROAMING = 4; // free roaming
// TODO: Improve SourceTS convar API
const mp_warmup_offline_enabled = () => Instance.Get_mp_warmup_offline_enabled();
const mp_warmup_online_enabled = () => Instance.Get_mp_warmup_online_enabled();
const mp_teammates_are_enemies = () => Instance.Get_mp_teammates_are_enemies();
const sv_warmup_to_freezetime_delay = () => Instance.Get_sv_warmup_to_freezetime_delay();
const mp_dm_time_between_bonus_min = () => Instance.Get_mp_dm_time_between_bonus_min();
const mp_dm_time_between_bonus_max = () => Instance.Get_mp_dm_time_between_bonus_max();
const mp_dm_bonus_length_min = () => Instance.Get_mp_dm_bonus_length_min();
const mp_dm_bonus_length_max = () => Instance.Get_mp_dm_bonus_length_max();
const mp_dm_kill_base_score = () => Instance.Get_mp_dm_kill_base_score();
const mp_dm_bonus_percent = () => Instance.Get_mp_dm_bonus_percent();
const mp_dm_healthshot_killcount = () => Instance.Get_mp_dm_healthshot_killcount();
;
const e_RoundEndReason = {
    Invalid_Round_End_Reason: -1,
    RoundEndReason_StillInProgress: 0,
    Target_Bombed: 1,
    VIP_Escaped: 2,
    VIP_Assassinated: 3,
    Terrorists_Escaped: 4,
    CTs_PreventEscape: 5,
    Escaping_Terrorists_Neutralized: 6,
    Bomb_Defused: 7,
    CTs_Win: 8,
    Terrorists_Win: 9,
    Round_Draw: 10,
    All_Hostages_Rescued: 11,
    Target_Saved: 12,
    Hostages_Not_Rescued: 13,
    Terrorists_Not_Escaped: 14,
    VIP_Not_Escaped: 15,
    Game_Commencing: 16,
    Terrorists_Surrender: 17,
    CTs_Surrender: 18,
    Terrorists_Planted: 19,
    CTs_ReachedHostage: 20,
    Survival_Win: 21,
    Survival_Draw: 22,
    RoundEndReason_Count: 23
};
const bonus_weapon_slots = [2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18];
if (Instance.IsServer()) {
    const Server = Instance;
    let bFirstThink = true;
    let bFirstThinkAfterConnected = false;
    const mKillStreaks = new Map();
    const mTaserStreaks = new Map();
    let flBonusWeaponStartTime = -1;
    let flBonusWeaponDuration = -1;
    let nBonusWeaponSlot = -1;
    Server.OnThink(() => {
        if (bFirstThink) {
            bFirstThink = false;
            Server.SetIsFirstConnected(false);
            Server.ResetMatch();
            Server.ResetRound();
            Server.FreezePlayers();
            Server.BeginFreezePeriod();
        }
        if (Server.CheckGameOver())
            return;
        if (Server.IsFreezePeriod())
            return;
        if (bFirstThinkAfterConnected) {
            bFirstThinkAfterConnected = false;
            for (let i = 0; i < MAX_PLAYERS; ++i) {
                let controller = Server.GetPlayerController(i);
                if (controller?.IsObserving()) {
                    let observer = controller.GetObserver();
                    let nObserverMode = observer.GetObserverMode();
                    if (nObserverMode != OBS_MODE_CHASE && nObserverMode != OBS_MODE_IN_EYE)
                        observer.SetObserverMode(OBS_MODE_CHASE);
                }
            }
            Server.UnfreezePlayers();
        }
        if (Server.IsWarmupPeriod() && Server.GetGameTime() >= Server.GetWarmupPeriodEndTime() - 1) // This 1 second is to counter the fudging done in CCSGO_HudMatchAlerts::ShowWarmupAlertPanel
         {
            Server.FreezePlayers();
            Server.BeginGameRestart(sv_warmup_to_freezetime_delay());
        }
        if (Server.IsGameRestarting() && Server.GetGameTime() > Server.GetRoundRestartTime()) {
            Server.ResetMatch();
            Server.BeginMatch();
            Server.ResetRound();
            Server.BeginRound();
            Server.UnfreezePlayers();
        }
        if (Server.IsInMatch() && Server.GetRoundRemainingTime() <= 0) {
            let nWinningTeam = TEAM_UNASSIGNED;
            let nMaxScore = -1;
            for (let nPlayer = 0; nPlayer < 64; nPlayer++) {
                let pPlayer = Server.GetPlayerController(nPlayer);
                if (!pPlayer)
                    continue;
                let nTeamNumber = pPlayer.GetTeamNumber();
                let nScore = pPlayer.GetScore();
                if (nScore >= nMaxScore) {
                    nWinningTeam = nTeamNumber;
                    nMaxScore = nScore;
                }
            }
            let nRoundEndReason = e_RoundEndReason.Round_Draw;
            if (nWinningTeam == TEAM_CT)
                nRoundEndReason = e_RoundEndReason.CTs_Win;
            else if (nWinningTeam == TEAM_TERRORIST)
                nRoundEndReason = e_RoundEndReason.Terrorists_Win;
            Server.EndBonusWeapon();
            Server.FreezePlayers();
            Server.EndRound(nRoundEndReason);
            Server.BeginIntermission();
        }
        if (Server.IsInMatch())
            HandleDeathmatchBonusWeapon();
    });
    Server.OnResetRound(() => {
        mKillStreaks.clear();
        mTaserStreaks.clear();
        nBonusWeaponSlot = -1;
        flBonusWeaponStartTime = -1;
        flBonusWeaponDuration = -1;
        Server.EndBonusWeapon();
    });
    Server.OnRestartMatch(() => {
        for (let i = 0; i < MAX_PLAYERS; ++i) {
            const player = Server.GetPlayerController(i);
            if (!player)
                continue;
            if (player.IsFakeClient())
                Server.KickClient(i);
            else
                player.ChangeTeam(TEAM_UNASSIGNED);
        }
        Server.SetIsFirstConnected(false);
        Server.ResetMatch();
        Server.ResetRound();
        Server.FreezePlayers();
        Server.BeginFreezePeriod();
    });
    Server.OnPlayerChangedTeam((player) => {
        if (player && !player.IsFakeClient() && !Server.IsFirstConnected()) {
            Server.SetIsFirstConnected(true);
            const bWarmup = Server.IsPlayingOffline() ? mp_warmup_offline_enabled() : mp_warmup_online_enabled();
            if (bWarmup) {
                Server.BeginWarmupPeriod();
            }
            else {
                Server.BeginGameRestart(0);
            }
            bFirstThinkAfterConnected = true;
        }
    });
    Server.OnEntityBeginDying((victim, takeDamageInfo) => {
        const victimPawn = Server.ToPlayer(victim);
        const scorerPawn = Server.ToPlayer(takeDamageInfo.GetDeathScorer(victim));
        if (victimPawn) {
            const nVictimSlot = victimPawn.GetOriginalController().GetPlayerSlot();
            mKillStreaks.set(nVictimSlot, 0);
            mTaserStreaks.set(nVictimSlot, 0);
        }
        if (victimPawn === scorerPawn)
            return;
        if (scorerPawn && victimPawn) {
            if (mp_teammates_are_enemies() || scorerPawn.GetTeamNumber() != victimPawn.GetTeamNumber()) {
                const nScorerSlot = scorerPawn.GetOriginalController().GetPlayerSlot();
                const nKillStreak = (mKillStreaks.get(nScorerSlot) || 0) + 1;
                mKillStreaks.set(nScorerSlot, nKillStreak);
                if (nKillStreak % mp_dm_healthshot_killcount() == 0) {
                    if (!scorerPawn.FindWeapon("weapon_healthshot"))
                        scorerPawn.GiveNamedItem("weapon_healthshot");
                }
                let nScore = 0;
                let nBonus = 0;
                const weapon = takeDamageInfo.GetWeapon();
                if (weapon) {
                    const weaponData = weapon.GetData();
                    nScore = GetBaseWeaponScore(weaponData.GetType(), weaponData.GetPrice());
                    const bonusWeaponData = scorerPawn.GetOriginalController()?.GetWeaponDataForLoadoutSlot(nBonusWeaponSlot);
                    if (bonusWeaponData && bonusWeaponData.GetName() === weaponData.GetName()) {
                        nBonus = GetBonusWeaponScore(nScore);
                    }
                    else if (weaponData.GetType() == 8 /* ECSWeaponType.WEAPONTYPE_TASER */) {
                        const nTaserStreak = (mTaserStreaks.get(nScorerSlot) || 0) + 1;
                        mTaserStreaks.set(nScorerSlot, nTaserStreak);
                        nBonus = nScore * (nTaserStreak - 1);
                    }
                    Server.AddScoreDM(scorerPawn, victimPawn, nScore, nBonus);
                    const assisterPawn = Server.GetKillAssister(victimPawn, scorerPawn);
                    if (assisterPawn) {
                        Server.AddScoreDM(assisterPawn, victimPawn, mp_dm_kill_base_score() / 2 + 1, 0, true);
                    }
                }
            }
        }
        else if (victim && scorerPawn && victim.GetClassName() === "chicken") {
            Server.AddScoreDM(scorerPawn, undefined, 1);
        }
    });
    // Called every tick if gamemode is deathmatch
    function HandleDeathmatchBonusWeapon() {
        if (flBonusWeaponStartTime === -1) {
            flBonusWeaponStartTime = RandomBonusWeaponStartTime();
        }
        const flCurTime = Server.GetGameTime();
        if (flCurTime > flBonusWeaponStartTime) {
            if (flBonusWeaponDuration === -1) {
                flBonusWeaponDuration = RandomBonusWeaponDuration();
                nBonusWeaponSlot = RandomBonusWeaponSlot();
                Server.StartBonusWeapon(flBonusWeaponDuration, nBonusWeaponSlot);
            }
            else if (flBonusWeaponStartTime + flBonusWeaponDuration < flCurTime) {
                Server.EndBonusWeapon();
                flBonusWeaponStartTime = RandomBonusWeaponStartTime();
                flBonusWeaponDuration = -1;
                nBonusWeaponSlot = -1;
            }
        }
    }
    function RandomBonusWeaponStartTime() {
        return Server.GetGameTime() + mp_dm_time_between_bonus_min() + Math.random() * (mp_dm_time_between_bonus_max() - mp_dm_time_between_bonus_min());
    }
    function RandomBonusWeaponDuration() {
        return mp_dm_bonus_length_min() + Math.random() * (mp_dm_bonus_length_max() - mp_dm_bonus_length_min());
    }
    function RandomBonusWeaponSlot() {
        return bonus_weapon_slots[Math.floor(Math.random() * bonus_weapon_slots.length)];
    }
}
function GetBaseWeaponScore(nWeaponType, nWeaponPrice) {
    let nScore = mp_dm_kill_base_score();
    if (nWeaponType === 0 /* ECSWeaponType.WEAPONTYPE_KNIFE */) {
        nScore += 10;
    }
    else if (nWeaponType === 8 /* ECSWeaponType.WEAPONTYPE_TASER */) {
        nScore += 5;
    }
    else if (nWeaponPrice < 1400) {
        nScore += 2;
    }
    else if (nWeaponPrice < 3500) {
        nScore += 1;
    }
    return nScore;
}
Instance.GetBaseWeaponScore(GetBaseWeaponScore);
function GetBonusWeaponScore(nBaseScore) {
    return nBaseScore * mp_dm_bonus_percent() / 100;
}
Instance.GetBonusWeaponScore(GetBonusWeaponScore);
