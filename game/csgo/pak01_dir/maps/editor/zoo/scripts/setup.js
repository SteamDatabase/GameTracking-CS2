import { Instance } from "cs_script/point_script";

Instance.ServerCommand("mp_warmup_offline_enabled 1");
Instance.ServerCommand("mp_warmup_pausetimer 1");

Instance.OnGameEvent("player_activate", (event) => {
    const player = Instance.GetPlayerController(event.userid);
    player?.JoinTeam(2);
});

Instance.SetThink(() => {
    Instance.DebugScreenText(Instance.GetGameTime().toString(), 10, 10, 0.01, { r: 0xff, g: 0, b: 0xff });
    Instance.SetNextThink(Instance.GetGameTime());
});
Instance.SetNextThink(Instance.GetGameTime());
