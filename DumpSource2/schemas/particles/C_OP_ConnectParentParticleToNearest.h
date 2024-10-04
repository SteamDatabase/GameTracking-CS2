class C_OP_ConnectParentParticleToNearest : public CParticleFunctionOperator
{
	int32 m_nFirstControlPoint;
	int32 m_nSecondControlPoint;
	bool m_bUseRadius;
	CParticleCollectionFloatInput m_flRadiusScale;
	CParticleCollectionFloatInput m_flParentRadiusScale;
};
