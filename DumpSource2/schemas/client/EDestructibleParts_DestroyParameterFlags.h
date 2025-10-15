enum EDestructibleParts_DestroyParameterFlags : uint32_t
{
	// MEnumeratorIsNotAFlag
	None = 0,
	GenerateBreakpieces = 1,
	EnableFlinches = 2,
	ForceDamageApply = 4,
	IgnoreKillEntityFlag = 8,
	IgnoreHealthCheck = 16,
	// MEnumeratorIsNotAFlag
	Default = 3,
};
