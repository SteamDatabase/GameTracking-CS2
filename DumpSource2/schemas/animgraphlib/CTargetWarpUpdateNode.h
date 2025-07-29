// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CTargetWarpUpdateNode : public CUnaryUpdateNode
{
	TargetWarpAngleMode_t m_eAngleMode;
	CAnimParamHandle m_hTargetPositionParameter;
	CAnimParamHandle m_hTargetUpVectorParameter;
	CAnimParamHandle m_hTargetFacePositionParameter;
	CAnimParamHandle m_hMoveHeadingParameter;
	CAnimParamHandle m_hDesiredMoveHeadingParameter;
	TargetWarpCorrectionMethod m_eCorrectionMethod;
	TargetWarpTimingMethod m_eTargetWarpTimingMethod;
	bool m_bTargetFacePositionIsWorldSpace;
	bool m_bTargetPositionIsWorldSpace;
	bool m_bOnlyWarpWhenTagIsFound;
	bool m_bWarpOrientationDuringTranslation;
	bool m_bWarpAroundCenter;
	float32 m_flMaxAngle;
};
