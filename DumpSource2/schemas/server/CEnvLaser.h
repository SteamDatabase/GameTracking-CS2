class CEnvLaser : public CBeam
{
	CUtlSymbolLarge m_iszLaserTarget;
	// MClassPtr
	CSprite* m_pSprite;
	CUtlSymbolLarge m_iszSpriteName;
	Vector m_firePosition;
	float32 m_flStartFrame;
};
