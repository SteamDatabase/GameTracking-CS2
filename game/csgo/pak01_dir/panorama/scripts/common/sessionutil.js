"use strict";
/// <reference path="../csgo.d.ts" />
var SessionUtil = (function () {
    const _DoesGameModeHavePrimeQueue = function (gameModeSettingName) {
        const bPrimeQueueSupported = (gameModeSettingName === 'competitive' || gameModeSettingName === 'scrimcomp2v2' || gameModeSettingName === 'survival');
        return bPrimeQueueSupported;
    };
    const _GetMaxLobbySlotsForGameMode = function (gameMode) {
        let numLobbySlots = 5;
        if (gameMode == "scrimcomp2v2" ||
            gameMode == "cooperative" ||
            gameMode == "coopmission")
            numLobbySlots = 2;
        else if (gameMode === "survival")
            numLobbySlots = 2;
        return numLobbySlots;
    };
    const _AreLobbyPlayersPrime = function () {
        const playersCount = PartyListAPI.GetCount();
        for (let i = 0; i < playersCount; i++) {
            const xuid = PartyListAPI.GetXuidByIndex(i);
            const isFriendPrime = PartyListAPI.GetFriendPrimeEligible(xuid);
            if (isFriendPrime === false) {
                return false;
            }
        }
        return true;
    };
    const _GetNumWinsNeededForRank = function (skillgroupType) {
        if (skillgroupType.toLowerCase() === 'survival')
            return 0;
        if (skillgroupType.toLowerCase() === 'dangerzone')
            return 0;
        return 10;
    };
    return {
        DoesGameModeHavePrimeQueue: _DoesGameModeHavePrimeQueue,
        GetMaxLobbySlotsForGameMode: _GetMaxLobbySlotsForGameMode,
        AreLobbyPlayersPrime: _AreLobbyPlayersPrime,
        GetNumWinsNeededForRank: _GetNumWinsNeededForRank
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2Vzc2lvbnV0aWwuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9jb21tb24vc2Vzc2lvbnV0aWwudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUlyQyxJQUFJLFdBQVcsR0FBRyxDQUFFO0lBRW5CLE1BQU0sMkJBQTJCLEdBQUcsVUFBVSxtQkFBMkI7UUFReEUsTUFBTSxvQkFBb0IsR0FBRyxDQUFFLG1CQUFtQixLQUFLLGFBQWEsSUFBSSxtQkFBbUIsS0FBSyxjQUFjLElBQUksbUJBQW1CLEtBQUssVUFBVSxDQUFFLENBQUM7UUFDdkosT0FBTyxvQkFBb0IsQ0FBQztJQUM3QixDQUFDLENBQUM7SUFFRixNQUFNLDRCQUE0QixHQUFHLFVBQVUsUUFBZ0I7UUFJOUQsSUFBSSxhQUFhLEdBQUcsQ0FBQyxDQUFDO1FBQ3RCLElBQUssUUFBUSxJQUFJLGNBQWM7WUFDOUIsUUFBUSxJQUFJLGFBQWE7WUFDekIsUUFBUSxJQUFJLGFBQWE7WUFDekIsYUFBYSxHQUFHLENBQUMsQ0FBQzthQUNkLElBQUssUUFBUSxLQUFLLFVBQVU7WUFDaEMsYUFBYSxHQUFHLENBQUMsQ0FBQztRQUNuQixPQUFPLGFBQWEsQ0FBQztJQUN0QixDQUFDLENBQUM7SUFFRixNQUFNLHFCQUFxQixHQUFHO1FBRTdCLE1BQU0sWUFBWSxHQUFHLFlBQVksQ0FBQyxRQUFRLEVBQUUsQ0FBQztRQUU3QyxLQUFNLElBQUksQ0FBQyxHQUFHLENBQUMsRUFBRSxDQUFDLEdBQUcsWUFBWSxFQUFFLENBQUMsRUFBRSxFQUN0QztZQUNDLE1BQU0sSUFBSSxHQUFHLFlBQVksQ0FBQyxjQUFjLENBQUUsQ0FBQyxDQUFFLENBQUM7WUFDOUMsTUFBTSxhQUFhLEdBQUcsWUFBWSxDQUFDLHNCQUFzQixDQUFFLElBQUksQ0FBRSxDQUFDO1lBRWxFLElBQUssYUFBYSxLQUFLLEtBQUssRUFDNUI7Z0JBQ0MsT0FBTyxLQUFLLENBQUM7YUFDYjtTQUNEO1FBRUQsT0FBTyxJQUFJLENBQUM7SUFDYixDQUFDLENBQUM7SUFFRixNQUFNLHdCQUF3QixHQUFHLFVBQVUsY0FBc0I7UUFFaEUsSUFBSyxjQUFjLENBQUMsV0FBVyxFQUFFLEtBQUssVUFBVTtZQUFHLE9BQU8sQ0FBQyxDQUFDO1FBQzVELElBQUssY0FBYyxDQUFDLFdBQVcsRUFBRSxLQUFLLFlBQVk7WUFBRyxPQUFPLENBQUMsQ0FBQztRQUM5RCxPQUFPLEVBQUUsQ0FBQztJQUNYLENBQUMsQ0FBQztJQUVGLE9BQU07UUFDTCwwQkFBMEIsRUFBRywyQkFBMkI7UUFDeEQsMkJBQTJCLEVBQUUsNEJBQTRCO1FBQ3pELG9CQUFvQixFQUFFLHFCQUFxQjtRQUMzQyx1QkFBdUIsRUFBRyx3QkFBd0I7S0FDbEQsQ0FBQztBQUNILENBQUMsQ0FBQyxFQUFFLENBQUMifQ==