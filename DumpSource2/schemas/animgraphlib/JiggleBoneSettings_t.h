// MGetKV3ClassDefaults = {
//	"m_nBoneIndex": 0,
//	"m_flSpringStrength": 0.000000,
//	"m_flMaxTimeStep": 0.000000,
//	"m_flDamping": 0.000000,
//	"m_vBoundsMaxLS":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vBoundsMinLS":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_eSimSpace": "SimSpace_Local"
//}
class JiggleBoneSettings_t
{
	int32 m_nBoneIndex;
	float32 m_flSpringStrength;
	float32 m_flMaxTimeStep;
	float32 m_flDamping;
	Vector m_vBoundsMaxLS;
	Vector m_vBoundsMinLS;
	JiggleBoneSimSpace m_eSimSpace;
};
