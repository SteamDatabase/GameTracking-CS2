"Resource/UI/ZombiePanel.res"
{
	"TooFarFromSurvivors"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"TooFarFromSurvivors"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"1"
		"wide"			"400"
		"tall"			"155" [$WIN32]
		"tall"			"155" [$X360]
		"visible"		"0"
		"enabled"		"1"
		
		"TooFarTitle"
		{
			"ControlName"	"Label"
			"fieldName"		"TooFarTitle"
			"xpos"			"105"
			"ypos"			"34"
			"zpos"			"1"
			"wide"			"220"
			"tall"			"35" [$WIN32]
			"tall"			"42" [$X360]
			"visible"		"1"
			"enabled"		"1"
			"textAlignment"	"west"	
			"labelText"		"#L4D_Zombie_UI_Too_Far"
			"font"				"FrameTitle"
			"fgcolor_override"	"192 192 192 255"
			"wrap"			"1"
		}
		"TooFarText"
		{
			"ControlName"	"Label"
			"fieldName"		"TooFarText"
			"zpos"			"1"
			"xpos"			"130"
			"ypos"			"70" [$WIN32]
			"tall"			"40" [$WIN32]
			"ypos"			"108" [$X360]
			"tall"			"40" [$X360]
			"wide"			"200"
			"visible"		"1"
			"enabled"		"1"
			"textAlignment"	"west"	
			"labelText"		"#L4D_Zombie_UI_To_Be_Moved"
			"font"				"DefaultMedium" [$WIN32]
			"font"				"DefaultLarge" [$X360]
			"fgcolor_override"	"231 231 231 255"
			"wrap"			"1"
		}	
		"SurvivorsImage"
		{
			"ControlName"	"CIconPanel"
			"fieldName"		"SurvivorsImage"
			"xpos"			"21"
			"ypos"			"30"
			"zpos"			"1"
			"wide"			"78"
			"tall"			"78"
			"visible"		"1"
			"enabled"		"1"
			"scaleImage"	"1"
			"image"			"Stat_vs_Most_Damage_Done"
		}
		"UseBind"
		{
			"ControlName"	"CBindPanel"
			"fieldName"		"UseBind"
			"xpos"			"105"
			"ypos"			"77" [$WIN32]
			"ypos"			"115" [$X360]
			"zpos"			"1"
			"visible"		"1"
			"enabled"		"1"
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
	
	"TankTakeover"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"TankTakeover"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"1"
		"wide"			"400"
		"tall"			"155" [$WIN32]
		"tall"			"155" [$X360]
		"visible"		"0"
		"enabled"		"1"
		
		"Title"
		{
			"ControlName"	"Label"
			"fieldName"		"Title"
			"xpos"			"105"
			"ypos"			"30"
			"zpos"			"1"
			"wide"			"220"
			"tall"			"35" [$WIN32]
			"tall"			"42" [$X360]
			"visible"		"1"
			"enabled"		"1"
			"textAlignment"	"west"	
			"labelText"		"%tanktitle%"
			"font"				"FrameTitle"
			"fgcolor_override"	"192 192 192 255"
			"wrap"			"1"
		}
		"Text"
		{
			"ControlName"	"Label"
			"fieldName"		"Text"
			"xpos"			"105"
			"ypos"			"64"
			"zpos"			"1"
			"wide"			"150"
			"tall"			"40"
			"visible"		"1"
			"enabled"		"1"
			"textAlignment"	"west"	
			"labelText"		"%tanktext%"
			"font"				"DefaultMedium" [$WIN32]
			"font"				"Default" [$X360]
			"fgcolor_override"	"192 192 192 255"
			"wrap"			"1"
		}	
		"TankImage"
		{
			"ControlName"	"CIconPanel"
			"fieldName"		"TankImage"
			"xpos"			"21"
			"ypos"			"30"
			"zpos"			"1"
			"wide"			"78"
			"tall"			"78"
			"visible"		"1"
			"enabled"		"1"
			"scaleImage"	"1"
			"icon"			"tip_tank"
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
}