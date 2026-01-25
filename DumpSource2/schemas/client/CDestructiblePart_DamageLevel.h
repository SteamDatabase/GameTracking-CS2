// MGetKV3ClassDefaults = {
//	"m_sName": "",
//	"m_sBreakablePieceName": "",
//	"m_nBodyGroupValue": -1,
//	"m_nHealth": 1,
//	"m_flCriticalDamagePercent": 0.000000,
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
class CDestructiblePart_DamageLevel
{
	// MPropertyDescription = "Name for this damage level.  Presently only used for debugging/display - one day may be used in code to allow destroying by name."
	CUtlString m_sName;
	// MPropertyStartGroup = "+Model Setup"
	// MPropertyDescription = "Name of the breakable to trigger breaking on when health reaches zero."
	// MPropertyAttributeEditor = "ModelDocPicker( MODELDOC_PICK_TYPE_BREAKPIECE )"
	CGlobalSymbol m_sBreakablePieceName;
	// MPropertyDescription = "Value to set for the body group when the damage level is broken."
	int32 m_nBodyGroupValue;
	// MPropertyStartGroup = "+Damage"
	// MPropertyDescription = "Total health of this damage level. When it reaches 0, the damage level is 'broken' using the breakable prop system."
	// MPropertySuppressExpr = "m_nDamagePassthroughType == InvincibleAbsorb || m_nDamagePassthroughType == InvinciblePassthrough"
	CSkillInt m_nHealth;
	// MPropertyDescription = "% chance (0-1) of dealing 'critical' damage, which destroys this damage level, regardless of damage pass through type."
	float32 m_flCriticalDamagePercent;
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
