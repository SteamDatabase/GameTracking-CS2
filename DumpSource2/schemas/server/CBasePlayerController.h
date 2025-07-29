// MNetworkIncludeByName = "m_pEntity"
// MNetworkIncludeByName = "m_flSimulationTime"
// MNetworkIncludeByName = "m_flCreateTime"
// MNetworkIncludeByName = "m_iTeamNum"
// MNetworkIncludeByName = "m_nNextThinkTick"
// MNetworkIncludeByName = "m_fFlags"
// MNetworkUserGroupProxy = "CBasePlayerController"
// MNetworkUserGroupProxy = "CBasePlayerController"
// MNetworkIncludeByUserGroup = "LocalPlayerExclusive"
// MNetworkVarNames = "uint32 m_nTickBase"
// MNetworkVarNames = "CHandle< CBasePlayerPawn> m_hPawn"
// MNetworkVarNames = "bool m_bKnownTeamMismatch"
// MNetworkVarNames = "PlayerConnectedState m_iConnected"
// MNetworkVarNames = "char m_iszPlayerName"
// MNetworkVarNames = "uint64 m_steamID"
// MNetworkVarNames = "bool m_bNoClipEnabled"
// MNetworkVarNames = "uint32 m_iDesiredFOV"
class CBasePlayerController : public CBaseEntity
{
	uint64 m_nInButtonsWhichAreToggles;
	// MNetworkEnable
	// MNetworkPriority = 1
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint32 m_nTickBase;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnPawnChanged"
	CHandle< CBasePlayerPawn > m_hPawn;
	// MNetworkEnable
	bool m_bKnownTeamMismatch;
	CSplitScreenSlot m_nSplitScreenSlot;
	CHandle< CBasePlayerController > m_hSplitOwner;
	CUtlVector< CHandle< CBasePlayerController > > m_hSplitScreenPlayers;
	bool m_bIsHLTV;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnConnectionStateChanged"
	PlayerConnectedState m_iConnected;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnPlayerControllerNameChanged"
	char[128] m_iszPlayerName;
	CUtlString m_szNetworkIDString;
	float32 m_fLerpTime;
	bool m_bLagCompensation;
	bool m_bPredict;
	bool m_bIsLowViolence;
	bool m_bGamePaused;
	ChatIgnoreType_t m_iIgnoreGlobalChat;
	float32 m_flLastPlayerTalkTime;
	float32 m_flLastEntitySteadyState;
	int32 m_nAvailableEntitySteadyState;
	bool m_bHasAnySteadyStateEnts;
	// MNetworkEnable
	// MNetworkEncoder = "fixed64"
	// MNetworkChangeCallback = "OnSteamIDChanged"
	uint64 m_steamID;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNoClipEnableChanged"
	bool m_bNoClipEnabled;
	// MNetworkEnable
	uint32 m_iDesiredFOV;
};
