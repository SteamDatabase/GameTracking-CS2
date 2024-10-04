class C_Inferno : public C_BaseModelEntity
{
	ParticleIndex_t m_nfxFireDamageEffect;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoPointsSnapshot;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoFillerPointsSnapshot;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoOutlinePointsSnapshot;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoClimbingOutlinePointsSnapshot;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoDecalsSnapshot;
	Vector[64] m_firePositions;
	Vector[64] m_fireParentPositions;
	bool[64] m_bFireIsBurning;
	Vector[64] m_BurnNormal;
	int32 m_fireCount;
	int32 m_nInfernoType;
	float32 m_nFireLifetime;
	bool m_bInPostEffectTime;
	int32 m_lastFireCount;
	int32 m_nFireEffectTickBegin;
	int32 m_drawableCount;
	bool m_blosCheck;
	int32 m_nlosperiod;
	float32 m_maxFireHalfWidth;
	float32 m_maxFireHeight;
	Vector m_minBounds;
	Vector m_maxBounds;
	float32 m_flLastGrassBurnThink;
}
