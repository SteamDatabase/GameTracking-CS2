// MGetKV3ClassDefaults = {
//	"m_nFlags": 0,
//	"m_nRefCounter": 0,
//	"m_bonesHash":
//	[
//	],
//	"m_boneNames":
//	[
//	],
//	"m_indexNames":
//	[
//	],
//	"m_indexHash":
//	[
//	],
//	"m_bindPose":
//	[
//	],
//	"m_parts":
//	[
//	],
//	"m_shapeMarkups":
//	[
//	],
//	"m_constraints2":
//	[
//	],
//	"m_joints":
//	[
//	],
//	"m_pFeModel": null,
//	"m_boneParents":
//	[
//	],
//	"m_surfacePropertyHashes":
//	[
//	],
//	"m_collisionAttributes":
//	[
//	],
//	"m_debugPartNames":
//	[
//	],
//	"m_embeddedKeyvalues": ""
//}
class VPhysXAggregateData_t
{
	uint16 m_nFlags;
	uint16 m_nRefCounter;
	CUtlVector< uint32 > m_bonesHash;
	CUtlVector< CUtlString > m_boneNames;
	CUtlVector< uint16 > m_indexNames;
	CUtlVector< uint16 > m_indexHash;
	CUtlVector< matrix3x4a_t > m_bindPose;
	CUtlVector< VPhysXBodyPart_t > m_parts;
	CUtlVector< PhysShapeMarkup_t > m_shapeMarkups;
	CUtlVector< VPhysXConstraint2_t > m_constraints2;
	CUtlVector< VPhysXJoint_t > m_joints;
	PhysFeModelDesc_t* m_pFeModel;
	CUtlVector< uint16 > m_boneParents;
	CUtlVector< uint32 > m_surfacePropertyHashes;
	CUtlVector< VPhysXCollisionAttributes_t > m_collisionAttributes;
	CUtlVector< CUtlString > m_debugPartNames;
	CUtlString m_embeddedKeyvalues;
};
