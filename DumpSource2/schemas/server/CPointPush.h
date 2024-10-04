class CPointPush : public CPointEntity
{
	bool m_bEnabled;
	float32 m_flMagnitude;
	float32 m_flRadius;
	float32 m_flInnerRadius;
	float32 m_flConeOfInfluence;
	CUtlSymbolLarge m_iszFilterName;
	CHandle< CBaseFilter > m_hFilter;
}
