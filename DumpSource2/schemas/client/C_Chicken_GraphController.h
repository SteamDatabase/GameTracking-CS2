class C_Chicken_GraphController : public CAnimGraphControllerBase
{
	CAnimGraphParamRef< char* > m_paramActivity;
	CAnimGraphParamRef< bool > m_paramEndActivityImmediately;
	CAnimGraphParamRef< bool > m_paramSnapToSquatting;
	CAnimGraphTagRef m_sActivityFinished;
	float32 m_flSquatProbability;
};
