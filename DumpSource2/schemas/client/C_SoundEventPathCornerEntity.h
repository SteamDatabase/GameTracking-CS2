// MNetworkVarNames = "SoundeventPathCornerPairNetworked_t m_vecCornerPairsNetworked"
class C_SoundEventPathCornerEntity : public C_SoundEventEntity
{
	// MNetworkEnable
	// MNotSaved
	C_NetworkUtlVectorBase< SoundeventPathCornerPairNetworked_t > m_vecCornerPairsNetworked;
};
