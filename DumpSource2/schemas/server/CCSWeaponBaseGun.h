// MNetworkVarNames = "int m_zoomLevel"
// MNetworkVarNames = "int m_iBurstShotsRemaining"
// MNetworkVarNames = "bool m_bNeedsBoltAction"
class CCSWeaponBaseGun : public CCSWeaponBase
{
	// MNetworkEnable
	int32 m_zoomLevel;
	// MNetworkEnable
	int32 m_iBurstShotsRemaining;
	int32 m_silencedModelIndex;
	bool m_inPrecache;
	// MNetworkEnable
	bool m_bNeedsBoltAction;
	bool m_bSkillReloadAvailable;
	bool m_bSkillReloadLiftedReloadKey;
	bool m_bSkillBoltInterruptAvailable;
	bool m_bSkillBoltLiftedFireKey;
};
