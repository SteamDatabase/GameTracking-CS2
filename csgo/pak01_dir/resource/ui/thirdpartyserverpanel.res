"Resource/UI/ThirdPartyServerPanel.res"
{
	"BackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"300"
		"tall"			"130"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineGrey"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
		
		"if_embedded"
		{
			"visible"	"0"
		}
	}

	"ServerTitle"
	{
		"ControlName"		"Label"
		"fieldName"		"ServerTitle"
		"xpos"		"13"
		"ypos"		"11"
		"wide"		"300"
		"tall"		"24"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_ThirdPartyTitle"
		"textAlignment"		"north-west"
		"dulltext"		"0"
		"brighttext"		"0"
		"font"		"MenuTitle"
		"fgcolor_override"	"White"
	}

	"HostnameLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"HostnameLabel"
		"xpos"			"20"
		"ypos"			"35"
		"wide"			"314"
		"tall"			"20"
		"zpos"		"1"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"labelText"		"%hostname%"
		"textAlignment"		"center"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle"
		"fgcolor_override"	"MediumGray"
	}
	
	"TerrorTextMessage"
	{
		"ControlName"	"CTerrorRichText"
		"fieldName"		"TerrorTextMessage"
		"xpos"			"20"
		"ypos"			"32"
		"wide"			"314"
		"tall"			"45"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"textAlignment"	"northwest"
		"textHidden"	"0"
		"editable"		"0"
		"maxchars"		"-1"
	}
	
	"HTMLMessage"
	{
		"ControlName"	"HTML"
		"fieldName"		"HTMLMessage"
		"xpos"			"15"
		"ypos"			"32"
		"wide"			"270"
		"tall"			"55"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
	}

	"RankLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"RankLabel"
		"xpos"		"13"
		"ypos"		"90"
		"wide"		"220"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Server_Rank"
		"textAlignment"		"north-west"
		"dulltext"		"1"
		"brighttext"		"0"
		"fgcolor_override"	"White"
		"auto_wide_tocontents"	"1"
	}	
	
	"RankAmount"
	{
		"ControlName"		"Label"
		"fieldName"		"RankAmount"
		"xpos"		"10"
		"ypos"		"0"
		"wide"		"20"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%rank%"
		"textAlignment"		"north-west"
		"dulltext"		"1"
		"brighttext"		"0"
		"fgcolor_override"	"MediumGray"
		"auto_wide_tocontents"	"1"
		
		"pin_to_sibling"		"RankLabel"
		"pin_corner_to_sibling"	"0"
		"pin_to_sibling_corner"	"1"
	}	
	
	"PlayerCountLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"PlayerCountLabel"
		"xpos"		"13"
		"ypos"		"105"
		"wide"		"220"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Server_Player_Count"
		"textAlignment"		"north-west"
		"dulltext"		"1"
		"brighttext"		"0"
		"fgcolor_override"	"White"
		"auto_wide_tocontents"	"1"
	}	
	
	"PlayerCountAmount"
	{
		"ControlName"		"Label"
		"fieldName"		"PlayerCountAmount"
		"xpos"		"10"
		"ypos"		"0"
		"wide"		"220"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%playercount%"
		"textAlignment"		"north-west"
		"dulltext"		"1"
		"brighttext"		"0"
		"fgcolor_override"	"MediumGray"
		
		"pin_to_sibling"		"PlayerCountLabel"
		"pin_corner_to_sibling"	"0"
		"pin_to_sibling_corner"	"1"
	}	
}
