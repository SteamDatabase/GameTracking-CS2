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
