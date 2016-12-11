"Resource/UI/SpawnBoomerMenu.res"
{
	"spawn_boomer"
	{
		"ControlName"	"Frame"
		"fieldName"		"spawn_boomer"
		"xpos"			"c-180"
		"ypos"			"c-120"
		"wide"			"360"
		"tall"			"265"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"padding"		"2"
		
		"if_split_screen_top"
		{
			"ypos"		"c-134"
		}
		
		"if_split_screen_bottom"
		{
			"ypos"		"c-135"
		}
		
		"if_split_screen_left"
		{
			"xpos"		"c-160"
		}
		
		"if_split_screen_right"
		{
			"xpos"		"c-187"
		}
	}
	"BackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"			"0"
		"ypos"			"29"
		"wide"			"340"
		"tall"			"205"		
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
		"xpos"				"0"
		"ypos"				"29"
		"wide"				"340"
		"tall"				"205"
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
		"wide"					"350"
		"tall"					"205"
		"visible"				"0"
		"enabled"				"1"
		"PaintBackgroundType"	"2"
		"bgcolor_override"		"0 0 0 245"
	}	
	
	"InfectedClass"
	{
		"ControlName"	"Label"
		"fieldName"		"InfectedClass"
		"xpos"			"30"
		"ypos"			"34"
		"zpos"			"1"
		"wide"			"170"
		"tall"			"20"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_spawn_select_mode_class_BOOMER"
		"textAlignment"	"north-west"
		"dulltext"		"0"
		"brighttext"	"0"
		"font"			"FrameTitle"
	}
	"ActionPrimaryLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"ActionPrimaryLabel"
		"xpos"			"30"
		"ypos"			"57"
		"zpos"			"2"
		"wide"			"130"
		"tall"			"12"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"labelText"		"#L4D_spawn_select_mode_boomer_1_title" [$WIN32]
		"labelText"		"#L4D_spawn_select_mode_boomer_2_title" [$X360]
		"textAlignment"	"center"
		"dulltext"		"0"
		"brighttext"	"0"
		"Font"			"default"
		"wrap"			"0"
	}
	"ActionSecondaryLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"ActionSecondaryLabel"
		"xpos"			"180"
		"ypos"			"57"
		"zpos"			"2"
		"wide"			"130"
		"tall"			"12"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"labelText"		"#L4D_spawn_select_mode_boomer_2_title" [$WIN32]
		"labelText"		"#L4D_spawn_select_mode_boomer_1_title" [$X360]
		"textAlignment"	"center"
		"dulltext"		"0"
		"brighttext"	"0"
		"Font"			"default"
		"wrap"			"0"
	}
	"PrimaryFrame"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"PrimaryFrame"
		"xpos"			"45"
		"ypos"			"69"
		"zpos"			"1"
		"wide"			"100"
		"tall"			"100"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineGrey"
		
		"src_corner_height"		"8"				// pixels inside the image
		"src_corner_width"		"8"
			
		"draw_corner_width"		"4"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"4"	
	}
	"PrimaryIcon"
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"PrimaryIcon"
		"icon"				"tip_boomer_vomit" [$WIN32]
		"icon"				"tip_boomer_swipe" [$X360]
		"xpos"				"50"
		"ypos"				"74"
		"zpos"				"2"
		"wide"				"90"
		"tall"				"90"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"scaleimage"		"1"
		"iconcolor"			"255 255 255 255"
	}
	"MeleeFrame"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"MeleeFrame"
		"xpos"			"195"
		"ypos"			"69"
		"zpos"			"1"
		"wide"			"100"
		"tall"			"100"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineGrey"
		
		"src_corner_height"		"8"				// pixels inside the image
		"src_corner_width"		"8"
			
		"draw_corner_width"		"4"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"4"	
	}
	"MeleeIcon"
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"MeleeIcon"
		"icon"				"tip_boomer_swipe" [$WIN32]
		"icon"				"tip_boomer_vomit" [$X360]
		"xpos"				"200"
		"ypos"				"74"
		"zpos"				"2"
		"wide"				"90"
		"tall"				"90"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"scaleimage"		"1"
		"iconcolor"			"255 255 255 255"
	}
	
	"ActionOneLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"ActionOneLabel"
		"xpos"			"35"
		"ypos"			"165"
		"zpos"			"1"
		"wide"			"135"
		"tall"			"44"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"labelText"		"#L4D_spawn_select_mode_boomer_1_text" [$WIN32]
		"labelText"		"#L4D_spawn_select_mode_boomer_2_text" [$X360]
		"textAlignment"	"west"
		"dulltext"		"0"
		"brighttext"	"0"
		"Font"			"default"
		"wrap"			"1"
	}
		
	"ActionOneBind"
	{
		"ControlName"			"CBindPanel"
		"fieldName"				"ActionOneBind"
		"xpos"					"0"
		"ypos"					"-10"
		"zpos"					"2"
		"visible"				"1"
		"enabled"				"1"
		"fgcolor_override"      "127 127 127 255"
		"scale"                 "1.0"
		"bind"					"+attack" [$WIN32]
		"bind"					"+attack2" [$X360]
	
		"pin_to_sibling"		"ActionOneLabel"
		"pin_corner_to_sibling"	"1"
		"pin_to_sibling_corner"	"0"
	}
	
	"ActionTwoLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"ActionTwoLabel"
		"xpos"			"190"
		"ypos"			"165"
		"zpos"			"1"
		"wide"			"145"
		"tall"			"44"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"labelText"		"#L4D_spawn_select_mode_boomer_2_text" [$WIN32]
		"labelText"		"#L4D_spawn_select_mode_boomer_1_text" [$X360]
		"textAlignment"	"west"
		"dulltext"		"0"
		"brighttext"	"0"
		"Font"			"default"
		"wrap"			"1"
	}	
	
	"ActionTwoBind"
	{
		"ControlName"			"CBindPanel"
		"fieldName"				"ActionTwoBind"
		"xpos"					"0"
		"ypos"					"-10"
		"zpos"					"2"
		"visible"				"1"
		"enabled"				"1"
		"fgcolor_override"      "127 127 127 255"
		"scale"                 "1.0"
		"bind"					"+attack2" [$WIN32]
		"bind"					"+attack" [$X360]
	
		"pin_to_sibling"		"ActionTwoLabel"
		"pin_corner_to_sibling"	"1"
		"pin_to_sibling_corner"	"0"
	}	
	
	"ContinueBind"
	{
		"ControlName"	"CBindPanel"
		"fieldName"		"ContinueBind"
		"xpos"			"30"
		"ypos"			"204"
		"zpos"			"2"
		"visible"		"1"
		"enabled"		"1"
		"bind"			"+attack" 
	}		
	"ContinueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"ContinueLabel"
		"xpos"				"30"
		"ypos"				"204"
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
		"auto_wide_tocontents"	"1"
	}	
	"Splatter1"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Splatter1"
		"xpos"				"-10"
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
	"Splatter2"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Splatter2"
		"xpos"				"-15"
		"ypos"				"180"
		"wide"				"80"
		"tall"				"80"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter2"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
	
	"Splatter3"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Splatter3"
		"xpos"				"30"
		"ypos"				"177"
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
		"ypos"				"-7"
		"wide"				"80"
		"tall"				"80"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter_corner_upper_right"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
	"Splatter5"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Splatter5"
		"xpos"				"340"
		"ypos"				"76"
		"wide"				"40"
		"tall"				"80"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter_vertical_right"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
		
	"Splatter6"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Splatter6"
		"xpos"				"193"
		"ypos"				"232"
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
