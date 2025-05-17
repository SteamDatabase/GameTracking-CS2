// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CSosGroupActionMemberCountEnvelopeSchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Min Threshold Count"
	int32 m_nBaseCount;
	// MPropertyFriendlyName = "Max Target Count"
	int32 m_nTargetCount;
	// MPropertyFriendlyName = "Threshold Value"
	float32 m_flBaseValue;
	// MPropertyFriendlyName = "Target Value"
	float32 m_flTargetValue;
	// MPropertyFriendlyName = "Attack"
	float32 m_flAttack;
	// MPropertyFriendlyName = "Decay"
	float32 m_flDecay;
	// MPropertyFriendlyName = "Result Variable Name"
	CUtlString m_resultVarName;
	// MPropertyFriendlyName = "Save Result to Group"
	bool m_bSaveToGroup;
};
