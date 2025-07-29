// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class PostProcessingResource_t
{
	bool m_bHasTonemapParams;
	PostProcessingTonemapParameters_t m_toneMapParams;
	bool m_bHasBloomParams;
	PostProcessingBloomParameters_t m_bloomParams;
	bool m_bHasVignetteParams;
	PostProcessingVignetteParameters_t m_vignetteParams;
	bool m_bHasLocalContrastParams;
	PostProcessingLocalContrastParameters_t m_localConstrastParams;
	int32 m_nColorCorrectionVolumeDim;
	CUtlBinaryBlock m_colorCorrectionVolumeData;
	bool m_bHasColorCorrection;
	bool m_bHasFogScatteringParams;
	PostProcessingFogScatteringParameters_t m_fogScatteringParams;
};
