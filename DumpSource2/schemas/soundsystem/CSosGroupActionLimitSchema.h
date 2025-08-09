// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionLimitSchema",
//	"m_name": "None",
//	"m_actionType": "SOS_ACTION_LIMITER",
//	"m_actionInstanceType": "SOS_ACTION_LIMITER",
//	"m_nMaxCount": -1,
//	"m_nStopType": "SOS_STOPTYPE_NONE",
//	"m_nSortType": "SOS_SORTTYPE_HIGHEST"
//}
// M_LEGACY_OptInToSchemaPropertyDomain
class CSosGroupActionLimitSchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Max Count"
	int32 m_nMaxCount;
	// MPropertyFriendlyName = "Stop Type"
	SosActionStopType_t m_nStopType;
	// MPropertyFriendlyName = "Sort Type"
	SosActionSortType_t m_nSortType;
};
