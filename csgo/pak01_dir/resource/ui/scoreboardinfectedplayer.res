"Resource/UI/ScoreBoardInfectedPlayer.res"
{
	"Avatar"
	{
		"ControlName"		"DontAutoCreate"
		"fieldName"		"Avatar"
		"xpos"		"2"
		"ypos"		"16"
		"zpos"		"1"
		"wide"		"16"
		"tall"		"16"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"autoresize"	"3"
		"color_outline"	"0 0 0 0"
	}
	"Name"
	{
		"ControlName"		"Label"
		"fieldName"		"Name"
		"xpos"		"4"		[$X360]
		"xpos"		"20"	[$WIN32]
		"ypos"		"19"
		"zpos"		"1"
		"wide"		"230"	[$X360]
		"wide"		"132"	[$WIN32]
		"tall"		"18"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"		"north-west"
		"dulltext"		"0"
		"brighttext"	"1"
		"font"		"DefaultMedium"
		"noshortcutsyntax"		"1"
	}
	"NoAvatarName"	/// apparently not used on xbox.
	{
		"ControlName"		"Label"
		"fieldName"		"NoAvatarName"
		"xpos"		"4"
		"ypos"		"19"
		"zpos"		"1"
		"wide"		"230"
		"tall"		"18"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"		"north-west"
		"dulltext"		"0"
		"brighttext"	"1"
		"font"		"DefaultMedium"
		"noshortcutsyntax"		"1"
	}
	"Status"
	{
		"ControlName"		"Label"
		"fieldName"		"Status"
		"font"			"BodyText_small"
		"labelText"		""
		"textAlignment"		"north-west"
		"xpos"			"182"
		"ypos"			"19"
		"zpos"			"1"
		"wide"			"95"
		"tall"			"18"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
	}
	"Score"
	{
		"ControlName"		"Label"
		"fieldName"		"Score"
		"xpos"		"140"	[$X360]
		"xpos"		"150"	[$WIN32]
		"ypos"		"0"
		"wide"		"78"
		"tall"		"49"
		"zpos"		"1"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%score%"
		"textAlignment"		"west"
		"dulltext"		"0"
		"brighttext"		"0"
		"font"		"MenuTitle"
	}
	"NoAvatarStatus"
	{
		"ControlName"		"Label"
		"fieldName"		"NoAvatarStatus"
		"font"			"BodyText_small"
		"labelText"		""
		"textAlignment"		"north-east"
		"xpos"			"162"
		"ypos"			"19"
		"zpos"			"1"
		"wide"			"64"
		"tall"			"18"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
	}
	"PingImage"
	{
		"ControlName"		"Label"
		"fieldName"		"PingImage"
		"font"			"GameUIButtons"
		"labelText"		""
		"textAlignment"	"center"	[$X360]
		"textAlignment"	"east"	[$WIN32]
		"xpos"			"280"	[$X360]
		"xpos"			"255"	[$WIN32]
		"ypos"			"16"
		"zpos"			"1"
		"wide"			"16"
		"tall"			"16"
		"autoResize"	"1"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
	}
	
	"PingLabel"	[$WIN32]
	{
		"ControlName"	"Label"
		"fieldName"		"PingLabel"
		"xpos"			"274"
		"ypos"			"18"
		"wide"			"32"
		"tall"			"12"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"0"
		"textAlignment"	"west"
		"font"			"DefaultMedium"
		"zpos"			"2"
	}
	
	"PlayerBackground"
	{
		"ControlName"	"Panel"
		"fieldName"		"PlayerBackground"
		"xpos"			"0"
		"ypos"			"15"
		"wide"			"300"
		"tall"			"19"
		"autoResize"	"1"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"	
		"scaleImage"	"1"	
		"PaintBackgroundType"	"0"
		"bgcolor_override"	"40 40 40 255"
	}
	
	"PlayerBackground_Selected"
	{
		"ControlName"	"Panel"
		"fieldName"		"PlayerBackground_Selected"
		"xpos"			"0"
		"ypos"			"15"
		"wide"			"300"
		"tall"			"19"
		"autoResize"	"1"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"tabPosition"	"0"	
		"bgcolor_override"	"140 0 0 255"
	}
}
