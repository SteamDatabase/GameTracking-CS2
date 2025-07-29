class CRR_Response
{
	uint8 m_Type;
	char[192] m_szResponseName;
	char[128] m_szMatchingRule;
	ResponseParams m_Params;
	float32 m_fMatchScore;
	bool m_bAnyMatchingRulesInCooldown;
	char* m_szSpeakerContext;
	char* m_szWorldContext;
	ResponseFollowup m_Followup;
	CUtlSymbol m_recipientFilter;
};
