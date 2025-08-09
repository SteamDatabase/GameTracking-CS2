// MGetKV3ClassDefaults = {
//	"m_nActorID": 0,
//	"m_szPreIdleSequence": "",
//	"m_szEntrySequence": "",
//	"m_szSequence": "",
//	"m_szExitSequence": "",
//	"m_nMoveTo": "eWaitFacing",
//	"m_nMoveToGait": "eInvalid",
//	"m_nHeldWeaponBehavior": "eInvalid",
//	"m_bLoopPreIdleSequence": false,
//	"m_bLoopActionSequence": false,
//	"m_bLoopPostIdleSequence": false,
//	"m_bIgnoreLookAt": false
//}
class PulseScriptedSequenceData_t
{
	int32 m_nActorID;
	CUtlString m_szPreIdleSequence;
	CUtlString m_szEntrySequence;
	CUtlString m_szSequence;
	CUtlString m_szExitSequence;
	ScriptedMoveTo_t m_nMoveTo;
	SharedMovementGait_t m_nMoveToGait;
	ScriptedHeldWeaponBehavior_t m_nHeldWeaponBehavior;
	bool m_bLoopPreIdleSequence;
	bool m_bLoopActionSequence;
	bool m_bLoopPostIdleSequence;
	bool m_bIgnoreLookAt;
};
