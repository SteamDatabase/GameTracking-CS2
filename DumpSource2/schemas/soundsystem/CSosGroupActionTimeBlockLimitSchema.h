// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionTimeBlockLimitSchema",
//	"m_nMaxCount": -1,
//	"m_flMaxDuration": 0.000000
//}
// MPropertyFriendlyName = "Timed Block Limiter"
class CSosGroupActionTimeBlockLimitSchema : public CSosGroupActionSchema
{
	int32 m_nMaxCount;
	float32 m_flMaxDuration;
};
