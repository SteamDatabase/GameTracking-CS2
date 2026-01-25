class CPhysForce : public CPointEntity
{
	CUtlSymbolLarge m_nameAttach;
	float32 m_force;
	float32 m_forceTime;
	CHandle< CBaseEntity > m_attachedObject;
	// MNotSaved
	bool m_wasRestored;
	CConstantForceController m_integrator;
};
