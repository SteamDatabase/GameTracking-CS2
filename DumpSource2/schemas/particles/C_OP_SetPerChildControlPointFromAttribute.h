class C_OP_SetPerChildControlPointFromAttribute : public CParticleFunctionOperator
{
	int32 m_nChildGroupID;
	int32 m_nFirstControlPoint;
	int32 m_nNumControlPoints;
	int32 m_nParticleIncrement;
	int32 m_nFirstSourcePoint;
	bool m_bNumBasedOnParticleCount;
	ParticleAttributeIndex_t m_nAttributeToRead;
	int32 m_nCPField;
};
