class C_ClientRagdoll : public CBaseAnimGraph
{
	bool m_bFadeOut;
	bool m_bImportant;
	GameTime_t m_flEffectTime;
	GameTime_t m_gibDespawnTime;
	int32 m_iCurrentFriction;
	int32 m_iMinFriction;
	int32 m_iMaxFriction;
	int32 m_iFrictionAnimState;
	bool m_bReleaseRagdoll;
	AttachmentHandle_t m_iEyeAttachment;
	bool m_bFadingOut;
	float32[10] m_flScaleEnd;
	GameTime_t[10] m_flScaleTimeStart;
	GameTime_t[10] m_flScaleTimeEnd;
}
