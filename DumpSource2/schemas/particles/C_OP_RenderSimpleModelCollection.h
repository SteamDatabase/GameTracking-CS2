class C_OP_RenderSimpleModelCollection : public CParticleFunctionRenderer
{
	bool m_bCenterOffset;
	CStrongHandle< InfoForResourceTypeCModel > m_hModel;
	CParticleModelInput m_modelInput;
	CParticleCollectionFloatInput m_fSizeCullScale;
	bool m_bDisableShadows;
	bool m_bDisableMotionBlur;
	bool m_bAcceptsDecals;
	ParticleAttributeIndex_t m_nAngularVelocityField;
};
