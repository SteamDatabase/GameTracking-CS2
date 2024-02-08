import { Instance } from "csarmsracescript";
Instance.Msg("starting cs_armsrace.ts");
// TODO: expose consts to SourceTS
const MAX_PLAYERS = 64;
const TEAM_INVALID = -1;
const TEAM_UNASSIGNED = 0;
const TEAM_TERRORIST = 2;
const TEAM_CT = 3;
const INVALID_PLAYERSLOT = -1;
const OBS_MODE_NONE = 0; // not in spectator mode
const OBS_MODE_FIXED = 1; // view from a fixed camera position
const OBS_MODE_IN_EYE = 1; // follow a player in first person view
const OBS_MODE_CHASE = 1; // follow a player in third person view
const OBS_MODE_ROAMING = 1; // free roaming
// TODO: Improve SourceTS convar API
const mp_teammates_are_enemies = () => Instance.Get_mp_teammates_are_enemies();
const sv_warmup_to_freezetime_delay = () => Instance.Get_sv_warmup_to_freezetime_delay();
;
;
;
;
const gArmsRaceCategories = [
    {
        pickCount: 1,
        weaponNames: ["weapon_scar20", "weapon_g3sg1",]
    },
    {
        pickCount: 1,
        weaponNames: ["weapon_awp",]
    },
    {
        pickCount: 4,
        weaponNames: ["weapon_ak47", "weapon_aug", "weapon_famas", "weapon_galilar", "weapon_m4a1", "weapon_m4a1_silencer", "weapon_sg556",]
    },
    {
        pickCount: 1,
        weaponNames: ["weapon_m249", "weapon_negev",]
    },
    {
        pickCount: 3,
        weaponNames: ["weapon_mac10", "weapon_p90", "weapon_ump45", "weapon_bizon", "weapon_mp7", "weapon_mp5sd", "weapon_mp9",]
    },
    {
        pickCount: 1,
        weaponNames: ["weapon_deagle", "weapon_revolver", "weapon_ssg08",]
    },
    {
        pickCount: 3,
        weaponNames: ["weapon_elite", "weapon_fiveseven", "weapon_glock", "weapon_tec9", "weapon_hkp2000", "weapon_usp_silencer", "weapon_p250",]
    },
    {
        pickCount: 2,
        weaponNames: ["weapon_xm1014", "weapon_nova", "weapon_mag7", "weapon_sawedoff",]
    },
    {
        pickCount: 1,
        weaponNames: ["weapon_knifegg"]
    },
];
if (Instance.IsServer()) {
    const Server = Instance;
    let bFirstThink = true;
    const armsRaceSequence = [];
    initArmsRaceSequence();
    let nWinningPlayer = -1;
    let hKnifeTierMusicCue = null;
    let nCurrentLeader = null;
    let nextThinkCallbacks = [];
    Server.OnRestartMatch(() => {
        bFirstThink = true;
        initArmsRaceSequence();
        nWinningPlayer = -1;
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
        Server.BeginFreezePeriod();
    });
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
        for (const cb of nextThinkCallbacks)
            cb();
        nextThinkCallbacks.length = 0;
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
        if (Server.IsInMatch()) {
            let winningPlayer;
            if (nWinningPlayer !== -1) {
                winningPlayer = Server.GetPlayerController(nWinningPlayer);
            }
            if (!winningPlayer && Server.GetRoundRemainingTime() <= 0) {
                let nMaxScore = -1;
                for (const playerController of allControllers()) {
                    let nScore = playerController.GetScore();
                    if (nScore >= nMaxScore) {
                        winningPlayer = playerController;
                        nMaxScore = nScore;
                    }
                }
            }
            if (winningPlayer) {
                if (hKnifeTierMusicCue != null) {
                    Server.StopSound(hKnifeTierMusicCue);
                    hKnifeTierMusicCue = null;
                }
                const nWinningTeam = winningPlayer.GetTeamNumber();
                let nRoundEndReason = 10 /* ERoundEndReason.Round_Draw */;
                if (nWinningTeam == TEAM_CT)
                    nRoundEndReason = 8 /* ERoundEndReason.CTs_Win */;
                else if (nWinningTeam == TEAM_TERRORIST)
                    nRoundEndReason = 9 /* ERoundEndReason.Terrorists_Win */;
                Server.FreezePlayers();
                Server.EndRound(nRoundEndReason);
                Server.BeginIntermission();
            }
        }
    });
    Server.OnPlayerChangedTeam((controller, _, nNewTeam) => {
        if (!controller.IsFakeClient() && !Server.IsFirstConnected()) {
            Server.SetIsFirstConnected(true);
            if (Server.IsPlayingOffline()) {
                Server.BeginGameRestart(0);
            }
            else {
                Server.BeginWarmupPeriod();
            }
            nextThinkCallbacks.push(() => {
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
            });
        }
        const player = controller.GetPlayer();
        if (player) {
            const bUseTeamColors = !mp_teammates_are_enemies();
            if (bUseTeamColors && nNewTeam === TEAM_TERRORIST)
                player.SetGunGameImmunityColor([234, 200, 117]); // saturate ( #eabe54, .5 )
            else if (bUseTeamColors && nNewTeam === TEAM_CT)
                player.SetGunGameImmunityColor([125, 187, 250]); // saturate ( #96c8fa, .5 )
            else
                player.SetGunGameImmunityColor([255, 255, 255]);
        }
    });
    Server.OnEntityBeginDying((victim, takeDamageInfo) => {
        if (!(Server.IsWarmupPeriod() || Server.IsInMatch()))
            return;
        const victimPPlayer = Server.ToPlayer(victim);
        const victimController = victimPPlayer?.GetOriginalController();
        const scorerPlayer = takeDamageInfo.GetDeathScorer(victim);
        const scorerController = scorerPlayer?.GetOriginalController();
        if (victimPPlayer && victimController && scorerPlayer && scorerController) {
            if (mp_teammates_are_enemies() || scorerPlayer.GetTeamNumber() != victimPPlayer.GetTeamNumber()) {
                const nScorerProgress = getArmsRaceProgress(scorerController);
                const nVictimProgress = getArmsRaceProgress(victimController);
                if (nScorerProgress < armsRaceSequence.length) {
                    const weapon = takeDamageInfo.GetWeapon();
                    const weaponData = weapon?.GetData();
                    const weaponType = weaponData ? weaponData.GetType() : 19 /* ECSWeaponType.WEAPONTYPE_UNKNOWN */;
                    let nAddScore = 0;
                    let nTakeScore = 0;
                    let bChangeWeapon = weaponType !== 0 /* ECSWeaponType.WEAPONTYPE_KNIFE */ && weaponType !== 8 /* ECSWeaponType.WEAPONTYPE_TASER */;
                    if (weaponType === 0 /* ECSWeaponType.WEAPONTYPE_KNIFE */) {
                        nAddScore = 2;
                        nTakeScore = 2;
                    }
                    else if (armsRaceSequence[nScorerProgress] != "weapon_knifegg") {
                        // Non-knives only give and take points outside the knife level
                        nAddScore = 1;
                        nTakeScore = weaponType === 8 /* ECSWeaponType.WEAPONTYPE_TASER */ ? 1 : 0;
                    }
                    if (nAddScore > 0) {
                        scorerController.AddScore(nAddScore);
                        const nNewProgress = getArmsRaceProgress(scorerController);
                        if (nNewProgress > nScorerProgress) {
                            if (nNewProgress >= armsRaceSequence.length) {
                                nWinningPlayer = scorerController.GetPlayerSlot();
                            }
                            else {
                                // Don't remove current gun immediately. There might be additional bullets to process (shotguns)
                                nextThinkCallbacks.push(() => giveCorrectGun(scorerPlayer, bChangeWeapon));
                            }
                        }
                    }
                    if (nTakeScore > 0) {
                        victimController.AddScore(-nTakeScore);
                    }
                }
                playScorerSounds(scorerController, nScorerProgress);
                playVictimSounds(victimController, nVictimProgress);
            }
        }
    });
    Server.OnPlayerSpawned(player => {
        giveCorrectGun(player, true);
    });
    function initArmsRaceSequence() {
        armsRaceSequence.length = 0;
        gArmsRaceCategories.forEach(category => armsRaceSequence.push(...shuffle(category.weaponNames).slice(0, category.pickCount)));
        Server.ClearWeaponSequence();
        armsRaceSequence.forEach(name => Server.AddToWeaponSequence(name));
    }
    function getArmsRaceProgress(controller) {
        return Math.floor(controller.GetScore() / 2);
    }
    function giveCorrectGun(player, bAutoDeploy) {
        const controller = player.GetCurrentController();
        if (!controller)
            return;
        const nProgress = Math.floor(controller.GetScore() / 2);
        if (nProgress < armsRaceSequence.length) {
            const taser = player.FindWeapon("weapon_taser");
            const sWeaponName = armsRaceSequence[nProgress];
            if (sWeaponName === "weapon_knifegg") {
                player.DestroyWeapons();
                player.SwitchToWeapon(player.FindWeaponBySlot(2 /* EGearSlot.GEAR_SLOT_KNIFE */));
                if (taser)
                    player.DestroyWeapon(taser);
            }
            else {
                if (!player.FindWeapon(sWeaponName)) {
                    player.DestroyWeapons();
                    player.GiveNamedItem(sWeaponName, bAutoDeploy);
                    if (!taser)
                        player.GiveNamedItem("weapon_taser");
                }
            }
        }
    }
    function playScorerSounds(controller, nOldProgress) {
        const nProgress = getArmsRaceProgress(controller);
        if (nProgress === armsRaceSequence.length) // This player just won
         {
            Server.StartEntitySound(controller.GetPlayer(), "UI.ArmsRace.FinalKill_Knife");
            return; // no other sounds need to layer on top of this one
        }
        const nPlayerSlot = controller.GetPlayerSlot();
        Server.StartUISoundForPlayer("UI.ArmsRace.Kill1", nPlayerSlot);
        if (nProgress > nOldProgress) {
            Server.StartUISoundForPlayer("UI.ArmsRace.Weapon_LevelUp", nPlayerSlot);
            // Play knife sound if this player is entering the knife level
            if (armsRaceSequence[nProgress] === "weapon_knifegg") {
                Server.StartEntitySound(controller.GetPlayer(), "UI.ArmsRace.ReachedKnife");
                // If this scorer is the first one to reach the knife level we play the music cue.
                if (hKnifeTierMusicCue == null) {
                    hKnifeTierMusicCue = Server.StartUISound("UI.ArmsRace.ReachedKnife_Music");
                }
            }
            // If we have a new leader
            if (nCurrentLeader !== nPlayerSlot) {
                let bIsLeader = true;
                for (const other of allControllers()) {
                    if (other.GetPlayerSlot() !== nPlayerSlot && getArmsRaceProgress(other) >= nProgress) {
                        bIsLeader = false;
                        break;
                    }
                }
                if (bIsLeader) {
                    if (nCurrentLeader != null) {
                        Server.StartUISoundForPlayer("UI.ArmsRace.Demoted", nCurrentLeader);
                    }
                    nCurrentLeader = nPlayerSlot;
                    Server.StartUISoundForPlayer("UI.ArmsRace.BecomeMatchLeader", nCurrentLeader);
                }
            }
        }
    }
    function playVictimSounds(controller, nOldProgress) {
        Server.StartUISoundForPlayer("UI.ArmsRace.PlayerDeath", controller.GetPlayerSlot());
        if (getArmsRaceProgress(controller) < nOldProgress) {
            Server.StartUISoundForPlayer("UI.ArmsRace.Weapon_LevelDown", controller.GetPlayerSlot());
        }
    }
    function* allControllers() {
        for (let nPlayer = 0; nPlayer < 64; nPlayer++) {
            const controller = Server.GetPlayerController(nPlayer);
            if (controller)
                yield controller;
        }
    }
}
if (Instance.IsClient()) {
    Instance.OnPlayerStateChanged((player, oldState, newState) => {
        if (player && player.IsLocalPlayer() && newState === 0) // STATE_ACTIVE
         {
            player.SetShouldAutoBuyWeapons(false);
        }
    });
}
function shuffle(input) {
    const output = [...input];
    for (let i = output.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        if (j !== i) {
            const tmp = output[i];
            output[i] = output[j];
            output[j] = tmp;
        }
    }
    return output;
}
