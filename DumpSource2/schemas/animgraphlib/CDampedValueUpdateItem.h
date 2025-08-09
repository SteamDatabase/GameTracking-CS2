// MGetKV3ClassDefaults = {
//	"m_damping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_hParamIn":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hParamOut":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	}
//}
class CDampedValueUpdateItem
{
	CAnimInputDamping m_damping;
	CAnimParamHandle m_hParamIn;
	CAnimParamHandle m_hParamOut;
};
