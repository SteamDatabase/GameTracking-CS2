// MGetKV3ClassDefaults = {
//	"m_nParentIndex": -1,
//	"m_nBodyIndex": -1,
//	"m_xLocalFrame":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_flSwingLimit": 90.000000,
//	"m_flMinTwistLimit": -180.000000,
//	"m_flMaxTwistLimit": 180.000000,
//	"m_flWeight": 1.000000
//}
class CNmIKJoint
{
	int32 m_nParentIndex;
	int32 m_nBodyIndex;
	CTransform m_xLocalFrame;
	float32 m_flSwingLimit;
	float32 m_flMinTwistLimit;
	float32 m_flMaxTwistLimit;
	float32 m_flWeight;
};
