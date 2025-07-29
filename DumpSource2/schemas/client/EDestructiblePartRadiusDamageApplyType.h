enum EDestructiblePartRadiusDamageApplyType : uint32_t
{
	// MPropertyDescription = "Damage is scaled proportionally based on distance from the epicenter."
	ScaleByExplosionRadius = 0,
	// MPropertyDescription = "Damage is dumped to the closest alive part, and the remainder is scaled as in ScaleByExplosionRadius algorithm."
	PrioritizeClosestPart = 1,
};
