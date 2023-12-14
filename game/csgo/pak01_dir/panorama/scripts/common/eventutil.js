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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZXZlbnR1dGlsLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvY29tbW9uL2V2ZW50dXRpbC50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBVXJDLElBQUksVUFBVSxHQUFHO0lBRVIsV0FBVyxHQUFHLElBQUksR0FBRyxFQUFVLENBQUM7SUFFeEM7UUFVQyxNQUFNLGdCQUFnQixHQUFHO1lBR3hCLElBQUk7WUFDSixJQUFJO1lBQ0osSUFBSTtZQUNKLElBQUk7WUFDSixJQUFJO1lBR0osSUFBSTtZQUNKLElBQUk7WUFDSixJQUFJO1lBQ0osSUFBSTtZQUdKLElBQUk7WUFDSixJQUFJO1lBQ0osSUFBSTtZQUNKLElBQUk7WUFHSixJQUFJO1lBQ0osSUFBSTtZQUdKLElBQUk7WUFDSixJQUFJO1NBQ0osQ0FBQztRQUNGLEtBQU0sTUFBTSxFQUFFLElBQUksZ0JBQWdCLEVBQ2xDO1lBQ0MsSUFBSSxDQUFDLFdBQVcsQ0FBQyxHQUFHLENBQUUsRUFBRSxDQUFDLFFBQVEsRUFBRSxDQUFFLENBQUM7U0FDdEM7SUFDRixDQUFDO0lBRUQsc0JBQXNCLEdBQUcsQ0FBNkIsVUFBZSxFQUFRLEVBQUU7UUFFOUUsS0FBTSxJQUFJLEtBQUssSUFBSSxVQUFVLEVBQzdCO1lBQ0MsSUFBSyxJQUFJLENBQUMsV0FBVyxDQUFDLEdBQUcsQ0FBRSxLQUFLLENBQUMsUUFBUSxDQUFFLEVBQzNDO2dCQUNDLEtBQUssQ0FBQyxXQUFXLEdBQUcsSUFBSSxDQUFDO2FBQ3pCO1NBQ0Q7UUFFRCxPQUFPLFVBQVUsQ0FBQztJQUNuQixDQUFDLENBQUM7Q0FDRixDQUFDO0FBRUYsSUFBSSxTQUFTLEdBQWdDLFNBQVUsSUFBSSxJQUFJLFVBQVUsRUFBRSxDQUFDIn0=