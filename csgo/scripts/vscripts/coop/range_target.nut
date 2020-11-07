///////
///////
/////// 

m_targFrame <- EntityGroup[0]
m_targBase <- EntityGroup[1]
m_number <- 0;


function Precache()
{
	self.PrecacheScriptSound( "coop.HitRangeTarget_Red" );
	self.PrecacheScriptSound( "coop.HitRangeTarget_Blue" );
}

function OnPostSpawn()
{
	EntFire ( m_targFrame.GetName(),"Open", "", 0.2 );
	//printl("---------------OnPostSpawn()");

	local spawner = Entities.FindByClassnameNearest("env_entity_maker", self.GetOrigin(), 128); 	

	if ( spawner )
	{
		//printl("---------------spawner name = "+spawner.GetName()+"\n"+spawner);
		local scope = spawner.GetScriptScope();
		//printl( spawner.GetName().find( "number" ) );

		local a = split(spawner.GetName(),"_");
		foreach(i,val in a )
		{
			m_number = val;
		}
		//printl("---------------m_number = "+m_number );
	}
	else
	{
		//printl("---------------DIDNT FIND SPAWNER!");	
	}
}

function OnShot( color )
{
	EntFire ( m_targFrame.GetName(),"Close", "", 0.0 );
	//EntFire ( m_targFrame.GetName(),"Kill", "", 0.5 );

	EntFire ( "@script_shooting_range","RunScriptCode", "OnTargetShot( "+color+", "+m_number+" )", 0.0 );
	//OnTargetShot( color, m_number );

	if ( color == 0 )
		m_targBase.EmitSound( "coop.HitRangeTarget_Blue" );
	else if ( color == 1 )
		m_targBase.EmitSound( "coop.HitRangeTarget_Red" );
}

