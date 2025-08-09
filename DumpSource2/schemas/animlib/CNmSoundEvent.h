// MGetKV3ClassDefaults = {
//	"_class": "CNmSoundEvent",
//	"m_flStartTimeSeconds": 0.000000,
//	"m_flDurationSeconds": 0.000000,
//	"m_syncID": "",
//	"m_bClientOnly": false,
//	"m_relevance": "ClientAndServer",
//	"m_type": "Play",
//	"m_name": "",
//	"m_position": "None",
//	"m_attachmentName": "",
//	"m_tags": "",
//	"m_bIsServerOnly": false,
//	"m_bContinuePlayingSoundAtDurationEnd": false,
//	"m_flDurationInterruptionThreshold": 0.900000
//}
class CNmSoundEvent : public CNmEvent
{
	CNmEventRelevance_t m_relevance;
	CNmSoundEvent::Type_t m_type;
	CUtlString m_name;
	CNmSoundEvent::Position_t m_position;
	CUtlString m_attachmentName;
	CUtlString m_tags;
	bool m_bIsServerOnly;
	bool m_bContinuePlayingSoundAtDurationEnd;
	float32 m_flDurationInterruptionThreshold;
};
