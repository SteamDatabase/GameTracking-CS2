// MNetworkVarNames = "CHandle< CFogController> m_hCtrl"
class C_fogplayerparams_t
{
	// MNetworkEnable
	// MNetworkUserGroup = "PlayerFogController"
	CHandle< C_FogController > m_hCtrl;
	float32 m_flTransitionTime;
	Color m_OldColor;
	float32 m_flOldStart;
	float32 m_flOldEnd;
	float32 m_flOldMaxDensity;
	float32 m_flOldHDRColorScale;
	float32 m_flOldFarZ;
	Color m_NewColor;
	float32 m_flNewStart;
	float32 m_flNewEnd;
	float32 m_flNewMaxDensity;
	float32 m_flNewHDRColorScale;
	float32 m_flNewFarZ;
};
