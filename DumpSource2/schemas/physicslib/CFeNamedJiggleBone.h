// MGetKV3ClassDefaults = {
//	"m_strParentBone": "",
//	"m_transform":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_nJiggleParent": 0,
//	"m_jiggleBone":
//	{
//		"m_nFlags": 0,
//		"m_flLength": 1.000000,
//		"m_flTipMass": 0.000000,
//		"m_flYawStiffness": 0.000000,
//		"m_flYawDamping": 0.000000,
//		"m_flPitchStiffness": 0.000000,
//		"m_flPitchDamping": 0.000000,
//		"m_flAlongStiffness": 0.000000,
//		"m_flAlongDamping": 0.000000,
//		"m_flAngleLimit": 0.000000,
//		"m_flMinYaw": 0.000000,
//		"m_flMaxYaw": 0.000000,
//		"m_flYawFriction": 0.000000,
//		"m_flYawBounce": 0.000000,
//		"m_flMinPitch": 0.000000,
//		"m_flMaxPitch": 0.000000,
//		"m_flPitchFriction": 0.000000,
//		"m_flPitchBounce": 0.000000,
//		"m_flBaseMass": 0.000000,
//		"m_flBaseStiffness": 0.000000,
//		"m_flBaseDamping": 0.000000,
//		"m_flBaseMinLeft": 0.000000,
//		"m_flBaseMaxLeft": 0.000000,
//		"m_flBaseLeftFriction": 0.000000,
//		"m_flBaseMinUp": 0.000000,
//		"m_flBaseMaxUp": 0.000000,
//		"m_flBaseUpFriction": 0.000000,
//		"m_flBaseMinForward": 0.000000,
//		"m_flBaseMaxForward": 0.000000,
//		"m_flBaseForwardFriction": 0.000000,
//		"m_flRadius0": 1.000000,
//		"m_flRadius1": 1.000000,
//		"m_vPoint0":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_vPoint1":
//		[
//			10.000000,
//			0.000000,
//			0.000000
//		],
//		"m_nCollisionMask": 65535
//	}
//}
class CFeNamedJiggleBone
{
	CUtlString m_strParentBone;
	CTransform m_transform;
	uint32 m_nJiggleParent;
	CFeJiggleBone m_jiggleBone;
};
