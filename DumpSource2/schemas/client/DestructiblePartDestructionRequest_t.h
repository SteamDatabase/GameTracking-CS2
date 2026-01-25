class DestructiblePartDestructionRequest_t
{
	EDestructibleParts_DestroyParameterFlags m_nDestroyFlags;
	DamageTypes_t m_nDamageType;
	float32 m_flPartDamage;
	float32 m_flPartDamageRadius;
	VectorWS m_vWsPartDamageOrigin;
	Vector m_vWsPartDamageForce;
};
