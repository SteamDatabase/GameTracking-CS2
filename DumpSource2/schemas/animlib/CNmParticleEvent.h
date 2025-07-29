// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
