// MGetKV3ClassDefaults = {
//	"_class": "CSetParameterActionUpdater",
//	"m_hParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_value":
//	{
//		"m_nType": 0
//	}
//}
class CSetParameterActionUpdater : public CAnimActionUpdater
{
	CAnimParamHandle m_hParam;
	CAnimVariant m_value;
};
