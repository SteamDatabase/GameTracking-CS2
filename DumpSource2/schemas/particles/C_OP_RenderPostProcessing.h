// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderPostProcessing : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "Post Processing Strength"
	CPerParticleFloatInput m_flPostProcessStrength;
	// MPropertyFriendlyName = "Post Processing File"
	// MPropertyAttributeEditor = "AssetBrowse( vpost, *showassetpreview )"
	CStrongHandle< InfoForResourceTypeCPostProcessingResource > m_hPostTexture;
	// MPropertyFriendlyName = "Post Processing Priority Group"
	ParticlePostProcessPriorityGroup_t m_nPriority;
};
