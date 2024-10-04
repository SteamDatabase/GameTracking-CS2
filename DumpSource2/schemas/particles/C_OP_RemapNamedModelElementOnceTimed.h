class C_OP_RemapNamedModelElementOnceTimed : public CParticleFunctionOperator
{
	CStrongHandle< InfoForResourceTypeCModel > m_hModel;
	CUtlVector< CUtlString > m_inNames;
	CUtlVector< CUtlString > m_outNames;
	CUtlVector< CUtlString > m_fallbackNames;
	bool m_bModelFromRenderer;
	bool m_bProportional;
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flRemapTime;
};
