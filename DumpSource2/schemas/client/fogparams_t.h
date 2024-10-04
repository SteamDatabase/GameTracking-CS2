class fogparams_t
{
	Vector dirPrimary;
	Color colorPrimary;
	Color colorSecondary;
	Color colorPrimaryLerpTo;
	Color colorSecondaryLerpTo;
	float32 start;
	float32 end;
	float32 farz;
	float32 maxdensity;
	float32 exponent;
	float32 HDRColorScale;
	float32 skyboxFogFactor;
	float32 skyboxFogFactorLerpTo;
	float32 startLerpTo;
	float32 endLerpTo;
	float32 maxdensityLerpTo;
	GameTime_t lerptime;
	float32 duration;
	float32 blendtobackground;
	float32 scattering;
	float32 locallightscale;
	bool enable;
	bool blend;
	bool m_bNoReflectionFog;
	bool m_bPadding;
}
