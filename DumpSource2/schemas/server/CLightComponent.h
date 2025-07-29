// MNetworkVarNames = "Color m_Color"
// MNetworkVarNames = "Color m_SecondaryColor"
// MNetworkVarNames = "float m_flBrightness"
// MNetworkVarNames = "float m_flBrightnessScale"
// MNetworkVarNames = "float m_flBrightnessMult"
// MNetworkVarNames = "float m_flRange"
// MNetworkVarNames = "float m_flFalloff"
// MNetworkVarNames = "float m_flAttenuation0"
// MNetworkVarNames = "float m_flAttenuation1"
// MNetworkVarNames = "float m_flAttenuation2"
// MNetworkVarNames = "float m_flTheta"
// MNetworkVarNames = "float m_flPhi"
// MNetworkVarNames = "HRenderTextureStrong m_hLightCookie"
// MNetworkVarNames = "int m_nCascades"
// MNetworkVarNames = "int m_nCastShadows"
// MNetworkVarNames = "int m_nShadowWidth"
// MNetworkVarNames = "int m_nShadowHeight"
// MNetworkVarNames = "bool m_bRenderDiffuse"
// MNetworkVarNames = "int m_nRenderSpecular"
// MNetworkVarNames = "bool m_bRenderTransmissive"
// MNetworkVarNames = "float m_flOrthoLightWidth"
// MNetworkVarNames = "float m_flOrthoLightHeight"
// MNetworkVarNames = "int m_nStyle"
// MNetworkVarNames = "CUtlString m_Pattern"
// MNetworkVarNames = "int m_nCascadeRenderStaticObjects"
// MNetworkVarNames = "float m_flShadowCascadeCrossFade"
// MNetworkVarNames = "float m_flShadowCascadeDistanceFade"
// MNetworkVarNames = "float m_flShadowCascadeDistance0"
// MNetworkVarNames = "float m_flShadowCascadeDistance1"
// MNetworkVarNames = "float m_flShadowCascadeDistance2"
// MNetworkVarNames = "float m_flShadowCascadeDistance3"
// MNetworkVarNames = "int m_nShadowCascadeResolution0"
// MNetworkVarNames = "int m_nShadowCascadeResolution1"
// MNetworkVarNames = "int m_nShadowCascadeResolution2"
// MNetworkVarNames = "int m_nShadowCascadeResolution3"
// MNetworkVarNames = "bool m_bUsesBakedShadowing"
// MNetworkVarNames = "int m_nShadowPriority"
// MNetworkVarNames = "int m_nBakedShadowIndex"
// MNetworkVarNames = "int32 m_nLightPathUniqueId"
// MNetworkVarNames = "int32 m_nLightMapUniqueId"
// MNetworkVarNames = "bool m_bRenderToCubemaps"
// MNetworkVarNames = "bool m_bAllowSSTGeneration"
// MNetworkVarNames = "int m_nDirectLight"
// MNetworkVarNames = "int m_nIndirectLight"
// MNetworkVarNames = "float m_flFadeMinDist"
// MNetworkVarNames = "float m_flFadeMaxDist"
// MNetworkVarNames = "float m_flShadowFadeMinDist"
// MNetworkVarNames = "float m_flShadowFadeMaxDist"
// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "bool m_bFlicker"
// MNetworkVarNames = "bool m_bPrecomputedFieldsValid"
// MNetworkVarNames = "Vector m_vPrecomputedBoundsMins"
// MNetworkVarNames = "Vector m_vPrecomputedBoundsMaxs"
// MNetworkVarNames = "Vector m_vPrecomputedOBBOrigin"
// MNetworkVarNames = "QAngle m_vPrecomputedOBBAngles"
// MNetworkVarNames = "Vector m_vPrecomputedOBBExtent"
// MNetworkVarNames = "float m_flPrecomputedMaxRange"
// MNetworkVarNames = "int m_nFogLightingMode"
// MNetworkVarNames = "float m_flFogContributionStength"
// MNetworkVarNames = "float m_flNearClipPlane"
// MNetworkVarNames = "Color m_SkyColor"
// MNetworkVarNames = "float m_flSkyIntensity"
// MNetworkVarNames = "Color m_SkyAmbientBounce"
// MNetworkVarNames = "bool m_bUseSecondaryColor"
// MNetworkVarNames = "bool m_bMixedShadows"
// MNetworkVarNames = "GameTime_t m_flLightStyleStartTime"
// MNetworkVarNames = "float m_flCapsuleLength"
// MNetworkVarNames = "float m_flMinRoughness"
class CLightComponent : public CEntityComponent
{
	CNetworkVarChainer __m_pChainEntity;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	Color m_Color;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	Color m_SecondaryColor;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flBrightness;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flBrightnessScale;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flBrightnessMult;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flRange;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flFalloff;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flAttenuation0;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flAttenuation1;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flAttenuation2;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flTheta;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flPhi;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hLightCookie;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nCascades;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nCastShadows;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nShadowWidth;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nShadowHeight;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	bool m_bRenderDiffuse;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nRenderSpecular;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	bool m_bRenderTransmissive;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flOrthoLightWidth;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flOrthoLightHeight;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nStyle;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	CUtlString m_Pattern;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nCascadeRenderStaticObjects;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flShadowCascadeCrossFade;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flShadowCascadeDistanceFade;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flShadowCascadeDistance0;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flShadowCascadeDistance1;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flShadowCascadeDistance2;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flShadowCascadeDistance3;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nShadowCascadeResolution0;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nShadowCascadeResolution1;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nShadowCascadeResolution2;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nShadowCascadeResolution3;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	// MNetworkAlias = "m_bUsesIndexedBakedLighting"
	bool m_bUsesBakedShadowing;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nShadowPriority;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nBakedShadowIndex;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nLightPathUniqueId;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	int32 m_nLightMapUniqueId;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	bool m_bRenderToCubemaps;
	// MNetworkEnable
	bool m_bAllowSSTGeneration;
	// MNetworkEnable
	int32 m_nDirectLight;
	// MNetworkEnable
	int32 m_nIndirectLight;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flFadeMinDist;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flFadeMaxDist;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flShadowFadeMinDist;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flShadowFadeMaxDist;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	bool m_bEnabled;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	bool m_bFlicker;
	// MNetworkEnable
	bool m_bPrecomputedFieldsValid;
	// MNetworkEnable
	Vector m_vPrecomputedBoundsMins;
	// MNetworkEnable
	Vector m_vPrecomputedBoundsMaxs;
	// MNetworkEnable
	Vector m_vPrecomputedOBBOrigin;
	// MNetworkEnable
	QAngle m_vPrecomputedOBBAngles;
	// MNetworkEnable
	Vector m_vPrecomputedOBBExtent;
	// MNetworkEnable
	float32 m_flPrecomputedMaxRange;
	// MNetworkEnable
	int32 m_nFogLightingMode;
	// MNetworkEnable
	float32 m_flFogContributionStength;
	// MNetworkEnable
	float32 m_flNearClipPlane;
	// MNetworkEnable
	Color m_SkyColor;
	// MNetworkEnable
	float32 m_flSkyIntensity;
	// MNetworkEnable
	Color m_SkyAmbientBounce;
	// MNetworkEnable
	bool m_bUseSecondaryColor;
	// MNetworkEnable
	// MNetworkChangeCallback = "MixedShadowsChanged"
	bool m_bMixedShadows;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	GameTime_t m_flLightStyleStartTime;
	// MNetworkEnable
	float32 m_flCapsuleLength;
	// MNetworkEnable
	// MNetworkChangeCallback = "LightRenderingChanged"
	float32 m_flMinRoughness;
	bool m_bPvsModifyEntity;
};
