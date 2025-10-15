// MGetKV3ClassDefaults = {
//	"m_vAccumulatedRootMotion":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_angAccumulatedRootMotionRotation":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vSrc": null,
//	"m_angSrc":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_angCurrent":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flLockedSpeed": -1.000000,
//	"m_flAngRate": 0.000000,
//	"m_flDuration": 0.000000,
//	"m_flStartTime": null,
//	"m_bActive": false,
//	"m_bTeleportOnEnd": false,
//	"m_bIgnoreRotation": false,
//	"m_bSuccess": true,
//	"m_nForcedCrouchState": "FORCEDCROUCH_NONE",
//	"m_bIgnoreCollisions": false,
//	"m_vDest":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_angDst":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_hDestEntity": null
//}
class CGameScriptedMoveData
{
	Vector m_vAccumulatedRootMotion;
	QAngle m_angAccumulatedRootMotionRotation;
	VectorWS m_vSrc;
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
