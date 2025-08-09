// MGetKV3ClassDefaults = {
//	"m_StartTime": null,
//	"m_EndTime": null,
//	"m_flWaitInterval": 0.000000,
//	"m_flWaitIntervalHigh": 0.000000,
//	"m_bCompleteOnNextWake": false
//}
class CPulseCell_IntervalTimer::CursorState_t
{
	GameTime_t m_StartTime;
	GameTime_t m_EndTime;
	float32 m_flWaitInterval;
	float32 m_flWaitIntervalHigh;
	bool m_bCompleteOnNextWake;
};
