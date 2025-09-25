import { Entity, Instance } from "cs_script/point_script";

let Rounds = 0;
let Hits = 0;
let Target = 0;

let TargetEasy = "targetbox.ez";
let TargetMedium = "targetbox.med";
let TargetHard = "targetbox.hard";

Instance.ServerCommand("sv_cheats 1");
Instance.ServerCommand("mp_warmup_offline_enabled 1");
Instance.ServerCommand("mp_warmup_pausetimer 1");

function SetNextTarget() {
    Rounds++;

    Instance.EntFireAtName("worldtext.rounds", "SetMessage", Rounds);
    Instance.EntFireAtName("cover.*", "Enable");
    Instance.EntFireAtName("tele.reset", "Teleport");

    // Roll 1-11, if it duplicates last value choose value 12.
    let NewTarget = Math.floor(Math.random() * 11) + 1;
    if (NewTarget === Target) NewTarget = 12;
    Target = NewTarget;

    let difficulty = "ez";
    if (Rounds > 7) difficulty = "hard";
    else if (Rounds > 4) difficulty = "med";

    Instance.EntFireAtName(`cover.${Target}`, "Disable");
    Instance.EntFireAtName(`tele.${Target}`, "TeleportEntity", `targetbox.${difficulty}`);
}

// called if player leaves play area at any time
Instance.OnScriptInput("ResetAndCleanUp", () => {
    Instance.EntFireAtName("trigger.start", "Enable");
    Instance.EntFireAtName("trigger.end_early", "Disable");
    Instance.EntFireAtName("worldtext.go_here", "Enable");
    Instance.EntFireAtName("relay.start_countdown", "CancelPending");

    Instance.EntFireAtName("worldtext.training_countdown_dyn", "SetMessage", "3");
    Instance.EntFireAtName("worldtext.training_countdown_static", "Disable");
    Instance.EntFireAtName("worldtext.training_countdown_dyn", "Disable");
    Instance.EntFireAtName("board.timer", "Disable");
    Instance.EntFireAtName("board.timer", "ResetTimer");
    Instance.EntFireAtName("snd.tick", "StopSound");
    Instance.EntFireAtName("tele.reset", "Teleport");
    Instance.EntFireAtName("cover.*", "Enable");
    Instance.EntFireAtName("worldtext.hits", "SetMessage", "0");
    Instance.EntFireAtName("worldtext.rounds", "SetMessage", "0");

    Instance.ServerCommand("sv_infinite_ammo 0");
    const player = Instance.GetPlayerController(0)?.GetPlayerPawn();
    player?.DestroyWeapons();
    Instance.ClientCommand(0, "slot3");
});

Instance.OnScriptInput("StartTraining", () => {
    Instance.EntFireAtName("trigger.start", "Disable");
    Instance.EntFireAtName("trigger.end_early", "Enable");
    Instance.EntFireAtName("worldtext.go_here", "Disable");
    Instance.EntFireAtName("relay.start_countdown", "Trigger");

    Instance.ServerCommand("sv_infinite_ammo 1");
    const player = Instance.GetPlayerController(0)?.GetPlayerPawn();
    player?.DestroyWeapons();
    player?.GiveNamedItem("weapon_hegrenade", true);

    Rounds = 0;
    Hits = 0;
});

// called from grenade trigger inside target area
Instance.OnScriptInput("GrenadeHit", () => {
    Hits++;
    Instance.EntFireAtName("snd.hit", "StartSound");
    Instance.EntFireAtName("worldtext.hits", "SetMessage", Hits);
    if (trackedProjectile && trackedProjectile.IsValid()) {
        trackedProjectile.Remove();
        trackedProjectile = undefined;
    }
});

// called from logic_timer "board.timer", 3 sec interval
Instance.OnScriptInput("SetNextTarget", () => {
    if (Rounds < 10) {
        SetNextTarget();
    } else {
        Instance.EntFireAtName("snd.end", "StartSound");
        Instance.EntFireAtName("board.timer", "Disable");
        Instance.EntFireAtName("board.timer", "ResetTimer");
        Instance.EntFireAtName("tele.reset", "Teleport");
        Instance.EntFireAtName("cover.*", "Enable");
    }
});

/** @type {Entity | undefined} */
let trackedProjectile;
/** @type {import("cs_script/point_script").Vector} */
let trackedPos;
Instance.OnGrenadeThrow((weapon, projectile) => {
    Instance.ClientCommand(0, "slot6");
    trackedProjectile = projectile;
    trackedPos = trackedProjectile.GetAbsOrigin();
    Instance.SetNextThink(Instance.GetGameTime());
});
Instance.SetThink(() => {
    if (trackedProjectile && trackedProjectile.IsValid()) {
        Instance.DebugLine(trackedPos, trackedProjectile.GetAbsOrigin(), 1, { r: 0, g: 0, b: 255 });
        trackedPos = trackedProjectile.GetAbsOrigin();
        Instance.SetNextThink(Instance.GetGameTime());
    }
});
