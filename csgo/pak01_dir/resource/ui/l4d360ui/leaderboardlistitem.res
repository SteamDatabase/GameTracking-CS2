"Resource/UI/LeaderboardListItem.res"
{
	"LeaderboardListItem"
	{
		"ControlName"					"EditablePanel"
		"fieldName"						"LeaderboardListItem"
		"xpos"							"0"
		"ypos"							"0"
		"wide"							"40"
		"tall"							"16"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"paintBorder"					"0"
		"selected_color"				"HybridButton.BorderColor"
	}
	
	"PnlGamerPic" [$WIN32]
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"PnlGamerPic"
		"xpos"							"77"
		"ypos"							"1"
		"wide"							"14"
		"tall"							"14"
		"visible"						"1"
		"bgcolor_override"				"255 255 255 255"
		"scaleImage"					"1"
	}
	
	"LblRank"
	{
		"ControlName"					"Label"
		"fieldName"						"LblRank"
		"xpos"							"0"
		"ypos"							"0"
		"wide"							"63"
		"tall"							"16"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						"9,999,999"
		"textAlignment"					"east"
		"Font"							"DefaultMedium"		[$WIN32]
		"Font"							"Default"			[$X360HIDEF]
		"Font"							"DefaultMedium"		[$X360LODEF]
		"fgcolor_override"				"Label.DisabledFgColor1"
	}
			
	"ImgLocalPlayer" [$X360]
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"ImgLocalPlayer"
		"xpos"							"67"
		"ypos"							"0"
		"wide"							"16"
		"tall"							"16"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"bgcolor_override"				"255 255 255 255"
		"scaleImage"					"1"
		"image"							""
	}
		
 	"LblGamerTag" [$X360]
 	{
 		"ControlName"					"Label"
 		"fieldName"						"LblGamerTag"
 		"xpos"							"84"
 		"ypos"							"0"
 		"wide"							"200"
 		"tall"							"16"
 		"autoResize"					"0"
 		"pinCorner"						"0"
 		"visible"						"1"
 		"enabled"						"1"
 		"tabPosition"					"0"
 		"labelText"						"WWWWWWWWWWWWWWWx"
 		"textAlignment"					"west"
 		"Font"							"DefaultMedium"
 		"fgcolor_override"				"White"
 	}

	"DrpPlayerName" [$WIN32]
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpPlayerName"
		"xpos"					"95"
		"ypos"					"0"
		"zpos"					"2"
		"wide"					"175"
		"tall"					"16"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
	
		"BtnPlayerName"
		{
			"ControlName"		"L4D360HybridButton"
			"fieldName"			"BtnPlayerName"
			"xpos"				"0"
			"ypos" 				"0"
			"tall"				"16"
			"wide"				"175"
			"visible"			"1"
			"enabled"			"1"
			"tabPosition"		"0"
			"command"			"PlayerDropDown"
			"style"				"MediumButton"
			"labelText"			""
		}
	}
	
	"ImgAward"
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"ImgAward"
		"xpos"							"263"
		"ypos"							"0"
		"wide"							"16"
		"tall"							"16"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"bgcolor_override"				"255 255 255 255"
		"scaleImage"					"1"
		"image"							"icon_con_grey"
	}
			
	"LblTime"
	{
		"ControlName"					"Label"
		"fieldName"						"LblTime"
		"xpos"							"279"
		"ypos"							"0"
		"wide"							"100"
		"tall"							"16"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						"99:59.99"
		"textAlignment"					"west"
		"Font"							"DefaultMedium"
		"fgcolor_override"				"Label.DisabledFgColor1"
	}	
}