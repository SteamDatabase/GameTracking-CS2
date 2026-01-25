class CPointTemplate : public CLogicalEntity
{
	CUtlSymbolLarge m_iszWorldName;
	CUtlSymbolLarge m_iszSource2EntityLumpName;
	CUtlSymbolLarge m_iszEntityFilterName;
	float32 m_flTimeoutInterval;
	bool m_bAsynchronouslySpawnEntities;
	// MNotSaved
	PointTemplateClientOnlyEntityBehavior_t m_clientOnlyEntityBehavior;
	// MNotSaved
	PointTemplateOwnerSpawnGroupType_t m_ownerSpawnGroupType;
	CUtlVector< uint32 > m_createdSpawnGroupHandles;
	CUtlVector< CEntityHandle > m_SpawnedEntityHandles;
	// MNotSaved
	HSCRIPT m_ScriptSpawnCallback;
	// MNotSaved
	HSCRIPT m_ScriptCallbackScope;
};
