// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmLayerBlendNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nBaseNodeIdx;
	bool m_bOnlySampleBaseRootMotion;
	CUtlLeanVectorFixedGrowable< CNmLayerBlendNode::LayerDefinition_t, 3 > m_layerDefinition;
};
