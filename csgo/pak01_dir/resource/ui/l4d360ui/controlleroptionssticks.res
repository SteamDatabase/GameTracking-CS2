"Resource/UI/ControllerOptionsSticks.res"
{
	"ControllerOptionsSticks"
	{
		"ControlName"		"Frame"
		"fieldName"			"ControllerOptionsSticks"
		"xpos"				"c-240" [$ENGLISH]
		"xpos"				"c-285" [!$ENGLISH]
		"ypos"				"c-135"
		"wide"				"480" [$ENGLISH]
		"wide"				"570" [!$ENGLISH]
		"tall"				"270"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
	}
	
	"LblGameTitle"
	{
		"ControlName"				"Label"
		"fieldName"					"LblGameTitle"
		"xpos"						"10"
		"ypos"						"10" [$ENGLISH]
		"ypos"						"15" [!$ENGLISH]
		"wide"						"f0"
		"wrap"						"1"
		"autoResize"				"1"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"proportionalToParent"		"1"
		"usetitlesafe"				"0"
		"Font"						"FrameTitle"
		"LabelText"					"#L4D360UI_Controller_Sticks_Title"
	}

	"LblDescription"
	{
		"ControlName"				"Label"
		"fieldName"					"LblDescription"
		"xpos"						"10"
		"ypos"						"33" [$ENGLISH]
		"ypos"						"49" [!$ENGLISH]
		"wide"						"f0"
		"wrap"						"1"
		"autoResize"				"1"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"proportionalToParent"		"1"
		"usetitlesafe"				"0"
		"Font"						"Default"
		"fgcolor_override"          "MediumGray"
		"LabelText"					"#L4D360UI_Controller_Sticks_Desc"
	}
	
	"BtnDefault"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnDefault"
		"xpos"					"c-180"
		"ypos"					"240"
		"zpos"					"3"
		"wide"					"180"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"proportionalToParent"	"1"
		"navLeft"				"BtnSouthpaw"
		"navRight"				"BtnSouthpaw"
		"labelText"				"#L4D360UI_Controller_Sticks_Default"
		"tooltiptext"			"#L4D360UI_Controller_Tooltip_Sticks_Default"
		"usetitlesafe" 			"1"
		"style"					"DialogButton"
		"command" 				"BtnDefault"
		"navToCommand"			"BtnDefault"
		"ActivationType"		"1"
		"OnlyActiveUser"		"1"
		"IgnoreButtonA"			"1"
		"FocusDisabledBorderSize" "1"
	}	
	
	"BtnSouthpaw"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnSouthpaw"
		"xpos"					"c0"
		"ypos"					"240"
		"zpos"					"3"
		"wide"					"180"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"proportionalToParent"	"1"
		"navLeft"				"BtnDefault"
		"navRight"				"BtnDefault"
		"labelText"				"#L4D360UI_Controller_Sticks_Southpaw"
		"tooltiptext"			"#L4D360UI_Controller_Tooltip_Sticks_Southpaw"
		"usetitlesafe" 			"1"
		"style"					"DialogButton"
		"command" 				"BtnSouthpaw"
		"navToCommand"			"BtnSouthpaw"
		"ActivationType"		"1"
		"OnlyActiveUser"		"1"
		"IgnoreButtonA"			"1"
		"FocusDisabledBorderSize" "1"
	}	
	
	"ControllerImage"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ControllerImage"
		"xpos"					"c-245"	[!$ENGLISH]
		"xpos"					"c-285"	[$ENGLISH]
		"ypos"					"75"
		"zpos"					"3"
		"wide"					"280"
		"tall"					"130"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"		
		"scaleImage"			"1"
		"image"					"controller_layout_sticks"
	}
	
	"Normal_Move"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"Normal_Move"
		"xpos"					"c-237"	[!$ENGLISH]
		"xpos"					"c-277"	[$ENGLISH]
		"ypos"					"63"
		"zpos"					"4"
		"wide"					"75"
		"tall"					"75"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"		
		"scaleImage"			"1"
		"image"					"controller_layout_sticks_move"
	}
	
	"Normal_Look"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"Normal_Look"
		"xpos"					"c-156"	[!$ENGLISH]
		"xpos"					"c-196"	[$ENGLISH]
		"ypos"					"90"
		"zpos"					"4"
		"wide"					"75"
		"tall"					"75"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"		
		"scaleImage"			"1"
		"image"					"controller_layout_sticks_look"
	}
	
	"Southpaw_Move"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"Southpaw_Move"
		"xpos"					"c-156"	[!$ENGLISH]
		"xpos"					"c-196"	[$ENGLISH]
		"ypos"					"90"
		"zpos"					"4"
		"wide"					"75"
		"tall"					"75"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"		
		"scaleImage"			"1"
		"image"					"controller_layout_sticks_move"
	}
	
	"Southpaw_Look"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"Southpaw_Look"
		"xpos"					"c-237"	[!$ENGLISH]
		"xpos"					"c-277"	[$ENGLISH]
		"ypos"					"63"
		"zpos"					"4"
		"wide"					"75"
		"tall"					"75"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"		
		"scaleImage"			"1"
		"image"					"controller_layout_sticks_look"
	}	
}
