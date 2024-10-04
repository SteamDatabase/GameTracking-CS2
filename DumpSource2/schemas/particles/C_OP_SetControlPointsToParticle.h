class C_OP_SetControlPointsToParticle : public CParticleFunctionOperator
{
	int32 m_nChildGroupID;
	int32 m_nFirstControlPoint;
	int32 m_nNumControlPoints;
	int32 m_nFirstSourcePoint;
	bool m_bSetOrientation;
	ParticleOrientationSetMode_t m_nOrientationMode;
	ParticleParentSetMode_t m_nSetParent;
};
