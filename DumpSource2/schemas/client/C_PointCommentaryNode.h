// MNetworkVarNames = "bool m_bActive"
// MNetworkVarNames = "GameTime_t m_flStartTime"
// MNetworkVarNames = "float32 m_flStartTimeInCommentary"
// MNetworkVarNames = "string_t m_iszCommentaryFile"
// MNetworkVarNames = "string_t m_iszTitle"
// MNetworkVarNames = "string_t m_iszSpeakers"
// MNetworkVarNames = "int m_iNodeNumber"
// MNetworkVarNames = "int m_iNodeNumberMax"
// MNetworkVarNames = "bool m_bListenedTo"
// MNetworkVarNames = "CHandle< C_BaseEntity> m_hViewPosition"
class C_PointCommentaryNode : public CBaseAnimGraph
{
	// MNetworkEnable
	bool m_bActive;
	bool m_bWasActive;
	GameTime_t m_flEndTime;
	// MNetworkEnable
	GameTime_t m_flStartTime;
	// MNetworkEnable
	float32 m_flStartTimeInCommentary;
	// MNetworkEnable
	CUtlSymbolLarge m_iszCommentaryFile;
	// MNetworkEnable
	CUtlSymbolLarge m_iszTitle;
	// MNetworkEnable
	CUtlSymbolLarge m_iszSpeakers;
	// MNetworkEnable
	int32 m_iNodeNumber;
	// MNetworkEnable
	int32 m_iNodeNumberMax;
	// MNetworkEnable
	bool m_bListenedTo;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hViewPosition;
	bool m_bRestartAfterRestore;
};
