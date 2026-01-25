// MGetKV3ClassDefaults = {
//	"_class": "CAimCameraUpdateNode",
//	"m_nodePath":
//	{
//		"m_path":
//		[
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			}
//		],
//		"m_nCount": 0
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_name": "",
//	"m_pChildNode":
//	{
//		"m_nodeIndex": -1
//	},
//	"m_hParameterPosition":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hParameterOrientation":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hParameterPelvisOffset":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hParameterCameraOnly":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hParameterWeaponDepenetrationDistance":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hParameterWeaponDepenetrationDelta":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hParameterCameraClearanceDistance":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_opFixedSettings":
//	{
//		"m_nChainIndex": -1,
//		"m_nCameraJointIndex": -1,
//		"m_nPelvisJointIndex": -1,
//		"m_nClavicleLeftJointIndex": -1,
//		"m_nClavicleRightJointIndex": -1,
//		"m_nDepenetrationJointIndex": -1,
//		"m_propJoints":
//		[
//		]
//	}
//}
class CAimCameraUpdateNode : public CUnaryUpdateNode
{
	CAnimParamHandle m_hParameterPosition;
	CAnimParamHandle m_hParameterOrientation;
	CAnimParamHandle m_hParameterPelvisOffset;
	CAnimParamHandle m_hParameterCameraOnly;
	CAnimParamHandle m_hParameterWeaponDepenetrationDistance;
	CAnimParamHandle m_hParameterWeaponDepenetrationDelta;
	CAnimParamHandle m_hParameterCameraClearanceDistance;
	AimCameraOpFixedSettings_t m_opFixedSettings;
};
