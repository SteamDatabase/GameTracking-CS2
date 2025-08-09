// MGetKV3ClassDefaults = {
//	"_class": "CNmParticleEvent",
//	"m_flStartTimeSeconds": 0.000000,
//	"m_flDurationSeconds": 0.000000,
//	"m_syncID": "",
//	"m_bClientOnly": false,
//	"m_relevance": "ClientAndServer",
//	"m_type": "Create",
//	"m_hParticleSystem": "",
//	"m_tags": "",
//	"m_bStopImmediately": false,
//	"m_attachmentPoint0": "",
//	"m_attachmentType0": "PATTACH_ABSORIGIN",
//	"m_attachmentPoint1": "",
//	"m_attachmentType1": "PATTACH_ABSORIGIN",
//	"m_config": "preview",
//	"m_effectForConfig": "",
//	"m_bDetachFromOwner": false,
//	"m_bPlayEndCap": false
//}
class CNmParticleEvent : public CNmEvent
{
	CNmEventRelevance_t m_relevance;
	CNmParticleEvent::Type_t m_type;
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_hParticleSystem;
	CUtlString m_tags;
	bool m_bStopImmediately;
	CUtlString m_attachmentPoint0;
	ParticleAttachment_t m_attachmentType0;
	CUtlString m_attachmentPoint1;
	ParticleAttachment_t m_attachmentType1;
	CUtlString m_config;
	CUtlString m_effectForConfig;
	bool m_bDetachFromOwner;
	bool m_bPlayEndCap;
};
