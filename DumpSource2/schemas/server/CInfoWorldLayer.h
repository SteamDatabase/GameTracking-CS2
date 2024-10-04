class CInfoWorldLayer : public CBaseEntity
{
	CEntityIOOutput m_pOutputOnEntitiesSpawned;
	CUtlSymbolLarge m_worldName;
	CUtlSymbolLarge m_layerName;
	bool m_bWorldLayerVisible;
	bool m_bEntitiesSpawned;
	bool m_bCreateAsChildSpawnGroup;
	uint32 m_hLayerSpawnGroup;
};
