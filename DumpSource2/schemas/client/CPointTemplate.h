class CPointTemplate : public CLogicalEntity
{
	CUtlSymbolLarge m_iszWorldName;
	CUtlSymbolLarge m_iszSource2EntityLumpName;
	CUtlSymbolLarge m_iszEntityFilterName;
	float32 m_flTimeoutInterval;
	bool m_bAsynchronouslySpawnEntities;
	CEntityIOOutput m_pOutputOnSpawned;
	PointTemplateClientOnlyEntityBehavior_t m_clientOnlyEntityBehavior;
	PointTemplateOwnerSpawnGroupType_t m_ownerSpawnGroupType;
	CUtlVector< uint32 > m_createdSpawnGroupHandles;
	CUtlVector< CEntityHandle > m_SpawnedEntityHandles;
	HSCRIPT m_ScriptSpawnCallback;
	HSCRIPT m_ScriptCallbackScope;
};
