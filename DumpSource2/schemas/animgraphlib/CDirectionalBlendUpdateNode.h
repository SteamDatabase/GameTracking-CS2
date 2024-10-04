class CDirectionalBlendUpdateNode : public CLeafUpdateNode
{
	HSequence[8] m_hSequences;
	CAnimInputDamping m_damping;
	AnimValueSource m_blendValueSource;
	CAnimParamHandle m_paramIndex;
	float32 m_playbackSpeed;
	float32 m_duration;
	bool m_bLoop;
	bool m_bLockBlendOnReset;
}
