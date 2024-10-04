class CBasePlayerController : public CBaseEntity
{
	uint64 m_nInButtonsWhichAreToggles;
	uint32 m_nTickBase;
	CHandle< CBasePlayerPawn > m_hPawn;
	bool m_bKnownTeamMismatch;
	CSplitScreenSlot m_nSplitScreenSlot;
	CHandle< CBasePlayerController > m_hSplitOwner;
	CUtlVector< CHandle< CBasePlayerController > > m_hSplitScreenPlayers;
	bool m_bIsHLTV;
	PlayerConnectedState m_iConnected;
	char[128] m_iszPlayerName;
	CUtlString m_szNetworkIDString;
	float32 m_fLerpTime;
	bool m_bLagCompensation;
	bool m_bPredict;
	bool m_bAutoKickDisabled;
	bool m_bIsLowViolence;
	bool m_bGamePaused;
	ChatIgnoreType_t m_iIgnoreGlobalChat;
	float32 m_flLastPlayerTalkTime;
	float32 m_flLastEntitySteadyState;
	int32 m_nAvailableEntitySteadyState;
	bool m_bHasAnySteadyStateEnts;
	uint64 m_steamID;
	uint32 m_iDesiredFOV;
}
