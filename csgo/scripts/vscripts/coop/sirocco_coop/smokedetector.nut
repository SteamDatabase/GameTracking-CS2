// detect smoke grenade projectiles and fireuser1 on self when found

SmokeGrenadeDetectorActive <- false;

SND_FIRE_EXTINGUISH <- "weapons/molotov/molotov_extinguish.wav";
SND_SMOKEGRENADE_DEPLOY <- "weapons/smokegrenade/sg_explode.wav";


function Precache()
{
	self.PrecacheScriptSound( SND_FIRE_EXTINGUISH );
	self.PrecacheScriptSound( SND_SMOKEGRENADE_DEPLOY );

}

function Think()
{

	if (SmokeGrenadeDetectorActive == true)
	{
	FindAndDeleteSmokeGrenade();
	//printl (self.GetName() + " is active and thinking");
	}

}

function Enable()
{
SmokeGrenadeDetectorActive = true;
}

function Disable()
{
SmokeGrenadeDetectorActive = false;
}

function FindAndDeleteSmokeGrenade()
{

	if (SmokeGrenadeDetectorActive == true)
	{

	local origin = self.GetOrigin();
	local grenade = null;
	
		while( ( grenade = Entities.FindByClassnameWithin (grenade, "smokegrenade_projectile", origin, 64.00) ) != null )
			{
			//printl ("Found a smokegrenade");
			
			grenade.Destroy();
			
			self.EmitSound (SND_FIRE_EXTINGUISH);
			self.EmitSound (SND_SMOKEGRENADE_DEPLOY);
			
			DispatchParticleEffect( "explosion_basic", origin, origin );
			
			EntFire( "!self", "FireUser1", "", 0 );		// fire whatever is hooked up to fireuser1 on owner entity 
			
			SmokeGrenadeDetectorActive = false;
			
			break;
			}
	}
}