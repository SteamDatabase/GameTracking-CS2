class EventSetTime_t
{
	EngineLoopState_t m_LoopState;
	int32 m_nClientOutputFrames;
	float64 m_flRealTime;
	float64 m_flRenderTime;
	float64 m_flRenderFrameTime;
	float64 m_flRenderFrameTimeUnbounded;
	float64 m_flRenderFrameTimeUnscaled;
	float64 m_flTickRemainder;
};
