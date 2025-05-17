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
// MNetworkVarNames = "uint32 m_iDesiredFOV"
// MNetworkReplayCompatField = "m_skeletonInstance\.m_vecOrigin\..*|"
class CBasePlayerController : public C_BaseEntity
{
	int32 m_nFinalPredictedTick;
	C_CommandContext m_CommandContext;
	uint64 m_nInButtonsWhichAreToggles;
	// MNetworkEnable
	// MNetworkPriority = 1
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint32 m_nTickBase;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnPawnChanged"
	CHandle< C_BasePlayerPawn > m_hPawn;
	// MNetworkEnable
	bool m_bKnownTeamMismatch;
	CHandle< C_BasePlayerPawn > m_hPredictedPawn;
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
	// MNetworkEnable
	// MNetworkEncoder = "fixed64"
	// MNetworkChangeCallback = "OnSteamIDChanged"
	uint64 m_steamID;
	bool m_bIsLocalPlayerController;
	// MNetworkEnable
	uint32 m_iDesiredFOV;
};
