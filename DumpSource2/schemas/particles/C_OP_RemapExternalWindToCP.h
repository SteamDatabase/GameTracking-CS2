class C_OP_RemapExternalWindToCP : public CParticleFunctionPreEmission
{
	int32 m_nCP;
	int32 m_nCPOutput;
	CParticleCollectionVecInput m_vecScale;
	bool m_bSetMagnitude;
	int32 m_nOutVectorField;
};
