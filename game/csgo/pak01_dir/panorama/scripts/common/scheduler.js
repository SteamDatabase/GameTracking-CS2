"use strict";
/// <reference path="../csgo.d.ts" />
var Scheduler = (function () {
    const oJobs = {};
    function _Schedule(delay, fn, key = 'default') {
        if (!oJobs.hasOwnProperty(key))
            oJobs[key] = [];
        oJobs[key].push(_Job(delay, fn, key));
    }
    function _Cancel(key = 'default') {
        if (oJobs.hasOwnProperty(key)) {
            while (oJobs[key].length) {
                const job = oJobs[key].pop();
                job.Cancel();
            }
        }
    }
    function _Job(delay, func, key) {
        let m_handle = $.Schedule(delay, function () {
            m_handle = null;
            func();
        });
        function _GetHandle() {
            return m_handle;
        }
        function _Cancel() {
            if (m_handle) {
                $.CancelScheduled(m_handle);
                m_handle = null;
            }
        }
        return {
            Cancel: _Cancel,
            GetHandle: _GetHandle,
        };
    }
    return {
        Schedule: _Schedule,
        Cancel: _Cancel
    };
})();
(function () {
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2NoZWR1bGVyLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvY29tbW9uL3NjaGVkdWxlci50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEscUNBQXFDO0FBZXJDLElBQUksU0FBUyxHQUFHLENBQUU7SUFTakIsTUFBTSxLQUFLLEdBQTBCLEVBQUUsQ0FBQztJQUV4QyxTQUFTLFNBQVMsQ0FBRyxLQUFhLEVBQUUsRUFBYyxFQUFFLE1BQWMsU0FBUztRQUUxRSxJQUFLLENBQUMsS0FBSyxDQUFDLGNBQWMsQ0FBRSxHQUFHLENBQUU7WUFDaEMsS0FBSyxDQUFFLEdBQUcsQ0FBRSxHQUFHLEVBQUUsQ0FBQztRQUVuQixLQUFLLENBQUUsR0FBRyxDQUFFLENBQUMsSUFBSSxDQUFFLElBQUksQ0FBRSxLQUFLLEVBQUUsRUFBRSxFQUFFLEdBQUcsQ0FBRSxDQUFFLENBQUM7SUFDN0MsQ0FBQztJQUVELFNBQVMsT0FBTyxDQUFHLE1BQWMsU0FBUztRQUV6QyxJQUFLLEtBQUssQ0FBQyxjQUFjLENBQUUsR0FBRyxDQUFFLEVBQ2hDO1lBQ0MsT0FBUSxLQUFLLENBQUUsR0FBRyxDQUFFLENBQUMsTUFBTSxFQUMzQjtnQkFDQyxNQUFNLEdBQUcsR0FBRyxLQUFLLENBQUUsR0FBRyxDQUFFLENBQUMsR0FBRyxFQUFHLENBQUM7Z0JBQ2hDLEdBQUcsQ0FBQyxNQUFNLEVBQUUsQ0FBQzthQUNiO1NBQ0Q7SUFDRixDQUFDO0lBRUQsU0FBUyxJQUFJLENBQUcsS0FBYSxFQUFFLElBQWdCLEVBQUUsR0FBVztRQUUzRCxJQUFJLFFBQVEsR0FBa0IsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxLQUFLLEVBQUU7WUFFaEQsUUFBUSxHQUFHLElBQUksQ0FBQztZQUNoQixJQUFJLEVBQUUsQ0FBQztRQUdSLENBQUMsQ0FBRSxDQUFDO1FBSUosU0FBUyxVQUFVO1lBRWxCLE9BQU8sUUFBUSxDQUFDO1FBQ2pCLENBQUM7UUFFRCxTQUFTLE9BQU87WUFFZixJQUFLLFFBQVEsRUFDYjtnQkFFQyxDQUFDLENBQUMsZUFBZSxDQUFFLFFBQVEsQ0FBRSxDQUFDO2dCQUM5QixRQUFRLEdBQUcsSUFBSSxDQUFDO2FBQ2hCO1FBQ0YsQ0FBQztRQUVELE9BQU87WUFDTixNQUFNLEVBQUUsT0FBTztZQUNmLFNBQVMsRUFBRSxVQUFVO1NBQ3JCLENBQUM7SUFDSCxDQUFDO0lBRUQsT0FBTztRQUVOLFFBQVEsRUFBRSxTQUFTO1FBQ25CLE1BQU0sRUFBRSxPQUFPO0tBQ2YsQ0FBQztBQUNILENBQUMsQ0FBRSxFQUFFLENBQUM7QUFLTixDQUFFO0FBRUYsQ0FBQyxDQUFFLEVBQUUsQ0FBQyJ9