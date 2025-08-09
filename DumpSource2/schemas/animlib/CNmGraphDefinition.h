// MGetKV3ClassDefaults = {
//	"m_variationID": "",
//	"m_skeleton": "",
//	"m_persistentNodeIndices":
//	[
//	],
//	"m_nRootNodeIdx": -1,
//	"m_controlParameterIDs":
//	[
//	],
//	"m_virtualParameterIDs":
//	[
//	],
//	"m_virtualParameterNodeIndices":
//	[
//	],
//	"m_referencedGraphSlots":
//	[
//	],
//	"m_externalGraphSlots":
//	[
//	],
//	"m_nodePaths":
//	[
//	],
//	"m_resources":
//	[
//	],
//	"m_nodes":
//	[
//	]
//}
class CNmGraphDefinition
{
	CGlobalSymbol m_variationID;
	CStrongHandle< InfoForResourceTypeCNmSkeleton > m_skeleton;
	CUtlVector< int16 > m_persistentNodeIndices;
	int16 m_nRootNodeIdx;
	CUtlVector< CGlobalSymbol > m_controlParameterIDs;
	CUtlVector< CGlobalSymbol > m_virtualParameterIDs;
	CUtlVector< int16 > m_virtualParameterNodeIndices;
	CUtlVector< CNmGraphDefinition::ReferencedGraphSlot_t > m_referencedGraphSlots;
	CUtlVector< CNmGraphDefinition::ExternalGraphSlot_t > m_externalGraphSlots;
	CUtlVector< CUtlString > m_nodePaths;
	CUtlVector< CStrongHandleVoid > m_resources;
};
