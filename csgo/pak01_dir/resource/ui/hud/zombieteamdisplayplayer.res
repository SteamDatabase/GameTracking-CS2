"Resource/UI/HUD/ZombieTeamDisplayPlayer.res"
{
	"BackgroundImage"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"			"0"
		"ypos"			"10"
		"wide"			"128"
		"tall"			"64"
		"zpos"			"-1"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"drawColor"		"64 64 64 255"
		"image"			"hud/infected_healthbar_bg_1"
	}
	
	"ZombieTeamDisplayPlayer"
	{
		"ControlName"	"Panel"
		"fieldName"		"ZombieTeamDisplayPlayer"
		"wide"			"256"
		"tall"			"128"
		"visible"		"1"
		"enabled"		"1"
	}
	
	"NameLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"NameLabel"
		"xpos"			"13"
		"ypos"			"55"
		"wide"			"120"
		"tall"			"12"
		"visible"		"1"
		"enabled"		"1"
		"textAlignment"	"west"
		
		"font"			"PlayerDisplayName"
		"zpos"			"3"
		"fgcolor_override" "255 255 255 255"
	}
	
	"SpawnTimeLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"SpawnTimeLabel"
		"xpos"			"39"
		"ypos"			"40"
		"wide"			"55"
		"tall"			"12"
		"zpos"			"1"
		"visible"		"1"
		"enabled"		"1"
		"textAlignment"	"west"
		"font"			"PlayerDisplayName"
		"zpos"			"3"
		"fgcolor_override" "255 255 255 255"
	}
	
	"HealthPanel"
	{
		"ControlName"	"HealthPanel"
		"fieldName"		"HealthPanel"
		"xpos"			"38"
		"ypos"			"41"
		"wide"			"86"
		"tall"			"12"
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"1"
	}
	
	"Dead"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"Dead"
		"xpos"			"0"
		"ypos"			"18"
		"wide"			"256"
		"tall"			"0"
		"zpos"			"3"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"image"			"hud/overlay_dead"
	}
	
	"SkullIconPlacement"
	{
		"ControlName"	"Panel"
		"fieldName"		"SkullIconPlacement"
		"xpos"			"8"
		"ypos"			"24"
		"wide"			"24"
		"tall"			"24"
		"visible"		"1"
		"enabled"		"1"
	}
	
	"PlayerImage"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"PlayerImage"
		"xpos"			"9"
		"ypos"			"23"
		"wide"			"24"
		"tall"			"24"
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"3"
		"fgcolor_override" "255 255 255 255"
	}
	
	"Voice"
	{
		"ControlName"	"Panel"
		"fieldName"		"Voice"
		"xpos"			"38"
		"ypos"			"14"
		"wide"			"16"
		"tall"			"16"
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"3"
		"voice_icon"	"voice_player"
	}
		
	"AbilityProgress"
	{
		"ControlName"	"CircularProgressBar"
		"fieldName"		"AbilityProgress"
		"xpos"			"2"
		"ypos"			"18"
		"wide"			"36"
		"tall"			"36"
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"2"
		"fg_image"		"HUD/PZ_charge_meter"
		"bgcolor_override"	"0 0 0 0"
		
		"progress"		"0.75"
	}
}