class CFlashlightEffect
{
	bool m_bIsOn;
	bool m_bMuzzleFlashEnabled;
	float32 m_flMuzzleFlashBrightness;
	Quaternion m_quatMuzzleFlashOrientation;
	Vector m_vecMuzzleFlashOrigin;
	float32 m_flFov;
	float32 m_flFarZ;
	float32 m_flLinearAtten;
	bool m_bCastsShadows;
	float32 m_flCurrentPullBackDist;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_FlashlightTexture;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_MuzzleFlashTexture;
	char[64] m_textureName;
}
