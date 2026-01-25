// MGetKV3ClassDefaults = {
//	"m_nIncludeDetailLayerCount": 0,
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
//	"m_DetailLayers":
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
//	],
//	"m_DetailLayerStrings":
//	[
//	]
//}
class VPhysXCollisionAttributes_t
{
	int32 m_nIncludeDetailLayerCount;
	uint32 m_CollisionGroup;
	CUtlVector< uint32 > m_InteractAs;
	CUtlVector< uint32 > m_InteractWith;
	CUtlVector< uint32 > m_InteractExclude;
	CUtlVector< uint32 > m_DetailLayers;
	CUtlString m_CollisionGroupString;
	CUtlVector< CUtlString > m_InteractAsStrings;
	CUtlVector< CUtlString > m_InteractWithStrings;
	CUtlVector< CUtlString > m_InteractExcludeStrings;
	CUtlVector< CUtlString > m_DetailLayerStrings;
};
