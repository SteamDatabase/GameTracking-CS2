// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
