import { Instance } from "domains/serverpointentity";
// This is the script to enable 2v2 entities when playing Wingman mode
Instance.PublicMethod("CheckGameMode", () => {
    if (Instance.GameType() == 0 && Instance.GameMode() == 2) {
        // if it is "Wingman" then enable 2v2 map elements and disable standard
        Instance.EntFireBroadcast("brush.blocker.b", "Enable");
        Instance.EntFireBroadcast("navblocker.2v2.b", "BlockNav");
        Instance.EntFireBroadcast("props.2v2.b", "Enable");
        Instance.EntFireBroadcast("props.2v2.b", "EnableCollision");
        Instance.EntFireBroadcast("bombsite.tag.a", "Disable");
    }
    else {
        // for all other modes disable all 2v2 map elements
        Instance.EntFireBroadcast("brush.blocker.b", "Disable");
        Instance.EntFireBroadcast("navblocker.2v2", "UnblockNav");
    }
});
let g_InjuryCount = 0;
Instance.PublicMethod("WorkplaceInjury", () => {
    g_InjuryCount++;
    WorkplaceInjuryDisplay();
});
Instance.PublicMethod("WorkplaceInjuryDisplay", WorkplaceInjuryDisplay);
function WorkplaceInjuryDisplay() {
    let ones = g_InjuryCount % 10;
    let tens = Math.floor(g_InjuryCount / 10);
    if (g_InjuryCount > 99) {
        ones = 10;
        tens = 10;
    }
    Instance.EntFireBroadcast("safetysign.numbers", "skin", ones.toString());
    Instance.EntFireBroadcast("safetysign.numbers.ten", "skin", tens.toString());
    if (tens > 0) {
        Instance.EntFireBroadcast("safetysign.numbers.ten", tens > 0 ? "Enable" : "Disable");
    }
}
