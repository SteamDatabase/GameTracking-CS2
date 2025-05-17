// MNetworkVarNames = "SoundeventPathCornerPairNetworked_t m_vecCornerPairsNetworked"
class C_SoundEventPathCornerEntity : public C_SoundEventEntity
{
	// MNetworkEnable
	C_NetworkUtlVectorBase< SoundeventPathCornerPairNetworked_t > m_vecCornerPairsNetworked;
};
