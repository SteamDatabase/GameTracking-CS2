// MGetKV3ClassDefaults = {
//	"_class": "CMotionGraph",
//	"m_paramSpans":
//	{
//		"m_spans":
//		[
//		]
//	},
//	"m_tags":
//	[
//	],
//	"m_pRootNode": null,
//	"m_nParameterCount": 0,
//	"m_nConfigStartIndex": -1,
//	"m_nConfigCount": -1,
//	"m_bLoop": false
//}
class CMotionGraph
{
	CParamSpanUpdater m_paramSpans;
	CUtlVector< TagSpan_t > m_tags;
	CSmartPtr< CMotionNode > m_pRootNode;
	int32 m_nParameterCount;
	int32 m_nConfigStartIndex;
	int32 m_nConfigCount;
	bool m_bLoop;
};
