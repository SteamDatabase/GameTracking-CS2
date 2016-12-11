"Resource/UI/FoundGameListItemPublic.res"
{
	"FoundGameListItemPublic"
	{
		"ControlName"					"Frame"
		"fieldName"						"FoundGameListItemPublic"
		"wide"							"f8"
		"tall"							"30" [$X360]
		"tall"							"25" [$WIN32]
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"paintBorder"					"0"
		"leftFadeWidth"					"100"
		"rightFadeWidth"				"50"
		"selected_color"				"168 26 26 255"
	}
	
	"ImgPing" [$WIN32]
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"ImgPing"
		"xpos"							"2"
		"ypos"							"4"
		"wide"							"16"
		"tall"							"16"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"bgcolor_override"				"255 255 255 255"
		"scaleImage"					"1"
	}	
	
	"ImgAvatarBG" [$WIN32]
	{
		"ControlName"			"Panel"
		"fieldName"				"ImgAvatarBG"
		"xpos"							"22"
		"ypos"							"4"
		"wide"							"16"
		"tall"							"16"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"bgcolor_override"		"80 80 80 255"
	}
	
	"PnlGamerPic" [$X360]
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"PnlGamerPic"
		"xpos"							"10"
		"ypos"							"3"
		"wide"							"24"
		"tall"							"24"
		"visible"						"0"
		"bgcolor_override"				"255 255 255 255"
	}
	
	"PnlGamerPic" [$WIN32]
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"PnlGamerPic"
		"xpos"							"23"
		"ypos"							"5"
		"wide"							"14"
		"tall"							"14"
		"visible"						"1"
		"bgcolor_override"				"255 255 255 255"
		"scaleImage"					"1"
	}
		
	"PnlModPic"
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"PnlModPic"
		"xpos"							"22"
		"ypos"							"4"
		"wide"							"16"
		"tall"							"16"
		"visible"						"0"
		"bgcolor_override"				"255 255 255 255"
		"scaleImage"					"1"
	}
		
		
	"LblGamerTag"
	{
		"ControlName"					"Label"
		"fieldName"						"LblGamerTag"
		"xpos"							"40" [$X360]
		"ypos"							"0"  [$X360]
		"wide"							"200" [$X360]
		"tall"							"30" [$X360]
		"xpos"							"41" [$WIN32]
		"ypos"							"20" [$WIN32]
		"wide"							"123" [$WIN32]
		"tall"							"20" [$WIN32]
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						""
		"Font"							"DefaultMedium"
		"textAlignment"					"west" [$WIN32]
		"noshortcutsyntax"		"1"
	}
	
	"LblDifficulty"
	{
		"ControlName"					"Label"
		"fieldName"						"LblDifficulty"
		"xpos"							"190" [$X360 && $X360WIDE]
		"xpos"							"165" [$X360 && !$X360WIDE]
		"xpos"							"155" [$WIN32]
		"ypos"							"0" [$X360]
		"ypos"							"2" [$WIN32]
		"wide"							"200"
		"tall"							"30" [$X360]
		"tall"							"20" [$WIN32]
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						""
		"Font"							"DefaultMedium"
		"textAlignment"					"west" [$WIN32]
	}
	
	"LblNotJoinable"
	{
		"ControlName"					"Label"
		"fieldName"						"LblNotJoinable"
		"xpos"							"190" [$X360 && $X360WIDE]
		"xpos"							"160" [$X360 && !$X360WIDE]
		"xpos"							"155" [$WIN32]
		"ypos"							"0" [$X360]
		"ypos"							"2" [$WIN32]
		"wide"							"200"
		"tall"							"30" [$X360]
		"tall"							"20" [$WIN32]
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"0"
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						""
		"Font"							"DefaultMedium"
		"textAlignment"					"west" [$WIN32]
	}
	
	"LblNumPlayers"
	{
		"ControlName"					"Label"
		"fieldName"						"LblNumPlayers"
		"xpos"							"360" [$X360 && $X360WIDE]
		"xpos"							"320" [$X360 && !$X360WIDE]
		"xpos"							"295" [$WIN32]
		"ypos"							"0" [$X360]
		"ypos"							"2" [$WIN32]
		"wide"							"200"
		"tall"							"30" [$X360]
		"tall"							"20" [$WIN32]
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						""
		"Font"							"DefaultMedium"
		"textAlignment"					"west" [$WIN32]
	}
		
	"LblPing"
	{
		"ControlName"					"Label"
		"fieldName"						"LblPing"
		"xpos"							"5" [$X360]
		"ypos"							"3" [$X360]
		"wide"							"24" [$X360]
		"tall"							"24" [$X360]
		"xpos"							"340" [$WIN32]
		"ypos"							"4" [$WIN32]
		"wide"							"32" [$WIN32]
		"tall"							"16" [$WIN32]
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"Font"							"GameUIButtons" [$X360]
		"labelText"						""
		"textAlignment"					"west" [$WIN32]
	}
	
	"ImgPingSmall" [$WIN32]
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"ImgPingSmall"
		"xpos"							"330"
		"ypos"							"9"
		"wide"							"8"
		"tall"							"8"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"bgcolor_override"				"255 255 255 255"
		"scaleImage"					"1"
		"image"							"icon_con_grey"
	}	
}