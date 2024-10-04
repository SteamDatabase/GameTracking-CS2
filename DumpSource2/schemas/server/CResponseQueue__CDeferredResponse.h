class CResponseQueue::CDeferredResponse
{
	CResponseCriteriaSet m_contexts;
	float32 m_fDispatchTime;
	CHandle< CBaseEntity > m_hIssuer;
	CRR_Response m_response;
	bool m_bResponseValid;
};
