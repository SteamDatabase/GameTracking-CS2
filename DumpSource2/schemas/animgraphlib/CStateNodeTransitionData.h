class CStateNodeTransitionData
{
	CBlendCurve m_curve;
	CAnimValue< float32 > m_blendDuration;
	CAnimValue< float32 > m_resetCycleValue;
	bitfield:1 m_bReset;
	bitfield:3 m_resetCycleOption;
}
