// MGetKV3ClassDefaults = {
//	"m_nBodyIndex": -1,
//	"m_bEnabled": true,
//	"m_vTargetPosition":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_qTargetOrientation":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_flWeight": 1.000000
//}
class CNmIKEffector
{
	int32 m_nBodyIndex;
	bool m_bEnabled;
	Vector m_vTargetPosition;
	Quaternion m_qTargetOrientation;
	float32 m_flWeight;
};
