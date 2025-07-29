// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CGameScriptedMoveData
{
	Vector m_vAccumulatedRootMotion;
	QAngle m_angAccumulatedRootMotionRotation;
	Vector m_vSrc;
	QAngle m_angSrc;
	QAngle m_angCurrent;
	float32 m_flLockedSpeed;
	float32 m_flAngRate;
	float32 m_flDuration;
	GameTime_t m_flStartTime;
	bool m_bActive;
	bool m_bTeleportOnEnd;
	bool m_bIgnoreRotation;
	bool m_bSuccess;
	ForcedCrouchState_t m_nForcedCrouchState;
	bool m_bIgnoreCollisions;
	Vector m_vDest;
	QAngle m_angDst;
	CHandle< CBaseEntity > m_hDestEntity;
};
