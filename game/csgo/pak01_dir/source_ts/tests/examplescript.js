import { Instance } from "server/cspointscript";
// Run me with ent_create point_script { "script" "source_ts/tests//examplescript.vts" }
Instance.Msg("DOMAIN");
Instance.Msg(JSON.stringify(Object.keys(Instance)));
Instance.Msg(Instance.GameMode().toString());
Instance.Msg(Instance.GameType().toString());
Instance.Msg(Instance.EntFireBroadcast.length.toString());
Instance.InitialActivate(() => {
    Instance.Msg("InitialActivate");
    var pawn = Instance.GetPlayerPawn(0);
    if (pawn) {
        Instance.Msg("got pawn");
        var controller = pawn.GetOriginalController();
        if (controller) {
            Instance.Msg("got controller");
            var score = controller.GetScore();
            Instance.Msg("score: " + score.toString());
            var slot = controller.GetPlayerSlot();
            Instance.Msg("slot: " + slot.toString());
            var weapon_0 = controller.GetWeaponDataForLoadoutSlot(0);
            var name = weapon_0?.GetName();
            Instance.Msg("weapon 0 vdata name: " + name);
        }
        else {
            Instance.Msg("no controller");
        }
    }
    else {
        Instance.Msg("no pawn");
    }
});
