// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "bool m_bUseHitboxesForRenderBox"
// MNetworkVarNames = "bool m_bUseAnimGraph"
class C_DynamicProp : public C_BreakableProp
{
	// MNetworkEnable
	bool m_bUseHitboxesForRenderBox;
	// MNetworkEnable
	bool m_bUseAnimGraph;
	CEntityIOOutput m_pOutputAnimBegun;
	CEntityIOOutput m_pOutputAnimOver;
	CEntityIOOutput m_pOutputAnimLoopCycleOver;
	CEntityIOOutput m_OnAnimReachedStart;
	CEntityIOOutput m_OnAnimReachedEnd;
	CUtlSymbolLarge m_iszIdleAnim;
	AnimLoopMode_t m_nIdleAnimLoopMode;
	bool m_bRandomizeCycle;
	bool m_bStartDisabled;
	bool m_bFiredStartEndOutput;
	bool m_bForceNpcExclude;
	bool m_bCreateNonSolid;
	bool m_bIsOverrideProp;
	int32 m_iInitialGlowState;
	int32 m_nGlowRange;
	int32 m_nGlowRangeMin;
	Color m_glowColor;
	int32 m_nGlowTeam;
	int32 m_iCachedFrameCount;
	Vector m_vecCachedRenderMins;
	Vector m_vecCachedRenderMaxs;
};
