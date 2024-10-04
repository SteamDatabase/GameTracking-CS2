class C_OP_RenderAsModels : public CParticleFunctionRenderer
{
	CUtlVector< ModelReference_t > m_ModelList;
	float32 m_flModelScale;
	bool m_bFitToModelSize;
	bool m_bNonUniformScaling;
	ParticleAttributeIndex_t m_nXAxisScalingAttribute;
	ParticleAttributeIndex_t m_nYAxisScalingAttribute;
	ParticleAttributeIndex_t m_nZAxisScalingAttribute;
	int32 m_nSizeCullBloat;
};
