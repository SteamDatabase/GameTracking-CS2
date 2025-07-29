// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CBlendUpdateNode : public CAnimUpdateNodeBase
{
	CUtlVector< CAnimUpdateNodeRef > m_children;
	CUtlVector< uint8 > m_sortedOrder;
	CUtlVector< float32 > m_targetValues;
	AnimValueSource m_blendValueSource;
	LinearRootMotionBlendMode_t m_eLinearRootMotionBlendMode;
	CAnimParamHandle m_paramIndex;
	CAnimInputDamping m_damping;
	BlendKeyType m_blendKeyType;
	bool m_bLockBlendOnReset;
	bool m_bSyncCycles;
	bool m_bLoop;
	bool m_bLockWhenWaning;
	bool m_bIsAngle;
};
