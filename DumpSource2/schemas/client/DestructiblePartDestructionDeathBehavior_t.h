enum DestructiblePartDestructionDeathBehavior_t : uint32_t
{
	// MPropertyDescription = "Does not kill the entity when the part is destroyed"
	eDoNotKill = 0,
	// MPropertyDescription = "Kills the entity, using the normal codepath to determine kill type, when the part is destroyed"
	eKill = 1,
	// MPropertyDescription = "Kills and gibs the entity when the part is destroyed"
	eGib = 2,
	// MPropertyDescription = "Kills and instantly removes the entity when the part is destroyed"
	eRemove = 3,
};
