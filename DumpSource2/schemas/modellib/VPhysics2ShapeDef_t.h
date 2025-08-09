// MGetKV3ClassDefaults = {
//	"m_spheres":
//	[
//	],
//	"m_capsules":
//	[
//	],
//	"m_hulls":
//	[
//	],
//	"m_meshes":
//	[
//	],
//	"m_CollisionAttributeIndices":
//	[
//	]
//}
class VPhysics2ShapeDef_t
{
	CUtlVector< RnSphereDesc_t > m_spheres;
	CUtlVector< RnCapsuleDesc_t > m_capsules;
	CUtlVector< RnHullDesc_t > m_hulls;
	CUtlVector< RnMeshDesc_t > m_meshes;
	CUtlVector< uint16 > m_CollisionAttributeIndices;
};
