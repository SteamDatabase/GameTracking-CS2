class CBasePlayerVData : public CEntitySubclassVDataBase
{
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_sModelName;
	CSkillFloat m_flHeadDamageMultiplier;
	CSkillFloat m_flChestDamageMultiplier;
	CSkillFloat m_flStomachDamageMultiplier;
	CSkillFloat m_flArmDamageMultiplier;
	CSkillFloat m_flLegDamageMultiplier;
	float32 m_flHoldBreathTime;
	float32 m_flDrowningDamageInterval;
	int32 m_nDrowningDamageInitial;
	int32 m_nDrowningDamageMax;
	int32 m_nWaterSpeed;
	float32 m_flUseRange;
	float32 m_flUseAngleTolerance;
	float32 m_flCrouchTime;
}
