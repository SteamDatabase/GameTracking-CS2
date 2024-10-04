class CBasePlayerController : public C_BaseEntity
{
	int32 m_nFinalPredictedTick;
	C_CommandContext m_CommandContext;
	uint64 m_nInButtonsWhichAreToggles;
	uint32 m_nTickBase;
	CHandle< C_BasePlayerPawn > m_hPawn;
	bool m_bKnownTeamMismatch;
	CHandle< C_BasePlayerPawn > m_hPredictedPawn;
	CSplitScreenSlot m_nSplitScreenSlot;
	CHandle< CBasePlayerController > m_hSplitOwner;
	CUtlVector< CHandle< CBasePlayerController > > m_hSplitScreenPlayers;
	bool m_bIsHLTV;
	PlayerConnectedState m_iConnected;
	char[128] m_iszPlayerName;
	uint64 m_steamID;
	bool m_bIsLocalPlayerController;
	uint32 m_iDesiredFOV;
}
