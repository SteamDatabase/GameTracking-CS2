// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionTimeLimitSchema",
//	"m_name": "None",
//	"m_actionType": "SOS_ACTION_TIME_LIMIT",
//	"m_actionInstanceType": "SOS_ACTION_TIME_LIMIT",
//	"m_flMaxDuration": -1.000000
//}
// M_LEGACY_OptInToSchemaPropertyDomain
class CSosGroupActionTimeLimitSchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Max Time"
	float32 m_flMaxDuration;
};
