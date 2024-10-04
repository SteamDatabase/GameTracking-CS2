class CPointTeleport : public CServerOnlyPointEntity
{
	Vector m_vSaveOrigin;
	QAngle m_vSaveAngles;
	bool m_bTeleportParentedEntities;
	bool m_bTeleportUseCurrentAngle;
}
