// remove any ragdolls in radius

ACTIVE <- false;



function Think()
{

	if (ACTIVE == true)
	{
	FindAndRemoveRagdolls();
	//printl (self.GetName() + " is active and thinking");
	}

}

function Enable()
{
ACTIVE = true;
}

function Disable()
{
ACTIVE = false;
}

function FindAndRemoveRagdolls()
{

	if (ACTIVE == true)
	{

	local origin = self.GetOrigin();
	local ragdoll = null;
	
		while( ( ragdoll = Entities.FindByClassnameWithin (ragdoll, "cs_ragdoll", origin, 256.00) ) != null )
			{
			//printl ("Found a ragdoll");
			
			ragdoll.Destroy();
			}
	}
}