class CPhysicsPropRespawnable : public CPhysicsProp
{
	VectorWS m_vOriginalSpawnOrigin;
	QAngle m_vOriginalSpawnAngles;
	Vector m_vOriginalMins;
	Vector m_vOriginalMaxs;
	float32 m_flRespawnDuration;
};
