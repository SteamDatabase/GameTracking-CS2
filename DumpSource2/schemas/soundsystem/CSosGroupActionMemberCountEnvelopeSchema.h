// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionMemberCountEnvelopeSchema",
//	"m_nBaseCount": 0,
//	"m_nTargetCount": 1,
//	"m_flBaseValue": 0.000000,
//	"m_flTargetValue": 0.000000,
//	"m_flAttack": 1.000000,
//	"m_flDecay": 1.000000,
//	"m_resultVarName": "envelope_result",
//	"m_bSaveToGroup": false
//}
// MPropertyFriendlyName = "Count Envelope"
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
