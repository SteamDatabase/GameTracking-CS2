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
	// MNotSaved
	bool m_bForceNpcExclude;
	// MNotSaved
	bool m_bCreateNonSolid;
	// MNotSaved
	bool m_bIsOverrideProp;
	int32 m_iInitialGlowState;
	int32 m_nGlowRange;
	int32 m_nGlowRangeMin;
	Color m_glowColor;
	int32 m_nGlowTeam;
	// MNotSaved
	int32 m_iCachedFrameCount;
	// MNotSaved
	Vector m_vecCachedRenderMins;
	// MNotSaved
	Vector m_vecCachedRenderMaxs;
};
