import { Instance } from "cspointscript";
// This is the script to enable 2v2 entities when playing Wingman mode
Instance.PublicMethod("CheckGameMode", () => {
    if (Instance.GameType() == 0 && Instance.GameMode() == 2) {
        // if it is "Wingman" then enable 2v2 map elements and disable standard
        Instance.EntFireAtName("brush.blocker.a", "Enable");
        Instance.EntFireAtName("navblocker.2v2.a", "BlockNav");
        Instance.EntFireAtName("props.2v2.a", "Enable");
        Instance.EntFireAtName("props.2v2.a", "EnableCollision");
        Instance.EntFireAtName("bombsite.tag.b", "Disable");
    }
    else {
        // for all other modes disable all 2v2 map elements
        Instance.EntFireAtName("brush.blocker.a", "Disable");
        Instance.EntFireAtName("navblocker.2v2.a", "UnblockNav");
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
    Instance.EntFireAtName("safetysign.numbers", "skin", ones.toString());
    Instance.EntFireAtName("safetysign.numbers.ten", "skin", tens.toString());
    if (tens > 0) {
        Instance.EntFireAtName("safetysign.numbers.ten", tens > 0 ? "Enable" : "Disable");
    }
}
