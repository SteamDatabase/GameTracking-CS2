// MGetKV3ClassDefaults = {
//	"_class": "CMotionNodeBlend1D",
//	"m_name": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_blendItems":
//	[
//	],
//	"m_nParamIndex": 0
//}
class CMotionNodeBlend1D : public CMotionNode
{
	CUtlVector< MotionBlendItem > m_blendItems;
	int32 m_nParamIndex;
};
