// MGetKV3ClassDefaults = {
//	"m_transforms":
//	[
//	],
//	"m_nNumFrames": 0,
//	"m_flAverageLinearVelocity": 0.000000,
//	"m_flAverageAngularVelocityRadians": 0.000000,
//	"m_totalDelta":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	]
//}
class CNmRootMotionData
{
	CUtlVector< CTransform > m_transforms;
	int32 m_nNumFrames;
	float32 m_flAverageLinearVelocity;
	float32 m_flAverageAngularVelocityRadians;
	CTransform m_totalDelta;
};
