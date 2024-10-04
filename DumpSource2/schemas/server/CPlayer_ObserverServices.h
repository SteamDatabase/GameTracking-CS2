class CPlayer_ObserverServices : public CPlayerPawnComponent
{
	uint8 m_iObserverMode;
	CHandle< CBaseEntity > m_hObserverTarget;
	ObserverMode_t m_iObserverLastMode;
	bool m_bForcedObserverMode;
}
