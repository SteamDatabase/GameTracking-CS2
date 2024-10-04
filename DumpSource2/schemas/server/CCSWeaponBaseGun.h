class CCSWeaponBaseGun : public CCSWeaponBase
{
	int32 m_zoomLevel;
	int32 m_iBurstShotsRemaining;
	int32 m_silencedModelIndex;
	bool m_inPrecache;
	bool m_bNeedsBoltAction;
	bool m_bSkillReloadAvailable;
	bool m_bSkillReloadLiftedReloadKey;
	bool m_bSkillBoltInterruptAvailable;
	bool m_bSkillBoltLiftedFireKey;
}
