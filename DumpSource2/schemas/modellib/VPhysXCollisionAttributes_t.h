// MGetKV3ClassDefaults = {
//	"m_CollisionGroup": 0,
//	"m_InteractAs":
//	[
//	],
//	"m_InteractWith":
//	[
//	],
//	"m_InteractExclude":
//	[
//	],
//	"m_CollisionGroupString": "",
//	"m_InteractAsStrings":
//	[
//	],
//	"m_InteractWithStrings":
//	[
//	],
//	"m_InteractExcludeStrings":
//	[
//	]
//}
class VPhysXCollisionAttributes_t
{
	uint32 m_CollisionGroup;
	CUtlVector< uint32 > m_InteractAs;
	CUtlVector< uint32 > m_InteractWith;
	CUtlVector< uint32 > m_InteractExclude;
	CUtlString m_CollisionGroupString;
	CUtlVector< CUtlString > m_InteractAsStrings;
	CUtlVector< CUtlString > m_InteractWithStrings;
	CUtlVector< CUtlString > m_InteractExcludeStrings;
};
