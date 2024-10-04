class CSound
{
	CHandle< CBaseEntity > m_hOwner;
	CHandle< CBaseEntity > m_hTarget;
	int32 m_iVolume;
	float32 m_flOcclusionScale;
	AISound_t m_Sound;
	int32 m_iNextAudible;
	GameTime_t m_flExpireTime;
	int16 m_iNext;
	bool m_bNoExpirationTime;
	int32 m_ownerChannelIndex;
	Vector m_vecOrigin;
	bool m_bHasOwner;
};
