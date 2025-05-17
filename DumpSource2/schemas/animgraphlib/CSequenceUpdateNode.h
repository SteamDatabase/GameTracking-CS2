// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CSequenceUpdateNode : public CSequenceUpdateNodeBase
{
	HSequence m_hSequence;
	float32 m_duration;
	CParamSpanUpdater m_paramSpans;
	CUtlVector< TagSpan_t > m_tags;
};
