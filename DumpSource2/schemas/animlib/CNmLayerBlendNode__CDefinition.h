// MGetKV3ClassDefaults = {
//	"_class": "CNmLayerBlendNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nBaseNodeIdx": -1,
//	"m_bOnlySampleBaseRootMotion": true,
//	"m_layerDefinition":
//	[
//	]
//}
class CNmLayerBlendNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nBaseNodeIdx;
	bool m_bOnlySampleBaseRootMotion;
	CUtlLeanVectorFixedGrowable< CNmLayerBlendNode::LayerDefinition_t, 3 > m_layerDefinition;
};
