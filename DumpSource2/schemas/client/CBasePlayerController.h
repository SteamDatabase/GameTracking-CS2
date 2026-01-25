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
// MNetworkReplayCompatField = "m_skeletonInstance\.m_vecOrigin\..*|"
class CBasePlayerController : public C_BaseEntity
{
	// MNotSaved
	C_CommandContext m_CommandContext;
	// MNotSaved
	uint64 m_nInButtonsWhichAreToggles;
	// MNetworkEnable
	// MNetworkPriority = 1
	// MNetworkUserGroup = "LocalPlayerExclusive"
	// MNotSaved
	uint32 m_nTickBase;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnPawnChanged"
	CHandle< C_BasePlayerPawn > m_hPawn;
	// MNetworkEnable
	bool m_bKnownTeamMismatch;
	// MNotSaved
	CHandle< C_BasePlayerPawn > m_hPredictedPawn;
	// MNotSaved
	CSplitScreenSlot m_nSplitScreenSlot;
	// MNotSaved
	CHandle< CBasePlayerController > m_hSplitOwner;
	// MNotSaved
	CUtlVector< CHandle< CBasePlayerController > > m_hSplitScreenPlayers;
	bool m_bIsHLTV;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnConnectionStateChanged"
	// MNotSaved
	PlayerConnectedState m_iConnected;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnPlayerControllerNameChanged"
	// MNotSaved
	char[128] m_iszPlayerName;
	// MNetworkEnable
	// MNetworkEncoder = "fixed64"
	// MNetworkChangeCallback = "OnSteamIDChanged"
	// MNotSaved
	uint64 m_steamID;
	// MNotSaved
	bool m_bIsLocalPlayerController;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnNoClipEnableChanged"
	bool m_bNoClipEnabled;
	// MNetworkEnable
	uint32 m_iDesiredFOV;
};
