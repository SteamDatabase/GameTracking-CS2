// MGetKV3ClassDefaults = {
//	"m_flDamage": 0.000000,
//	"m_flNPCDamageScalarVsNPC": 1.000000,
//	"m_flPhysicsForceDamage": 0.000000
//}
class CSkillDamage
{
	// MPropertyDescription = "Damage Dealt (in the case of NPC vs NPC damage, medium skill times the NPC damage scalar is used)"
	CSkillFloat m_flDamage;
	// MPropertyDescription = "Damage Scalar for NPC vs NPC cases"
	float32 m_flNPCDamageScalarVsNPC;
	// MPropertyDescription = "If specified, the damage used to compute physics forces. Otherwise normal damage is used (and is not scaled by the NPC damage scalar."
	float32 m_flPhysicsForceDamage;
};
