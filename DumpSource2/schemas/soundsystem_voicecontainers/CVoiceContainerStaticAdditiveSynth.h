// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Additive Synth Container"
// MPropertyDescription = "This is a static additive synth that can scale components of the synth based on how many instances are running."
class CVoiceContainerStaticAdditiveSynth : public CVoiceContainerBase
{
	CUtlVector< CVoiceContainerStaticAdditiveSynth::CTone > m_tones;
};
