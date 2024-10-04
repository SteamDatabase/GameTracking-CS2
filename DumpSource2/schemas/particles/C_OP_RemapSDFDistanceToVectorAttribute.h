class C_OP_RemapSDFDistanceToVectorAttribute : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nVectorFieldOutput;
	ParticleAttributeIndex_t m_nVectorFieldInput;
	CParticleCollectionFloatInput m_flMinDistance;
	CParticleCollectionFloatInput m_flMaxDistance;
	Vector m_vValueBelowMin;
	Vector m_vValueAtMin;
	Vector m_vValueAtMax;
	Vector m_vValueAboveMax;
};
