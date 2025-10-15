// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionLimitSchema",
//	"m_nMaxCount": -1,
//	"m_nStopType": "SOS_STOPTYPE_NONE",
//	"m_nSortType": "SOS_LIMIT_SORTTYPE_HIGHEST",
//	"m_bStopImmediate": false,
//	"m_bCountStopped": true
//}
// MPropertyFriendlyName = "Limiter"
class CSosGroupActionLimitSchema : public CSosGroupActionSchema
{
	int32 m_nMaxCount;
	SosActionStopType_t m_nStopType;
	SosActionLimitSortType_t m_nSortType;
	bool m_bStopImmediate;
	// MPropertyFriendlyName = "Count Stopped Events"
	bool m_bCountStopped;
};
