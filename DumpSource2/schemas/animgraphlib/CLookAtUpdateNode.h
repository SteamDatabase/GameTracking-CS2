// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CLookAtUpdateNode : public CUnaryUpdateNode
{
	LookAtOpFixedSettings_t m_opFixedSettings;
	AnimVectorSource m_target;
	CAnimParamHandle m_paramIndex;
	CAnimParamHandle m_weightParamIndex;
	bool m_bResetChild;
	bool m_bLockWhenWaning;
};
