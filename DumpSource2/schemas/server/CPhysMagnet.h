class CPhysMagnet : public CBaseAnimGraph
{
	CEntityIOOutput m_OnMagnetAttach;
	CEntityIOOutput m_OnMagnetDetach;
	float32 m_massScale;
	float32 m_forceLimit;
	float32 m_torqueLimit;
	CUtlVector< magnetted_objects_t > m_MagnettedEntities;
	bool m_bActive;
	bool m_bHasHitSomething;
	float32 m_flTotalMass;
	float32 m_flRadius;
	GameTime_t m_flNextSuckTime;
	int32 m_iMaxObjectsAttached;
};
