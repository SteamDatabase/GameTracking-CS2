// MGetKV3ClassDefaults = {
//	"m_vDestOffset":
//	[
//		340282346638528859811704183484516925440.000000,
//		340282346638528859811704183484516925440.000000,
//		340282346638528859811704183484516925440.000000
//	],
//	"m_hDestEntity": null,
//	"m_angDest":
//	[
//		340282346638528859811704183484516925440.000000,
//		340282346638528859811704183484516925440.000000,
//		340282346638528859811704183484516925440.000000
//	],
//	"m_flDuration": 0.000000,
//	"m_flAngRate": 180.000000,
//	"m_flMoveSpeed": 0.000000,
//	"m_bAimDisabled": false,
//	"m_bIgnoreRotation": false,
//	"m_nForcedCrouchState": "FORCEDCROUCH_NONE"
//}
class CGameScriptedMoveDef_t
{
	Vector m_vDestOffset;
	CHandle< CBaseEntity > m_hDestEntity;
	QAngle m_angDest;
	float32 m_flDuration;
	float32 m_flAngRate;
	float32 m_flMoveSpeed;
	bool m_bAimDisabled;
	bool m_bIgnoreRotation;
	ForcedCrouchState_t m_nForcedCrouchState;
};
