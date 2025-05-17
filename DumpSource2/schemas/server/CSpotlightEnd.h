// MNetworkVarNames = "float32 m_flLightScale"
// MNetworkVarNames = "float32 m_Radius"
class CSpotlightEnd : public CBaseModelEntity
{
	// MNetworkEnable
	float32 m_flLightScale;
	// MNetworkEnable
	float32 m_Radius;
	Vector m_vSpotlightDir;
	Vector m_vSpotlightOrg;
};
