// MGetKV3ClassDefaults = {
//	"_class": "CBasePlayerVData",
//	"m_sModelName": "",
//	"m_flHeadDamageMultiplier": 3.000000,
//	"m_flChestDamageMultiplier": 1.000000,
//	"m_flStomachDamageMultiplier": 1.000000,
//	"m_flArmDamageMultiplier": 1.000000,
//	"m_flLegDamageMultiplier": 1.000000,
//	"m_flHoldBreathTime": 15.000000,
//	"m_flDrowningDamageInterval": 1.000000,
//	"m_nDrowningDamageInitial": 10,
//	"m_nDrowningDamageMax": 10,
//	"m_nWaterSpeed": 100,
//	"m_flUseRange": 55.000000,
//	"m_flUseAngleTolerance": 45.000000,
//	"m_flCrouchTime": 0.400000
//}
class CBasePlayerVData : public CEntitySubclassVDataBase
{
	// MPropertyProvidesEditContextString = "ToolEditContext_ID_VMDL"
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_sModelName;
	CSkillFloat m_flHeadDamageMultiplier;
	CSkillFloat m_flChestDamageMultiplier;
	CSkillFloat m_flStomachDamageMultiplier;
	CSkillFloat m_flArmDamageMultiplier;
	CSkillFloat m_flLegDamageMultiplier;
	// MPropertyGroupName = "Water"
	float32 m_flHoldBreathTime;
	// MPropertyGroupName = "Water"
	// MPropertyDescription = "Seconds between drowning ticks"
	float32 m_flDrowningDamageInterval;
	// MPropertyGroupName = "Water"
	// MPropertyDescription = "Amount of damage done on the first drowning tick (+1 each subsequent interval)"
	int32 m_nDrowningDamageInitial;
	// MPropertyGroupName = "Water"
	// MPropertyDescription = "Max damage done by a drowning tick"
	int32 m_nDrowningDamageMax;
	// MPropertyGroupName = "Water"
	int32 m_nWaterSpeed;
	// MPropertyGroupName = "Use"
	float32 m_flUseRange;
	// MPropertyGroupName = "Use"
	float32 m_flUseAngleTolerance;
	// MPropertyGroupName = "Crouch"
	// MPropertyDescription = "Time to move between crouch and stand"
	float32 m_flCrouchTime;
};
