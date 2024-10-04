class C_OP_StopAfterCPDuration : public CParticleFunctionPreEmission
{
	CParticleCollectionFloatInput m_flDuration;
	bool m_bDestroyImmediately;
	bool m_bPlayEndCap;
};
