"Resource/UI/HudGhostPanel.res"
{
	"BackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"			"20"
		"ypos"			"29"
		"wide"			"319"
		"tall"			"80"		
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack50_outlineGrey"
		"drawcolor"		"255 64 64 255"
		"src_corner_height"		"16"			// pixels inside the image
		"src_corner_width"		"16"
		"draw_corner_width"		"3"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"3"	
	}
	"BackgroundFill"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"BackgroundFill"
		"xpos"				"20"
		"ypos"				"29"
		"wide"				"319"
		"tall"				"80"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"fillcolor" 		"0 0 0 235"
		"zpos"				"-2"
	}
	"ClassImage"
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"ClassImage"
		"xpos"				"21"
		"ypos"				"30"
		"zpos"				"1"
		"wide"				"78"
		"tall"				"78"
		"visible"			"1"
		"enabled"			"1"
		"scaleImage"		"1"
		"image"				"tip_boomer"
	}
	"ClassName"
	{
		"ControlName"		"Label"
		"fieldName"			"ClassName"
		"xpos"				"105"
		"ypos"				"34"
		"zpos"				"1"
		"wide"				"230"
		"tall"				"18"
		"visible"			"1"
		"enabled"			"1"
		"textAlignment"		"west"	
		"labelText"			"%classname%"
		"font"				"FrameTitle"
		"wrap"				"0"
	}
	"SelectSpawn"
	{
		"ControlName"		"Label"
		"fieldName"			"SelectSpawn"
		"xpos"				"105"
		"ypos"				"53"
		"zpos"				"1"
		"wide"				"230"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"textAlignment"		"west"	
		"labelText"			"#L4D_spawn_select_mode_title"
		"font"				"DefaultMedium" [$WIN32]
		"font"				"Default" [$X360]
		"wrap"				"0"
	}
	"Ready"
	{
		"ControlName"		"Label"
		"fieldName"			"Ready"
		"xpos"				"105"
		"ypos"				"69"
		"zpos"				"1"
		"wide"				"240"
		"tall"				"30"
		"visible"			"1"
		"enabled"			"1"
		"textAlignment"		"north-west"	
		"labelText"			"%ready%"
		"font"				"DefaultMedium" [$WIN32]
		"font"				"Default" [$X360]
		"wrap"				"1"
	}
	"Info"
	{
		"ControlName"		"Label"
		"fieldName"			"Info"
		"xpos"				"105"
		"ypos"				"79"
		"zpos"				"1"
		"wide"				"230"
		"tall"				"30"
		"visible"			"1"
		"enabled"			"1"
		"textAlignment"		"west"	
		"labelText"			"%info%"
		"font"				"DefaultMedium" [$WIN32]
		"font"				"Default" [$X360]
		"wrap"				"1"
	}
	"SpawnBind"
	{
		"ControlName"	"CBindPanel"
		"fieldName"		"SpawnBind"
		"xpos"			"105"
		"ypos"			"80" [$WIN32]
		"ypos"			"115" [$X360]
		"zpos"			"2"
		"visible"		"1"
		"enabled"		"1"
	}		
	"SpawnLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"SpawnLabel"
		"xpos"				"115"
		"ypos"				"75" [$WIN32]
		"ypos"			    "110" [$X360]
		"zpos"				"1"
		"wide"				"230"
		"tall"				"25"
		"visible"			"1"
		"enabled"			"1"
		"textAlignment"		"west"	
		"labelText"			"#L4D_Zombie_UI_Press_Fire_To_Play"
		"font"				"DefaultMedium" [$WIN32]
		"font"				"DefaultLarge" [$X360]
		"wrap"				"1"
		"fgcolor_override"		"231 231 231 255"
	}
	"Splatter1"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Splatter1"
		"xpos"				"0"
		"ypos"				"10"
		"wide"				"100"
		"tall"				"60"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter1"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
	
	"Splatter3"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Splatter3"
		"xpos"				"36"
		"ypos"				"55"
		"wide"				"80"
		"tall"				"80"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter3"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
	
	"Splatter4"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Splatter4"
		"xpos"				"277"
		"ypos"				"-8"
		"wide"				"80"
		"tall"				"80"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter_corner_upper_right"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
		
	"Splatter6"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Splatter6"
		"xpos"				"193"
		"ypos"				"109"
		"wide"				"110"
		"tall"				"30"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter_horizontal_bottom"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
}
