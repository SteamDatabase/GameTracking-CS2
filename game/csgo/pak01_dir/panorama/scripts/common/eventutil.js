"use strict";
/// <reference path="../csgo.d.ts" />
var CEventUtil = class {
    _eventIdSet = new Set();
    constructor() {
        const officialEventIds = [
            5277,
            5278,
            5279,
            5281,
            5282,
            5356,
            5339,
            5338,
            5376,
            5500,
            5506,
            5465,
            5464,
            5937,
            5967,
            4866,
            6207,
        ];
        for (const id of officialEventIds) {
            this._eventIdSet.add(id.toString());
        }
    }
    AnnotateOfficialEvents = (jsonEvents) => {
        for (let event of jsonEvents) {
            if (this._eventIdSet.has(event.event_id)) {
                event.is_official = true;
            }
        }
        return jsonEvents;
    };
};
var EventUtil = EventUtil ?? new CEventUtil();
