// MGetKV3ClassDefaults = {
//	"m_flTimeFromPrevious": 0.000000,
//	"m_EventOutflow":
//	{
//		"m_SourceOutflowName": "",
//		"m_nDestChunk": -1,
//		"m_nInstruction": -1
//	}
//}
class CPulseCell_Timeline::TimelineEvent_t
{
	float32 m_flTimeFromPrevious;
	CPulse_OutflowConnection m_EventOutflow;
};
