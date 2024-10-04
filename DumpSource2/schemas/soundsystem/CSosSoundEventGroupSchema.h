class CSosSoundEventGroupSchema
{
	CUtlString m_name;
	SosGroupType_t m_nType;
	bool m_bIsBlocking;
	int32 m_nBlockMaxCount;
	bool m_bInvertMatch;
	CSosGroupMatchPattern m_matchPattern;
	CSosGroupBranchPattern m_branchPattern;
	float32 m_flLifeSpanTime;
	CSosGroupActionSchema*[4] m_vActions;
};
