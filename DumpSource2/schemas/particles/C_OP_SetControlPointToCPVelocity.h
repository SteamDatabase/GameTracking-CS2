class C_OP_SetControlPointToCPVelocity : public CParticleFunctionPreEmission
{
	int32 m_nCPInput;
	int32 m_nCPOutputVel;
	bool m_bNormalize;
	int32 m_nCPOutputMag;
	int32 m_nCPField;
	CParticleCollectionVecInput m_vecComparisonVelocity;
};
