class CLogicCase : public CLogicalEntity
{
	CUtlSymbolLarge[32] m_nCase;
	int32 m_nShuffleCases;
	int32 m_nLastShuffleCase;
	uint8[32] m_uchShuffleCaseMap;
	CEntityIOOutput[32] m_OnCase;
	CEntityOutputTemplate< CVariantBase< CVariantDefaultAllocator > > m_OnDefault;
}
