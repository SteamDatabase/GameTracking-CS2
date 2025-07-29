// MNetworkVarNames = "int m_zoomLevel"
// MNetworkVarNames = "int m_iBurstShotsRemaining"
// MNetworkVarNames = "bool m_bNeedsBoltAction"
// MNetworkVarNames = "int32 m_nRevolverCylinderIdx"
class C_CSWeaponBaseGun : public C_CSWeaponBase
{
	// MNetworkEnable
	int32 m_zoomLevel;
	// MNetworkEnable
	int32 m_iBurstShotsRemaining;
	int32 m_iSilencerBodygroup;
	int32 m_silencedModelIndex;
	bool m_inPrecache;
	// MNetworkEnable
	bool m_bNeedsBoltAction;
	// MNetworkEnable
	int32 m_nRevolverCylinderIdx;
};
