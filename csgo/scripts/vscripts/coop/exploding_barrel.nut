BARREL_TOP <- "models/props/coop_cementplant/exloding_barrel/exploding_barrel_top.mdl";
EXPLODE_SND1 <- "BaseGrenade.Explode";
EXPLODE_SND2 <- "Inferno.Start_IncGrenade";
START_FADEOUT_AT <- 6;
TIME_TO_FADE <- 2;

m_fExplodedAt			<- -1;

m_BarrelMain		<- EntityGroup[0];
m_BarrelBottom		<- EntityGroup[1];
m_Explosion			<- EntityGroup[2]; 
m_Thrust			<- EntityGroup[3]; 
m_ParticleExplosion	<- EntityGroup[4]; 
m_ParticleBarrel	<- EntityGroup[5]; 

function Precache()
{
	//printl( "<---------------------------PRECACHE SCRIPT" );	
	self.PrecacheModel( BARREL_TOP );
	self.PrecacheScriptSound( EXPLODE_SND1 );
	self.PrecacheScriptSound( EXPLODE_SND2 );
}

function BarrelThink()
{
	if ( m_fExplodedAt == -1 )
		return;

	if ( (m_fExplodedAt + START_FADEOUT_AT) <= Time() )
	{
		local flFrac = 1-((Time() - (m_fExplodedAt + START_FADEOUT_AT)) / TIME_TO_FADE);
		local alpha = flFrac*255;
		m_BarrelMain.__KeyValueFromInt("rendermode", 1);
		m_BarrelMain.__KeyValueFromInt("renderamt", alpha);
	}

	if ( (m_fExplodedAt + START_FADEOUT_AT + TIME_TO_FADE) <= Time() )
	{
		m_fExplodedAt = -1;
		EntFire( m_BarrelMain.GetName(), "Kill", "", 0 ); 
	}
}

function OnTakeDamage()
{
	m_fExplodedAt = Time();

	m_BarrelMain.SetModel( BARREL_TOP );

	//printl( "<---------------------------hBarrelTop name = "+hBarrelTop.GetName() );	

	EntFire( m_BarrelMain.GetName(), "EnableMotion", "", 0 );
	m_BarrelMain.__KeyValueFromInt("spawnflags", 1540);

	m_BarrelBottom.EmitSound( EXPLODE_SND1 );
	m_BarrelBottom.EmitSound( EXPLODE_SND2 );

	EntFire( m_ParticleExplosion.GetName(), "Start", "", 0 );
	EntFire( m_ParticleBarrel.GetName(), "Start", "", 0 );
	EntFire( m_Thrust.GetName(), "Activate", "", 0.01 );
	EntFire( m_BarrelBottom.GetName(), "Enable", "", 0 );

	EntFire( m_Explosion.GetName(), "Explode", "", 0 );

	EntFire( m_ParticleBarrel.GetName(), "Stop", "", 2.5 );
}

