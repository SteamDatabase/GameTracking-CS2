// MNetworkVarNames = "bool m_bDisabled"
// MNetworkVarNames = "string_t m_iszSoundAreaType"
// MNetworkVarNames = "Vector m_vPos"
class C_SoundAreaEntityBase : public C_BaseEntity
{
	// MNetworkEnable
	bool m_bDisabled;
	// MNotSaved
	bool m_bWasEnabled;
	// MNetworkEnable
	CUtlSymbolLarge m_iszSoundAreaType;
	// MNetworkEnable
	Vector m_vPos;
};
