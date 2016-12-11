"Resource/UI/SpawnModeMenu.res" //Dialogue that comes up when you enter Spawn Select Mode
{
	"spawnmode"
	{
		"ControlName"		"Frame"
		"fieldName"			"spawnmode"
		"xpos"				"c-180"
		"ypos"				"c10"
		"wide"				"360"
		"tall"				"155"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"padding"			"4"
		
		"if_split_screen_bottom"
		{
			"ypos"		"c-50"
		}
		
		"if_split_screen_top"
		{
			"ypos"		"c-65"
		}
	}
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
	"Background"
	{
		"ControlName"			"Panel"
		"fieldName"				"Background"
		"xpos"					"0"
		"ypos"					"0"
		"zpos"					"0"
		"wide"					"360"
		"tall"					"205"
		"visible"				"0"
		"enabled"				"1"
		"PaintBackgroundType"	"2"
		"bgcolor_override"		"0 0 0 245"
	}	
	"ModeTitle"
	{
		"ControlName"		"Label"
		"fieldName"			"ModeTitle"
		"xpos"				"30"
		"ypos"				"34"
		"zpos"				"1"
		"wide"				"300"
		"tall"				"50"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_spawn_select_mode_title"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"font"				"FrameTitle"
		"wrap"				"1"
	}
	"SpawnModeOneText"
	{
		"ControlName"		"Label"
		"fieldName"			"SpawnModeOneText"
		"xpos"				"30"
		"ypos"				"56"
		"zpos"				"1"
		"wide"				"300"
		"tall"				"45"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_spawn_select_mode_text_1"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"wrap"				"1"
		"font"				"Default"
	}
	"ContinueBind"
	{
		"ControlName"	"CBindPanel"
		"fieldName"		"ContinueBind"
		"xpos"			"100"
		"ypos"			"111" [$WIN32]
		"ypos"			"115" [$X360]
		"zpos"			"2"
		"visible"		"1"
		"enabled"		"1"
		"bind"			"+attack" 
	}		
	"ContinueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"ContinueLabel"
		"xpos"				"10"
		"ypos"			    "111" [$WIN32]
		"ypos"			    "115" [$X360]
		"zpos"				"2"
		"wide"				"10"
		"tall"				"25"
		"visible"			"1"
		"enabled"			"1"
		"textAlignment"		"west"	
		"labelText"			"#L4D_btn_continue"
		"font"				"DefaultMedium" [$WIN32]
		"font"				"DefaultLarge" [$X360]
		"wrap"				"0"
		"fgcolor_override"		"231 231 231 255"
		"auto_wide_tocontents"	"1"
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
