class C_OP_RemapDensityToVector : public CParticleFunctionOperator
{
	float32 m_flRadiusScale;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flDensityMin;
	float32 m_flDensityMax;
	Vector m_vecOutputMin;
	Vector m_vecOutputMax;
	bool m_bUseParentDensity;
	int32 m_nVoxelGridResolution;
};
