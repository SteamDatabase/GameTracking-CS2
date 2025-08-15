class CInfoProjectedDecal : public CPointEntity
{
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterial;
	CUtlStringToken m_sSequenceName;
	float32 m_flDistance;
	bool m_bNotInMultiplayer;
};
