// MGetKV3ClassDefaults = {
//	"m_sName": "",
//	"m_sBreakablePieceName": "",
//	"m_sBodyGroupName": "",
//	"m_nBodyGroupValue": -1,
//	"m_nHealth": 1,
//	"m_nDamagePassthroughType": "Normal",
//	"m_nDestructionDeathBehavior": "eDoNotKill",
//	"m_sCustomDeathHandshake": "",
//	"m_bShouldDestroyOnDeath": false,
//	"m_flDeathDestroyTime":
//	[
//		0.100000,
//		1.000000
//	]
//}
class CDestructiblePartsSystemData_DamageLevel
{
	// MPropertyDescription = "Name for this damage level."
	CUtlString m_sName;
	// MPropertyStartGroup = "+Model Setup"
	// MPropertyDescription = "Name of the breakable to trigger breaking on when health reaches zero."
	// MPropertyAttributeEditor = "ModelDocPicker( 16 )"
	CGlobalSymbol m_sBreakablePieceName;
	// MPropertyStartGroup = "+Model Setup/+Body Group"
	// MPropertyDescription = "Body group to set when this damage level is broken."
	// MPropertyAttributeEditor = "ModelDocPicker( 4 )"
	CGlobalSymbol m_sBodyGroupName;
	// MPropertyDescription = "Value to set for the body group when the damage level is broken."
	int32 m_nBodyGroupValue;
	// MPropertyStartGroup = "+Damage"
	// MPropertyDescription = "Total health of this damage level. When it reaches 0, the damage level is 'broken' using the breakable prop system."
	CSkillInt m_nHealth;
	// MPropertyDescription = "How damage to this damage level is handled."
	EDestructiblePartDamagePassThroughType m_nDamagePassthroughType;
	// MPropertyStartGroup = "+Death"
	// MPropertyDescription = "Should the entity die when this damage level is destroyed?"
	DestructiblePartDestructionDeathBehavior_t m_nDestructionDeathBehavior;
	// MPropertyDescription = "Custom death handshake to set when this damage level is destroyed."
	// MPropertySuppressExpr = "m_nDestructionDeathBehavior == eDoNotKill"
	CGlobalSymbol m_sCustomDeathHandshake;
	// MPropertyDescription = "Whether the damage level should be destroyed when the entity dies."
	bool m_bShouldDestroyOnDeath;
	// MPropertyDescription = "Time after death the damage level should be destroyed"
	// MPropertySuppressExpr = "m_bShouldDestroyOnDeath == false"
	CRangeFloat m_flDeathDestroyTime;
};
