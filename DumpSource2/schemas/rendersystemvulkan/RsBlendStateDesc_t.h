class RsBlendStateDesc_t
{
	uint32 m_srcBlendBits;
	uint32 m_destBlendBits;
	uint32 m_srcBlendAlphaBits;
	uint32 m_destBlendAlphaBits;
	uint32 m_renderTargetWriteMaskBits;
	bitfield:30 m_blendOpBits;
	bitfield:1 m_bAlphaToCoverageEnable;
	bitfield:1 m_bIndependentBlendEnable;
	uint32 m_blendOpAlphaBits;
	uint8 m_blendEnableBits;
	uint8 m_srgbWriteEnableBits;
};
