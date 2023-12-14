"use strict";
/// <reference path="../csgo.d.ts" />
var HudSpecatorBg = (function () {
    const m_aPlayerTable = [];
    const m_elBg = $.GetContextPanel().FindChildTraverse('AnimBackground');
    function _pickBg(xuid) {
        const playerXuid = xuid;
        if (!m_elBg || !m_elBg.IsValid()) {
            return;
        }
        m_elBg.PopulateFromSteamID(playerXuid);
        return;
    }
    function _setBackground(bgIdx) {
        if (m_elBg) {
            m_elBg.SetHasClass('hidden', false);
            m_elBg.style.backgroundImage = 'url("file://{resources}/videos/card_' + bgIdx + '.webm");';
            m_elBg.style.backgroundPosition = '0% 50%;';
            m_elBg.style.backgroundSize = '100% auto;';
        }
    }
    function _addPlayerToTable(playerXuid) {
        const nPlayers = m_aPlayerTable.length;
        const newIdx = (nPlayers + 1) % 10;
        m_aPlayerTable.push({ xuid: playerXuid, bgIdx: newIdx });
        _setBackground(newIdx);
    }
    return {
        PickBg: _pickBg
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiYW5pbV9iYWNrZ3JvdW5kLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvY29tbW9uL2FuaW1fYmFja2dyb3VuZC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBRXJDLElBQUksYUFBYSxHQUFHLENBQUU7SUFFckIsTUFBTSxjQUFjLEdBQTRDLEVBQUUsQ0FBQztJQUNuRSxNQUFNLE1BQU0sR0FBRyxDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsaUJBQWlCLENBQUUsZ0JBQWdCLENBQWtDLENBQUM7SUFFekcsU0FBUyxPQUFPLENBQUcsSUFBWTtRQUU5QixNQUFNLFVBQVUsR0FBRyxJQUFJLENBQUM7UUFFeEIsSUFBSyxDQUFDLE1BQU0sSUFBSSxDQUFDLE1BQU0sQ0FBQyxPQUFPLEVBQUUsRUFDakM7WUFDQyxPQUFPO1NBQ1A7UUFHRCxNQUFNLENBQUMsbUJBQW1CLENBQUUsVUFBVSxDQUFFLENBQUM7UUFDekMsT0FBTztJQXNCUixDQUFDO0lBRUQsU0FBUyxjQUFjLENBQUcsS0FBYTtRQUV0QyxJQUFLLE1BQU0sRUFDWDtZQUNDLE1BQU0sQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLEtBQUssQ0FBRSxDQUFDO1lBQ3RDLE1BQU0sQ0FBQyxLQUFLLENBQUMsZUFBZSxHQUFHLHNDQUFzQyxHQUFHLEtBQUssR0FBRyxVQUFVLENBQUM7WUFDM0YsTUFBTSxDQUFDLEtBQUssQ0FBQyxrQkFBa0IsR0FBRyxTQUFTLENBQUM7WUFDNUMsTUFBTSxDQUFDLEtBQUssQ0FBQyxjQUFjLEdBQUcsWUFBWSxDQUFDO1NBQzNDO0lBQ0YsQ0FBQztJQUVELFNBQVMsaUJBQWlCLENBQUcsVUFBa0I7UUFNOUMsTUFBTSxRQUFRLEdBQUcsY0FBYyxDQUFDLE1BQU0sQ0FBQztRQUN2QyxNQUFNLE1BQU0sR0FBRyxDQUFFLFFBQVEsR0FBRyxDQUFDLENBQUUsR0FBRyxFQUFFLENBQUM7UUFFckMsY0FBYyxDQUFDLElBQUksQ0FBRSxFQUFFLElBQUksRUFBRSxVQUFVLEVBQUUsS0FBSyxFQUFFLE1BQU0sRUFBRSxDQUFFLENBQUM7UUFDM0QsY0FBYyxDQUFFLE1BQU0sQ0FBRSxDQUFDO0lBQzFCLENBQUM7SUFHRCxPQUFPO1FBQ04sTUFBTSxFQUFFLE9BQU87S0FDZixDQUFDO0FBRUgsQ0FBQyxDQUFFLEVBQUUsQ0FBQyJ9