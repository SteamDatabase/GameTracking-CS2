// MNetworkVarNames = "int8 m_iCurrentMaxRagdollCount"
class CRagdollManager : public CBaseEntity
{
	// MNetworkEnable
	int8 m_iCurrentMaxRagdollCount;
	int32 m_iMaxRagdollCount;
	bool m_bSaveImportant;
	bool m_bCanTakeDamage;
};
