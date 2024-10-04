class C_INIT_RemapParticleCountToNamedModelElementScalar : public C_INIT_RemapParticleCountToScalar
{
	CStrongHandle< InfoForResourceTypeCModel > m_hModel;
	CUtlString m_outputMinName;
	CUtlString m_outputMaxName;
	bool m_bModelFromRenderer;
};
