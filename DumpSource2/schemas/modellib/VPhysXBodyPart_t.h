// MGetKV3ClassDefaults = {
//	"m_nFlags": 0,
//	"m_flMass": 0.000000,
//	"m_rnShape":
//	{
//		"m_spheres":
//		[
//		],
//		"m_capsules":
//		[
//		],
//		"m_hulls":
//		[
//		],
//		"m_meshes":
//		[
//		],
//		"m_CollisionAttributeIndices":
//		[
//		]
//	},
//	"m_nCollisionAttributeIndex": 0,
//	"m_nReserved": 0,
//	"m_flInertiaScale": 0.000000,
//	"m_flLinearDamping": 0.000000,
//	"m_flAngularDamping": 0.000000,
//	"m_flLinearDrag": 1.000000,
//	"m_flAngularDrag": 1.000000,
//	"m_bOverrideMassCenter": false,
//	"m_vMassCenterOverride":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	]
//}
class VPhysXBodyPart_t
{
	uint32 m_nFlags;
	float32 m_flMass;
	VPhysics2ShapeDef_t m_rnShape;
	uint16 m_nCollisionAttributeIndex;
	uint16 m_nReserved;
	float32 m_flInertiaScale;
	float32 m_flLinearDamping;
	float32 m_flAngularDamping;
	float32 m_flLinearDrag;
	float32 m_flAngularDrag;
	bool m_bOverrideMassCenter;
	Vector m_vMassCenterOverride;
};
