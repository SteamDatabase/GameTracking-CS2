// MGetKV3ClassDefaults = {
//	"m_hMaterial": "",
//	"m_sSequenceName": "",
//	"m_flProbability": 1.000000,
//	"m_bEnableAngleBetweenNormalAndGravityRange": false,
//	"m_flMinAngleBetweenNormalAndGravity": 0.000000,
//	"m_flMaxAngleBetweenNormalAndGravity": 180.000000
//}
class DecalGroupOption_t
{
	CStrongHandleCopyable< InfoForResourceTypeIMaterial2 > m_hMaterial;
	CGlobalSymbol m_sSequenceName;
	float32 m_flProbability;
	bool m_bEnableAngleBetweenNormalAndGravityRange;
	// MPropertySuppressExpr = "m_bEnableAngleBetweenNormalAndGravityRange == 0"
	float32 m_flMinAngleBetweenNormalAndGravity;
	// MPropertySuppressExpr = "m_bEnableAngleBetweenNormalAndGravityRange == 0"
	float32 m_flMaxAngleBetweenNormalAndGravity;
};
