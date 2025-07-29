// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CMovementComponentUpdater : public CAnimComponentUpdater
{
	CUtlVector< CSmartPtr< CAnimMotorUpdaterBase > > m_motors;
	CAnimInputDamping m_facingDamping;
	int32 m_nDefaultMotorIndex;
	float32 m_flDefaultRunSpeed;
	bool m_bMoveVarsDisabled;
	bool m_bNetworkPath;
	bool m_bNetworkFacing;
	CAnimParamHandle[34] m_paramHandles;
};
