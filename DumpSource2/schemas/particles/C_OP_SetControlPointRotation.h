class C_OP_SetControlPointRotation : public CParticleFunctionPreEmission
{
	CParticleCollectionVecInput m_vecRotAxis;
	CParticleCollectionFloatInput m_flRotRate;
	int32 m_nCP;
	int32 m_nLocalCP;
};
