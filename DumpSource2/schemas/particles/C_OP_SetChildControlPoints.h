class C_OP_SetChildControlPoints : public CParticleFunctionOperator
{
	int32 m_nChildGroupID;
	int32 m_nFirstControlPoint;
	int32 m_nNumControlPoints;
	CParticleCollectionFloatInput m_nFirstSourcePoint;
	bool m_bReverse;
	bool m_bSetOrientation;
};
