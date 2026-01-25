// MGetKV3ClassDefaults = {
//	"_class": "CNmSoundEvent",
//	"m_flStartTime":
//	{
//		"m_flValue": 0.000000
//	},
//	"m_flDuration":
//	{
//		"m_flValue": 0.000000
//	},
//	"m_syncID": "",
//	"m_bClientOnly": false,
//	"m_relevance": "ClientAndServer",
//	"m_name": "",
//	"m_position": "None",
//	"m_attachmentName": "",
//	"m_tags": "",
//	"m_bContinuePlayingSoundAtDurationEnd": false,
//	"m_flDurationInterruptionThreshold": 0.900000
//}
class CNmSoundEvent : public CNmEvent
{
	CNmEventRelevance_t m_relevance;
	CUtlString m_name;
	CNmSoundEvent::Position_t m_position;
	CUtlString m_attachmentName;
	CUtlString m_tags;
	bool m_bContinuePlayingSoundAtDurationEnd;
	float32 m_flDurationInterruptionThreshold;
};
