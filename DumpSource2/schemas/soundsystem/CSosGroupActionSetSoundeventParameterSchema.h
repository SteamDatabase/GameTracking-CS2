// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionSetSoundeventParameterSchema",
//	"m_name": "None",
//	"m_actionType": "SOS_ACTION_SET_SOUNDEVENT_PARAM",
//	"m_actionInstanceType": "SOS_ACTION_SET_SOUNDEVENT_PARAM",
//	"m_nMaxCount": -1,
//	"m_flMinValue": 0.000000,
//	"m_flMaxValue": 1.000000,
//	"m_opvarName": "None",
//	"m_nSortType": "SOS_SORTTYPE_LOWEST"
//}
// M_LEGACY_OptInToSchemaPropertyDomain
class CSosGroupActionSetSoundeventParameterSchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Max Count"
	int32 m_nMaxCount;
	// MPropertyFriendlyName = "Minimum Value"
	float32 m_flMinValue;
	// MPropertyFriendlyName = "Maximum Value"
	float32 m_flMaxValue;
	// MPropertyFriendlyName = "Parameter Name"
	CUtlString m_opvarName;
	// MPropertyFriendlyName = "Sort Type"
	SosActionSortType_t m_nSortType;
};
