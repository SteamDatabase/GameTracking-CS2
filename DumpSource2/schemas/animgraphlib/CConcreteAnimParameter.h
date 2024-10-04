class CConcreteAnimParameter : public CAnimParameterBase
{
	AnimParamButton_t m_previewButton;
	AnimParamNetworkSetting m_eNetworkSetting;
	bool m_bUseMostRecentValue;
	bool m_bAutoReset;
	bool m_bGameWritable;
	bool m_bGraphWritable;
};
