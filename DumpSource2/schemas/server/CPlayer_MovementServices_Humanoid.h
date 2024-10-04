class CPlayer_MovementServices_Humanoid : public CPlayer_MovementServices
{
	float32 m_flStepSoundTime;
	float32 m_flFallVelocity;
	bool m_bInCrouch;
	uint32 m_nCrouchState;
	GameTime_t m_flCrouchTransitionStartTime;
	bool m_bDucked;
	bool m_bDucking;
	bool m_bInDuckJump;
	Vector m_groundNormal;
	float32 m_flSurfaceFriction;
	CUtlStringToken m_surfaceProps;
	int32 m_nStepside;
	int32 m_iTargetVolume;
	Vector m_vecSmoothedVelocity;
}
