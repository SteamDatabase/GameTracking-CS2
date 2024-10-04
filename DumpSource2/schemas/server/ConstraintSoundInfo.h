class ConstraintSoundInfo
{
	VelocitySampler m_vSampler;
	SimpleConstraintSoundProfile m_soundProfile;
	Vector m_forwardAxis;
	CUtlSymbolLarge m_iszTravelSoundFwd;
	CUtlSymbolLarge m_iszTravelSoundBack;
	CUtlSymbolLarge[3] m_iszReversalSounds;
	bool m_bPlayTravelSound;
	bool m_bPlayReversalSound;
}
