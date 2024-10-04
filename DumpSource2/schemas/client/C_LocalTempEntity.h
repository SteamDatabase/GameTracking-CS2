class C_LocalTempEntity : public CBaseAnimGraph
{
	int32 flags;
	GameTime_t die;
	float32 m_flFrameMax;
	float32 x;
	float32 y;
	float32 fadeSpeed;
	float32 bounceFactor;
	int32 hitSound;
	int32 priority;
	Vector tentOffset;
	QAngle m_vecTempEntAngVelocity;
	int32 tempent_renderamt;
	Vector m_vecNormal;
	float32 m_flSpriteScale;
	int32 m_nFlickerFrame;
	float32 m_flFrameRate;
	float32 m_flFrame;
	char* m_pszImpactEffect;
	char* m_pszParticleEffect;
	bool m_bParticleCollision;
	int32 m_iLastCollisionFrame;
	Vector m_vLastCollisionOrigin;
	Vector m_vecTempEntVelocity;
	Vector m_vecPrevAbsOrigin;
	Vector m_vecTempEntAcceleration;
};
