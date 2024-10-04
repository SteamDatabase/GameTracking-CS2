class CNmLayerBlendNode::LayerDefinition_t
{
	int16 m_nInputNodeIdx;
	int16 m_nWeightValueNodeIdx;
	int16 m_nBoneMaskValueNodeIdx;
	int16 m_nRootMotionWeightValueNodeIdx;
	bool m_bIsSynchronized;
	bool m_bIgnoreEvents;
	bool m_bIsStateMachineLayer;
	NmPoseBlendMode_t m_blendMode;
};
