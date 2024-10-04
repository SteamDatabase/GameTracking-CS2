class CTriggerSoundscape : public CBaseTrigger
{
	CHandle< CEnvSoundscapeTriggerable > m_hSoundscape;
	CUtlSymbolLarge m_SoundscapeName;
	CUtlVector< CHandle< CBasePlayerPawn > > m_spectators;
}
