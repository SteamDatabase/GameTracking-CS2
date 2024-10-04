class CSprite : public CBaseModelEntity
{
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hSpriteMaterial;
	CHandle< CBaseEntity > m_hAttachedToEntity;
	AttachmentHandle_t m_nAttachment;
	float32 m_flSpriteFramerate;
	float32 m_flFrame;
	GameTime_t m_flDieTime;
	uint32 m_nBrightness;
	float32 m_flBrightnessDuration;
	float32 m_flSpriteScale;
	float32 m_flScaleDuration;
	bool m_bWorldSpaceScale;
	float32 m_flGlowProxySize;
	float32 m_flHDRColorScale;
	GameTime_t m_flLastTime;
	float32 m_flMaxFrame;
	float32 m_flStartScale;
	float32 m_flDestScale;
	GameTime_t m_flScaleTimeStart;
	int32 m_nStartBrightness;
	int32 m_nDestBrightness;
	GameTime_t m_flBrightnessTimeStart;
	int32 m_nSpriteWidth;
	int32 m_nSpriteHeight;
}
