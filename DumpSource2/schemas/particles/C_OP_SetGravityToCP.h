class C_OP_SetGravityToCP : public CParticleFunctionPreEmission
{
	int32 m_nCPInput;
	int32 m_nCPOutput;
	CParticleCollectionFloatInput m_flScale;
	bool m_bSetOrientation;
	bool m_bSetZDown;
};
