class C_OP_SetControlPointToWaterSurface : public CParticleFunctionPreEmission
{
	int32 m_nSourceCP;
	int32 m_nDestCP;
	int32 m_nFlowCP;
	int32 m_nActiveCP;
	int32 m_nActiveCPField;
	CParticleCollectionFloatInput m_flRetestRate;
	bool m_bAdaptiveThreshold;
};
