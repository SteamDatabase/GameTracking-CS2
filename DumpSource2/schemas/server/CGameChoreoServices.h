class CGameChoreoServices : public IChoreoServices
{
	CHandle< CBaseAnimGraph > m_hOwner;
	CHandle< CScriptedSequence > m_hScriptedSequence;
	IChoreoServices::ScriptState_t m_scriptState;
	IChoreoServices::ChoreoState_t m_choreoState;
	GameTime_t m_flTimeStartedState;
}
