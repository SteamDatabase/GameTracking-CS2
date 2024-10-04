class C_OP_BoxConstraint : public CParticleFunctionConstraint
{
	CParticleCollectionVecInput m_vecMin;
	CParticleCollectionVecInput m_vecMax;
	int32 m_nCP;
	bool m_bLocalSpace;
	bool m_bAccountForRadius;
};
