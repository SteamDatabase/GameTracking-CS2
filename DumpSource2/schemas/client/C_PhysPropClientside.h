class C_PhysPropClientside : public C_BreakableProp
{
	GameTime_t m_flTouchDelta;
	GameTime_t m_fDeathTime;
	Vector m_vecDamagePosition;
	Vector m_vecDamageDirection;
	DamageTypes_t m_nDamageType;
};
