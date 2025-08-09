// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionTimeBlockLimitSchema",
//	"m_name": "None",
//	"m_actionType": "SOS_ACTION_TIME_BLOCK_LIMITER",
//	"m_actionInstanceType": "SOS_ACTION_TIME_BLOCK_LIMITER",
//	"m_nMaxCount": -1,
//	"m_flMaxDuration": 0.000000
//}
// M_LEGACY_OptInToSchemaPropertyDomain
class CSosGroupActionTimeBlockLimitSchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Max Count"
	int32 m_nMaxCount;
	// MPropertyFriendlyName = "Max Time"
	float32 m_flMaxDuration;
};
