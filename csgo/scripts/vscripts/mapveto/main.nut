WARMUP <- ScriptIsWarmupPeriod();


function OnPostSpawn()
{

	SendToConsoleServer( "sv_disable_radar 1" );

	if (!WARMUP)
	{
		EntFire ( "@trigger_camera_start","Enable", "", 0 );	// enable camera triggers
		EntFire ( "@fade_in","Fade", "", 0 );	// fade in from black
		
	}

}
