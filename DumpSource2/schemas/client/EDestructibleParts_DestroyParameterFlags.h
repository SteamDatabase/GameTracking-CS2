enum EDestructibleParts_DestroyParameterFlags : uint32_t
{
	GenerateBreakpieces = 1,
	EnableFlinches = 2,
	ForceDamageApply = 4,
	IgnoreKillEntityFlag = 8,
	IgnoreHealthCheck = 16,
	Default = 3,
};
