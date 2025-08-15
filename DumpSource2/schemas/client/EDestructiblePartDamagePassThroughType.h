enum EDestructiblePartDamagePassThroughType : uint32_t
{
	// MPropertyDescription = "Damage reduces the part's health pool and the owner entity equally."
	Normal = 0,
	// MPropertyDescription = "Damage reduces the part's health pool but not the owner entity until destroyed. (i.e., limited armour)"
	Absorb = 1,
	// MPropertyDescription = "Damage is completely ignored - i.e., this part ignores the health value and does not send damage to the owner entity."
	InvincibleAbsorb = 2,
	// MPropertyDescription = "Damage reduces the owner entity but not the part (health is ignored): part can only be destroyed by gibbing or procedurally."
	InvinciblePassthrough = 3,
};
