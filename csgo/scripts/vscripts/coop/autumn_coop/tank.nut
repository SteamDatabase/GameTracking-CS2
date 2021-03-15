SPOTTER <- EntityGroup[0];		// spotter position
TANK <- EntityGroup[1];		// func_tank
AIMPOINT <- EntityGroup[2];		// targetposition dummy
TANKBASE <- EntityGroup[3];		// base of tank turret

TARGET <- null;
TIME <- null;

LASTSEEN <- null;	// position where player was last seen

COOLDOWN <- 0;		// when cooldown expires
COOLDOWNTIME <- 6;	// how long the cooldown lasts

FORGET <- 0;		// when tank forgets target
FORGETTIME <- 3;	// how long to wait until forget

function OnPostSpawn()
{

EntFireByHandle( TANK, "SetTargetEntityName", AIMPOINT.GetName(), 0.0, null, null );
EntFireByHandle( TANKBASE, "SetTargetEntityName", AIMPOINT.GetName(), 0.0, null, null );

}

CASE1_TRIGGERED <- false;
CASE2_TRIGGERED <- false;
CASE3_TRIGGERED <- false;
CASE4_TRIGGERED <- false;

function CheckHealth()		// triggered by func_breakable, starts with 1000 hp
{

local health = caller.GetHealth();

//local breakable = caller;

//printl (health);

if (health < 950 && health > 900)
{
	if (!CASE1_TRIGGERED)
	{
		DamageState(1);
		CASE1_TRIGGERED = true;
	}
}

if (health < 500 && health > 450)
{
	if (!CASE2_TRIGGERED)
	{
		DamageState(2);
		CASE2_TRIGGERED = true;
	}
}

if (health < 300 && health > 250)
{
	if (!CASE3_TRIGGERED)
	{
		DamageState(3);
		CASE3_TRIGGERED = true;
	}
}

if (health < 1)
{
	if (!CASE4_TRIGGERED)
	{
		DamageState(4);
		CASE4_TRIGGERED = true;
	}
}


}

function DamageState( state )
{

	switch ( state )
	{
		case 1: 
		{
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(220)", 0 );
			break;
		}
		case 2:
		{
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(221)", 0 );
			break;
		}
		case 3:
		{
			//EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(222)", 0 );
			break;
		}
		case 4:
		{
			TankDeath();
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(222)", 1 );
			EntFire ( "@coopscript","RunScriptCode", "TheEnd()", 4 );
			break;
		}
		case 5:
		{
			// teehee, im useless
			break;
		}
	}

}

function Think()
{

TIME = Time();



	if (TARGET != null)
	{
	
		if (CheckPlayerVis(TARGET))
		{
			if (CheckBarrelVis(TARGET))
			{
			Shoot();
			FORGET = 0;
			}
		}
		else
		{
			if (FORGET == 0)
			{
			FORGET = TIME + FORGETTIME;
			}
		}

	}
	
if (TIME > FORGET && FORGET != 0 && TARGET != null)
{
TARGET = null;
FORGET = 0;
}


}

function TankEnable()		// start searching for targets
{

EntFire ( "@tank.triggercycle.timer","Enable", "", 0 );

}

function TankDisable()		// stop searching for targets
{
EntFire ( "@tank.triggercycle.timer","Disable", "", 0 );
EntFire ( "@tank.triggercycle","CancelPending", "", 0 );
}

function TankDeath()
{

TankDisable();
TARGET = null;

EntFire ( "@tank.expl1","FireUser1", "", 0 );
EntFire ( "@tank.expl2","FireUser1", "", 0.1 );
EntFire ( "@tank.expl3","FireUser1", "", 0.4 );
EntFire ( "@tank.expl4","FireUser1", "", 0.6 );
EntFire ( "@tank.expl5","FireUser1", "", 0.9 );
EntFire ( "@tank.expl6","FireUser1", "", 1.1 );
EntFire ( "@tank.expl7","FireUser1", "", 1.4 );		// on turret

EntFire ( "@tank.fire1","StartFire", "", 1 );		// on turret
EntFire ( "@tank.fire2","StartFire", "", 0.5 );
EntFire ( "@tank.fire3","StartFire", "", 1.3 );
EntFire ( "@tank.fire4","StartFire", "", 1.4 );

EntFire ( "@tank.gibshoot1","Shoot", "", 0.4 );
EntFire ( "@tank.gibshoot2","Shoot", "", 0.9 );
EntFire ( "@tank.gibshoot3","Shoot", "", 1.4 );

EntFire ( "@tank.turret_destroyed","Trigger", "", 1.5 );	// swap turret models
}

function Shoot()
{

	if (COOLDOWN < TIME)
	{
	EntFire ( "@tank.shoot","Trigger", "", 0 );
	COOLDOWN = TIME + COOLDOWNTIME;
	}
		else
		{
		//printl ("were on cooldown till " + COOLDOWN + " , current time is " + TIME);
		}

}

function SetTarget()
{

	//printl (activator);

	if (TARGET == null)
	{
	TARGET = activator;
	}
	else
	{
	//printl ("already got a target, ignoring..");
	}

}

function ForceNoTarget()
{

TARGET = null;
FORGET = 0;

}

function CheckPlayerVis( target )		// is the player behind cover
{

local vecmin = Vector(-2, -2, -2);
local vecmax = Vector (2, 2, 2);

local start = SPOTTER.GetCenter();
//local end =  target.GetCenter();
local end =  target.EyePosition();

//DebugDrawLine(start, end, 255, 0, 0, true, 0.1);

local progress = TraceLinePlayersIncluded (start, end, null);

local hit = start + ( end -  start ) * progress;

local TraceHit = Entities.FindByClassnameWithin(null, "player", hit, 16);

	if (TraceHit != null)
	{
	//	DebugDrawBox(hit, vecmin, vecmax, 0, 255, 0, 150, 0.1)
		LASTSEEN = hit;
		AIMPOINT.SetAbsOrigin(LASTSEEN);
		return true;
	}
	else
	{
	//	DebugDrawBox(hit, vecmin, vecmax, 255, 0, 0, 150, 0.1)
	//	DebugDrawBox(LASTSEEN, vecmin, vecmax, 255, 255, 0, 150, 0.1)
		return false;
	}

}

function CheckBarrelVis( target )	// is the barrel on target
{

local vecmin = Vector(-2, -2, -2);
local vecmax = Vector (2, 2, 2);

local start = TANK.GetCenter();
local rotationvec = TANK.GetForwardVector();

rotationvec.Norm();

local end =  start + ( rotationvec * 1000 );

local progress = TraceLinePlayersIncluded (start, end, null);

local hit = start + ( end -  start ) * progress;

local TraceHit = Entities.FindByClassnameWithin(null, "player", hit, 16);

	if (TraceHit != null)
	{
	//	printl ("barrel is on player");
	//	DebugDrawBox(hit, vecmin, vecmax, 0, 255, 0, 150, 0.1)
	//	DebugDrawLine(start, end, 0, 255, 0, true, 0.1);
		return true;
	}
	else
	{
	//	printl ("barrel is not on player");
	//	DebugDrawBox(hit, vecmin, vecmax, 255, 0, 0, 150, 0.1)
	//	DebugDrawLine(start, end, 255, 0, 0, true, 0.1);
		return false;
	}

}
