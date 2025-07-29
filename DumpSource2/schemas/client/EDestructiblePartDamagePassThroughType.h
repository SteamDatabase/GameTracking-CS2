enum EDestructiblePartDamagePassThroughType : uint32_t
{
	// MPropertyDescription = "Damages part and the NPC equally."
	Normal = 0,
	// MPropertyDescription = "Damages part but not the NPC until destroyed. (i.e., limited armour)"
	Absorb = 1,
	// MPropertyDescription = "Damages the NPC but not the part (health is ignored): part can only be destroyed by gibbing or procedurally."
	InvinciblePassthrough = 2,
};
