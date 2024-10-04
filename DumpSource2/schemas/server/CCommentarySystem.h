class CCommentarySystem
{
	bool m_bCommentaryConvarsChanging;
	bool m_bCommentaryEnabledMidGame;
	GameTime_t m_flNextTeleportTime;
	int32 m_iTeleportStage;
	bool m_bCheatState;
	bool m_bIsFirstSpawnGroupToLoad;
	CHandle< CPointCommentaryNode > m_hCurrentNode;
	CHandle< CPointCommentaryNode > m_hActiveCommentaryNode;
	CHandle< CPointCommentaryNode > m_hLastCommentaryNode;
	CUtlVector< CHandle< CPointCommentaryNode > > m_vecNodes;
}
