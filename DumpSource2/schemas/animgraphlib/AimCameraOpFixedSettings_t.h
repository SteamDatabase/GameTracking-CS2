// MGetKV3ClassDefaults = {
//	"m_nChainIndex": -1,
//	"m_nCameraJointIndex": -1,
//	"m_nPelvisJointIndex": -1,
//	"m_nClavicleLeftJointIndex": -1,
//	"m_nClavicleRightJointIndex": -1,
//	"m_nDepenetrationJointIndex": -1,
//	"m_propJoints":
//	[
//	]
//}
class AimCameraOpFixedSettings_t
{
	int32 m_nChainIndex;
	int32 m_nCameraJointIndex;
	int32 m_nPelvisJointIndex;
	int32 m_nClavicleLeftJointIndex;
	int32 m_nClavicleRightJointIndex;
	int32 m_nDepenetrationJointIndex;
	CUtlVector< int32 > m_propJoints;
};
