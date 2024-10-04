class CSosGroupActionMemberCountEnvelopeSchema : public CSosGroupActionSchema
{
	int32 m_nBaseCount;
	int32 m_nTargetCount;
	float32 m_flBaseValue;
	float32 m_flTargetValue;
	float32 m_flAttack;
	float32 m_flDecay;
	CUtlString m_resultVarName;
	bool m_bSaveToGroup;
};
