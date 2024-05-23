import { Instance } from "server/cspointscript";
// This is the script to enable 2v2 entities when playing Wingman mode
Instance.PublicMethod("EnableWingman", () => {
    // check the game mode and type for the current match:
    const nType = Instance.GameType();
    const nMode = Instance.GameMode();
    if (nType == 0 && nMode == 2) {
        // if it is "Wingman" then enable 2v2 map elements and disable standard
        Instance.EntFireAtName("spawnpoints.standard", "SetDisabled");
        Instance.EntFireAtName("spawnpoints.2v2", "SetEnabled");
        Instance.EntFireAtName("brush.blocker", "Enable");
        Instance.EntFireAtName("buyzone.2v2", "Enable");
        Instance.EntFireAtName("navblocker.2v2", "BlockNav");
        Instance.EntFireAtName("props.2v2", "Enable");
        Instance.EntFireAtName("props.2v2", "EnableCollision");
        Instance.EntFireAtName("bombsite.tag.a", "Disable");
        Instance.EntFireAtName("props.standard", "Disable");
        Instance.EntFireAtName("props.standard", "DisableCollision");
    }
    else {
        // for all other modes disable all 2v2 map elements
        Instance.EntFireAtName("buyzone.2v2", "Disable");
        Instance.EntFireAtName("navblocker.2v2", "UnblockNav");
        Instance.EntFireAtName("brush.blocker", "Disable");
    }
});
