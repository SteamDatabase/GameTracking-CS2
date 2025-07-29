// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmSoundEvent : public CNmEvent
{
	CNmEventRelevance_t m_relevance;
	CNmSoundEvent::Type_t m_type;
	CUtlString m_name;
	CNmSoundEvent::Position_t m_position;
	CUtlString m_attachmentName;
	CUtlString m_tags;
	bool m_bIsServerOnly;
};
