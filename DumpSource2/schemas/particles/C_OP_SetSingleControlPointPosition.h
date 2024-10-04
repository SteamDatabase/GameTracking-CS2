class C_OP_SetSingleControlPointPosition : public CParticleFunctionPreEmission
{
	bool m_bSetOnce;
	int32 m_nCP1;
	CParticleCollectionVecInput m_vecCP1Pos;
	CParticleTransformInput m_transformInput;
};
