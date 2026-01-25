// MNetworkVarNames = "HMaterialStrong m_hSpriteMaterial"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hAttachedToEntity"
// MNetworkVarNames = "AttachmentHandle_t m_nAttachment"
// MNetworkVarNames = "float32 m_flSpriteFramerate"
// MNetworkVarNames = "float32 m_flFrame"
// MNetworkVarNames = "uint32 m_nBrightness"
// MNetworkVarNames = "float32 m_flBrightnessDuration"
// MNetworkVarNames = "float32 m_flSpriteScale"
// MNetworkVarNames = "float32 m_flScaleDuration"
// MNetworkVarNames = "bool m_bWorldSpaceScale"
// MNetworkVarNames = "float32 m_flGlowProxySize"
// MNetworkVarNames = "float32 m_flHDRColorScale"
class C_Sprite : public C_BaseModelEntity
{
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hSpriteMaterial;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hAttachedToEntity;
	// MNetworkEnable
	AttachmentHandle_t m_nAttachment;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 60.000000
	// MNetworkEncodeFlags = 2
	float32 m_flSpriteFramerate;
	// MNetworkEnable
	// MNetworkBitCount = 20
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 256.000000
	// MNetworkEncodeFlags = 1
	float32 m_flFrame;
	GameTime_t m_flDieTime;
	// MNetworkEnable
	uint32 m_nBrightness;
	// MNetworkEnable
	float32 m_flBrightnessDuration;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnSpriteScaleChanged"
	float32 m_flSpriteScale;
	// MNetworkEnable
	float32 m_flScaleDuration;
	// MNetworkEnable
	bool m_bWorldSpaceScale;
	// MNetworkEnable
	// MNetworkBitCount = 6
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 64.000000
	// MNetworkEncodeFlags = 2
	float32 m_flGlowProxySize;
	// MNetworkEnable
	float32 m_flHDRColorScale;
	GameTime_t m_flLastTime;
	float32 m_flMaxFrame;
	float32 m_flStartScale;
	float32 m_flDestScale;
	GameTime_t m_flScaleTimeStart;
	int32 m_nStartBrightness;
	int32 m_nDestBrightness;
	GameTime_t m_flBrightnessTimeStart;
	// MNotSaved
	int32 m_nSpriteWidth;
	// MNotSaved
	int32 m_nSpriteHeight;
};
