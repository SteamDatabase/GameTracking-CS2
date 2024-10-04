class C_OP_RemapNamedModelElementEndCap : public CParticleFunctionOperator
{
	CStrongHandle< InfoForResourceTypeCModel > m_hModel;
	CUtlVector< CUtlString > m_inNames;
	CUtlVector< CUtlString > m_outNames;
	CUtlVector< CUtlString > m_fallbackNames;
	bool m_bModelFromRenderer;
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
};
