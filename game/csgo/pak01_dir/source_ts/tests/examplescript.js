import { Instance } from "domains/serverpointentity";
// Domain.OnHook( "Input", ( sInput, value ) =>
// {
//     Domain.DebugLog( `Hello from TypeScript. (${sInput},${value})` );
// } );
Instance.Log("DOMAIN");
Instance.Log(JSON.stringify(Object.keys(Instance)));
Instance.Log(Instance.GameMode().toString());
Instance.Log(Instance.GameType().toString());
Instance.Log(Instance.EntFireBroadcast.length.toString());
Instance.InitialActivate(() => {
    Instance.Log("InitialActivate");
    var pawn = Instance.GetPlayerPawn(0);
    if (pawn) {
        Instance.Log("got pawn");
        var controller = pawn.GetController();
        if (controller) {
            Instance.Log("got controller");
            var score = controller.GetScore();
            Instance.Log("score: " + score.toString());
        }
        else {
            Instance.Log("no controller");
        }
    }
    else {
        Instance.Log("no pawn");
    }
});
