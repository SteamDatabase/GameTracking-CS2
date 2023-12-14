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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMnYyX2VuYWJsZS5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uL2NvbnRlbnQvY3Nnby9zb3VyY2VfdHMvMnYyX2VuYWJsZS50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQSxPQUFPLEVBQUUsUUFBUSxFQUFFLE1BQU0sMkJBQTJCLENBQUM7QUFFckQsc0VBQXNFO0FBQ3RFLFFBQVEsQ0FBQyxZQUFZLENBQUUsZUFBZSxFQUFFLEdBQUcsRUFBRTtJQUV6QyxzREFBc0Q7SUFDdEQsTUFBTSxLQUFLLEdBQUcsUUFBUSxDQUFDLFFBQVEsRUFBRSxDQUFDO0lBQ2xDLE1BQU0sS0FBSyxHQUFHLFFBQVEsQ0FBQyxRQUFRLEVBQUUsQ0FBQztJQUVsQyxJQUFLLEtBQUssSUFBSSxDQUFDLElBQUksS0FBSyxJQUFJLENBQUMsRUFDN0I7UUFDSSx1RUFBdUU7UUFDdkUsUUFBUSxDQUFDLGdCQUFnQixDQUFFLHNCQUFzQixFQUFFLGFBQWEsQ0FBRSxDQUFDO1FBQ25FLFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxpQkFBaUIsRUFBRSxZQUFZLENBQUUsQ0FBQztRQUM3RCxRQUFRLENBQUMsZ0JBQWdCLENBQUUsZUFBZSxFQUFFLFFBQVEsQ0FBRSxDQUFDO1FBQ3ZELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxhQUFhLEVBQUUsUUFBUSxDQUFFLENBQUM7UUFDckQsUUFBUSxDQUFDLGdCQUFnQixDQUFFLGdCQUFnQixFQUFFLFVBQVUsQ0FBRSxDQUFDO1FBQzFELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxXQUFXLEVBQUUsUUFBUSxDQUFFLENBQUM7UUFDbkQsUUFBUSxDQUFDLGdCQUFnQixDQUFFLFdBQVcsRUFBRSxpQkFBaUIsQ0FBRSxDQUFDO1FBQzVELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxnQkFBZ0IsRUFBRSxTQUFTLENBQUUsQ0FBQztLQUM1RDtTQUVEO1FBQ0ksbURBQW1EO1FBQ25ELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxhQUFhLEVBQUUsU0FBUyxDQUFFLENBQUM7UUFDdEQsUUFBUSxDQUFDLGdCQUFnQixDQUFFLGdCQUFnQixFQUFFLFlBQVksQ0FBRSxDQUFDO1FBQzVELFFBQVEsQ0FBQyxnQkFBZ0IsQ0FBRSxlQUFlLEVBQUUsU0FBUyxDQUFFLENBQUM7S0FDM0Q7QUFDTCxDQUFDLENBQUUsQ0FBQyJ9