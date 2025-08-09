// MGetKV3ClassDefaults = {
//	"m_syncEvents":
//	[
//		{
//			"m_ID": "",
//			"m_startTime":
//			{
//				"m_flValue": 0.000000
//			},
//			"m_duration":
//			{
//				"m_flValue": 1.000000
//			}
//		}
//	],
//	"m_nStartEventOffset": 0
//}
class CNmSyncTrack
{
	CUtlLeanVectorFixedGrowable< CNmSyncTrack::Event_t, 10 > m_syncEvents;
	int32 m_nStartEventOffset;
};
