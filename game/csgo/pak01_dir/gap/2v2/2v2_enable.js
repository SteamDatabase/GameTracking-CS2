import { Instance } from "domains/serverpointentity";
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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMnYyX2VuYWJsZS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9nYXAvMnYyLzJ2Ml9lbmFibGUudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUEsT0FBTyxFQUFFLFFBQVEsRUFBRSxNQUFNLDJCQUEyQixDQUFDO0FBRXJELHNFQUFzRTtBQUN0RSxRQUFRLENBQUMsWUFBWSxDQUFFLGVBQWUsRUFBRSxHQUFHLEVBQUU7SUFFekMsc0RBQXNEO0lBQ3RELE1BQU0sS0FBSyxHQUFHLFFBQVEsQ0FBQyxRQUFRLEVBQUUsQ0FBQztJQUNsQyxNQUFNLEtBQUssR0FBRyxRQUFRLENBQUMsUUFBUSxFQUFFLENBQUM7SUFFbEMsSUFBSyxLQUFLLElBQUksQ0FBQyxJQUFJLEtBQUssSUFBSSxDQUFDLEVBQzdCO1FBQ0ksdUVBQXVFO1FBQ3ZFLFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxzQkFBc0IsRUFBRSxhQUFhLENBQUUsQ0FBQztRQUNuRSxRQUFRLENBQUMsZ0JBQWdCLENBQUUsaUJBQWlCLEVBQUUsWUFBWSxDQUFFLENBQUM7UUFDN0QsUUFBUSxDQUFDLGdCQUFnQixDQUFFLGVBQWUsRUFBRSxRQUFRLENBQUUsQ0FBQztRQUN2RCxRQUFRLENBQUMsZ0JBQWdCLENBQUUsYUFBYSxFQUFFLFFBQVEsQ0FBRSxDQUFDO1FBQ3JELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxnQkFBZ0IsRUFBRSxVQUFVLENBQUUsQ0FBQztRQUMxRCxRQUFRLENBQUMsZ0JBQWdCLENBQUUsV0FBVyxFQUFFLFFBQVEsQ0FBRSxDQUFDO1FBQ25ELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxXQUFXLEVBQUUsaUJBQWlCLENBQUUsQ0FBQztRQUM1RCxRQUFRLENBQUMsZ0JBQWdCLENBQUUsZ0JBQWdCLEVBQUUsU0FBUyxDQUFFLENBQUM7S0FDNUQ7U0FFRDtRQUNJLG1EQUFtRDtRQUNuRCxRQUFRLENBQUMsZ0JBQWdCLENBQUUsYUFBYSxFQUFFLFNBQVMsQ0FBRSxDQUFDO1FBQ3RELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxnQkFBZ0IsRUFBRSxZQUFZLENBQUUsQ0FBQztRQUM1RCxRQUFRLENBQUMsZ0JBQWdCLENBQUUsZUFBZSxFQUFFLFNBQVMsQ0FBRSxDQUFDO0tBQzNEO0FBQ0wsQ0FBQyxDQUFFLENBQUMifQ==