class C_INIT_PositionWarp : public CParticleFunctionInitializer
{
	CParticleCollectionVecInput m_vecWarpMin;
	CParticleCollectionVecInput m_vecWarpMax;
	int32 m_nScaleControlPointNumber;
	int32 m_nControlPointNumber;
	int32 m_nRadiusComponent;
	float32 m_flWarpTime;
	float32 m_flWarpStartTime;
	float32 m_flPrevPosScale;
	bool m_bInvertWarp;
	bool m_bUseCount;
};
