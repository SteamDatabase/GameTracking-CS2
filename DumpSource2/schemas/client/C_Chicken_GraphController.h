class C_Chicken_GraphController : public CBaseAnimGraphAnimGraphController
{
	CAnimGraphParamRef< char* > m_paramActivity;
	CAnimGraphParamRef< bool > m_paramEndActivityImmediately;
	CAnimGraphParamRef< bool > m_paramSnapToSquatting;
	CAnimGraphTagRef m_sActivityFinished;
};
