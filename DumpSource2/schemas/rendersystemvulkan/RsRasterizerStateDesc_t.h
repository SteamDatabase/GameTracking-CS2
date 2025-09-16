class RsRasterizerStateDesc_t
{
	RsFillMode_t m_nFillMode;
	RsCullMode_t m_nCullMode;
	bool m_bDepthClipEnable;
	bool m_bMultisampleEnable;
	int32 m_nDepthBias;
	float32 m_flDepthBiasClamp;
	float32 m_flSlopeScaledDepthBias;
};
