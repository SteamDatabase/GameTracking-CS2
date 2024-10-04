class CPointPrefab : public CServerOnlyPointEntity
{
	CUtlSymbolLarge m_targetMapName;
	CUtlSymbolLarge m_forceWorldGroupID;
	CUtlSymbolLarge m_associatedRelayTargetName;
	bool m_fixupNames;
	bool m_bLoadDynamic;
	CHandle< CPointPrefab > m_associatedRelayEntity;
}
