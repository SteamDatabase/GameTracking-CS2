class CCSObserver_ObserverServices : public CPlayer_ObserverServices
{
	CEntityHandle m_hLastObserverTarget;
	Vector m_vecObserverInterpolateOffset;
	Vector m_vecObserverInterpStartPos;
	float32 m_flObsInterp_PathLength;
	Quaternion m_qObsInterp_OrientationStart;
	Quaternion m_qObsInterp_OrientationTravelDir;
	ObserverInterpState_t m_obsInterpState;
	bool m_bObserverInterpolationNeedsDeferredSetup;
};
