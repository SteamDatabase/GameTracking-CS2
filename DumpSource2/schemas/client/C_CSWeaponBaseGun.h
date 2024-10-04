class C_CSWeaponBaseGun : public C_CSWeaponBase
{
	int32 m_zoomLevel;
	int32 m_iBurstShotsRemaining;
	int32 m_iSilencerBodygroup;
	int32 m_silencedModelIndex;
	bool m_inPrecache;
	bool m_bNeedsBoltAction;
};
