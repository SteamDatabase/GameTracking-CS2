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
