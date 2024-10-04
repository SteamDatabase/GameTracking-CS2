class C_OP_MovementLoopInsideSphere : public CParticleFunctionOperator
{
	int32 m_nCP;
	CParticleCollectionFloatInput m_flDistance;
	CParticleCollectionVecInput m_vecScale;
	ParticleAttributeIndex_t m_nDistSqrAttr;
};
