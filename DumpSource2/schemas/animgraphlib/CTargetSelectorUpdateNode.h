class CTargetSelectorUpdateNode : public CAnimUpdateNodeBase
{
	CUtlVector< CAnimUpdateNodeRef > m_children;
	CAnimParamHandle m_hPositionParameter;
	CAnimParamHandle m_hFacePositionParameter;
};
