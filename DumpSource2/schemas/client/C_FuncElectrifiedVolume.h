// MNetworkVarNames = "string_t m_EffectName"
// MNetworkVarNames = "bool m_bState"
class C_FuncElectrifiedVolume : public C_FuncBrush
{
	ParticleIndex_t m_nAmbientEffect;
	// MNetworkEnable
	CUtlSymbolLarge m_EffectName;
	// MNetworkEnable
	bool m_bState;
};
