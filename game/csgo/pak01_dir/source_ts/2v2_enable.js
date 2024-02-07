import { Instance } from "serverpointentity";
// This is the script to enable 2v2 entities when playing Wingman mode
Instance.PublicMethod("EnableWingman", () => {
    // check the game mode and type for the current match:
    const nType = Instance.GameType();
    const nMode = Instance.GameMode();
    if (nType == 0 && nMode == 2) {
        // if it is "Wingman" then enable 2v2 map elements and disable standard
        Instance.EntFireBroadcast("spawnpoints.standard", "SetDisabled");
        Instance.EntFireBroadcast("spawnpoints.2v2", "SetEnabled");
        Instance.EntFireBroadcast("brush.blocker", "Enable");
        Instance.EntFireBroadcast("buyzone.2v2", "Enable");
        Instance.EntFireBroadcast("navblocker.2v2", "BlockNav");
        Instance.EntFireBroadcast("props.2v2", "Enable");
        Instance.EntFireBroadcast("props.2v2", "EnableCollision");
        Instance.EntFireBroadcast("bombsite.tag.a", "Disable");
    }
    else {
        // for all other modes disable all 2v2 map elements
        Instance.EntFireBroadcast("buyzone.2v2", "Disable");
        Instance.EntFireBroadcast("navblocker.2v2", "UnblockNav");
        Instance.EntFireBroadcast("brush.blocker", "Disable");
    }
});
