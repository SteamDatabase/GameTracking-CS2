// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "int m_nColorMode"
// MNetworkVarNames = "Color m_Color"
// MNetworkVarNames = "float m_flColorTemperature"
// MNetworkVarNames = "float m_flBrightness"
// MNetworkVarNames = "float m_flBrightnessScale"
// MNetworkVarNames = "int m_nDirectLight"
// MNetworkVarNames = "int m_nBakedShadowIndex"
// MNetworkVarNames = "int32 m_nLightPathUniqueId"
// MNetworkVarNames = "int32 m_nLightMapUniqueId"
// MNetworkVarNames = "int m_nLuminaireShape"
// MNetworkVarNames = "float m_flLuminaireSize"
// MNetworkVarNames = "float m_flLuminaireAnisotropy"
// MNetworkVarNames = "CUtlString m_LightStyleString"
// MNetworkVarNames = "GameTime_t m_flLightStyleStartTime"
// MNetworkVarNames = "CUtlString m_QueuedLightStyleStrings"
// MNetworkVarNames = "CUtlString m_LightStyleEvents"
// MNetworkVarNames = "CHandle< C_BaseModelEntity > m_LightStyleTargets"
// MNetworkVarNames = "HRenderTextureStrong m_hLightCookie"
// MNetworkVarNames = "float m_flShape"
// MNetworkVarNames = "float m_flSoftX"
// MNetworkVarNames = "float m_flSoftY"
// MNetworkVarNames = "float m_flSkirt"
// MNetworkVarNames = "float m_flSkirtNear"
// MNetworkVarNames = "Vector m_vSizeParams"
// MNetworkVarNames = "float m_flRange"
// MNetworkVarNames = "Vector m_vShear"
// MNetworkVarNames = "int m_nBakeSpecularToCubemaps"
// MNetworkVarNames = "Vector m_vBakeSpecularToCubemapsSize"
// MNetworkVarNames = "int m_nCastShadows"
// MNetworkVarNames = "int m_nShadowMapSize"
// MNetworkVarNames = "int m_nShadowPriority"
// MNetworkVarNames = "bool m_bContactShadow"
// MNetworkVarNames = "bool m_bForceShadowsEnabled"
// MNetworkVarNames = "int m_nBounceLight"
// MNetworkVarNames = "float m_flBounceScale"
// MNetworkVarNames = "bool m_bDynamicBounce"
// MNetworkVarNames = "float m_flMinRoughness"
// MNetworkVarNames = "Vector m_vAlternateColor"
// MNetworkVarNames = "float m_fAlternateColorBrightness"
// MNetworkVarNames = "int m_nFog"
// MNetworkVarNames = "float m_flFogStrength"
// MNetworkVarNames = "int m_nFogShadows"
// MNetworkVarNames = "float m_flFogScale"
// MNetworkVarNames = "bool m_bFogMixedShadows"
// MNetworkVarNames = "float m_flFadeSizeStart"
// MNetworkVarNames = "float m_flFadeSizeEnd"
// MNetworkVarNames = "float m_flShadowFadeSizeStart"
// MNetworkVarNames = "float m_flShadowFadeSizeEnd"
// MNetworkVarNames = "bool m_bPrecomputedFieldsValid"
// MNetworkVarNames = "Vector m_vPrecomputedBoundsMins"
// MNetworkVarNames = "Vector m_vPrecomputedBoundsMaxs"
// MNetworkVarNames = "Vector m_vPrecomputedOBBOrigin"
// MNetworkVarNames = "QAngle m_vPrecomputedOBBAngles"
// MNetworkVarNames = "Vector m_vPrecomputedOBBExtent"
// MNetworkVarNames = "int m_nPrecomputedSubFrusta"
// MNetworkVarNames = "Vector m_vPrecomputedOBBOrigin0"
// MNetworkVarNames = "QAngle m_vPrecomputedOBBAngles0"
// MNetworkVarNames = "Vector m_vPrecomputedOBBExtent0"
// MNetworkVarNames = "Vector m_vPrecomputedOBBOrigin1"
// MNetworkVarNames = "QAngle m_vPrecomputedOBBAngles1"
// MNetworkVarNames = "Vector m_vPrecomputedOBBExtent1"
// MNetworkVarNames = "Vector m_vPrecomputedOBBOrigin2"
// MNetworkVarNames = "QAngle m_vPrecomputedOBBAngles2"
// MNetworkVarNames = "Vector m_vPrecomputedOBBExtent2"
// MNetworkVarNames = "Vector m_vPrecomputedOBBOrigin3"
// MNetworkVarNames = "QAngle m_vPrecomputedOBBAngles3"
// MNetworkVarNames = "Vector m_vPrecomputedOBBExtent3"
// MNetworkVarNames = "Vector m_vPrecomputedOBBOrigin4"
// MNetworkVarNames = "QAngle m_vPrecomputedOBBAngles4"
// MNetworkVarNames = "Vector m_vPrecomputedOBBExtent4"
// MNetworkVarNames = "Vector m_vPrecomputedOBBOrigin5"
// MNetworkVarNames = "QAngle m_vPrecomputedOBBAngles5"
// MNetworkVarNames = "Vector m_vPrecomputedOBBExtent5"
// MNetworkVarNames = "uint16 m_VisClusters"
class C_BarnLight : public C_BaseModelEntity
{
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	bool m_bEnabled;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nColorMode;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Color m_Color;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flColorTemperature;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flBrightness;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flBrightnessScale;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nDirectLight;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nBakedShadowIndex;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nLightPathUniqueId;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nLightMapUniqueId;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nLuminaireShape;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flLuminaireSize;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flLuminaireAnisotropy;
	// MNetworkEnable
	// MNetworkChangeCallback = "StyleChanged"
	CUtlString m_LightStyleString;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	GameTime_t m_flLightStyleStartTime;
	// MNetworkEnable
	C_NetworkUtlVectorBase< CUtlString > m_QueuedLightStyleStrings;
	// MNetworkEnable
	C_NetworkUtlVectorBase< CUtlString > m_LightStyleEvents;
	// MNetworkEnable
	C_NetworkUtlVectorBase< CHandle< C_BaseModelEntity > > m_LightStyleTargets;
	CEntityIOOutput[4] m_StyleEvent;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hLightCookie;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flShape;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flSoftX;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flSoftY;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flSkirt;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flSkirtNear;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	// MNetworkBitCount = 32
	Vector m_vSizeParams;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	// MNetworkBitCount = 32
	float32 m_flRange;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	// MNetworkBitCount = 32
	Vector m_vShear;
	// MNetworkEnable
	int32 m_nBakeSpecularToCubemaps;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	// MNetworkBitCount = 32
	Vector m_vBakeSpecularToCubemapsSize;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nCastShadows;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nShadowMapSize;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nShadowPriority;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	bool m_bContactShadow;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	bool m_bForceShadowsEnabled;
	// MNetworkEnable
	int32 m_nBounceLight;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flBounceScale;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	bool m_bDynamicBounce;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flMinRoughness;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vAlternateColor;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_fAlternateColorBrightness;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nFog;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flFogStrength;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nFogShadows;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flFogScale;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	bool m_bFogMixedShadows;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flFadeSizeStart;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flFadeSizeEnd;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flShadowFadeSizeStart;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flShadowFadeSizeEnd;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	bool m_bPrecomputedFieldsValid;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedBoundsMins;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedBoundsMaxs;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBOrigin;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	QAngle m_vPrecomputedOBBAngles;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBExtent;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	int32 m_nPrecomputedSubFrusta;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBOrigin0;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	QAngle m_vPrecomputedOBBAngles0;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBExtent0;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBOrigin1;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	QAngle m_vPrecomputedOBBAngles1;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBExtent1;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBOrigin2;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	QAngle m_vPrecomputedOBBAngles2;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBExtent2;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBOrigin3;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	QAngle m_vPrecomputedOBBAngles3;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBExtent3;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBOrigin4;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	QAngle m_vPrecomputedOBBAngles4;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBExtent4;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBOrigin5;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	QAngle m_vPrecomputedOBBAngles5;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	Vector m_vPrecomputedOBBExtent5;
	// MNotSaved
	bool m_bInitialBoneSetup;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	C_NetworkUtlVectorBase< uint16 > m_VisClusters;
};
