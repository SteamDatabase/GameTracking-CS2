// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionSetSoundeventParameterSchema",
//	"m_nMaxCount": -1,
//	"m_flMinValue": 0.000000,
//	"m_flMaxValue": 1.000000,
//	"m_opvarName": "None",
//	"m_nSortType": "SOS_SETPARAM_SORTTYPE_LOWEST"
//}
// MPropertyFriendlyName = "Set Sound Event Parameter"
class CSosGroupActionSetSoundeventParameterSchema : public CSosGroupActionSchema
{
	int32 m_nMaxCount;
	float32 m_flMinValue;
	float32 m_flMaxValue;
	// MPropertyFriendlyName = "Parameter Name"
	CUtlString m_opvarName;
	SosActionSetParamSortType_t m_nSortType;
};
