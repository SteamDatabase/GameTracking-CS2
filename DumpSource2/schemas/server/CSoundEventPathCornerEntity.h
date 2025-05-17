// MNetworkVarNames = "SoundeventPathCornerPairNetworked_t m_vecCornerPairsNetworked"
class CSoundEventPathCornerEntity : public CSoundEventEntity
{
	CUtlSymbolLarge m_iszPathCorner;
	int32 m_iCountMax;
	float32 m_flDistanceMax;
	float32 m_flDistMaxSqr;
	float32 m_flDotProductMax;
	bool m_bPlaying;
	// MNetworkEnable
	CNetworkUtlVectorBase< SoundeventPathCornerPairNetworked_t > m_vecCornerPairsNetworked;
};
