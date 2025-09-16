class RsStencilStateDesc_t
{
	bitfield:1 m_bStencilEnable;
	bitfield:3 m_frontStencilFailOp;
	bitfield:3 m_frontStencilDepthFailOp;
	bitfield:3 m_frontStencilPassOp;
	bitfield:3 m_frontStencilFunc;
	bitfield:3 m_backStencilFailOp;
	bitfield:3 m_backStencilDepthFailOp;
	bitfield:3 m_backStencilPassOp;
	bitfield:3 m_backStencilFunc;
	uint8 m_nStencilReadMask;
	uint8 m_nStencilWriteMask;
};
