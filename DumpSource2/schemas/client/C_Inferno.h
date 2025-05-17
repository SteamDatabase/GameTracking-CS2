// MNetworkVarNames = "Vector m_firePositions"
// MNetworkVarNames = "Vector m_fireParentPositions"
// MNetworkVarNames = "bool m_bFireIsBurning"
// MNetworkVarNames = "Vector m_BurnNormal"
// MNetworkVarNames = "int m_fireCount"
// MNetworkVarNames = "int m_nInfernoType"
// MNetworkVarNames = "float m_nFireLifetime"
// MNetworkVarNames = "bool m_bInPostEffectTime"
// MNetworkVarNames = "int m_nFireEffectTickBegin"
class C_Inferno : public C_BaseModelEntity
{
	ParticleIndex_t m_nfxFireDamageEffect;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoPointsSnapshot;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoFillerPointsSnapshot;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoOutlinePointsSnapshot;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoClimbingOutlinePointsSnapshot;
	CStrongHandle< InfoForResourceTypeIParticleSnapshot > m_hInfernoDecalsSnapshot;
	// MNetworkEnable
	Vector[64] m_firePositions;
	// MNetworkEnable
	Vector[64] m_fireParentPositions;
	// MNetworkEnable
	bool[64] m_bFireIsBurning;
	// MNetworkEnable
	Vector[64] m_BurnNormal;
	// MNetworkEnable
	int32 m_fireCount;
	// MNetworkEnable
	int32 m_nInfernoType;
	// MNetworkEnable
	float32 m_nFireLifetime;
	// MNetworkEnable
	bool m_bInPostEffectTime;
	int32 m_lastFireCount;
	// MNetworkEnable
	int32 m_nFireEffectTickBegin;
	int32 m_drawableCount;
	bool m_blosCheck;
	int32 m_nlosperiod;
	float32 m_maxFireHalfWidth;
	float32 m_maxFireHeight;
	Vector m_minBounds;
	Vector m_maxBounds;
	float32 m_flLastGrassBurnThink;
};
