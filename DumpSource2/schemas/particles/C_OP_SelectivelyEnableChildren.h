class C_OP_SelectivelyEnableChildren : public CParticleFunctionPreEmission
{
	CParticleCollectionFloatInput m_nChildGroupID;
	CParticleCollectionFloatInput m_nFirstChild;
	CParticleCollectionFloatInput m_nNumChildrenToEnable;
	bool m_bPlayEndcapOnStop;
	bool m_bDestroyImmediately;
};
