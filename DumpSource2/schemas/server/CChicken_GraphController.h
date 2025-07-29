class CChicken_GraphController : public CBaseAnimGraphAnimGraphController
{
	CAnimGraphParamRef< char* > m_paramActivity;
	CAnimGraphParamRef< bool > m_paramEndActivityImmediately;
	CAnimGraphTagRef m_sActivityFinished;
	CAnimGraphParamRef< float32 > m_paramTurnAngle;
};
