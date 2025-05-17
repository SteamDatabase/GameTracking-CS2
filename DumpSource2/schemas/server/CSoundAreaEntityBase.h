// MNetworkVarNames = "bool m_bDisabled"
// MNetworkVarNames = "string_t m_iszSoundAreaType"
// MNetworkVarNames = "Vector m_vPos"
class CSoundAreaEntityBase : public CBaseEntity
{
	// MNetworkEnable
	bool m_bDisabled;
	// MNetworkEnable
	CUtlSymbolLarge m_iszSoundAreaType;
	// MNetworkEnable
	Vector m_vPos;
};
