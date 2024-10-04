class C_OP_EnableChildrenFromParentParticleCount : public CParticleFunctionPreEmission
{
	int32 m_nChildGroupID;
	int32 m_nFirstChild;
	CParticleCollectionFloatInput m_nNumChildrenToEnable;
	bool m_bDisableChildren;
	bool m_bPlayEndcapOnStop;
	bool m_bDestroyImmediately;
};
