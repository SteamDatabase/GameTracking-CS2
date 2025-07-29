class CBaseFilter : public CLogicalEntity
{
	bool m_bNegated;
	CEntityIOOutput m_OnPass;
	CEntityIOOutput m_OnFail;
};
