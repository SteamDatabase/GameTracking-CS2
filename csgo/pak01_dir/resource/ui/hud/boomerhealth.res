"Resource/UI/HUD/BoomerHealth.res"
{
	// HudLayout has size/position of HudZombieHealth panel this is part of

	"Health"
	{
		"ControlName"	"HealthPanel"
		"fieldName"		"Health"
		"xpos"			"322"
		"ypos"			"69"
		"wide"			"64"
		"tall"			"13"
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"1"
	}

	"HealthNumber"
	{
		"ControlName"	"Label"
		"fieldName"		"HealthNumber"
		"xpos"			"335"
		"ypos"			"49"
		"wide"			"50"
		"tall"			"20"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%HealthNumber%"
		"textAlignment"	"south-east"
		"font"			"MenuTitle"
		"zpos"			"2"
	}

	"BackgroundImage"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"			"320"
		"ypos"			"0"
		"wide"			"100"
		"tall"			"100"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"HUD/PZ_healthbar_50"
		"zpos"			"-2"
	}
	
	"DuckingIcon"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"DuckingIcon"
		"xpos"			"320"
		"ypos"			"42"
		"wide"			"25"
		"tall"			"25"
		"zpos"			"2"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"image"			"hud/crouch_infected"
	}
}