// MGetKV3ClassDefaults = {
//	"m_nCollisionAttributeIndex": 0,
//	"m_nSurfacePropertyIndex": 0,
//	"m_UserFriendlyName": "",
//	"m_bUserFriendlyNameSealed": false,
//	"m_bUserFriendlyNameLong": false,
//	"m_nToolMaterialHash": 0,
//	"m_Sphere":
//	{
//		"m_vCenter":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_flRadius": 0.000000
//	}
//}
class RnSphereDesc_t : public RnShapeDesc_t
{
	SphereBase_t< float32 > m_Sphere;
};
