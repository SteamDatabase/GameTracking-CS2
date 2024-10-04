class C_OP_ConstrainDistanceToPath : public CParticleFunctionConstraint
{
	float32 m_fMinDistance;
	float32 m_flMaxDistance0;
	float32 m_flMaxDistanceMid;
	float32 m_flMaxDistance1;
	CPathParameters m_PathParameters;
	float32 m_flTravelTime;
	ParticleAttributeIndex_t m_nFieldScale;
	ParticleAttributeIndex_t m_nManualTField;
};
