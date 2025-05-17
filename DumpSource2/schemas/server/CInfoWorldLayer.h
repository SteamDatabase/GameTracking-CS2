// MNetworkVarNames = "string_t m_worldName"
// MNetworkVarNames = "string_t m_layerName"
// MNetworkVarNames = "bool m_bWorldLayerVisible"
// MNetworkVarNames = "bool m_bEntitiesSpawned"
class CInfoWorldLayer : public CBaseEntity
{
	CEntityIOOutput m_pOutputOnEntitiesSpawned;
	// MNetworkEnable
	CUtlSymbolLarge m_worldName;
	// MNetworkEnable
	CUtlSymbolLarge m_layerName;
	// MNetworkEnable
	bool m_bWorldLayerVisible;
	// MNetworkEnable
	bool m_bEntitiesSpawned;
	bool m_bCreateAsChildSpawnGroup;
	uint32 m_hLayerSpawnGroup;
};
