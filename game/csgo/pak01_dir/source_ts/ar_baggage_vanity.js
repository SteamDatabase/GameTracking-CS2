import { Instance } from "clientpointentity";
const planeNames = shuffle([
    'plane_01',
    'plane_02',
    'plane_03',
    'plane_04',
    'plane_05',
    'plane_06',
    'plane_07',
    'plane_08',
    'plane_09',
    'plane_10',
    'plane_11',
    'plane_12',
    'plane_13',
    'plane_14',
    'plane_15',
    'plane_16',
    'plane_17',
    'plane_18',
    'plane_19',
    'plane_20'
]);
const planeSpacing = 45; // seconds between planes
let nNextPlaneIndex = 0;
Instance.InitialActivate(() => {
    Instance.SetNextClientThink(Instance.GetGameTime() + 0.1);
});
Instance.ClientThink(() => {
    const planeName = planeNames[nNextPlaneIndex];
    const planeEnt = Instance.ToDynamicProp(Instance.FindFirstEntityByName(planeName));
    if (planeEnt)
        planeEnt.SetAnimationNotLooping("distant_plane06");
    nNextPlaneIndex++;
    if (nNextPlaneIndex >= planeNames.length)
        nNextPlaneIndex = 0;
    Instance.SetNextClientThink(Instance.GetGameTime() + planeSpacing);
});
// Random integer including min, less than max [min,max)
function randomInteger(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
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
