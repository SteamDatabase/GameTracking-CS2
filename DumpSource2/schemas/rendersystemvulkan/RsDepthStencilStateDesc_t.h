class RsDepthStencilStateDesc_t
{
	bitfield:1 m_bDepthTestEnable;
	bitfield:1 m_bDepthWriteEnable;
	RsComparison_t m_depthFunc;
	RsStencilStateDesc_t m_stencilState;
};
