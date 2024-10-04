class C_OP_SetPerChildControlPoint : public CParticleFunctionOperator
{
	int32 m_nChildGroupID;
	int32 m_nFirstControlPoint;
	int32 m_nNumControlPoints;
	CParticleCollectionFloatInput m_nParticleIncrement;
	CParticleCollectionFloatInput m_nFirstSourcePoint;
	bool m_bSetOrientation;
	ParticleAttributeIndex_t m_nOrientationField;
	bool m_bNumBasedOnParticleCount;
};
