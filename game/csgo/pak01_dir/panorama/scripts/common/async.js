"use strict";
/// <reference path="../../../../core/panorama/scripts/index.d.ts" />
var Async;
(function (Async) {
    function Delay(fDelay, value) {
        return new Promise(resolve => $.Schedule(fDelay, () => resolve(value)));
    }
    Async.Delay = Delay;
    function NextFrame() {
        return Delay(0.0);
    }
    Async.NextFrame = NextFrame;
    function UnhandledEvent(sEvent) {
        return new Promise(resolve => {
            const nHandlerId = $.RegisterForUnhandledEvent(sEvent, function (...args) {
                $.UnregisterForUnhandledEvent(sEvent, nHandlerId);
                resolve(args);
            });
        });
    }
    Async.UnhandledEvent = UnhandledEvent;
    class AbortController {
        signal;
        _aborted = false;
        constructor() {
            const controller = this;
            this.signal = { get aborted() { return controller._aborted; } };
        }
        abort() {
            this._aborted = true;
        }
    }
    Async.AbortController = AbortController;
    function Condition(predicate, abortSignal) {
        return new Promise(async (resolve) => {
            while (abortSignal === undefined || !abortSignal.aborted) {
                if (predicate()) {
                    resolve();
                    return;
                }
                await NextFrame();
            }
        });
    }
    Async.Condition = Condition;
    function RunSequence(sequenceFn, abortSignal) {
        return new Promise(async (resolve) => {
            const generator = sequenceFn(abortSignal || new Async.AbortController().signal);
            let value;
            while (true) {
                const iterResult = await generator.next(value);
                if (iterResult.done) {
                    resolve(true);
                    return;
                }
                value = await iterResult.value;
                if (abortSignal && abortSignal.aborted) {
                    resolve(false);
                    return;
                }
            }
        });
    }
    Async.RunSequence = RunSequence;
    class TimeStamp {
        frameTime = $.FrameTime();
        Schedule(fDelay, fn) {
            const fDelayFromNow = fDelay - ($.FrameTime() - this.frameTime);
            $.Schedule(fDelayFromNow, fn);
        }
        Delay(fDelay, value) {
            return new Promise(resolve => this.Schedule(fDelay, () => resolve(value)));
        }
    }
    Async.TimeStamp = TimeStamp;
})(Async || (Async = {}));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiYXN5bmMuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9jb21tb24vYXN5bmMudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFFQUFxRTtBQUVyRSxJQUFVLEtBQUssQ0FxSmQ7QUFySkQsV0FBVSxLQUFLO0lBVVgsU0FBZ0IsS0FBSyxDQUFNLE1BQWMsRUFBRSxLQUFTO1FBRWhELE9BQU8sSUFBSSxPQUFPLENBQUssT0FBTyxDQUFDLEVBQUUsQ0FBQyxDQUFDLENBQUMsUUFBUSxDQUFFLE1BQU0sRUFBRSxHQUFHLEVBQUUsQ0FBQyxPQUFPLENBQUUsS0FBTSxDQUFFLENBQUUsQ0FBRSxDQUFDO0lBQ3RGLENBQUM7SUFIZSxXQUFLLFFBR3BCLENBQUE7SUFLRCxTQUFnQixTQUFTO1FBRXJCLE9BQU8sS0FBSyxDQUFFLEdBQUcsQ0FBRSxDQUFDO0lBQ3hCLENBQUM7SUFIZSxlQUFTLFlBR3hCLENBQUE7SUFNRCxTQUFnQixjQUFjLENBQW9CLE1BQWM7UUFFNUQsT0FBTyxJQUFJLE9BQU8sQ0FBRSxPQUFPLENBQUMsRUFBRTtZQUUxQixNQUFNLFVBQVUsR0FBRyxDQUFDLENBQUMseUJBQXlCLENBQUUsTUFBTSxFQUFFLFVBQVcsR0FBRyxJQUFPO2dCQUV6RSxDQUFDLENBQUMsMkJBQTJCLENBQUUsTUFBTSxFQUFFLFVBQVUsQ0FBRSxDQUFDO2dCQUNwRCxPQUFPLENBQUUsSUFBSSxDQUFFLENBQUM7WUFDcEIsQ0FBQyxDQUFFLENBQUM7UUFDUixDQUFDLENBQUUsQ0FBQztJQUNSLENBQUM7SUFWZSxvQkFBYyxpQkFVN0IsQ0FBQTtJQWFELE1BQWEsZUFBZTtRQUV4QixNQUFNLENBQWdCO1FBQ2QsUUFBUSxHQUFHLEtBQUssQ0FBQztRQUN6QjtZQUVJLE1BQU0sVUFBVSxHQUFHLElBQUksQ0FBQztZQUN4QixJQUFJLENBQUMsTUFBTSxHQUFHLEVBQUUsSUFBSSxPQUFPLEtBQU0sT0FBTyxVQUFVLENBQUMsUUFBUSxDQUFDLENBQUMsQ0FBQyxFQUFFLENBQUM7UUFDckUsQ0FBQztRQUNELEtBQUs7WUFFRCxJQUFJLENBQUMsUUFBUSxHQUFHLElBQUksQ0FBQztRQUN6QixDQUFDO0tBQ0o7SUFiWSxxQkFBZSxrQkFhM0IsQ0FBQTtJQUVELFNBQWdCLFNBQVMsQ0FBRyxTQUF3QixFQUFFLFdBQTJCO1FBRTdFLE9BQU8sSUFBSSxPQUFPLENBQVEsS0FBSyxFQUFDLE9BQU8sRUFBQyxFQUFFO1lBRXRDLE9BQVEsV0FBVyxLQUFLLFNBQVMsSUFBSSxDQUFDLFdBQVcsQ0FBQyxPQUFPLEVBQ3pEO2dCQUNJLElBQUssU0FBUyxFQUFFLEVBQ2hCO29CQUNJLE9BQU8sRUFBRSxDQUFDO29CQUNWLE9BQU87aUJBQ1Y7Z0JBQ0QsTUFBTSxTQUFTLEVBQUUsQ0FBQzthQUNyQjtRQUNMLENBQUMsQ0FBRSxDQUFDO0lBQ1IsQ0FBQztJQWRlLGVBQVMsWUFjeEIsQ0FBQTtJQVFELFNBQWdCLFdBQVcsQ0FBRyxVQUF3QixFQUFFLFdBQWlDO1FBRXJGLE9BQU8sSUFBSSxPQUFPLENBQVcsS0FBSyxFQUFDLE9BQU8sRUFBQyxFQUFFO1lBRXpDLE1BQU0sU0FBUyxHQUFHLFVBQVUsQ0FBRSxXQUFXLElBQUksSUFBSSxLQUFLLENBQUMsZUFBZSxFQUFFLENBQUMsTUFBTSxDQUFFLENBQUM7WUFDbEYsSUFBSSxLQUFjLENBQUM7WUFDbkIsT0FBUSxJQUFJLEVBQ1o7Z0JBQ0ksTUFBTSxVQUFVLEdBQUcsTUFBTSxTQUFTLENBQUMsSUFBSSxDQUFFLEtBQU0sQ0FBRSxDQUFDO2dCQUNsRCxJQUFLLFVBQVUsQ0FBQyxJQUFJLEVBQ3BCO29CQUNJLE9BQU8sQ0FBRSxJQUFJLENBQUUsQ0FBQztvQkFDaEIsT0FBTztpQkFDVjtnQkFFRCxLQUFLLEdBQUcsTUFBTSxVQUFVLENBQUMsS0FBSyxDQUFDO2dCQUMvQixJQUFLLFdBQVcsSUFBSSxXQUFXLENBQUMsT0FBTyxFQUN2QztvQkFDSSxPQUFPLENBQUUsS0FBSyxDQUFFLENBQUM7b0JBQ2pCLE9BQU87aUJBQ1Y7YUFDSjtRQUNMLENBQUMsQ0FBRSxDQUFDO0lBQ1IsQ0FBQztJQXZCZSxpQkFBVyxjQXVCMUIsQ0FBQTtJQWFELE1BQWEsU0FBUztRQUVsQixTQUFTLEdBQUcsQ0FBQyxDQUFDLFNBQVMsRUFBRSxDQUFDO1FBSzFCLFFBQVEsQ0FBRyxNQUFjLEVBQUUsRUFBYztZQUVyQyxNQUFNLGFBQWEsR0FBRyxNQUFNLEdBQUcsQ0FBRSxDQUFDLENBQUMsU0FBUyxFQUFFLEdBQUcsSUFBSSxDQUFDLFNBQVMsQ0FBRSxDQUFDO1lBQ2xFLENBQUMsQ0FBQyxRQUFRLENBQUUsYUFBYSxFQUFFLEVBQUUsQ0FBRSxDQUFDO1FBQ3BDLENBQUM7UUFVRCxLQUFLLENBQU0sTUFBYyxFQUFFLEtBQVM7WUFFaEMsT0FBTyxJQUFJLE9BQU8sQ0FBSyxPQUFPLENBQUMsRUFBRSxDQUFDLElBQUksQ0FBQyxRQUFRLENBQUUsTUFBTSxFQUFFLEdBQUcsRUFBRSxDQUFDLE9BQU8sQ0FBRSxLQUFNLENBQUUsQ0FBRSxDQUFFLENBQUM7UUFDekYsQ0FBQztLQUNKO0lBekJZLGVBQVMsWUF5QnJCLENBQUE7QUFDTCxDQUFDLEVBckpTLEtBQUssS0FBTCxLQUFLLFFBcUpkIn0=