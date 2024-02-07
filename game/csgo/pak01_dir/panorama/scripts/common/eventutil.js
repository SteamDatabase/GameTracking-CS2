"use strict";
/// <reference path="../csgo.d.ts" />
var EventUtil;
(function (EventUtil) {
    const _eventIdSet = new Set([
        '5277',
        '5278',
        '5279',
        '5281',
        '5282',
        '5356',
        '5339',
        '5338',
        '5376',
        '5500',
        '5506',
        '5465',
        '5464',
        '5937',
        '5967',
        '4866',
        '6207',
    ]);
    function AnnotateOfficialEvents(jsonEvents) {
        for (let event of jsonEvents) {
            if (_eventIdSet.has(event.event_id)) {
                event.is_official = true;
            }
        }
        return jsonEvents;
    }
    EventUtil.AnnotateOfficialEvents = AnnotateOfficialEvents;
})(EventUtil || (EventUtil = {}));
