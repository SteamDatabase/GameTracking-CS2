// MNetworkVarNames = "string_t m_EffectName"
// MNetworkVarNames = "bool m_bState"
class C_FuncElectrifiedVolume : public C_FuncBrush
{
	// MNotSaved
	ParticleIndex_t m_nAmbientEffect;
	// MNetworkEnable
	// MNotSaved
	CUtlSymbolLarge m_EffectName;
	// MNetworkEnable
	// MNotSaved
	bool m_bState;
};
