class CSoundOpvarSetPointEntity : public CSoundOpvarSetPointBase
{
	CEntityIOOutput m_OnEnter;
	CEntityIOOutput m_OnExit;
	bool m_bAutoDisable;
	float32 m_flDistanceMin;
	float32 m_flDistanceMax;
	float32 m_flDistanceMapMin;
	float32 m_flDistanceMapMax;
	float32 m_flOcclusionRadius;
	float32 m_flOcclusionMin;
	float32 m_flOcclusionMax;
	float32 m_flValSetOnDisable;
	bool m_bSetValueOnDisable;
	// MNotSaved
	bool m_bReloading;
	int32 m_nSimulationMode;
	int32 m_nVisibilitySamples;
	Vector m_vDynamicProxyPoint;
	float32 m_flDynamicMaximumOcclusion;
	CEntityHandle m_hDynamicEntity;
	CUtlSymbolLarge m_iszDynamicEntityName;
	// MNotSaved
	float32 m_flPathingDistanceNormFactor;
	// MNotSaved
	Vector m_vPathingSourcePos;
	// MNotSaved
	Vector m_vPathingListenerPos;
	// MNotSaved
	Vector m_vPathingDirection;
	// MNotSaved
	int32 m_nPathingSourceIndex;
};
