import { CSDamageFlags, CSLoadoutSlot, Instance } from "cs_script/point_script";

Instance.ServerCommand("mp_warmup_offline_enabled 1");
Instance.ServerCommand("mp_warmup_pausetimer 1");

Instance.OnPlayerActivate(({ player }) => {
    player.JoinTeam(2);
    Instance.ServerCommand("bot_stop 1");
    Instance.ServerCommand("bot_add");
});

Instance.OnBeforePlayerDamage(({ player }) => {
    if (player.GetOriginalPlayerController().IsBot()) {
        return { damageFlags: CSDamageFlags.PREVENT_DEATH };
    }
});
