// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "bool m_bUseHitboxesForRenderBox"
// MNetworkVarNames = "bool m_bUseAnimGraph"
class CDynamicProp : public CBreakableProp
{
	bool m_bCreateNavObstacle;
	bool m_bNavObstacleUpdatesOverridden;
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
};
