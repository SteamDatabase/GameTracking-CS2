// MNetworkVarNames = "CHandle< C_BaseEntity> m_hTargetEntity"
// MNetworkVarNames = "bool m_bState"
// MNetworkVarNames = "bool m_bAlwaysUpdate"
// MNetworkVarNames = "float32 m_flLightFOV"
// MNetworkVarNames = "bool m_bEnableShadows"
// MNetworkVarNames = "bool m_bSimpleProjection"
// MNetworkVarNames = "bool m_bLightOnlyTarget"
// MNetworkVarNames = "bool m_bLightWorld"
// MNetworkVarNames = "bool m_bCameraSpace"
// MNetworkVarNames = "float32 m_flBrightnessScale"
// MNetworkVarNames = "Color m_LightColor"
// MNetworkVarNames = "float32 m_flIntensity"
// MNetworkVarNames = "float32 m_flLinearAttenuation"
// MNetworkVarNames = "float32 m_flQuadraticAttenuation"
// MNetworkVarNames = "bool m_bVolumetric"
// MNetworkVarNames = "float32 m_flVolumetricIntensity"
// MNetworkVarNames = "float32 m_flNoiseStrength"
// MNetworkVarNames = "float32 m_flFlashlightTime"
// MNetworkVarNames = "uint32 m_nNumPlanes"
// MNetworkVarNames = "float32 m_flPlaneOffset"
// MNetworkVarNames = "float32 m_flColorTransitionTime"
// MNetworkVarNames = "float32 m_flAmbient"
// MNetworkVarNames = "char m_SpotlightTextureName"
// MNetworkVarNames = "int32 m_nSpotlightTextureFrame"
// MNetworkVarNames = "uint32 m_nShadowQuality"
// MNetworkVarNames = "float32 m_flNearZ"
// MNetworkVarNames = "float32 m_flFarZ"
// MNetworkVarNames = "float32 m_flProjectionSize"
// MNetworkVarNames = "float32 m_flRotation"
// MNetworkVarNames = "bool m_bFlipHorizontal"
class CProjectedTextureBase
{
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hTargetEntity;
	// MNetworkEnable
	bool m_bState;
	// MNetworkEnable
	bool m_bAlwaysUpdate;
	// MNetworkEnable
	float32 m_flLightFOV;
	// MNetworkEnable
	bool m_bEnableShadows;
	// MNetworkEnable
	bool m_bSimpleProjection;
	// MNetworkEnable
	bool m_bLightOnlyTarget;
	// MNetworkEnable
	bool m_bLightWorld;
	// MNetworkEnable
	bool m_bCameraSpace;
	// MNetworkEnable
	float32 m_flBrightnessScale;
	// MNetworkEnable
	Color m_LightColor;
	// MNetworkEnable
	float32 m_flIntensity;
	// MNetworkEnable
	float32 m_flLinearAttenuation;
	// MNetworkEnable
	float32 m_flQuadraticAttenuation;
	// MNetworkEnable
	bool m_bVolumetric;
	// MNetworkEnable
	float32 m_flVolumetricIntensity;
	// MNetworkEnable
	float32 m_flNoiseStrength;
	// MNetworkEnable
	float32 m_flFlashlightTime;
	// MNetworkEnable
	uint32 m_nNumPlanes;
	// MNetworkEnable
	float32 m_flPlaneOffset;
	// MNetworkEnable
	float32 m_flColorTransitionTime;
	// MNetworkEnable
	float32 m_flAmbient;
	// MNetworkEnable
	char[512] m_SpotlightTextureName;
	// MNetworkEnable
	int32 m_nSpotlightTextureFrame;
	// MNetworkEnable
	uint32 m_nShadowQuality;
	// MNetworkEnable
	// MNetworkBitCount = 16
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 500.000000
	// MNetworkEncodeFlags = 1
	float32 m_flNearZ;
	// MNetworkEnable
	// MNetworkBitCount = 18
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1500.000000
	// MNetworkEncodeFlags = 1
	float32 m_flFarZ;
	// MNetworkEnable
	float32 m_flProjectionSize;
	// MNetworkEnable
	float32 m_flRotation;
	// MNetworkEnable
	bool m_bFlipHorizontal;
};
