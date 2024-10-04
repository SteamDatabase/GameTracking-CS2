class C_INIT_RandomNamedModelElement : public CParticleFunctionInitializer
{
	CStrongHandle< InfoForResourceTypeCModel > m_hModel;
	CUtlVector< CUtlString > m_names;
	bool m_bShuffle;
	bool m_bLinear;
	bool m_bModelFromRenderer;
	ParticleAttributeIndex_t m_nFieldOutput;
};
