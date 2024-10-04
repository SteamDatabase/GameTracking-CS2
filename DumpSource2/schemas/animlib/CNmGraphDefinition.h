class CNmGraphDefinition
{
	CUtlVector< int16 > m_persistentNodeIndices;
	int16 m_nRootNodeIdx;
	CUtlVector< CGlobalSymbol > m_controlParameterIDs;
	CUtlVector< CGlobalSymbol > m_virtualParameterIDs;
	CUtlVector< int16 > m_virtualParameterNodeIndices;
	CUtlVector< CNmGraphDefinition::ChildGraphSlot_t > m_childGraphSlots;
	CUtlVector< CNmGraphDefinition::ExternalGraphSlot_t > m_externalGraphSlots;
	CUtlVector< CUtlString > m_nodePaths;
	V_uuid_t m_runtimeVersionID;
}
