TRIGGER_CT <- EntityGroup[0];
TRIGGER_T <- EntityGroup[1];

AVAILABLE_TSPAWN <- true;
AVAILABLE_CTSPAWN <- true;

INSTANCE_PREFIX <- self.GetName().slice(0,6);		// as long as we dont go over arena9 we are fine

PLAYER_T <- null;
PLAYER_CT <- null;

WARMUP <- ScriptIsWarmupPeriod();

MAPNAME <- GetMapName();

V_ZERO <- (Vector (0.0, 0.0, 0.0));

SPAWN_T <- Entities.FindByName(null, INSTANCE_PREFIX + "-tspawn");
SPAWN_CT <- Entities.FindByName(null, INSTANCE_PREFIX + "-ctspawn");

RESET <- false;

RELAY_CLEARDECAL <- null;

WEAPON <- [	
	"weapon_ak47",
	"weapon_galilar",
	"weapon_famas",
	"weapon_awp",
	"weapon_m4a1",
	"weapon_m4a1_silencer",
	"weapon_deagle",
	"weapon_usp_silencer",
	"weapon_glock"
]

function OnPostSpawn()
{
	// check if we need to do map specific stuff
	if (MAPNAME == "de_shortnuke" || MAPNAME == "de_nuke" || MAPNAME == "de_inferno")
	{
		EntFire( "@skybox_swap", "Trigger", "", 0.0,  null );	// skybox_swapper entity 
	}
	
}


function DebugInfo()
{
	printl ("===" + INSTANCE_PREFIX + " debug info: ===");
	printl ("Available T spawn = " + AVAILABLE_TSPAWN);
	printl ("Available CT spawn = " + AVAILABLE_CTSPAWN);
	printl ("Current T player = " + PLAYER_T);
	printl ("Current CT player = " + PLAYER_CT);
	printl ("===" + INSTANCE_PREFIX + " end debug info ===");
}

function TSpawnCheck()
{
	// loops every .1 sec in the arena
	if (WARMUP == true)
	{
	EntFireByHandle( TRIGGER_T ,"TouchTest", "", 0, null, null );

		if ( SPAWN_T == null )
		{	// try to re-locate T-spawn if it wasn't available at spawn time
			SPAWN_T <- Entities.FindByName(null, INSTANCE_PREFIX + "-tspawn");
		}

	return;
	}
}

function DisableTSpawn()
{
	AVAILABLE_TSPAWN = false;

	PLAYER_T = activator;
}

function EnableTSpawn()
{
	AVAILABLE_TSPAWN = true;

	PLAYER_T = null;
}

function CTSpawnCheck()
{
	// loops every .1 sec in the arena, checks if player is still there (fixes bug with players removing bots on connect)
	if (WARMUP == true)
	{
	EntFireByHandle( TRIGGER_CT ,"TouchTest", "", 0, null, null );

		if ( SPAWN_CT == null )
		{	// try to re-locate CT-spawn if it wasn't available at spawn time
			SPAWN_CT <- Entities.FindByName(null, INSTANCE_PREFIX + "-ctspawn");
		}

	return;
	}
}

function DisableCTSpawn()
{
	AVAILABLE_CTSPAWN = false;
	PLAYER_CT = activator;
}

function EnableCTSpawn()
{
	AVAILABLE_CTSPAWN = true;
	PLAYER_CT = null;
}

function RemoveDroppedWeapons()
{
	local origin = self.GetOrigin();
	local DroppedGun = null;
	
		while( ( DroppedGun = Entities.FindByClassnameWithin (DroppedGun, "weapon_*", origin, 640.00) ) != null )
		{
			if (DroppedGun.GetOwner() == null)		// if it doesnt have a owner, kill it
			{
				DroppedGun.Destroy();
			}
		}

}

function StripGuns()
{
	EntFire( "@warmup.weapon_equip_empty", "Use", "", 0.0,  PLAYER_CT );	
	EntFire( "@warmup.weapon_equip_empty", "Use", "", 0.0,  PLAYER_T );	
	
	return;
}

function ArenaStart()		// called when the arena has two players, checks every .1 sec
{
	TSpawnCheck();
	CTSpawnCheck();

	if (AVAILABLE_TSPAWN == false && PLAYER_T != null && SPAWN_T != null && AVAILABLE_CTSPAWN == false && PLAYER_CT != null && SPAWN_CT != null && RESET == false && WARMUP == true)
	{
		
		RemoveDroppedWeapons();
		
		local RandomPick = RandomInt(0, WEAPON.len()-1 );	// pick a gun from the weapon list
		local PickedGun = WEAPON[RandomPick];
	
		// reset player positions, to ensure survivor is not spawn camping
		PLAYER_T.SetOrigin( SPAWN_T.GetOrigin() );
		PLAYER_T.SetAngles( 0, SPAWN_T.GetAngles().y, 0 );
		PLAYER_T.SetVelocity(V_ZERO);
		
		PLAYER_CT.SetOrigin( SPAWN_CT.GetOrigin() );
		PLAYER_CT.SetAngles( 0, SPAWN_CT.GetAngles().y, 0 );
		PLAYER_CT.SetVelocity(V_ZERO);
		
		// strip all guns
		StripGuns();
		
		// give current gun
		GiveGun( PickedGun );

		// top off health if injured
		PLAYER_CT.SetHealth(100);		
		PLAYER_T.SetHealth(100);
		
		RESET = true;		// dont keep resetting
	}
	
	if ( (AVAILABLE_TSPAWN == true || AVAILABLE_CTSPAWN == true) && (RESET == true && WARMUP == true))
	{
		RESET = false;
	}
}

function GiveGun( weapon )
{
	local equipper = Entities.CreateByClassname( "game_player_equip" )

	// set flags and keyvalues
	equipper.__KeyValueFromInt( "spawnflags", 5 )
	equipper.__KeyValueFromInt( weapon, 0 )
	equipper.__KeyValueFromInt( "weapon_knife", 0 )
	equipper.__KeyValueFromInt( "item_kevlar", 0 )

	equipper.ValidateScriptScope()

	EntFireByHandle( equipper, "Use", "", 0, PLAYER_CT, null )
	EntFireByHandle( equipper, "Use", "", 0, PLAYER_T, null )
	
	EntFireByHandle( equipper, "Kill", "", 0.1, null, null )
}