class CChoiceUpdateNode : public CAnimUpdateNodeBase
{
	CUtlVector< CAnimUpdateNodeRef > m_children;
	CUtlVector< float32 > m_weights;
	CUtlVector< float32 > m_blendTimes;
	ChoiceMethod m_choiceMethod;
	ChoiceChangeMethod m_choiceChangeMethod;
	ChoiceBlendMethod m_blendMethod;
	float32 m_blendTime;
	bool m_bCrossFade;
	bool m_bResetChosen;
	bool m_bDontResetSameSelection;
}
