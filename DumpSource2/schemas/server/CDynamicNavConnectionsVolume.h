class CDynamicNavConnectionsVolume : public CTriggerMultiple
{
	CUtlSymbolLarge m_iszConnectionTarget;
	CUtlVector< DynamicVolumeDef_t > m_vecConnections;
	CGlobalSymbol m_sTransitionType;
	bool m_bConnectionsEnabled;
	float32 m_flTargetAreaSearchRadius;
	float32 m_flUpdateDistance;
	float32 m_flMaxConnectionDistance;
};
