class CBaseAnimGraphAnimGraphController : public CAnimGraphControllerBase
{
	CAnimGraphParamOptionalRef< CGlobalSymbol > m_sDestructiblePartDestroyedHitGroup;
	CAnimGraphParamOptionalRef< int32 > m_nDestructiblePartDestroyedPartIndex;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_INVALID_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_GENERIC_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_HEAD_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_CHEST_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_STOMACH_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_LEFTARM_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_RIGHTARM_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_LEFTLEG_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_RIGHTLEG_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_NECK_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_UNUSED_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_GEAR_Destroyed;
	CAnimGraphParamOptionalRef< bool > m_bHITGROUP_SPECIAL_Destroyed;
};
