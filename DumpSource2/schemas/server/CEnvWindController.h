// MNetworkVarNames = "CEnvWindShared m_EnvWindShared"
// MNetworkVarNames = "float m_fDirectionVariation"
// MNetworkVarNames = "float m_fSpeedVariation"
// MNetworkVarNames = "float m_fTurbulence"
// MNetworkVarNames = "float m_fVolumeHalfExtentXY"
// MNetworkVarNames = "float m_fVolumeHalfExtentZ"
// MNetworkVarNames = "int m_nVolumeResolutionXY"
// MNetworkVarNames = "int m_nVolumeResolutionZ"
// MNetworkVarNames = "int m_nClipmapLevels"
// MNetworkVarNames = "bool m_bIsMaster"
class CEnvWindController : public CBaseEntity
{
	// MNetworkEnable
	CEnvWindShared m_EnvWindShared;
	// MNetworkEnable
	float32 m_fDirectionVariation;
	// MNetworkEnable
	float32 m_fSpeedVariation;
	// MNetworkEnable
	float32 m_fTurbulence;
	// MNetworkEnable
	float32 m_fVolumeHalfExtentXY;
	// MNetworkEnable
	float32 m_fVolumeHalfExtentZ;
	// MNetworkEnable
	int32 m_nVolumeResolutionXY;
	// MNetworkEnable
	int32 m_nVolumeResolutionZ;
	// MNetworkEnable
	int32 m_nClipmapLevels;
	// MNetworkEnable
	bool m_bIsMaster;
	bool m_bFirstTime;
};
