class CItem : public CBaseAnimGraph
{
	CEntityIOOutput m_OnPlayerTouch;
	CEntityIOOutput m_OnPlayerPickup;
	bool m_bActivateWhenAtRest;
	CEntityIOOutput m_OnCacheInteraction;
	CEntityIOOutput m_OnGlovePulled;
	Vector m_vOriginalSpawnOrigin;
	QAngle m_vOriginalSpawnAngles;
	bool m_bPhysStartAsleep;
};
