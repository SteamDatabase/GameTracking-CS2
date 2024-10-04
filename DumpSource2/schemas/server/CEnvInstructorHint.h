class CEnvInstructorHint : public CPointEntity
{
	CUtlSymbolLarge m_iszName;
	CUtlSymbolLarge m_iszReplace_Key;
	CUtlSymbolLarge m_iszHintTargetEntity;
	int32 m_iTimeout;
	int32 m_iDisplayLimit;
	CUtlSymbolLarge m_iszIcon_Onscreen;
	CUtlSymbolLarge m_iszIcon_Offscreen;
	CUtlSymbolLarge m_iszCaption;
	CUtlSymbolLarge m_iszActivatorCaption;
	Color m_Color;
	float32 m_fIconOffset;
	float32 m_fRange;
	uint8 m_iPulseOption;
	uint8 m_iAlphaOption;
	uint8 m_iShakeOption;
	bool m_bStatic;
	bool m_bNoOffscreen;
	bool m_bForceCaption;
	int32 m_iInstanceType;
	bool m_bSuppressRest;
	CUtlSymbolLarge m_iszBinding;
	bool m_bAllowNoDrawTarget;
	bool m_bAutoStart;
	bool m_bLocalPlayerOnly;
};
