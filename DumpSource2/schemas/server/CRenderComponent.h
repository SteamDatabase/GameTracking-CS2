class CRenderComponent : public CEntityComponent
{
	CNetworkVarChainer __m_pChainEntity;
	bool m_bIsRenderingWithViewModels;
	uint32 m_nSplitscreenFlags;
	bool m_bEnableRendering;
	bool m_bInterpolationReadyToDraw;
};
