class C_LightGlowOverlay : public CGlowOverlay
{
	Vector m_vecOrigin;
	Vector m_vecDirection;
	int32 m_nMinDist;
	int32 m_nMaxDist;
	int32 m_nOuterMaxDist;
	bool m_bOneSided;
	bool m_bModulateByDot;
};
