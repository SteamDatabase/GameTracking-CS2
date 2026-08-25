import { Instance, CSInputs, CSPlayerPawn } from "cs_script/point_script";

const CSInputsValues = Object.values(CSInputs).filter((i) => typeof i === "number");

/** @type {CSPlayerPawn | undefined} */
let inputPawn = undefined;

Instance.RegisterCheatCommand( "script_zoo_showinput", () => {
    const player = Instance.GetAllPlayerControllers()[0];
    inputPawn = inputPawn == player?.GetPlayerPawn() ? undefined : player?.GetPlayerPawn();
});

/**
 * @param {string} name
 * @param {(input:CSInputs) => boolean} getter
 * @param {number} x
 * @param {number} y
 */
function printInputType(name, getter, x, y) {
    const inputs = CSInputsValues.filter(getter).map((i) => CSInputs[i]);
    let inputText = inputs.length === 0 ? "NONE" : inputs.join("|");
    Instance.DebugScreenText({ text: `${name}: ${inputText}`, x, y });
}

/**
 * @param {CSPlayerPawn | undefined} pawn
 */
function printInput(pawn) {
    if (pawn) {
        printInputType("Pressed", pawn.IsInputPressed.bind(pawn), 100, 500);
        printInputType("Just Pressed", pawn.WasInputJustPressed.bind(pawn), 100, 510);
        printInputType("Just Released", pawn.WasInputJustReleased.bind(pawn), 100, 520);
    }
}

Instance.OnActivate(() => Instance.SetNextThink(Instance.GetGameTime()));
Instance.OnScriptReload({ after: () => Instance.SetNextThink(Instance.GetGameTime()) });
Instance.SetThink(() => {
    Instance.SetNextThink(Instance.GetGameTime());
    printInput(inputPawn);
});
