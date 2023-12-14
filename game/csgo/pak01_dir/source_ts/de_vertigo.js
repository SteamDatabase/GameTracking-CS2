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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZGVfdmVydGlnby5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uL2NvbnRlbnQvY3Nnby9zb3VyY2VfdHMvZGVfdmVydGlnby50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQSxPQUFPLEVBQUUsUUFBUSxFQUFFLE1BQU0sMkJBQTJCLENBQUM7QUFFckQsc0VBQXNFO0FBQ3RFLFFBQVEsQ0FBQyxZQUFZLENBQUUsZUFBZSxFQUFFLEdBQUcsRUFBRTtJQUV6QyxJQUFLLFFBQVEsQ0FBQyxRQUFRLEVBQUUsSUFBSSxDQUFDLElBQUksUUFBUSxDQUFDLFFBQVEsRUFBRSxJQUFJLENBQUMsRUFDekQ7UUFDSSx1RUFBdUU7UUFDdkUsUUFBUSxDQUFDLGdCQUFnQixDQUFFLGlCQUFpQixFQUFFLFFBQVEsQ0FBRSxDQUFDO1FBQ3pELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxrQkFBa0IsRUFBRSxVQUFVLENBQUUsQ0FBQztRQUM1RCxRQUFRLENBQUMsZ0JBQWdCLENBQUUsYUFBYSxFQUFFLFFBQVEsQ0FBRSxDQUFDO1FBQ3JELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxhQUFhLEVBQUUsaUJBQWlCLENBQUUsQ0FBQztRQUM5RCxRQUFRLENBQUMsZ0JBQWdCLENBQUUsZ0JBQWdCLEVBQUUsU0FBUyxDQUFFLENBQUM7S0FDNUQ7U0FFRDtRQUNJLG1EQUFtRDtRQUNuRCxRQUFRLENBQUMsZ0JBQWdCLENBQUUsaUJBQWlCLEVBQUUsU0FBUyxDQUFFLENBQUM7UUFDMUQsUUFBUSxDQUFDLGdCQUFnQixDQUFFLGdCQUFnQixFQUFFLFlBQVksQ0FBRSxDQUFDO0tBQy9EO0FBQ0wsQ0FBQyxDQUFFLENBQUM7QUFFSixJQUFJLGFBQWEsR0FBRyxDQUFDLENBQUM7QUFFdEIsUUFBUSxDQUFDLFlBQVksQ0FBRSxpQkFBaUIsRUFBRSxHQUFHLEVBQUU7SUFFM0MsYUFBYSxFQUFFLENBQUM7SUFDaEIsc0JBQXNCLEVBQUUsQ0FBQztBQUM3QixDQUFDLENBQUUsQ0FBQztBQUVKLFFBQVEsQ0FBQyxZQUFZLENBQUUsd0JBQXdCLEVBQUUsc0JBQXNCLENBQUUsQ0FBQztBQUUxRSxTQUFTLHNCQUFzQjtJQUUzQixJQUFJLElBQUksR0FBRyxhQUFhLEdBQUcsRUFBRSxDQUFDO0lBQzlCLElBQUksSUFBSSxHQUFHLElBQUksQ0FBQyxLQUFLLENBQUUsYUFBYSxHQUFHLEVBQUUsQ0FBRSxDQUFDO0lBRTVDLElBQUssYUFBYSxHQUFHLEVBQUUsRUFDdkI7UUFDSSxJQUFJLEdBQUcsRUFBRSxDQUFDO1FBQ1YsSUFBSSxHQUFHLEVBQUUsQ0FBQztLQUNiO0lBRUQsUUFBUSxDQUFDLGdCQUFnQixDQUFFLG9CQUFvQixFQUFFLE1BQU0sRUFBRSxJQUFJLENBQUMsUUFBUSxFQUFFLENBQUUsQ0FBQztJQUMzRSxRQUFRLENBQUMsZ0JBQWdCLENBQUUsd0JBQXdCLEVBQUUsTUFBTSxFQUFFLElBQUksQ0FBQyxRQUFRLEVBQUUsQ0FBRSxDQUFDO0lBQy9FLElBQUssSUFBSSxHQUFHLENBQUMsRUFDYjtRQUNJLFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSx3QkFBd0IsRUFBRSxJQUFJLEdBQUcsQ0FBQyxDQUFDLENBQUMsQ0FBQyxRQUFRLENBQUMsQ0FBQyxDQUFDLFNBQVMsQ0FBRSxDQUFDO0tBQzFGO0FBQ0wsQ0FBQyJ9