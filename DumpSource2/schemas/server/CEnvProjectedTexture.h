class CEnvProjectedTexture : public CModelPointEntity
{
	CHandle< CBaseEntity > m_hTargetEntity;
	bool m_bState;
	bool m_bAlwaysUpdate;
	float32 m_flLightFOV;
	bool m_bEnableShadows;
	bool m_bSimpleProjection;
	bool m_bLightOnlyTarget;
	bool m_bLightWorld;
	bool m_bCameraSpace;
	float32 m_flBrightnessScale;
	Color m_LightColor;
	float32 m_flIntensity;
	float32 m_flLinearAttenuation;
	float32 m_flQuadraticAttenuation;
	bool m_bVolumetric;
	float32 m_flNoiseStrength;
	float32 m_flFlashlightTime;
	uint32 m_nNumPlanes;
	float32 m_flPlaneOffset;
	float32 m_flVolumetricIntensity;
	float32 m_flColorTransitionTime;
	float32 m_flAmbient;
	char[512] m_SpotlightTextureName;
	int32 m_nSpotlightTextureFrame;
	uint32 m_nShadowQuality;
	float32 m_flNearZ;
	float32 m_flFarZ;
	float32 m_flProjectionSize;
	float32 m_flRotation;
	bool m_bFlipHorizontal;
}
